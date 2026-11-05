import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

import '../../heat/domain/heat.dart' show heatDayKey;
import '../../location/data/datasources/places_service.dart';
import '../domain/sharing.dart';

class SharingRepository {
  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;

  SharingRepository({FirebaseFirestore? db, FirebaseFunctions? functions})
    : _db = db ?? FirebaseFirestore.instance,
      _functions =
          functions ??
          FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion);

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('sharing');

  Stream<SharingConfig> watchConfig() =>
      _config.snapshots().map((d) => SharingConfig.fromMap(d.data()));

  Future<void> saveConfig(SharingConfig c, {required String adminId}) =>
      _config.set({
        'popup': c.popup,
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  // Counted by the server, so nobody can change the numbers from the app.
  Future<void> logShare(
    String reportId,
    ShareTarget target,
    ShareKind kind,
  ) async {
    try {
      await _functions.httpsCallable('logReportShare').call({
        'reportId': reportId,
        'target': target.name,
        'kind': kind.name,
      });
    } catch (e) {
      debugPrint('Share not counted: $e');
    }
  }

  DocumentReference<Map<String, dynamic>> get _reminderConfig =>
      _db.collection('config').doc('shareReminders');

  Stream<ShareReminderConfig> watchReminderConfig() => _reminderConfig
      .snapshots()
      .map((d) => ShareReminderConfig.fromMap(d.data()));

  Future<void> saveReminderConfig(
    ShareReminderConfig c, {
    required String adminId,
  }) => _reminderConfig.set({
    ...c.toMap(),
    'updatedBy': adminId,
    'updatedAt': FieldValue.serverTimestamp(),
  });

  // "opened" when a reminder is tapped, "shared" after sharing CodaMi.
  Future<void> reminderEvent(String event, {bool fromReminder = false}) async {
    try {
      await _functions.httpsCallable('shareReminderEvent').call({
        'event': event,
        'fromReminder': fromReminder,
      });
    } catch (e) {
      debugPrint('Share reminder event not saved: $e');
    }
  }

  Future<bool> sendTestReminder() async {
    final result = await _functions.httpsCallable('testShareReminder').call();
    return (result.data as Map?)?['sent'] == true;
  }

  Stream<ShareReminderStats> watchReminderTotals({int days = 30}) {
    final from = heatDayKey(DateTime.now().subtract(Duration(days: days - 1)));
    return _db
        .collection('shareReminderStats')
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: from)
        .snapshots()
        .map(
          (s) => s.docs.fold(
            const ShareReminderStats(),
            (total, d) => total + ShareReminderStats.fromMap(d.data()),
          ),
        );
  }

  // The owner sees how far their report travelled.
  Stream<ShareStats> watchReportStats(String reportId) => _db
      .collection('reportShares')
      .doc(reportId)
      .snapshots()
      .map((d) => ShareStats.fromMap(d.data()));

  // Admins: totals of the last [days] days.
  Stream<ShareStats> watchTotals({int days = 30}) {
    final from = heatDayKey(DateTime.now().subtract(Duration(days: days - 1)));
    return _db
        .collection('shareStats')
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: from)
        .snapshots()
        .map(
          (s) => s.docs.fold(
            const ShareStats(),
            (total, d) => total + ShareStats.fromMap(d.data()),
          ),
        );
  }
}
