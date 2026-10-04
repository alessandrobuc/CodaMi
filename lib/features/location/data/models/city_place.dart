class PlaceSuggestion {
  final String placeId;
  final String mainText;
  final String secondaryText;

  const PlaceSuggestion({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  List<String> get _secondaryParts => secondaryText
      .split(',')
      .map((p) => p.trim())
      .where((p) => p.isNotEmpty)
      .toList();

  String get country => _secondaryParts.isEmpty ? '' : _secondaryParts.last;

  String get area => _secondaryParts.length < 2
      ? ''
      : _secondaryParts.sublist(0, _secondaryParts.length - 1).join(', ');

  factory PlaceSuggestion.fromMap(Map<String, dynamic> map) {
    return PlaceSuggestion(
      placeId: map['placeId'] as String? ?? '',
      mainText: map['mainText'] as String? ?? '',
      secondaryText: map['secondaryText'] as String? ?? '',
    );
  }
}

class CityPlace {
  final String placeId;
  final String city;
  final String? province;
  final String? region;
  final String country;
  final String countryName;
  final double lat;
  final double lng;

  const CityPlace({
    required this.placeId,
    required this.city,
    this.province,
    this.region,
    required this.country,
    required this.countryName,
    required this.lat,
    required this.lng,
  });

  factory CityPlace.fromMap(
    Map<String, dynamic> map, {
    required PlaceSuggestion suggestion,
  }) {
    String text(String key) => (map[key] as String? ?? '').trim();
    String? optional(String key) => text(key).isEmpty ? null : text(key);

    return CityPlace(
      placeId: optional('placeId') ?? suggestion.placeId,
      city: optional('city') ?? suggestion.mainText,
      province: optional('province'),
      region: optional('region'),
      country: text('country').toUpperCase(),
      countryName: text('countryName'),
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
    );
  }

  String? get _provinceCode {
    final code = province?.trim() ?? '';
    return code.isNotEmpty && code.length <= 3 && code != city ? code : null;
  }

  String get cityKey =>
      slugify([city, _provinceCode, country].whereType<String>().join(' '));

  String get label => [
    city,
    ?_provinceCode,
    if (countryName.isNotEmpty) countryName,
  ].join(', ');

  Map<String, dynamic> toUserFields() => {
    'city': city,
    'cityKey': cityKey,
    'cityPlaceId': placeId,
    'province': province,
    'region': region,
    'country': country,
    'homeLat': lat,
    'homeLng': lng,
  };
}

String slugify(String input) {
  const accents = {
    'à': 'a',
    'á': 'a',
    'â': 'a',
    'ä': 'a',
    'ã': 'a',
    'å': 'a',
    'è': 'e',
    'é': 'e',
    'ê': 'e',
    'ë': 'e',
    'ì': 'i',
    'í': 'i',
    'î': 'i',
    'ï': 'i',
    'ò': 'o',
    'ó': 'o',
    'ô': 'o',
    'ö': 'o',
    'õ': 'o',
    'ù': 'u',
    'ú': 'u',
    'û': 'u',
    'ü': 'u',
    'ñ': 'n',
    'ç': 'c',
    'ß': 'ss',
  };
  final lower = input
      .toLowerCase()
      .split('')
      .map((c) => accents[c] ?? c)
      .join();
  return lower
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}
