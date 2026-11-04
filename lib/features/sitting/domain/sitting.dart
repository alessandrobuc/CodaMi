import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/geo.dart';
import '../../heat/domain/heat.dart' show parseHeatDay;
import '../../pets/domain/entities/pets_entity.dart';

// Must match the lists in firestore.rules.
enum SittingService { visits, overnight, walks, daycare, boarding }

enum SittingStatus { open, booked, done, closed }

enum OfferStatus { pending, accepted, declined, withdrawn }

const sittingAreasKm = [2, 5, 10, 25, 50];
const sittingDistancesKm = [5, 10, 25, 50];

T _enumOf<T extends Enum>(List<T> values, Object? v, T fallback) =>
    values.where((e) => e.name == v).firstOrNull ?? fallback;

List<T> _enumsOf<T extends Enum>(List<T> values, Object? list) => [
  for (final v in values)
    if (list is List && list.contains(v.name)) v,
];

String _text(Object? v) => v is String ? v : '';
double? _num(Object? v) => v is num ? v.toDouble() : null;
DateTime? _time(Object? v) => v is Timestamp ? v.toDate() : null;

// Rounded so a request never shows more than the area.
double roundPlace(double v) => (v * 100).round() / 100;

String sittingChatId(String a, String b) =>
    a.compareTo(b) < 0 ? '${a}_$b' : '${b}_$a';

double? kmBetween(double? lat1, double? lng1, double? lat2, double? lng2) {
  if (lat1 == null || lng1 == null || lat2 == null || lng2 == null) {
    return null;
  }
  return metersBetween(lat1, lng1, lat2, lng2) / 1000;
}

class SittingConfig {
  final bool enabled;
  final int minAccountDays;

  const SittingConfig({this.enabled = false, this.minAccountDays = 3});

  factory SittingConfig.fromMap(Map<String, dynamic>? map) {
    final days = map?['minAccountDays'];
    return SittingConfig(
      enabled: map?['enabled'] == true,
      minAccountDays: days is int && days >= 0 && days <= 60 ? days : 3,
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'minAccountDays': minAccountDays,
  };

  SittingConfig copyWith({bool? enabled, int? minAccountDays}) => SittingConfig(
    enabled: enabled ?? this.enabled,
    minAccountDays: minAccountDays ?? this.minAccountDays,
  );
}

class SitterProfile {
  final String uid;
  final String name;
  final String? photoUrl;
  final String about;
  final String experience;
  final List<PetSpecies> species;
  final List<SittingService> services;
  final String availability;
  final String city;
  final double? lat;
  final double? lng;
  final int areaKm;
  final bool active;
  final bool hidden;
  final int ratingSum;
  final int reviewCount;
  final int completedCount;

  const SitterProfile({
    required this.uid,
    required this.name,
    this.photoUrl,
    this.about = '',
    this.experience = '',
    this.species = const [],
    this.services = const [],
    this.availability = '',
    this.city = '',
    this.lat,
    this.lng,
    this.areaKm = 10,
    this.active = true,
    this.hidden = false,
    this.ratingSum = 0,
    this.reviewCount = 0,
    this.completedCount = 0,
  });

  double? get rating => reviewCount == 0 ? null : ratingSum / reviewCount;

  factory SitterProfile.fromMap(String id, Map<String, dynamic> m) =>
      SitterProfile(
        uid: id,
        name: _text(m['name']),
        photoUrl: m['photoUrl'] as String?,
        about: _text(m['about']),
        experience: _text(m['experience']),
        species: _enumsOf(PetSpecies.values, m['species']),
        services: _enumsOf(SittingService.values, m['services']),
        availability: _text(m['availability']),
        city: _text(m['city']),
        lat: _num(m['lat']),
        lng: _num(m['lng']),
        areaKm: m['areaKm'] is int ? m['areaKm'] as int : 10,
        active: m['active'] != false,
        hidden: m['hidden'] == true,
        ratingSum: m['ratingSum'] is int ? m['ratingSum'] as int : 0,
        reviewCount: m['reviewCount'] is int ? m['reviewCount'] as int : 0,
        completedCount: m['completedCount'] is int
            ? m['completedCount'] as int
            : 0,
      );

