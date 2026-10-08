import '../../../reports/domain/entities/reports_entity.dart';

enum NotificationKind {
  newReport,
  reportResolved;

  static NotificationKind fromValue(String? value) =>
      value == 'report_resolved' ? reportResolved : newReport;
}

class AppNotification {
  final String id;
  final NotificationKind kind;
  final String title;
  final String body;
  final String? reportId;
  final ReportType reportType;
  final String? photoUrl;
  final bool read;
  final DateTime? createdAt;

  const AppNotification({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.reportType,
    required this.read,
    this.reportId,
    this.photoUrl,
    this.createdAt,
  });
}
