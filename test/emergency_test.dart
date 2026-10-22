import 'package:CodaMi/features/emergency/domain/emergency.dart';
import 'package:CodaMi/features/emergency/presentation/providers/emergency_provider.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:flutter_test/flutter_test.dart';

EmergencyContact _contact(String id, double lat, {bool isTest = false}) =>
    EmergencyContact(
      id: id,
      name: id,
      kind: ContactKind.vet,
      lat: lat,
      lng: 9.19,
      isTest: isTest,
    );

void main() {
  test('emergencies read the server values', () {
    final e = Emergency.fromMap('e1', {
      'ownerId': 'u1',
      'ownerName': 'Fede',
      'type': 'urgent_found',
      'species': 'cat',
      'description': 'Kitten in a drain',
      'photoUrls': ['a', 1],
      'lat': 45.4,
      'lng': 9.1,
      'status': 'false_alarm',
      'helpers': ['u2'],
      'suggestedContacts': [
        {
          'id': 'c1',
          'name': 'TEST – Vet',
          'kind': 'public_service',
          'phones': ['+39 000', ''],
          'lat': 45.4,
          'lng': 9.1,
          'isTest': true,
          'distanceKm': 1.2,
        },
      ],
    });
    expect(e.type, EmergencyType.urgentFound);
    expect(e.species, PetSpecies.cat);
    expect(e.status, EmergencyStatus.falseAlarm);
    expect(e.status.isActive, isFalse);
    expect(e.photoUrls, ['a']);
    expect(e.helpers, ['u2']);
    final c = e.suggestedContacts!.single;
    expect(c.kind, ContactKind.publicService);
    expect(c.phones, ['+39 000']);
    expect(c.isTest, isTrue);
    expect(c.distanceKm, 1.2);
  });

  test('contacts are only ready once the server adds them', () {
    final e = Emergency.fromMap('e1', {'status': 'open'});
    expect(e.suggestedContacts, isNull);
    expect(e.status.isActive, isTrue);
    expect(EmergencyType.fromValue('nope'), EmergencyType.other);
  });

  test('a contact saves the fields the rules allow', () {
    final map = _contact('c1', 45.4).toMap();
    expect(map.keys, isNot(contains('id')));
    expect(map.keys, isNot(contains('distanceKm')));
    expect(map['kind'], 'vet');
    expect(map['types'], isEmpty);
  });

  test('browsing lists real contacts before test ones, then by distance', () {
    final sorted = sortedForBrowsing(
      [
        _contact('test-near', 45.47, isTest: true),
        _contact('far', 45.9),
        _contact('near', 45.47),
      ],
      lat: 45.4642,
      lng: 9.19,
    );
    expect(sorted.map((c) => c.id), ['near', 'far', 'test-near']);
  });
}
