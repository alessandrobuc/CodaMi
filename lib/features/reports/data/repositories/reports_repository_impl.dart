import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/reports_entity.dart';
import '../../domain/repositories/reports_repository.dart';
import '../datasources/reports_remote_data_source.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource _remote;

  const ReportsRepositoryImpl(this._remote);

  @override
  Stream<List<Report>> watchOpenReports(ReportType type) =>
      _remote.watchOpenReports(type);

  @override
  Stream<List<Report>> watchResolvedReports() => _remote.watchResolvedReports();

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
    failure: 'Couldn\'t publish your report. Please try again.',
  );

  @override
  Future<void> markResolved(Report report) => _guard(
    () => _remote.markResolved(report),
    failure: 'Couldn\'t update the report. Please try again.',
  );

  Future<T> _guard<T>(
    Future<T> Function() run, {
    required String failure,
  }) async {
    try {
      return await run();
    } on FirebaseException catch (e) {
      debugPrint('Report action failed: ${e.plugin}/${e.code} ${e.message}');
      throw ReportsException(switch (e.code) {
        'permission-denied' ||
        'unauthorized' ||
        'unauthenticated' => 'You don\'t have permission to do that.',
        'unavailable' || 'retry-limit-exceeded' || 'network-request-failed' =>
          'You\'re offline. Check your connection and try again.',
        _ => failure,
      });
    } catch (e) {
      debugPrint('Report action failed: $e');
      throw ReportsException(failure);
    }
  }
}
