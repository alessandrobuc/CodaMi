import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import '../../../../core/utils/geo.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../../reports/presentation/providers/reports_provider.dart';

const areaRadiusOptions = [1, 5, 10, 25, 50];

class AreaRadius extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? km) => state = km;
}

final areaRadiusProvider = NotifierProvider<AreaRadius, int?>(AreaRadius.new);

final homeCenterProvider = Provider<LatLng?>((ref) {
  final profile = ref.watch(userProfileProvider).value;
  final lat = profile?.homeLat;
  final lng = profile?.homeLng;
  return lat == null || lng == null ? null : LatLng(lat, lng);
});

List<Report> filterByArea(List<Report> reports, LatLng? center, int? km) {
  if (center == null || km == null) return reports;
  final meters = km * 1000;
  return [
    for (final r in reports)
      if (metersBetween(center.latitude, center.longitude, r.lat, r.lng) <=
          meters)
        r,
  ];
}

final areaReportsProvider =
    Provider.family<AsyncValue<List<Report>>, ReportType>((ref, type) {
      final center = ref.watch(homeCenterProvider);
      final km = ref.watch(areaRadiusProvider);
      final limit = ref.watch(reportsLimitProvider(type));
      return ref
          .watch(openReportsProvider(type))
          .whenData(
            (reports) => filterByArea(reports.take(limit).toList(), center, km),
          );
    });

final mapAreaReportsProvider =
    Provider.family<AsyncValue<List<Report>>, ReportType>((ref, type) {
      final center = ref.watch(homeCenterProvider);
      final km = ref.watch(areaRadiusProvider);
      return ref
          .watch(mapReportsProvider(type))
          .whenData(
            (reports) =>
                filterByArea(reports.take(mapPinLimit).toList(), center, km),
          );
    });

final mapHasMoreProvider = Provider.family<bool, ReportType>(
  (ref, type) =>
      (ref.watch(mapReportsProvider(type)).value?.length ?? 0) > mapPinLimit,
);

final areaResolvedReportsProvider = Provider<AsyncValue<List<Report>>>((ref) {
  final center = ref.watch(homeCenterProvider);
  final km = ref.watch(areaRadiusProvider);
  return ref
      .watch(resolvedReportsProvider)
      .whenData((reports) => filterByArea(reports, center, km));
});
