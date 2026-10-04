import 'package:CodaMi/features/location/data/datasources/places_service.dart';
import 'package:CodaMi/features/location/data/models/city_place.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';

const _milano = PlaceSuggestion(
  placeId: 'ChIJ53USP0nBhkcRjQ50xhPN_zw',
  mainText: 'Milano',
  secondaryText: 'MI, Italia',
);

void main() {
  test('searchCities calls the function with a session token', () async {
    final calls = <(String, Map<String, dynamic>)>[];
    final service = PlacesService(
      invoke: (name, data) async {
        calls.add((name, data));
        return {
          'suggestions': [
            {
              'placeId': _milano.placeId,
              'mainText': 'Milano',
              'secondaryText': 'MI, Italia',
            },
            {'placeId': '', 'mainText': 'broken'},
          ],
        };
      },
    );

    final results = await service.searchCities('  Mil ');

    expect(calls.single.$1, 'searchCities');
    expect(calls.single.$2['input'], 'Mil');
    expect((calls.single.$2['sessionToken'] as String).length, 32);
    expect(results.single.mainText, 'Milano');
  });

  test('search and details share one session, then it resets', () async {
    final tokens = <String>[];
    final service = PlacesService(
      invoke: (name, data) async {
        tokens.add(data['sessionToken'] as String);
        if (name == 'searchCities') return {'suggestions': []};
        return {
          'placeId': _milano.placeId,
          'city': 'Milano',
          'province': 'MI',
          'region': 'Lombardia',
          'country': 'IT',
          'countryName': 'Italia',
          'lat': 45.4642035,
          'lng': 9.189982,
        };
      },
    );

    await service.searchCities('Mil');
    final place = await service.cityDetails(_milano);
    await service.searchCities('Rom');

    expect(tokens[0], tokens[1]);
    expect(tokens[2], isNot(tokens[1]));
    expect(place.cityKey, 'milano-mi-it');
    expect(place.label, 'Milano, MI, Italia');
    expect(place.toUserFields()['homeLat'], closeTo(45.46, 0.01));
  });

  test(
    'details fall back to the suggestion name when city is missing',
    () async {
      final service = PlacesService(
        invoke: (_, _) async => {
          'placeId': '',
          'city': '',
          'province': null,
          'region': null,
          'country': 'it',
          'countryName': 'Italia',
          'lat': 45,
          'lng': 9,
        },
      );

      final place = await service.cityDetails(_milano);
      expect(place.city, 'Milano');
      expect(place.placeId, _milano.placeId);
      expect(place.country, 'IT');
      expect(place.cityKey, 'milano-it');
    },
  );

  test('long foreign provinces stay out of the key and label', () {
    const place = CityPlace(
      placeId: 'ChIJ1RphbMSQOzkRYvgD4agN3_w',
      city: 'Bahawalpur',
      province: 'Distretto di Bahawalpur',
      region: 'Punjab',
      country: 'PK',
      countryName: 'Pakistan',
      lat: 29.3885,
      lng: 71.7016,
    );
    expect(place.cityKey, 'bahawalpur-pk');
    expect(place.label, 'Bahawalpur, Pakistan');
    expect(place.toUserFields()['province'], 'Distretto di Bahawalpur');
  });

  test('short queries do not call the function', () async {
    var calls = 0;
    final service = PlacesService(
      invoke: (_, _) async {
        calls++;
        return {};
      },
    );
    expect(await service.searchCities('M'), isEmpty);
    expect(calls, 0);
  });

  test('function errors become friendly messages', () async {
    Future<void> expectMessage(String code, String text) async {
      final service = PlacesService(
        invoke: (_, _) async =>
            throw FirebaseFunctionsException(message: 'boom', code: code),
      );
      await expectLater(
        service.searchCities('Milano'),
        throwsA(
          isA<PlacesException>().having(
            (e) => e.message,
            'message',
            contains(text),
          ),
        ),
      );
    }

    await expectMessage('unauthenticated', 'sign in again');
    await expectMessage('unavailable', 'connection');
    await expectMessage('failed-precondition', 'City search failed');
  });

  test('suggestions split area and country for display', () {
    const it = PlaceSuggestion(
      placeId: 'a',
      mainText: 'Milano',
      secondaryText: 'MI, Italia',
    );
    const pk = PlaceSuggestion(
      placeId: 'b',
      mainText: 'Bahawalpur',
      secondaryText: 'Pakistan',
    );
    const pkSindh = PlaceSuggestion(
      placeId: 'c',
      mainText: 'Bahawalpur',
      secondaryText: 'Dadu, Sindh, Pakistan',
    );
    expect((it.area, it.country), ('MI', 'Italia'));
    expect((pk.area, pk.country), ('', 'Pakistan'));
    expect((pkSindh.area, pkSindh.country), ('Dadu, Sindh', 'Pakistan'));
  });

  test('malformed details become a friendly error', () async {
    final service = PlacesService(invoke: (_, _) async => {'city': 'Milano'});
    await expectLater(
      service.cityDetails(_milano),
      throwsA(isA<PlacesException>()),
    );
  });

  test('slugify strips accents and punctuation', () {
    expect(slugify('Forlì FC IT'), 'forli-fc-it');
    expect(slugify("Sant'Agata de' Goti BN IT"), 'sant-agata-de-goti-bn-it');
  });
}
