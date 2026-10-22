import 'package:cloud_firestore/cloud_firestore.dart';

import '../../pets/domain/entities/pets_entity.dart';

// Values match the server (`functions/src/emergency.ts`).
enum EmergencyType {
  injured('injured'),
  danger('danger'),
  abandoned('abandoned'),
  urgentFound('urgent_found'),
  intervention('intervention'),
  other('other');

  const EmergencyType(this.value);

  final String value;

  static EmergencyType fromValue(Object? value) =>
      values.where((t) => t.value == value).firstOrNull ?? other;
}

enum EmergencyStatus {
  open('open'),
  helping('helping'),
  resolved('resolved'),
  closed('closed'),
  falseAlarm('false_alarm');

  const EmergencyStatus(this.value);

  final String value;

  bool get isActive => this == open || this == helping;

  static EmergencyStatus fromValue(Object? value) =>
      values.where((s) => s.value == value).firstOrNull ?? open;
}

enum EmergencyAction {
  helping('helping'),
  resolved('resolved'),
  closed('closed'),
  falseAlarm('false_alarm'),
  reopen('reopen'),
  reportFalse('report_false');

  const EmergencyAction(this.value);

  final String value;
}

enum ContactKind {
  vet('vet'),
  association('association'),
  publicService('public_service'),
  other('other');

  const ContactKind(this.value);

  final String value;

  static ContactKind fromValue(Object? value) =>
      values.where((k) => k.value == value).firstOrNull ?? other;
}

// A directory entry, or the copy saved on an emergency with its distance.
class EmergencyContact {
  final String id;
  final String name;
  final ContactKind kind;
  final List<String> phones;
  final String? email;
  final String? address;
  final String? city;
  final double lat;
  final double lng;
  final double? areaKm;
  final Set<EmergencyType> types;
  final bool open24h;
  final String? hours;
  final bool verified;
  final bool recommended;
  final bool active;
  final bool isTest;
  final double? distanceKm;

  const EmergencyContact({
    required this.id,
    required this.name,
    required this.kind,
    required this.lat,
    required this.lng,
    this.phones = const [],
    this.email,
    this.address,
    this.city,
    this.areaKm,
    this.types = const {},
    this.open24h = false,
    this.hours,
    this.verified = false,
    this.recommended = false,
    this.active = true,
    this.isTest = false,
    this.distanceKm,
  });

  factory EmergencyContact.fromMap(String id, Map<String, dynamic> map) {
    String? text(Object? v) =>
        v is String && v.trim().isNotEmpty ? v.trim() : null;
    return EmergencyContact(
      id: id,
      name: map['name'] as String? ?? '',
      kind: ContactKind.fromValue(map['kind']),
      phones: [
        for (final p in map['phones'] as List? ?? const [])
          if (p is String && p.trim().isNotEmpty) p.trim(),
      ],
      email: text(map['email']),
      address: text(map['address']),
      city: text(map['city']),
      lat: (map['lat'] as num?)?.toDouble() ?? 0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0,
      areaKm: (map['areaKm'] as num?)?.toDouble(),
      types: {
        for (final t in map['types'] as List? ?? const [])
          EmergencyType.fromValue(t),
      },
      open24h: map['open24h'] == true,
      hours: text(map['hours']),
      verified: map['verified'] == true,
      recommended: map['recommended'] == true,
      active: map['active'] != false,
      isTest: map['isTest'] == true,
      distanceKm: (map['distanceKm'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'kind': kind.value,
    'phones': phones,
    'email': email,
    'address': address,
    'city': city,
    'lat': lat,
    'lng': lng,
    'areaKm': areaKm,
    'types': [for (final t in types) t.value],
    'open24h': open24h,
    'hours': hours,
    'verified': verified,
    'recommended': recommended,
    'active': active,
    'isTest': isTest,
  };
}

class Emergency {
  final String id;
  final String ownerId;
  final String ownerName;
  final EmergencyType type;
  final PetSpecies species;
  final String description;
  final List<String> photoUrls;
  final double lat;
  final double lng;
  final String? placeLabel;
  final String? city;
  final String? contactPhone;
  final EmergencyStatus status;
  final DateTime? createdAt;
  final List<String> helpers;
  final int falseReports;

  // Filled by the server a few seconds after the report is sent.
  final List<EmergencyContact>? suggestedContacts;
  final int? alertedUsers;

  const Emergency({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.type,
    required this.species,
    required this.description,
    required this.photoUrls,
    required this.lat,
    required this.lng,
    required this.status,
    this.placeLabel,
    this.city,
    this.contactPhone,
    this.createdAt,
    this.helpers = const [],
    this.falseReports = 0,
    this.suggestedContacts,
    this.alertedUsers,
  });

  String? get coverUrl => photoUrls.isEmpty ? null : photoUrls.first;

  factory Emergency.fromMap(String id, Map<String, dynamic> map) {
    final contacts = map['suggestedContacts'];
    return Emergency(
      id: id,
      ownerId: map['ownerId'] as String? ?? '',
      ownerName: map['ownerName'] as String? ?? '',
      type: EmergencyType.fromValue(map['type']),
      species: PetSpecies.fromValue(map['species'] as String?),
      description: map['description'] as String? ?? '',
      photoUrls: [
        for (final p in map['photoUrls'] as List? ?? const [])
          if (p is String) p,
      ],
      lat: (map['lat'] as num?)?.toDouble() ?? 0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0,
      placeLabel: map['placeLabel'] as String?,
      city: map['city'] as String?,
      contactPhone: map['contactPhone'] as String?,
      status: EmergencyStatus.fromValue(map['status']),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      helpers: [
        for (final h in map['helpers'] as List? ?? const [])
          if (h is String) h,
      ],
      falseReports: (map['falseReports'] as num?)?.toInt() ?? 0,
      suggestedContacts: contacts is List
          ? [
              for (final c in contacts)
                if (c is Map<String, dynamic>)
                  EmergencyContact.fromMap(c['id'] as String? ?? '', c),
            ]
          : null,
      alertedUsers: (map['alertedUsers'] as num?)?.toInt(),
    );
  }
}

class EmergencyDraft {
  final EmergencyType type;
  final PetSpecies species;
  final String description;
  final List<PetPhoto> photos;
  final double lat;
  final double lng;
  final String? placeLabel;
  final String? city;
  final String? cityKey;
  final String? contactPhone;

  const EmergencyDraft({
    required this.type,
    required this.species,
    required this.description,
    required this.photos,
    required this.lat,
    required this.lng,
    this.placeLabel,
    this.city,
    this.cityKey,
    this.contactPhone,
  });
}
