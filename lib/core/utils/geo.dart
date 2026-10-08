import 'dart:math';

const publicAreaRadius = 100;

const _metersPerDegree = 111320.0;

(double, double) blurPoint(
  double lat,
  double lng, {
  int radiusMeters = publicAreaRadius,
  Random? random,
}) {
  final rnd = random ?? Random.secure();
  final distance = radiusMeters * sqrt(rnd.nextDouble());
  final angle = 2 * pi * rnd.nextDouble();
  double round(double v) => (v * 1e6).roundToDouble() / 1e6;
  return (
    round(lat + distance * cos(angle) / _metersPerDegree),
    round(
      lng + distance * sin(angle) / (_metersPerDegree * cos(lat * pi / 180)),
    ),
  );
}

double metersBetween(double lat1, double lng1, double lat2, double lng2) {
  const earth = 6371000.0;
  final dLat = (lat2 - lat1) * pi / 180;
  final dLng = (lng2 - lng1) * pi / 180;
  final a =
      pow(sin(dLat / 2), 2) +
      cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * pow(sin(dLng / 2), 2);
  return 2 * earth * asin(sqrt(a));
}

double metersPerLogicalPixel(double lat, double zoom) =>
    156543.03392 * cos(lat * pi / 180) / pow(2, zoom);
