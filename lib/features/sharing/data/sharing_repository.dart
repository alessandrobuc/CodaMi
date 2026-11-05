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
