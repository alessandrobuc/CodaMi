import '../../../reports/domain/entities/reports_entity.dart';

enum NotificationKind {
  newReport,
  reportResolved,
  emergency;

  static NotificationKind fromValue(String? value) => switch (value) {
    'report_resolved' => reportResolved,
    'emergency' => emergency,
    _ => newReport,
  };
}

class AppNotification {
  final String id;
  final NotificationKind kind;
  final String title;
  final String body;
  final String? reportId;
  final String? emergencyId;
  final ReportType reportType;
  final String? photoUrl;
  final String? petName;
  final String? city;
  final String? placeDetail;
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
    this.emergencyId,
    this.photoUrl,
    this.petName,
    this.city,
    this.placeDetail,
    this.createdAt,
  });
}
