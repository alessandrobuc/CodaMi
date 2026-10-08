import 'package:CodaMi/features/map/domain/clustering.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/reports/domain/entities/reports_entity.dart';
import 'package:flutter_test/flutter_test.dart';

Report _r(
  String id,
  double lat,
  double lng,
  ReportType type, {
  ReportStatus status = ReportStatus.open,
}) => Report(
  id: id,
  ownerId: 'u',
  ownerName: 'A',
  type: type,
  petName: 'P',
  species: PetSpecies.dog,
  description: 'd',
  photoUrls: const [],
  country: 'IT',
  city: 'C',
  cityKey: 'c',
  lat: lat,
  lng: lng,
  eventAt: DateTime(2026),
  status: status,
);

void main() {
  final reports = [
    _r('a', 41.6888, 15.2855, ReportType.lost),
    _r('b', 41.6889, 15.2856, ReportType.found),
    _r('c', 41.6890, 15.2854, ReportType.lost),
    _r('far', 45.4642, 9.19, ReportType.lost),
  ];

  test('nearby reports merge when zoomed out', () {
    final clusters = clusterReports(reports, 12);
    expect(clusters, hasLength(2));
    final town = clusters.firstWhere((c) => c.reports.length == 3);
    expect(town.lostCount, 2);
    expect(town.lat, closeTo(41.6889, 1e-4));
    expect(clusters.firstWhere((c) => c.isSingle).id, 'far');
  });

  test('a lost pet that is back home counts as found in a bubble', () {
    final clusters = clusterReports([
      _r('a', 41.6888, 15.2855, ReportType.lost),
      _r('b', 41.6889, 15.2856, ReportType.lost, status: ReportStatus.resolved),
    ], 12);
    expect(clusters.single.lostCount, 1);
  });

  test('every report stands alone when zoomed far in', () {
    expect(clusterReports(reports, 17.2), hasLength(4));
  });

  test('worldPixel doubles per zoom level', () {
    final (x1, y1) = worldPixel(41.7, 15.3, 10);
    final (x2, y2) = worldPixel(41.7, 15.3, 11);
    expect(x2 / x1, closeTo(2, 1e-9));
    expect(y2 / y1, closeTo(2, 1e-9));
  });
}