  Map<String, Object?> toFields() => {
    'uid': uid,
    'name': name,
    'photoUrl': photoUrl,
    'about': about.trim(),
    'experience': experience.trim(),
    'species': [for (final s in species) s.name],
    'services': [for (final s in services) s.name],
    'availability': availability.trim(),
    'city': city,
    'lat': lat,
    'lng': lng,
    'areaKm': areaKm,
    'active': active,
  };
}

class SittingRequest {
  final String id;
  final String ownerId;
  final String ownerName;
  final List<String> petIds;
  final List<String> petNames;
  final List<PetSpecies> species;
  final SittingService service;
  final DateTime start;
  final DateTime end;
  final String city;
  final double? lat;
  final double? lng;
  final String notes;
  final String budget;
  final SittingStatus status;
  final bool hidden;
  final int offerCount;
  final String? sitterId;
  final String sitterName;
  final bool ownerConfirmed;
  final bool sitterConfirmed;
  final DateTime? createdAt;

  const SittingRequest({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.petIds,
    required this.petNames,
    required this.species,
    required this.service,
    required this.start,
    required this.end,
    required this.city,
    this.lat,
    this.lng,
    this.notes = '',
    this.budget = '',
    this.status = SittingStatus.open,
    this.hidden = false,
    this.offerCount = 0,
    this.sitterId,
    this.sitterName = '',
    this.ownerConfirmed = false,
    this.sitterConfirmed = false,
    this.createdAt,
  });

  bool get started => !DateTime.now().isBefore(start);

  static SittingRequest? fromMap(String id, Map<String, dynamic> m) {
    final start = parseHeatDay(m['start']);
    final end = parseHeatDay(m['end']);
    if (start == null || end == null) return null;
    return SittingRequest(
      id: id,
      ownerId: _text(m['ownerId']),
      ownerName: _text(m['ownerName']),
      petIds: [for (final p in m['petIds'] as List? ?? const []) '$p'],
      petNames: [for (final p in m['petNames'] as List? ?? const []) '$p'],
      species: _enumsOf(PetSpecies.values, m['species']),
      service: _enumOf(
        SittingService.values,
        m['service'],
        SittingService.visits,
      ),
      start: start,
      end: end,
      city: _text(m['city']),
      lat: _num(m['lat']),
      lng: _num(m['lng']),
      notes: _text(m['notes']),
      budget: _text(m['budget']),
      status: _enumOf(SittingStatus.values, m['status'], SittingStatus.closed),
      hidden: m['hidden'] == true,
      offerCount: m['offerCount'] is int ? m['offerCount'] as int : 0,
      sitterId: m['sitterId'] as String?,
      sitterName: _text(m['sitterName']),
      ownerConfirmed: m['ownerConfirmed'] == true,
      sitterConfirmed: m['sitterConfirmed'] == true,
      createdAt: _time(m['createdAt']),
    );
  }
}

class SittingOffer {
  final String requestId;
  final String ownerId;
  final String sitterId;
  final String sitterName;
  final String message;
  final String price;
  final OfferStatus status;
  final DateTime? createdAt;

  const SittingOffer({
    required this.requestId,
    required this.ownerId,
    required this.sitterId,
    required this.sitterName,
    this.message = '',
    this.price = '',
    this.status = OfferStatus.pending,
    this.createdAt,
  });

  String get id => '${requestId}_$sitterId';

