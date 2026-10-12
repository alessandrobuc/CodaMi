enum PetSpecies {
  dog,
  cat,
  other;

  static PetSpecies fromValue(String? value) => PetSpecies.values.firstWhere(
    (s) => s.name == value,
    orElse: () => PetSpecies.other,
  );
}

enum PetSex {
  male('M'),
  female('F'),
  unknown('unknown');

  final String code;

  const PetSex(this.code);

  static PetSex? fromCode(String? code) {
    for (final sex in PetSex.values) {
      if (sex.code == code) return sex;
    }
    return null;
  }
}

class Pet {
  final String id;
  final String ownerId;
  final String name;
  final PetSpecies species;
  final String? breed;
  final String? color;
  final PetSex? sex;
  final String? age;
  final String? features;
  final List<String> photoUrls;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Pet({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.species,
    this.breed,
    this.color,
    this.sex,
    this.age,
    this.features,
    this.photoUrls = const [],
    this.createdAt,
    this.updatedAt,
  });

  String? get coverUrl => photoUrls.isEmpty ? null : photoUrls.first;
}

class PetPhoto {
  final String? url;
  final String? localPath;

  const PetPhoto.remote(String this.url) : localPath = null;

  const PetPhoto.local(String this.localPath) : url = null;

  bool get isLocal => localPath != null;
}

class PetDraft {
  final String name;
  final PetSpecies species;
  final String? breed;
  final String? color;
  final PetSex? sex;
  final String? age;
  final String? features;
  final List<PetPhoto> photos;

  const PetDraft({
    required this.name,
    required this.species,
    required this.photos,
    this.breed,
    this.color,
    this.sex,
    this.age,
    this.features,
  });
}
