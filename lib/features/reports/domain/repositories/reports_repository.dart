import '../entities/reports_entity.dart';

abstract class ReportsRepository {
  Stream<List<Report>> watchOpenReports(ReportType type);

  Stream<Report?> watchReport(String id);

  Future<String> createReport({
    required String ownerId,
    required ReportDraft draft,
    void Function(double progress)? onUploadProgress,
  });

  Future<void> markResolved(Report report);
}

class ReportsException implements Exception {
  final String message;

  const ReportsException(this.message);

  @override
  String toString() => message;
}
