import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/pets_entity.dart';

class PetModel {
  static Pet fromMap(String id, Map<String, dynamic> map) {
    return Pet(
      id: id,
      ownerId: map['ownerId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      species: PetSpecies.fromValue(map['species'] as String?),
      breed: _optional(map['breed']),
      color: _optional(map['color']),
      sex: PetSex.fromCode(map['sex'] as String?),
      age: _optional(map['age']),
      features: _optional(map['features']),
      photoUrls: List<String>.from(map['photoUrls'] as List? ?? const []),
      createdAt: _date(map['createdAt']),
      updatedAt: _date(map['updatedAt']),
    );
  }

  static Map<String, Object?> toFields({
    required String ownerId,
    required PetDraft draft,
    required List<String> photoUrls,
  }) {
    return {
      'ownerId': ownerId,
      'name': draft.name.trim(),
      'species': draft.species.name,
      'breed': _optional(draft.breed),
      'color': _optional(draft.color),
      'sex': draft.sex?.code,
      'age': _optional(draft.age),
      'features': _optional(draft.features),
      'photoUrls': photoUrls,
    };
  }

  static String? _optional(Object? value) {
    final text = (value as String?)?.trim() ?? '';
    return text.isEmpty ? null : text;
  }

  static DateTime? _date(Object? value) => switch (value) {
    Timestamp t => t.toDate(),
    String s => DateTime.tryParse(s),
    _ => null,
  };
}
