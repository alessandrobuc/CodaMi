import 'package:CodaMi/core/utils/number_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('compactCount keeps small numbers and shortens large ones', () {
    expect(compactCount(0), '0');
    expect(compactCount(999), '999');
    expect(compactCount(1000), '1k');
    expect(compactCount(1049), '1k');
    expect(compactCount(1250), '1.2k');
    expect(compactCount(9999), '9.9k');
    expect(compactCount(12500), '12k');
    expect(compactCount(999999), '999k');
    expect(compactCount(1000000), '1M');
    expect(compactCount(2350000), '2.3M');
    expect(compactCount(300, more: true), '300+');
  });
}
