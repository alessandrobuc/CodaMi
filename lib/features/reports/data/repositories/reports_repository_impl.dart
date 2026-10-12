import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/reports_entity.dart';
import '../../domain/repositories/reports_repository.dart';
import '../datasources/reports_remote_data_source.dart';
import '../../../../l10n/l10n.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource _remote;

  const ReportsRepositoryImpl(this._remote);

  @override
  Stream<List<Report>> watchOpenReports(
    ReportType type, {
    required int limit,
  }) => _remote.watchOpenReports(type, limit: limit);

  @override
  Stream<List<Report>> watchResolvedReports({required int limit}) =>
      _remote.watchResolvedReports(limit: limit);

  @override
  Stream<List<Report>> watchMyReports(String ownerId, {required int limit}) =>
      _remote.watchMyReports(ownerId, limit: limit);

  @override
  Stream<Report?> watchReport(String id) => _remote.watchReport(id);

  @override
  Future<String> createReport({
    required String ownerId,
    required ReportDraft draft,
    void Function(double progress)? onUploadProgress,
  }) => _guard(
    () => _remote.createReport(
      ownerId: ownerId,
      draft: draft,
      onUploadProgress: onUploadProgress,
    ),
    failure: () => appL10n.publishFailed,
  );

  @override
  Future<void> markResolved(Report report) => _guard(
    () => _remote.markResolved(report),
    failure: () => appL10n.updateReportFailed,
  );

  @override
  Future<void> deleteReport(Report report) => _guard(
    () => _remote.deleteReport(report),
    failure: () => appL10n.deleteReportFailed,
  );

  Future<T> _guard<T>(
    Future<T> Function() run, {
    required String Function() failure,
  }) async {
    try {
      return await run();
    } on FirebaseException catch (e) {
      debugPrint('Report action failed: ${e.plugin}/${e.code} ${e.message}');
      throw ReportsException(switch (e.code) {
        'permission-denied' ||
        'unauthorized' ||
        'unauthenticated' => appL10n.errorPermission,
        'unavailable' ||
        'retry-limit-exceeded' ||
        'network-request-failed' => appL10n.errorOffline,
        _ => failure(),
      });
    } catch (e) {
      debugPrint('Report action failed: $e');
      throw ReportsException(failure());
    }
  }
}
