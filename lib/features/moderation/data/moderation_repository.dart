import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../reports/domain/entities/reports_entity.dart';

enum FlagReason {
  spam,
  scam,
  inappropriate,
  wrongInfo,
  other;

  static FlagReason fromValue(Object? value) =>
      values.where((r) => r.name == value).firstOrNull ?? other;
}

class ReportFlag {
  final String id;
  final String reportId;
  final String reportOwnerId;
  final String reporterId;
  final FlagReason reason;
  final String? note;
  final DateTime? createdAt;

  const ReportFlag({
    required this.id,
    required this.reportId,
    required this.reportOwnerId,
    required this.reporterId,
    required this.reason,
    this.note,
    this.createdAt,
  });

  factory ReportFlag.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    final note = (data['note'] as String?)?.trim() ?? '';
    return ReportFlag(
      id: doc.id,
      reportId: data['reportId'] as String? ?? '',
      reportOwnerId: data['reportOwnerId'] as String? ?? '',
      reporterId: data['reporterId'] as String? ?? '',
      reason: FlagReason.fromValue(data['reason']),
      note: note.isEmpty ? null : note,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

// All flags on one report, newest first.
class FlaggedReport {
  final String reportId;
  final List<ReportFlag> flags;

  const FlaggedReport(this.reportId, this.flags);

  DateTime? get latest => flags.first.createdAt;

  Set<FlagReason> get reasons => {for (final f in flags) f.reason};

  static List<FlaggedReport> group(List<ReportFlag> flags) {
    final byReport = <String, List<ReportFlag>>{};
    for (final flag in flags) {
      (byReport[flag.reportId] ??= []).add(flag);
    }
    return [for (final e in byReport.entries) FlaggedReport(e.key, e.value)];
  }
}

class ModerationRepository {
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  ModerationRepository({FirebaseFirestore? db, FirebaseStorage? storage})
    : _db = db ?? FirebaseFirestore.instance,
      _storage = storage ?? FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get _flags =>
      _db.collection('flags');

  DocumentReference<Map<String, dynamic>> _flagDoc(
    String reporterId,
    String reportId,
  ) => _flags.doc('${reporterId}_$reportId');

  Future<bool> hasFlagged(String reporterId, String reportId) async =>
      (await _flagDoc(reporterId, reportId).get()).exists;

  Future<void> flag({
    required String reporterId,
    required Report report,
    required FlagReason reason,
    String? note,
  }) {
    final text = note?.trim() ?? '';
    return _flagDoc(reporterId, report.id).set({
      'reportId': report.id,
      'reportOwnerId': report.ownerId,
      'reporterId': reporterId,
      'reason': reason.name,
      if (text.isNotEmpty) 'note': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> block(
    String uid, {
    required String userId,
    required String name,
  }) => _db.collection('users').doc(uid).update({'blockedUsers.$userId': name});

  Future<void> unblock(String uid, String userId) => _db
      .collection('users')
      .doc(uid)
      .update({'blockedUsers.$userId': FieldValue.delete()});

  Stream<List<ReportFlag>> watchFlags({required int limit}) => _flags
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map((snap) => snap.docs.map(ReportFlag.fromDoc).toList());

  Stream<List<ReportFlag>> watchFlagsFor(String reportId) => _flags
      .where('reportId', isEqualTo: reportId)
      .snapshots()
      .map(
        (snap) => snap.docs.map(ReportFlag.fromDoc).toList()
          ..sort(
            (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
              a.createdAt ?? DateTime.now(),
            ),
          ),
      );

  Future<void> dismissFlags(String reportId) async {
    final snap = await _flags.where('reportId', isEqualTo: reportId).get();
    final batch = _db.batch();
    for (final doc in snap.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  Future<void> hide(Report report) =>
      _db.collection('reports').doc(report.id).update({
        'status': ReportStatus.hidden.name,
        'hiddenBy': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<void> restore(Report report) =>
      _db.collection('reports').doc(report.id).update({
        'status': report.resolvedAt == null
            ? ReportStatus.open.name
            : ReportStatus.resolved.name,
        'hiddenBy': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  // Lost reports can reuse pet photos, so only photos in the report folder go.
  Future<void> remove(Report report) async {
    await _db.collection('reports').doc(report.id).delete();
    await dismissFlags(report.id);
    for (final url in report.photoUrls) {
      try {
        final ref = _storage.refFromURL(url);
        if (ref.fullPath.startsWith('reports/')) await ref.delete();
      } catch (e) {
        debugPrint('Could not delete photo: $e');
      }
    }
  }
}

final moderationRepositoryProvider = Provider((ref) => ModerationRepository());
