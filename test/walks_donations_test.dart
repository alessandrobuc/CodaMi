import 'package:flutter_test/flutter_test.dart';
import 'package:CodaMi/features/donations/domain/donations.dart';
import 'package:CodaMi/features/walks/domain/walks.dart';

void main() {
  const center = (45.4642, 9.1900);

  WalkPlace place(String id, double lat, double lng, WalkGroup group) =>
      WalkPlace(
        id: id,
        name: id,
        address: '',
        lat: lat,
        lng: lng,
        group: group,
      );

  test('walk places are sorted by distance and kept inside the radius', () {
    final places = [
      place('far', 45.50, 9.19, WalkGroup.parks),
      place('near', 45.4650, 9.1905, WalkGroup.dogParks),
      place('mid', 45.4750, 9.1900, WalkGroup.trails),
    ];
    expect(
      placesNear(places, center.$1, center.$2, radiusKm: 5).map((p) => p.id),
      ['near', 'mid', 'far'],
    );
    expect(
      placesNear(places, center.$1, center.$2, radiusKm: 1).map((p) => p.id),
      ['near'],
    );
    expect(
      placesNear(
        places,
        center.$1,
        center.$2,
        radiusKm: 5,
        group: WalkGroup.trails,
      ).map((p) => p.id),
      ['mid'],
    );
  });

  test('distances read naturally', () {
    expect(formatDistance(84), '80 m');
    expect(formatDistance(950), '950 m');
    expect(formatDistance(1260), '1.3 km');
    expect(formatDistance(12400), '12 km');
  });

  test('walks settings: defaults, hide and show again', () {
    final c = WalksConfig.fromMap({
      'enabled': true,
      'defaultRadiusKm': 7,
      'groups': {'trails': false},
      'dailySearches': 0,
    });
    expect(c.enabled, isTrue);
    expect(c.defaultRadiusKm, 5);
    expect(c.activeGroups, [
      WalkGroup.dogParks,
      WalkGroup.parks,
      WalkGroup.green,
    ]);
    expect(c.dailySearches, 40);
    final hidden = c.hide('abc', 'Parco X');
    expect(hidden.hiddenPlaceIds, ['abc']);
    expect(hidden.hiddenNames, {'abc': 'Parco X'});
    expect(hidden.hide('abc', 'Parco X').hiddenPlaceIds, ['abc']);
    final shown = hidden.unhide('abc');
    expect(shown.hiddenPlaceIds, isEmpty);
    expect(shown.hiddenNames, isEmpty);
    expect(WalksConfig.fromMap(hidden.toMap()).hiddenNames, {'abc': 'Parco X'});
  });

  test('directions open Google Maps on foot', () {
    final uri = directionsUri(place('ChIJ1', 45.1, 9.2, WalkGroup.parks));
    expect(uri.host, 'www.google.com');
    expect(uri.queryParameters['destination'], '45.1,9.2');
    expect(uri.queryParameters['destination_place_id'], 'ChIJ1');
    expect(uri.queryParameters['travelmode'], 'walking');
  });

  test('donations are off by default and each place has its own switch', () {
    const off = DonationsConfig();
    expect(off.shows(DonationTrigger.afterReport), isFalse);
    final on = DonationsConfig.fromMap({'enabled': true, 'afterFound': false});
    expect(on.shows(DonationTrigger.afterReport), isTrue);
    expect(on.shows(DonationTrigger.afterFound), isFalse);
    expect(on.paymentsReady, isFalse);
    expect(DonationsConfig.fromMap({'amountsCents': []}).amountsCents, [
      100,
      300,
      500,
      1000,
      2500,
    ]);
  });

  test('the support message waits the chosen number of days', () {
    final now = DateTime(2026, 11, 2);
    expect(promptDue(null, now, 30), isTrue);
    expect(promptDue(DateTime(2026, 10, 20), now, 30), isFalse);
    expect(promptDue(DateTime(2026, 10, 3), now, 30), isTrue);
  });

  test('amounts typed by the admin', () {
    expect(parseAmounts('1, 3, 5,10 , 25'), [100, 300, 500, 1000, 2500]);
    expect(parseAmounts('2.5; 5'), [250, 500]);
    expect(parseAmounts('5, 1, 5'), [100, 500]);
    expect(parseAmounts(''), isNull);
    expect(parseAmounts('0'), isNull);
    expect(parseAmounts('abc'), isNull);
    expect(parseAmounts('1,2,3,4,5,6,7'), isNull);
    expect(amountsInput([100, 250, 1000]), '1, 2.50, 10');
  });
}
