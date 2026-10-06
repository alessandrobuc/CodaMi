enum PetSpecies {
  dog('Dog'),
  cat('Cat'),
  other('Other');

  final String label;

  const PetSpecies(this.label);

  static PetSpecies fromValue(String? value) => PetSpecies.values.firstWhere(
    (s) => s.name == value,
    orElse: () => PetSpecies.other,
  );
}

enum PetSex {
  male('M', 'Male'),
  female('F', 'Female'),
  unknown('unknown', 'Unknown');

  final String code;
  final String label;

  const PetSex(this.code, this.label);

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

  String get subtitle {
    final parts = [breed, age].whereType<String>().where((p) => p.isNotEmpty);
    return parts.isEmpty ? species.label : parts.join(' · ');
  }
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
