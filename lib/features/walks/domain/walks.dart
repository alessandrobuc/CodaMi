import '../../../core/utils/geo.dart';

// Must match WALK_GROUPS in functions/src/walks.ts.
enum WalkGroup {
  dogParks,
  parks,
  green,
  trails;

  static WalkGroup fromValue(Object? value) => WalkGroup.values.firstWhere(
    (g) => g.name == value,
    orElse: () => WalkGroup.parks,
  );
}

const walkRadiusOptionsKm = [1, 3, 5, 10, 25];

class WalksConfig {
  final bool enabled;
  final int defaultRadiusKm;
  final Map<WalkGroup, bool> groups;
  final List<String> hiddenPlaceIds;
  final Map<String, String> hiddenNames;
  final int dailySearches;
  final int dailyDetails;

  const WalksConfig({
    this.enabled = false,
    this.defaultRadiusKm = 5,
    this.groups = const {
      WalkGroup.dogParks: true,
      WalkGroup.parks: true,
      WalkGroup.green: true,
      WalkGroup.trails: true,
    },
    this.hiddenPlaceIds = const [],
    this.hiddenNames = const {},
    this.dailySearches = 40,
    this.dailyDetails = 60,
  });

  List<WalkGroup> get activeGroups => [
    for (final g in WalkGroup.values)
      if (groups[g] ?? true) g,
  ];

  factory WalksConfig.fromMap(Map<String, dynamic>? map) {
    int intIn(Object? v, int fallback) =>
        v is int && v >= 1 && v <= 1000 ? v : fallback;
    final groups = map?['groups'] as Map? ?? const {};
    return WalksConfig(
      enabled: map?['enabled'] == true,
      defaultRadiusKm: walkRadiusOptionsKm.contains(map?['defaultRadiusKm'])
          ? map!['defaultRadiusKm'] as int
          : 5,
      groups: {for (final g in WalkGroup.values) g: groups[g.name] != false},
      hiddenPlaceIds: [
        for (final id in map?['hiddenPlaceIds'] as List? ?? const [])
          if (id is String) id,
      ],
      hiddenNames: {
        for (final e in (map?['hiddenNames'] as Map? ?? const {}).entries)
          if (e.key is String && e.value is String)
            e.key as String: e.value as String,
      },
      dailySearches: intIn(map?['dailySearches'], 40),
      dailyDetails: intIn(map?['dailyDetails'], 60),
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'defaultRadiusKm': defaultRadiusKm,
    'groups': {for (final g in WalkGroup.values) g.name: groups[g] ?? true},
    'hiddenPlaceIds': hiddenPlaceIds,
    'hiddenNames': hiddenNames,
    'dailySearches': dailySearches,
    'dailyDetails': dailyDetails,
  };

  WalksConfig copyWith({
    bool? enabled,
    int? defaultRadiusKm,
    Map<WalkGroup, bool>? groups,
    List<String>? hiddenPlaceIds,
    Map<String, String>? hiddenNames,
    int? dailySearches,
    int? dailyDetails,
  }) => WalksConfig(
    enabled: enabled ?? this.enabled,
    defaultRadiusKm: defaultRadiusKm ?? this.defaultRadiusKm,
    groups: groups ?? this.groups,
    hiddenPlaceIds: hiddenPlaceIds ?? this.hiddenPlaceIds,
    hiddenNames: hiddenNames ?? this.hiddenNames,
    dailySearches: dailySearches ?? this.dailySearches,
    dailyDetails: dailyDetails ?? this.dailyDetails,
  );

  WalksConfig hide(String id, String name) => copyWith(
    hiddenPlaceIds: {...hiddenPlaceIds, id}.toList(),
    hiddenNames: {...hiddenNames, id: name},
  );

  WalksConfig unhide(String id) => copyWith(
    hiddenPlaceIds: [
      for (final h in hiddenPlaceIds)
        if (h != id) h,
    ],
    hiddenNames: {...hiddenNames}..remove(id),
  );
}

class WalkPlace {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;
  final WalkGroup group;

  const WalkPlace({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.group,
  });

  factory WalkPlace.fromMap(Map map) => WalkPlace(
    id: map['id'] as String? ?? '',
    name: map['name'] as String? ?? '',
    address: map['address'] as String? ?? '',
    lat: (map['lat'] as num?)?.toDouble() ?? 0,
    lng: (map['lng'] as num?)?.toDouble() ?? 0,
    group: WalkGroup.fromValue(map['group']),
  );

  double metersFrom(double lat, double lng) =>
      metersBetween(lat, lng, this.lat, this.lng);
}

class WalkDetails {
  final String id;
  final String name;
  final String address;
  final double? rating;
  final int? ratingCount;
  final bool? openNow;
  final List<String> hours;
  final String phone;
  final String website;
  final String mapsUrl;
  final bool? allowsDogs;
  final String? photoUrl;
  final String photoAuthor;

  const WalkDetails({
    required this.id,
    this.name = '',
    this.address = '',
    this.rating,
    this.ratingCount,
    this.openNow,
    this.hours = const [],
    this.phone = '',
    this.website = '',
    this.mapsUrl = '',
    this.allowsDogs,
    this.photoUrl,
    this.photoAuthor = '',
  });

  factory WalkDetails.fromMap(Map map) => WalkDetails(
    id: map['id'] as String? ?? '',
    name: map['name'] as String? ?? '',
    address: map['address'] as String? ?? '',
    rating: (map['rating'] as num?)?.toDouble(),
    ratingCount: (map['ratingCount'] as num?)?.toInt(),
    openNow: map['openNow'] as bool?,
    hours: [
      for (final h in map['hours'] as List? ?? const [])
        if (h is String) h,
    ],
    phone: map['phone'] as String? ?? '',
    website: map['website'] as String? ?? '',
    mapsUrl: map['mapsUrl'] as String? ?? '',
    allowsDogs: map['allowsDogs'] as bool?,
    photoUrl: map['photoUrl'] as String?,
    photoAuthor: map['photoAuthor'] as String? ?? '',
  );
}

// Nearest first; places outside the chosen distance are left out.
List<WalkPlace> placesNear(
  Iterable<WalkPlace> places,
  double lat,
  double lng, {
  required int radiusKm,
  WalkGroup? group,
}) {
  final withDistance = [
    for (final p in places)
      if (group == null || p.group == group) (p, p.metersFrom(lat, lng)),
  ]..removeWhere((e) => e.$2 > radiusKm * 1000 + 200);
  withDistance.sort((a, b) => a.$2.compareTo(b.$2));
  return [for (final e in withDistance) e.$1];
}

String formatDistance(double meters) {
  if (meters < 1000) return '${(meters / 10).round() * 10} m';
  final km = meters / 1000;
  return km < 10 ? '${km.toStringAsFixed(1)} km' : '${km.round()} km';
}

Uri directionsUri(WalkPlace p) => Uri.https('www.google.com', '/maps/dir/', {
  'api': '1',
  'destination': '${p.lat},${p.lng}',
  'destination_place_id': p.id,
  'travelmode': 'walking',
});
