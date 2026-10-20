import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../location/data/datasources/places_service.dart';
import '../domain/support_case.dart';

enum CaseFilter { unanswered, unassigned, mine, active, done }

final _activeValues = [
  for (final s in CaseStatus.values)
    if (s.isActive) s.value,
];
final _doneValues = [CaseStatus.resolved.value, CaseStatus.closed.value];

// Cases, events and stats are written by Cloud Functions; the app only adds messages.
class SupportRepository {
  final FirebaseFirestore _db;

  SupportRepository([FirebaseFirestore? db])
    : _db = db ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _cases =>
      _db.collection('supportCases');

  List<SupportCase> _toCases(QuerySnapshot<Map<String, dynamic>> snap) =>
      snap.docs.map((d) => SupportCase.fromMap(d.id, d.data())).toList();

  Future<T> _call<T>(String name, Map<String, Object?> data) async {
    final result = await FirebaseFunctions.instanceFor(
      region: PlacesService.functionsRegion,
    ).httpsCallable(name).call<Object?>(data);
    return result.data as T;
  }

  Stream<List<SupportCase>> watchMyCases(String uid) => _cases
      .where('userId', isEqualTo: uid)
      .orderBy('lastMessageAt', descending: true)
      .limit(50)
      .snapshots()
      .map(_toCases);

  Stream<SupportCase?> watchCase(String id) => _cases
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? SupportCase.fromMap(d.id, d.data()!) : null);

  // Newest first, so the chat can load older pages as the user scrolls up.
  Stream<List<SupportMessage>> watchMessages(
    String caseId, {
    required int limit,
  }) => _cases
      .doc(caseId)
      .collection('messages')
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (snap) => snap.docs
            .map((d) => SupportMessage.fromMap(d.id, d.data()))
            .toList(),
      );

  Future<bool> liveChatAvailable() async {
    final data = await _call<Map<Object?, Object?>>('supportAvailability', {});
    return data['liveChat'] == true;
  }

  Future<String> createCase({
    required CaseKind kind,
    required CaseCategory category,
    required String subject,
    required String message,
  }) async {
    final data = await _call<Map<Object?, Object?>>('supportCreateCase', {
      'kind': kind.name,
      'category': category.name,
      'subject': subject.trim(),
      'message': message.trim(),
    });
    return data['caseId'] as String;
  }

  Future<void> sendMessage({
    required String caseId,
    required String senderId,
    required bool asStaff,
    required String text,
  }) => _cases.doc(caseId).collection('messages').add({
    'senderId': senderId,
    'senderRole': asStaff ? 'staff' : 'user',
    'text': text.trim(),
    'createdAt': FieldValue.serverTimestamp(),
  });

  Future<void> setStatus(String caseId, CaseStatus status) => _call<Object?>(
    'supportSetStatus',
    {'caseId': caseId, 'status': status.value},
  );

  Future<void> takeCase(String caseId) =>
      _call<Object?>('supportTakeCase', {'caseId': caseId});

  // `to: null` puts the case back in the unassigned queue.
  Future<void> reassignCase(String caseId, String? to) =>
      _call<Object?>('supportReassignCase', {'caseId': caseId, 'to': to});

  Stream<List<SupportCase>> watchStaffCases(
    CaseFilter filter, {
    required String uid,
    required int limit,
  }) {
    final query = switch (filter) {
      CaseFilter.unanswered =>
        _cases.where('awaitingStaff', isEqualTo: true).orderBy('awaitingSince'),
      CaseFilter.unassigned =>
        _cases
            .where('status', isEqualTo: CaseStatus.open.value)
            .orderBy('lastMessageAt', descending: true),
      CaseFilter.mine =>
        _cases
            .where('assignedTo', isEqualTo: uid)
            .where('status', whereIn: _activeValues)
            .orderBy('lastMessageAt', descending: true),
      CaseFilter.active =>
        _cases
            .where('status', whereIn: _activeValues)
            .orderBy('lastMessageAt', descending: true),
      CaseFilter.done =>
        _cases
            .where('status', whereIn: _doneValues)
            .orderBy('lastMessageAt', descending: true),
    };
    return query.limit(limit).snapshots().map(_toCases);
  }

  Stream<List<SupportCase>> watchOperatorCases(
    String uid, {
    required int limit,
  }) => _cases
      .where('assignedTo', isEqualTo: uid)
      .orderBy('lastMessageAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(_toCases);

  // A reference like `CM-1042` (or just `1042`), otherwise an email.
  Future<List<SupportCase>> search(String text) async {
    final typed = text.trim();
    final number = int.tryParse(
      typed.toUpperCase().replaceFirst(RegExp(r'^CM-?'), ''),
    );
    final query = number != null
        ? _cases.where('number', isEqualTo: number)
        : _cases.where('userEmail', isEqualTo: typed.toLowerCase());
    return _toCases(await query.limit(20).get());
  }

  Stream<List<SupportEvent>> watchEvents(String caseId) => _cases
      .doc(caseId)
      .collection('events')
      .orderBy('at')
      .snapshots()
      .map(
        (snap) =>
            snap.docs.map((d) => SupportEvent.fromMap(d.id, d.data())).toList(),
      );

  Stream<StaffStats> watchStats(String uid) => _db
      .collection('staffStats')
      .doc(uid)
      .snapshots()
      .map((d) => StaffStats.fromMap(d.data()));

  Stream<Map<String, StaffPresence>> watchPresence() => _db
      .collection('staffPresence')
      .snapshots()
      .map(
        (snap) => {
          for (final d in snap.docs) d.id: StaffPresence.fromMap(d.data()),
        },
      );

  Future<void> setPresence(String uid, PresenceState state) => _db
      .collection('staffPresence')
      .doc(uid)
      .set({'state': state.name, 'lastSeen': FieldValue.serverTimestamp()});

  Future<int> _count(Query<Map<String, dynamic>> query) async =>
      (await query.count().get()).count ?? 0;

  Future<int> activeCount(String uid) => _count(
    _cases
        .where('assignedTo', isEqualTo: uid)
        .where('status', whereIn: _activeValues),
  );

  Future<SupportCounts> counts() async {
    final (unassigned, unanswered, overdue) = await (
      _count(_cases.where('status', isEqualTo: CaseStatus.open.value)),
      _count(_cases.where('awaitingStaff', isEqualTo: true)),
      _count(_cases.where('overdue', isEqualTo: true)),
    ).wait;
    return SupportCounts(
      unassigned: unassigned,
      unanswered: unanswered,
      overdue: overdue,
    );
  }
}

class SupportCounts {
  final int unassigned;
  final int unanswered;
  final int overdue;

  const SupportCounts({
    required this.unassigned,
    required this.unanswered,
    required this.overdue,
  });
}

final supportRepositoryProvider = Provider((ref) => SupportRepository());
