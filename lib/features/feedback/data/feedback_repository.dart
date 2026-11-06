import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../location/data/datasources/places_service.dart';
import '../domain/feedback.dart';
import '../domain/feedback_rules.dart';
import 'device_info.dart';

class FeedbackRepository {
  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;
  final FirebaseStorage _storage;

  FeedbackRepository({
    FirebaseFirestore? db,
    FirebaseFunctions? functions,
    FirebaseStorage? storage,
  }) : _db = db ?? FirebaseFirestore.instance,
       _functions =
           functions ??
           FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion),
       _storage = storage ?? FirebaseStorage.instance;

  DocumentReference<Map<String, dynamic>> get _askConfig =>
      _db.collection('config').doc('feedbackAsks');

  Stream<FeedbackAskConfig> watchAskConfig() =>
      _askConfig.snapshots().map((d) => FeedbackAskConfig.fromMap(d.data()));

  Future<void> saveAskConfig(FeedbackAskConfig c, {required String adminId}) =>
      _askConfig.set({
        ...c.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  // Returns the points given (0 after the first time).
  Future<int> submit({
    required String uid,
    required FeedbackType type,
    required FeedbackArea area,
    required int rating,
    required String comment,
    required bool asked,
    required String appVersion,
    required String lang,
    String? screenshot,
  }) async {
    final path = screenshot == null
        ? null
        : await _uploadScreenshot(uid, screenshot);
    final result = await _functions.httpsCallable('submitFeedback').call({
      'type': type.name,
      'area': area.name,
      'rating': rating,
      'comment': comment,
      'asked': asked,
      'screenshotPath': ?path,
      'appVersion': appVersion,
      'platform': defaultTargetPlatform.name,
      'device': await describeDevice(),
      'lang': lang,
    });
    return ((result.data as Map?)?['points'] as num?)?.toInt() ?? 0;
  }

  Future<String> _uploadScreenshot(String uid, String localPath) async {
    final png = localPath.toLowerCase().endsWith('.png');
    final path =
        'feedback/$uid/${DateTime.now().millisecondsSinceEpoch}'
        '${png ? '.png' : '.jpg'}';
    await _storage
        .ref(path)
        .putFile(
          File(localPath),
          SettableMetadata(contentType: png ? 'image/png' : 'image/jpeg'),
        );
    return path;
  }

  DocumentReference<Map<String, dynamic>> _user(String uid) =>
      _db.collection('users').doc(uid);

  // Recorded before the question shows, so it is never asked twice.
  Future<void> markAsked(String uid, FeedbackArea area) => _user(uid).update({
    'feedbackAsk.lastAt': FieldValue.serverTimestamp(),
    'feedbackAsk.count': FieldValue.increment(1),
    'feedbackAsk.asked': FieldValue.arrayUnion([area.name]),
  });

  // Sending feedback also starts the pause.
  Future<void> markSent(String uid) =>
      _user(uid).update({'feedbackAsk.lastAt': FieldValue.serverTimestamp()});

  Future<void> optOut(String uid) =>
      _user(uid).update({'feedbackAsk.optOut': true});

  Stream<List<FeedbackEntry>> watchLatest({int limit = 200}) => _db
      .collection('feedback')
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (snap) => [
          for (final d in snap.docs) FeedbackEntry.fromMap(d.id, d.data()),
        ],
      );

  // Returns true when the user was sent a thank-you notification.
  Future<bool> update(
    String id, {
    FeedbackStatus? status,
    String? note,
    bool notify = false,
  }) async {
    final result = await _functions.httpsCallable('updateFeedback').call({
      'id': id,
      'status': ?status?.value,
      'note': ?note,
      'notify': notify,
    });
    return (result.data as Map?)?['notified'] == true;
  }

  Future<String> screenshotUrl(String path) =>
      _storage.ref(path).getDownloadURL();
}

final feedbackRepositoryProvider = Provider((ref) => FeedbackRepository());

// When the store rating window was last shown on this phone.
class PromptHistoryStore {
  final SharedPreferences _prefs;
  final String uid;

  PromptHistoryStore(this._prefs, this.uid);

  String get _reviewAt => 'prompt_review_at_$uid';

  DateTime? get reviewAskedAt {
    final ms = _prefs.getInt(_reviewAt);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  PromptHistory read({DateTime? feedbackAskedAt}) => PromptHistory(
    feedbackAskedAt: feedbackAskedAt,
    reviewAskedAt: reviewAskedAt,
  );

  Future<void> reviewAsked(DateTime now) =>
      _prefs.setInt(_reviewAt, now.millisecondsSinceEpoch);
}

// How often each part of the app was used on this phone.
class FeedbackUsage {
  final SharedPreferences _prefs;
  final String uid;

  FeedbackUsage(this._prefs, this.uid);

  String _key(FeedbackArea area) => 'feedback_uses_${uid}_${area.name}';

  int count(FeedbackArea area) => _prefs.getInt(_key(area)) ?? 0;

  Future<int> add(FeedbackArea area) async {
    final next = count(area) + 1;
    await _prefs.setInt(_key(area), next);
    return next;
  }
}