  factory SittingOffer.fromMap(Map<String, dynamic> m) => SittingOffer(
    requestId: _text(m['requestId']),
    ownerId: _text(m['ownerId']),
    sitterId: _text(m['sitterId']),
    sitterName: _text(m['sitterName']),
    message: _text(m['message']),
    price: _text(m['price']),
    status: _enumOf(OfferStatus.values, m['status'], OfferStatus.withdrawn),
    createdAt: _time(m['createdAt']),
  );
}

class SittingChat {
  final String id;
  final List<String> members;
  final Map<String, String> names;
  final String lastMessage;
  final DateTime? lastAt;
  final String lastSender;
  final Map<String, DateTime> readAt;

  const SittingChat({
    required this.id,
    required this.members,
    this.names = const {},
    this.lastMessage = '',
    this.lastAt,
    this.lastSender = '',
    this.readAt = const {},
  });

  String otherOf(String me) =>
      members.firstWhere((m) => m != me, orElse: () => '');

  bool unreadFor(String me) {
    final last = lastAt;
    if (last == null || lastSender == me || lastSender.isEmpty) return false;
    final read = readAt[me];
    return read == null || read.isBefore(last);
  }

  factory SittingChat.fromMap(String id, Map<String, dynamic> m) => SittingChat(
    id: id,
    members: [for (final x in m['members'] as List? ?? const []) '$x'],
    names: {
      for (final e in (m['names'] as Map? ?? const {}).entries)
        '${e.key}': '${e.value}',
    },
    lastMessage: _text(m['lastMessage']),
    lastAt: _time(m['lastAt']),
    lastSender: _text(m['lastSender']),
    readAt: {
      for (final e in (m['readAt'] as Map? ?? const {}).entries)
        if (e.value is Timestamp) '${e.key}': (e.value as Timestamp).toDate(),
    },
  );
}

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime? at;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    this.at,
  });

  factory ChatMessage.fromMap(String id, Map<String, dynamic> m) => ChatMessage(
    id: id,
    senderId: _text(m['senderId']),
    text: _text(m['text']),
    at: _time(m['at']),
  );
}

class SittingReview {
  final String id;
  final String sitterId;
  final String reviewerName;
  final int stars;
  final String text;
  final bool hidden;
  final DateTime? createdAt;

  const SittingReview({
    required this.id,
    required this.sitterId,
    required this.reviewerName,
    required this.stars,
    this.text = '',
    this.hidden = false,
    this.createdAt,
  });

  factory SittingReview.fromMap(String id, Map<String, dynamic> m) =>
      SittingReview(
        id: id,
        sitterId: _text(m['sitterId']),
        reviewerName: _text(m['reviewerName']),
        stars: m['stars'] is int ? (m['stars'] as int).clamp(1, 5) : 1,
        text: _text(m['text']),
        hidden: m['hidden'] == true,
        createdAt: _time(m['createdAt']),
      );
}

enum SittingFlagKind { request, sitter, review, chat }

// What a viewer may do with a request right now.
enum RequestRole { owner, bookedSitter, other }

RequestRole roleIn(SittingRequest r, String? me) => me == r.ownerId
    ? RequestRole.owner
    : (me != null && me == r.sitterId
          ? RequestRole.bookedSitter
          : RequestRole.other);

bool canConfirm(SittingRequest r, String? me) {
  if (r.status != SittingStatus.booked || !r.started) return false;
  return switch (roleIn(r, me)) {
    RequestRole.owner => !r.ownerConfirmed,
    RequestRole.bookedSitter => !r.sitterConfirmed,
    RequestRole.other => false,
  };
}

// Items inside the chosen distance, nearest first.
List<T> nearby<T>(
  List<T> items, {
  required double? lat,
  required double? lng,
  required int km,
  required double? Function(T) latOf,
  required double? Function(T) lngOf,
}) {
  if (lat == null || lng == null) return items;
  final withDistance = [
    for (final i in items)
      if (kmBetween(lat, lng, latOf(i), lngOf(i)) case final d? when d <= km)
        (i, d),
  ]..sort((a, b) => a.$2.compareTo(b.$2));
  return [for (final e in withDistance) e.$1];
}
