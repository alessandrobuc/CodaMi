import 'dart:math';

import 'package:CodaMi/core/utils/geo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('blurPoint stays within the radius', () {
    final random = Random(7);
    for (var i = 0; i < 300; i++) {
      final (lat, lng) = blurPoint(41.6888, 15.2855, random: random);
      expect(metersBetween(41.6888, 15.2855, lat, lng), lessThanOrEqualTo(101));
    }
  });

  test('metersBetween is roughly right', () {
    expect(metersBetween(41.0, 15.0, 41.01, 15.0), closeTo(1112, 5));
  });

  test('metersPerLogicalPixel halves per zoom level', () {
    final a = metersPerLogicalPixel(41.7, 14);
    final b = metersPerLogicalPixel(41.7, 15);
    expect(a / b, closeTo(2, 1e-9));
  });
}
