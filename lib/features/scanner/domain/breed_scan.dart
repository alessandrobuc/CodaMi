import '../../pets/domain/entities/pets_entity.dart';

// Must match MODEL_PATTERN and DEFAULT_SCANNER in functions/src/scanner.ts.
final scannerModelPattern = RegExp(r'^gemini-[a-z0-9.-]{1,60}$');
const defaultScannerModel = 'gemini-3.8-flash';

class ScannerConfig {
  final bool enabled;
  final int dailyScans;
  final String model;

  const ScannerConfig({
    this.enabled = false,
    this.dailyScans = 10,
    this.model = defaultScannerModel,
  });

  factory ScannerConfig.fromMap(Map<String, dynamic>? map) {
    final scans = map?['dailyScans'];
    final model = map?['model'];
    return ScannerConfig(
      enabled: map?['enabled'] == true,
      dailyScans: scans is int && scans >= 1 && scans <= 100 ? scans : 10,
      model: model is String && scannerModelPattern.hasMatch(model)
          ? model
          : defaultScannerModel,
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'dailyScans': dailyScans,
    'model': model,
  };

  ScannerConfig copyWith({bool? enabled, int? dailyScans, String? model}) =>
      ScannerConfig(
        enabled: enabled ?? this.enabled,
        dailyScans: dailyScans ?? this.dailyScans,
        model: model ?? this.model,
      );
}

enum ModelTier {
  lite,
  flash,
  pro;

  static ModelTier fromValue(Object? v) =>
      values.firstWhere((t) => t.name == v, orElse: () => flash);
}

class ScannerModels {
  final List<(String id, ModelTier tier)> options;
  final String recommended;
  // False when Google's list couldn't be read and the usual models are shown.
  final bool fromGoogle;

  const ScannerModels({
    required this.options,
    this.recommended = defaultScannerModel,
    this.fromGoogle = true,
  });

  factory ScannerModels.fromMap(Map map) => ScannerModels(
    options: [
      for (final m in map['models'] as List? ?? const [])
        if (m is Map &&
            m['id'] is String &&
            scannerModelPattern.hasMatch(m['id'] as String))
          (m['id'] as String, ModelTier.fromValue(m['tier'])),
    ],
    recommended: map['recommended'] is String
        ? map['recommended'] as String
        : defaultScannerModel,
    fromGoogle: map['fromGoogle'] != false,
  );

  bool offers(String id) => options.any((o) => o.$1 == id);
}

enum ScanConfidence {
  high,
  medium,
  low;

  static ScanConfidence of(int percent) => percent >= 70
      ? high
      : percent >= 40
      ? medium
      : low;
}

class BreedGuess {
  final String name;
  final int confidence;

  const BreedGuess(this.name, this.confidence);
}

enum BreedFact { size, weight, lifeSpan, temperament, characteristics, care }

class BreedScan {
  final bool animalFound;
  final PetSpecies species;
  final String speciesName;
  final bool mixed;
  final List<BreedGuess> breeds;
  final bool poorPhoto;
  final Map<BreedFact, String> facts;
  final String note;

  const BreedScan({
    required this.animalFound,
    required this.species,
    this.speciesName = '',
    this.mixed = false,
    this.breeds = const [],
    this.poorPhoto = false,
    this.facts = const {},
    this.note = '',
  });

  BreedGuess? get top => breeds.isEmpty ? null : breeds.first;
  List<BreedGuess> get others => breeds.skip(1).toList();

  // What goes in the pet's breed field (60 characters at most).
  String get breedForPet {
    final names = mixed
        ? breeds.take(2).map((b) => b.name).join(' × ')
        : top?.name ?? '';
    return names.length <= 60 ? names : names.substring(0, 60).trim();
  }

  factory BreedScan.fromMap(Map map) {
    String text(Object? v) => v is String ? v.trim() : '';
    final info = map['info'] is Map ? map['info'] as Map : const {};
    final breeds = <BreedGuess>[
      for (final b in map['breeds'] as List? ?? const [])
        if (b is Map && text(b['name']).isNotEmpty)
          BreedGuess(
            text(b['name']),
            ((b['confidence'] as num?) ?? 0).round().clamp(0, 100),
          ),
    ]..sort((a, b) => b.confidence.compareTo(a.confidence));
    final found = map['animalFound'] == true && breeds.isNotEmpty;
    return BreedScan(
      animalFound: found,
      species: PetSpecies.fromValue(map['species'] as String?),
      speciesName: text(map['speciesName']),
      mixed: found && map['mixed'] == true,
      breeds: found ? breeds : const [],
      poorPhoto: map['photoQuality'] == 'poor',
      facts: {
        for (final f in BreedFact.values)
          if (found && text(info[f.name]).isNotEmpty) f: text(info[f.name]),
      },
      note: text(map['note']),
    );
  }
}
