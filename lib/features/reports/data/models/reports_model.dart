import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../pets/domain/entities/pets_entity.dart';
import '../../domain/entities/reports_entity.dart';

class ReportModel {
  static Report fromMap(String id, Map<String, dynamic> map) {
    return Report(
      id: id,
      ownerId: map['ownerId'] as String? ?? '',
      ownerName: map['ownerName'] as String? ?? '',
      type: ReportType.fromValue(map['type'] as String?),
      petId: _optional(map['petId']),
      petName: map['petName'] as String? ?? '',
      species: PetSpecies.fromValue(map['species'] as String?),
      description: map['description'] as String? ?? '',
      photoUrls: List<String>.from(map['photoUrls'] as List? ?? const []),
      country: map['country'] as String? ?? '',
      city: map['city'] as String? ?? '',
      cityKey: map['cityKey'] as String? ?? '',
      placeDetail: _optional(map['placeDetail']),
      lat: (map['lat'] as num?)?.toDouble() ?? 0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0,
      eventAt: _date(map['eventAt']) ?? DateTime.now(),
      status: ReportStatus.fromValue(map['status'] as String?),
      contactPhone: _optional(map['contactPhone']),
      contactEmail: _optional(map['contactEmail']),
      whatsapp: map['whatsapp'] as bool? ?? false,
      createdAt: _date(map['createdAt']),
      resolvedAt: _date(map['resolvedAt']),
    );
  }

  static Map<String, Object> toCreateMap({
    required String ownerId,
    required ReportDraft draft,
    required List<String> photoUrls,
  }) {
    final phone = _optional(draft.contactPhone);
    final email = _optional(draft.contactEmail);
    final fields = <String, Object?>{
      'ownerId': ownerId,
      'ownerName': draft.ownerName.trim(),
      'ownerContact': phone ?? email ?? '',
      'type': draft.type.name,
      'petId': draft.petId,
      'petName': draft.petName.trim(),
      'species': draft.species.name,
      'description': draft.description.trim(),
      'photoUrls': photoUrls,
      'country': draft.place.country,
      'city': draft.place.city,
      'cityKey': draft.place.cityKey,
      'placeDetail': _optional(draft.placeDetail),
      'lat': draft.place.lat,
      'lng': draft.place.lng,
      'eventAt': draft.eventAt.toUtc().toIso8601String(),
      'status': ReportStatus.open.name,
      'contactPhone': phone,
      'contactEmail': email,
      'whatsapp': phone != null && draft.whatsapp,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    return {
      for (final e in fields.entries)
        if (e.value != null) e.key: e.value!,
    };
  }

  static String? _optional(Object? value) {
    final text = (value as String?)?.trim() ?? '';
    return text.isEmpty ? null : text;
  }

  static DateTime? _date(Object? value) => switch (value) {
    Timestamp t => t.toDate(),
    String s => DateTime.tryParse(s)?.toLocal(),
    _ => null,
  };
}
