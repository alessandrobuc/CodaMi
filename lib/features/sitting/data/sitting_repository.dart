import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

import '../../heat/domain/heat.dart' show heatDay, heatDayKey;
import '../../location/data/datasources/places_service.dart';
import '../../moderation/data/moderation_repository.dart' show FlagReason;
import '../../pets/domain/entities/pets_entity.dart';
import '../domain/sitting.dart';

const chatPageSize = 20;

class SittingException implements Exception {
  final String code;

  const SittingException(this.code);
}

class SittingRepository {
  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;

  SittingRepository({FirebaseFirestore? db, FirebaseFunctions? functions})
    : _db = db ?? FirebaseFirestore.instance,
      _functions =
          functions ??
          FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion);

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('sitting');
  CollectionReference<Map<String, dynamic>> get _sitters =>
      _db.collection('sitters');
  CollectionReference<Map<String, dynamic>> get _requests =>
      _db.collection('sittingRequests');
  CollectionReference<Map<String, dynamic>> get _offers =>
      _db.collection('sittingOffers');
  CollectionReference<Map<String, dynamic>> get _chats =>
      _db.collection('sittingChats');
  CollectionReference<Map<String, dynamic>> get _reviews =>
      _db.collection('sittingReviews');

  Future<T> _call<T>(String name, Map<String, Object> data, T value) async {
    try {
      await _functions.httpsCallable(name).call(data);
      return value;
    } on FirebaseFunctionsException catch (e) {
      debugPrint('$name failed: ${e.code} ${e.message}');
      throw SittingException(e.code);
    }
  }

  // Settings

  Stream<SittingConfig> watchConfig() =>
      _config.snapshots().map((d) => SittingConfig.fromMap(d.data()));

  Future<void> saveConfig(SittingConfig c, {required String adminId}) =>
      _config.set({
        ...c.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  // Sitter profiles

  Stream<SitterProfile?> watchSitter(String uid) => _sitters
      .doc(uid)
      .snapshots()
      .map((d) => d.exists ? SitterProfile.fromMap(d.id, d.data()!) : null);

  Stream<List<SitterProfile>> watchSitters({int limit = 300}) => _sitters
      .where('hidden', isEqualTo: false)
      .where('active', isEqualTo: true)
      .limit(limit)
      .snapshots()
      .map(
        (s) => [for (final d in s.docs) SitterProfile.fromMap(d.id, d.data())],
      );

  Future<void> saveSitter(SitterProfile p, {required bool isNew}) =>
      _sitters.doc(p.uid).set({
        ...p.toFields(),
        if (isNew) 'hidden': false,
        if (isNew) 'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

  // Requests

  Stream<List<SittingRequest>> watchOpenRequests({int limit = 300}) => _requests
      .where('hidden', isEqualTo: false)
      .where('status', isEqualTo: 'open')
      .where('end', isGreaterThanOrEqualTo: heatDayKey(heatDay(DateTime.now())))
      .orderBy('end')
      .limit(limit)
      .snapshots()
      .map(_requestsOf);

  Stream<List<SittingRequest>> watchMyRequests(String uid) => _requests
      .where('ownerId', isEqualTo: uid)
      .snapshots()
      .map((s) => _requestsOf(s)..sort((a, b) => b.start.compareTo(a.start)));

  Stream<SittingRequest?> watchRequest(String id) => _requests
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? SittingRequest.fromMap(d.id, d.data()!) : null);

  List<SittingRequest> _requestsOf(QuerySnapshot<Map<String, dynamic>> s) => [
    for (final d in s.docs) ?SittingRequest.fromMap(d.id, d.data()),
  ];

  Future<void> createRequest({
    required String ownerId,
    required String ownerName,
    required List<Pet> pets,
    required SittingService service,
    required DateTime start,
    required DateTime end,
    required String city,
    required double lat,
    required double lng,
    required String notes,
    required String budget,
  }) => _requests.add({
    'ownerId': ownerId,
    'ownerName': ownerName,
    'petIds': [for (final p in pets) p.id],
    'petNames': [for (final p in pets) p.name],
    'species': {for (final p in pets) p.species.name}.toList(),
    'service': service.name,
    'start': heatDayKey(start),
    'end': heatDayKey(end),
    'city': city,
    'lat': roundPlace(lat),
    'lng': roundPlace(lng),
    'notes': notes.trim(),
    if (budget.trim().isNotEmpty) 'budget': budget.trim(),
    'status': 'open',
    'hidden': false,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });

  Future<void> closeRequest(String id) => _requests.doc(id).update({
    'status': 'closed',
    'updatedAt': FieldValue.serverTimestamp(),
  });

  // Offers

  Stream<List<SittingOffer>> watchOffersOn(String requestId, String ownerId) =>
      _offers
          .where('requestId', isEqualTo: requestId)
          .where('ownerId', isEqualTo: ownerId)
          .snapshots()
          .map(
            (s) =>
                [for (final d in s.docs) SittingOffer.fromMap(d.data())]
                  ..sort((a, b) => a.status.index.compareTo(b.status.index)),
          );

  Stream<List<SittingOffer>> watchMyOffers(String sitterId) => _offers
      .where('sitterId', isEqualTo: sitterId)
      .snapshots()
      .map((s) => [for (final d in s.docs) SittingOffer.fromMap(d.data())]);

  Future<void> sendOffer(
    SittingRequest r, {
    required String sitterId,
    required String sitterName,
    required String message,
    required String price,
  }) => _offers.doc('${r.id}_$sitterId').set({
    'requestId': r.id,
    'ownerId': r.ownerId,
    'sitterId': sitterId,
    'sitterName': sitterName,
    'message': message.trim(),
    if (price.trim().isNotEmpty) 'price': price.trim(),
    'status': 'pending',
    'createdAt': FieldValue.serverTimestamp(),
  });

  Future<void> setOfferStatus(SittingOffer o, OfferStatus status) =>
      _offers.doc(o.id).update({'status': status.name});

  Future<void> acceptOffer(SittingOffer o) => _call('acceptSittingOffer', {
    'requestId': o.requestId,
    'sitterId': o.sitterId,
  }, null);

  Future<void> confirm(String requestId) =>
      _call('confirmSitting', {'requestId': requestId}, null);

  // Reviews

  Stream<List<SittingReview>> watchReviews(String sitterId) => _reviews
      .where('sitterId', isEqualTo: sitterId)
      .where('hidden', isEqualTo: false)
      .snapshots()
      .map(
        (s) =>
            [for (final d in s.docs) SittingReview.fromMap(d.id, d.data())]
              ..sort(
                (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
                  a.createdAt ?? DateTime(0),
                ),
              ),
      );

  Stream<bool> watchReviewed(String requestId) =>
      _reviews.doc(requestId).snapshots().map((d) => d.exists);

  Future<void> review(String requestId, int stars, String text) => _call(
    'reviewSitter',
    {'requestId': requestId, 'stars': stars, 'text': text.trim()},
    null,
  );

  // Chats

  Stream<List<SittingChat>> watchChats(String uid) => _chats
      .where('members', arrayContains: uid)
      .snapshots()
      .map(
        (s) => [for (final d in s.docs) SittingChat.fromMap(d.id, d.data())]
          ..sort(
            (a, b) =>
                (b.lastAt ?? DateTime(0)).compareTo(a.lastAt ?? DateTime(0)),
          ),
      );

  // Live: only the newest page. Older pages are read once with olderMessages.
  Stream<List<ChatMessage>> watchMessages(String chatId) => _chats
      .doc(chatId)
      .collection('messages')
      .orderBy('at', descending: true)
      .limit(chatPageSize)
      .snapshots()
      .map(
        (s) => [for (final d in s.docs) ChatMessage.fromMap(d.id, d.data())],
      );

  Future<List<ChatMessage>> olderMessages(
    String chatId,
    DateTime before,
  ) async {
    final page = await _chats
        .doc(chatId)
        .collection('messages')
        .orderBy('at', descending: true)
        .startAfter([Timestamp.fromDate(before)])
        .limit(chatPageSize)
        .get();
    return [for (final d in page.docs) ChatMessage.fromMap(d.id, d.data())];
  }

  // Opens the chat between two users, creating it the first time.
  Future<String> openChat({
    required String me,
    required String myName,
    required String other,
    required String otherName,
  }) async {
    final id = sittingChatId(me, other);
    final ref = _chats.doc(id);
    try {
      if ((await ref.get()).exists) return id;
    } on FirebaseException catch (e) {
      if (e.code != 'permission-denied') rethrow;
    }
    final members = [me, other]..sort();
    await ref.set({
      'members': members,
      'names': {me: myName, other: otherName},
      'lastMessage': '',
      'lastSender': '',
      'readAt': {},
      'createdAt': FieldValue.serverTimestamp(),
    });
    return id;
  }

  Future<void> send(
    String chatId, {
    required String me,
    required String to,
    required String text,
  }) async {
    final chat = _chats.doc(chatId);
    final clean = text.trim();
    await chat.collection('messages').add({
      'senderId': me,
      'to': to,
      'text': clean,
      'at': FieldValue.serverTimestamp(),
    });
    await chat.update({
      'lastMessage': clean.length > 140 ? '${clean.substring(0, 139)}…' : clean,
      'lastSender': me,
      'lastAt': FieldValue.serverTimestamp(),
      'readAt.$me': FieldValue.serverTimestamp(),
    });
  }

  Future<void> markRead(String chatId, String me) =>
      _chats.doc(chatId).update({'readAt.$me': FieldValue.serverTimestamp()});

  // Reports and moderation

  Future<void> flag({
    required String reporterId,
    required SittingFlagKind kind,
    required String targetId,
    required String targetOwnerId,
    required FlagReason reason,
    required String note,
  }) => _db
      .collection('sittingFlags')
      .doc('${reporterId}_${kind.name}_$targetId')
      .set({
        'reporterId': reporterId,
        'kind': kind.name,
        'targetId': targetId,
        'targetOwnerId': targetOwnerId,
        'reason': reason.name,
        if (note.isNotEmpty) 'note': note,
        'createdAt': FieldValue.serverTimestamp(),
      });

  Stream<List<SittingFlag>> watchFlags({int limit = 200}) => _db
      .collection('sittingFlags')
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (s) => [for (final d in s.docs) SittingFlag.fromMap(d.id, d.data())],
      );

  Future<void> dismissFlag(String id) =>
      _db.collection('sittingFlags').doc(id).delete();

  Future<void> setHidden(SittingFlagKind kind, String id, bool hidden) =>
      switch (kind) {
        SittingFlagKind.request => _requests.doc(id).update({'hidden': hidden}),
        SittingFlagKind.sitter => _sitters.doc(id).update({'hidden': hidden}),
        SittingFlagKind.review => _call('adminSetReviewHidden', {
          'reviewId': id,
          'hidden': hidden,
        }, null),
        SittingFlagKind.chat => Future.value(),
      };

  Stream<List<SittingRequest>> watchLatestRequests({int limit = 100}) =>
      _requests
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .snapshots()
          .map(_requestsOf);

  Stream<List<SitterProfile>> watchLatestSitters({int limit = 100}) => _sitters
      .orderBy('updatedAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (s) => [for (final d in s.docs) SitterProfile.fromMap(d.id, d.data())],
      );

  Stream<List<SittingReview>> watchLatestReviews({int limit = 100}) => _reviews
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (s) => [for (final d in s.docs) SittingReview.fromMap(d.id, d.data())],
      );
}

class SittingFlag {
  final String id;
  final SittingFlagKind kind;
  final String targetId;
  final String targetOwnerId;
  final FlagReason reason;
  final String note;
  final DateTime? createdAt;

  const SittingFlag({
    required this.id,
    required this.kind,
    required this.targetId,
    required this.targetOwnerId,
    required this.reason,
    this.note = '',
    this.createdAt,
  });

  factory SittingFlag.fromMap(String id, Map<String, dynamic> m) => SittingFlag(
    id: id,
    kind: SittingFlagKind.values.firstWhere(
      (k) => k.name == m['kind'],
      orElse: () => SittingFlagKind.request,
    ),
    targetId: m['targetId'] as String? ?? '',
    targetOwnerId: m['targetOwnerId'] as String? ?? '',
    reason: FlagReason.fromValue(m['reason']),
    note: m['note'] as String? ?? '',
    createdAt: (m['createdAt'] as Timestamp?)?.toDate(),
  );
}
