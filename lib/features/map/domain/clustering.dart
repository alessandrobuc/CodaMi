import 'dart:math';

import '../../reports/domain/entities/reports_entity.dart';

class ReportCluster {
  final List<Report> reports;
  final double lat;
  final double lng;

  const ReportCluster(this.reports, this.lat, this.lng);

  bool get isSingle => reports.length == 1;

  int get lostCount =>
      reports.where((r) => r.type == ReportType.lost && r.isOpen).length;

  String get id => isSingle ? reports.first.id : 'c-${reports.first.id}';
}

const clusterMaxZoom = 17;

(double, double) worldPixel(double lat, double lng, int zoom) {
  final size = 256.0 * pow(2, zoom);
  final sinLat = sin(lat.clamp(-85.0, 85.0) * pi / 180);
  final x = (lng + 180) / 360 * size;
  final y = (0.5 - log((1 + sinLat) / (1 - sinLat)) / (4 * pi)) * size;
  return (x, y);
}

List<ReportCluster> clusterReports(
  List<Report> reports,
  double zoom, {
  double cellPixels = 64,
}) {
  final level = zoom.floor();
  if (level >= clusterMaxZoom) {
    return [
      for (final r in reports) ReportCluster([r], r.lat, r.lng),
    ];
  }
  final groups = <(double, double, List<Report>)>[];
  final radiusSq = cellPixels * cellPixels;
  for (final r in reports) {
    final (x, y) = worldPixel(r.lat, r.lng, level);
    final match = groups.indexWhere((g) {
      final dx = g.$1 - x;
      final dy = g.$2 - y;
      return dx * dx + dy * dy <= radiusSq;
    });
    if (match == -1) {
      groups.add((x, y, [r]));
    } else {
      groups[match].$3.add(r);
    }
  }
  return [
    for (final (_, _, members) in groups)
      ReportCluster(
        members,
        members.map((r) => r.lat).reduce((a, b) => a + b) / members.length,
        members.map((r) => r.lng).reduce((a, b) => a + b) / members.length,
      ),
  ];
}
