import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/feedback_rules.dart';

class FeedbackEntry {
  final String id;
  final String uid;
  final String name;
  final String email;
  final int rating;
  final String comment;
  final String? appVersion;
  final String? platform;
  final DateTime? createdAt;

  const FeedbackEntry({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.rating,
    required this.comment,
    this.appVersion,
    this.platform,
    this.createdAt,
  });

  factory FeedbackEntry.fromMap(String id, Map<String, dynamic> map) =>
      FeedbackEntry(
        id: id,
        uid: map['uid'] as String? ?? '',
        name: map['name'] as String? ?? '',
        email: map['email'] as String? ?? '',
        rating: ((map['rating'] as num?)?.toInt() ?? 0).clamp(0, 5),
        comment: map['comment'] as String? ?? '',
        appVersion: map['appVersion'] as String?,
        platform: map['platform'] as String?,
        createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      );
}

class FeedbackRepository {
  final FirebaseFirestore _db;

  FeedbackRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

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
}

final feedbackRepositoryProvider = Provider((ref) => FeedbackRepository());

// When this account was last asked on this phone.
class PromptHistoryStore {
  final SharedPreferences _prefs;
  final String uid;

  PromptHistoryStore(this._prefs, this.uid);

  String get _feedbackAt => 'prompt_feedback_at_$uid';
  String get _feedbackCount => 'prompt_feedback_count_$uid';
  String get _reviewAt => 'prompt_review_at_$uid';

  DateTime? _time(String key) {
    final ms = _prefs.getInt(key);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  PromptHistory read() => PromptHistory(
    feedbackAskedAt: _time(_feedbackAt),
    feedbackAsks: _prefs.getInt(_feedbackCount) ?? 0,
    reviewAskedAt: _time(_reviewAt),
  );

  Future<void> feedbackAsked(DateTime now) async {
    await _prefs.setInt(_feedbackAt, now.millisecondsSinceEpoch);
    await _prefs.setInt(
      _feedbackCount,
      (_prefs.getInt(_feedbackCount) ?? 0) + 1,
    );
  }

  Future<void> reviewAsked(DateTime now) =>
      _prefs.setInt(_reviewAt, now.millisecondsSinceEpoch);
}
