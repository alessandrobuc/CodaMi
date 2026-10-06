import 'package:CodaMi/core/utils/date_format.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/reports/data/models/reports_model.dart';
import 'package:CodaMi/features/reports/domain/entities/reports_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

const _place = ReportPlace(
  city: 'Milano',
  cityKey: 'milano-mi-it',
  country: 'IT',
  lat: 45.46,
  lng: 9.19,
  label: 'Milano, MI, Italia',
);

ReportDraft _draft({String? phone, String? email, bool whatsapp = true}) =>
    ReportDraft(
      type: ReportType.lost,
      ownerName: ' Ammar ',
      petId: 'pet1',
      petName: 'Milo ',
      species: PetSpecies.dog,
      description: '  Golden retriever with a red collar  ',
      photos: const [],
      place: _place,
      placeDetail: '  ',
      eventAt: DateTime.utc(2026, 10, 6, 14, 30),
      contactPhone: phone,
      contactEmail: email,
      whatsapp: whatsapp,
    );

void main() {
  test('toCreateMap trims, drops empty optionals and sets status', () {
    final map = ReportModel.toCreateMap(
      ownerId: 'u1',
      draft: _draft(phone: ' +39 333 1234567 ', email: ''),
      photoUrls: const ['https://a'],
    );

    expect(map['ownerName'], 'Ammar');
    expect(map['petName'], 'Milo');
    expect(map['description'], 'Golden retriever with a red collar');
    expect(map['type'], 'lost');
    expect(map['status'], 'open');
    expect(map['cityKey'], 'milano-mi-it');
    expect(map['eventAt'], '2026-10-06T14:30:00.000Z');
    expect(map['contactPhone'], '+39 333 1234567');
    expect(map['ownerContact'], '+39 333 1234567');
    expect(map['whatsapp'], true);
    expect(map.containsKey('contactEmail'), isFalse);
    expect(map.containsKey('placeDetail'), isFalse);
    expect(map['createdAt'], isA<FieldValue>());
  });

  test('whatsapp is false without a phone, email becomes the contact', () {
    final map = ReportModel.toCreateMap(
      ownerId: 'u1',
      draft: _draft(email: 'me@mail.com'),
      photoUrls: const ['https://a'],
    );
    expect(map['whatsapp'], false);
    expect(map['ownerContact'], 'me@mail.com');
  });

  test('fromMap round-trips the important fields', () {
    final report = ReportModel.fromMap('r1', {
      'ownerId': 'u1',
      'ownerName': 'Ammar',
      'type': 'found',
      'petName': 'Unknown cat',
      'species': 'cat',
      'description': 'Found near the park',
      'photoUrls': ['https://a'],
      'city': 'Milano',
      'cityKey': 'milano-mi-it',
      'placeDetail': 'Parco Sempione',
      'lat': 45,
      'lng': 9,
      'eventAt': '2026-10-06T14:30:00.000Z',
      'status': 'resolved',
      'contactEmail': 'me@mail.com',
      'createdAt': Timestamp.fromDate(DateTime(2026, 10, 6)),
    });

    expect(report.type, ReportType.found);
    expect(report.species, PetSpecies.cat);
    expect(report.status, ReportStatus.resolved);
    expect(report.isOpen, isFalse);
    expect(report.lat, 45.0);
    expect(report.eventAt.toUtc(), DateTime.utc(2026, 10, 6, 14, 30));
    expect(report.placeLabel, 'Parco Sempione, Milano');
    expect(report.contactPhone, isNull);
    expect(report.whatsapp, isFalse);
    expect(report.ownerContact, 'me@mail.com');
  });

  test('timeAgo reads naturally', () {
    final now = DateTime(2026, 10, 6, 12);
    expect(
      timeAgo(now.subtract(const Duration(seconds: 20)), now: now),
      'Just now',
    );
    expect(
      timeAgo(now.subtract(const Duration(minutes: 5)), now: now),
      '5 min ago',
    );
    expect(
      timeAgo(now.subtract(const Duration(hours: 3)), now: now),
      '3 h ago',
    );
    expect(
      timeAgo(now.subtract(const Duration(days: 1)), now: now),
      'Yesterday',
    );
    expect(
      timeAgo(now.subtract(const Duration(days: 4)), now: now),
      '4 days ago',
    );
  });
}
