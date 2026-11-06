import 'package:cloud_firestore/cloud_firestore.dart';

// Names must match TITLE_IDS in functions/src/titles.ts.
enum TitleId {
  contributor,
  rescuer,
  volunteer,
  advocate,
  helper,
  trusted,
  sitter,
  ambassador,
  donor,
  team,
  partner;

  static const counted = [
    contributor,
    rescuer,
    volunteer,
    advocate,
    helper,
    trusted,
    sitter,
  ];
  static const manual = [team, partner];

  bool get isCounted => counted.contains(this);
  bool get isManual => manual.contains(this);

  static TitleId? of(Object? value) =>
      values.where((t) => t.name == value).firstOrNull;
}

const donorLevels = 6;
const defaultTitleLevels = {
  TitleId.contributor: [1, 5, 15],
  TitleId.rescuer: [1, 3, 10],
  TitleId.volunteer: [1, 5, 15],
  TitleId.advocate: [5, 25, 100],
  TitleId.helper: [1, 3, 10],
  TitleId.trusted: [30, 100, 365],
  TitleId.sitter: [1, 5, 15],
};
const defaultTitleBonus = [10, 25, 50];
// Bronze, Silver, Gold, Platinum, Lifetime; any donation makes a Supporter.
const defaultDonorCents = [1000, 2500, 5000, 10000, 25000];

// The count each title follows, as saved by the server in `counts`.
const titleMetric = {
  TitleId.contributor: 'reports',
  TitleId.rescuer: 'rescues',
  TitleId.volunteer: 'helps',
  TitleId.advocate: 'shares',
  TitleId.helper: 'feedbackDone',
  TitleId.trusted: 'activeDays',
  TitleId.sitter: 'sittings',
  TitleId.ambassador: 'invites',
  TitleId.donor: 'donorCents',
};

bool risingInts(List<int> list, {required int min, required int max}) {
  for (var i = 0; i < list.length; i++) {
    if (list[i] < min || list[i] > max) return false;
    if (i > 0 && list[i] <= list[i - 1]) return false;
  }
  return true;
}

class TitlesConfig {
  final bool enabled;
  final Set<TitleId> off;
  final Map<TitleId, List<int>> levels;
  final List<int> bonus;
  final List<int> donorCents;

  const TitlesConfig({
    this.enabled = false,
    this.off = const {},
    this.levels = defaultTitleLevels,
    this.bonus = defaultTitleBonus,
    this.donorCents = defaultDonorCents,
  });

  static bool validLevels(List<int> l) =>
      l.length == 3 && risingInts(l, min: 1, max: 100000);
  static bool validBonus(List<int> l) =>
      l.length == 3 && l.every((v) => v >= 0 && v <= 10000);
  static bool validDonor(List<int> l) =>
      l.length == 5 && risingInts(l, min: 100, max: 10000000);

  factory TitlesConfig.fromMap(Map<String, dynamic>? map) {
    List<int>? ints(Object? v) =>
        v is List && v.every((e) => e is int) ? v.cast<int>().toList() : null;
    final levels = map?['levels'] is Map ? map!['levels'] as Map : const {};
    final bonus = ints(map?['bonus']);
    final donor = ints(map?['donorCents']);
    return TitlesConfig(
      enabled: map?['enabled'] == true,
      off: {for (final v in map?['off'] as List? ?? const []) ?TitleId.of(v)},
      levels: {
        for (final id in TitleId.counted)
          id: switch (ints(levels[id.name])) {
            final l? when validLevels(l) => l,
            _ => defaultTitleLevels[id]!,
          },
      },
      bonus: bonus != null && validBonus(bonus) ? bonus : defaultTitleBonus,
      donorCents: donor != null && validDonor(donor)
          ? donor
          : defaultDonorCents,
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'off': [for (final id in off) id.name],
    'levels': {for (final e in levels.entries) e.key.name: e.value},
    'bonus': bonus,
    'donorCents': donorCents,
  };

  TitlesConfig copyWith({
    bool? enabled,
    Set<TitleId>? off,
    Map<TitleId, List<int>>? levels,
    List<int>? bonus,
    List<int>? donorCents,
  }) => TitlesConfig(
    enabled: enabled ?? this.enabled,
    off: off ?? this.off,
    levels: levels ?? this.levels,
    bonus: bonus ?? this.bonus,
    donorCents: donorCents ?? this.donorCents,
  );

  // The counts needed for each level; the first donor level is any donation.
  List<int> thresholds(TitleId id, List<int> ambassadorMins) => switch (id) {
    TitleId.ambassador => ambassadorMins,
    TitleId.donor => [1, ...donorCents],
    TitleId.team || TitleId.partner => const [],
    _ => levels[id] ?? const [],
  };

  int maxLevel(TitleId id, List<int> ambassadorMins) => switch (id) {
    TitleId.team || TitleId.partner => 1,
    TitleId.donor => donorLevels,
    TitleId.ambassador => ambassadorMins.length,
    _ => 3,
  };
}

class TitleLevel {
  final TitleId id;
  final int level;

  const TitleLevel(this.id, this.level);

  String get key => '${id.name}_$level';

  static TitleLevel? fromMap(Object? value) {
    if (value is! Map) return null;
    final id = TitleId.of(value['id']);
    final level = (value['level'] as num?)?.toInt() ?? 0;
    return id == null || level < 1 ? null : TitleLevel(id, level);
  }

  @override
  bool operator ==(Object other) =>
      other is TitleLevel && other.id == id && other.level == level;

  @override
  int get hashCode => Object.hash(id, level);
}

Map<TitleId, int> _levels(Object? value) => {
  if (value is Map)
    for (final e in value.entries)
      if (TitleId.of(e.key) case final id?)
        if (e.value case final num n when n >= 1) id: n.toInt(),
};

class Achievements {
  final Map<String, int> counts;
  final Map<TitleId, int> levels;
  final Map<TitleId, int> granted;
  final Set<TitleId> revoked;
  final Map<String, DateTime> unlockedAt;
  final TitleId? main;
  final bool hideDonor;

  const Achievements({
    this.counts = const {},
    this.levels = const {},
    this.granted = const {},
    this.revoked = const {},
    this.unlockedAt = const {},
    this.main,
    this.hideDonor = false,
  });

  factory Achievements.fromMap(Map<String, dynamic>? map) => Achievements(
    counts: {
      if (map?['counts'] case final Map c)
        for (final e in c.entries)
          if (e.value case final num n) '${e.key}': n.toInt(),
    },
    levels: _levels(map?['levels']),
    granted: _levels(map?['granted']),
    revoked: {
      for (final v in map?['revoked'] as List? ?? const []) ?TitleId.of(v),
    },
    unlockedAt: {
      if (map?['unlockedAt'] case final Map u)
        for (final e in u.entries)
          if (e.value case final Timestamp t) '${e.key}': t.toDate(),
    },
    main: TitleId.of(map?['main']),
    hideDonor: map?['hideDonor'] == true,
  );

  int level(TitleId id) => levels[id] ?? 0;

  int count(TitleId id) => counts[titleMetric[id]] ?? 0;

  List<TitleLevel> get unlocked => [
    for (final id in TitleId.values)
      if (level(id) > 0) TitleLevel(id, level(id)),
  ];

  // Every level reached, used to spot new ones.
  Set<String> get unlockedKeys => {
    for (final t in unlocked)
      for (var l = 1; l <= t.level; l++) '${t.id.name}_$l',
  };
}

class PublicTitles {
  final TitleLevel? title;
  final List<TitleLevel> tags;

  const PublicTitles({this.title, this.tags = const []});

  factory PublicTitles.fromMap(Map<String, dynamic>? map) => PublicTitles(
    title: TitleLevel.fromMap(map?['title']),
    tags: [
      for (final t in map?['tags'] as List? ?? const []) ?TitleLevel.fromMap(t),
    ],
  );
}

class TitleProgress {
  final int level;
  final int maxLevel;
  final int current;
  // The count for the next level, or null when all levels are reached.
  final int? next;

  const TitleProgress({
    required this.level,
    required this.maxLevel,
    required this.current,
    this.next,
  });

  bool get complete => next == null;

  double get fraction =>
      next == null ? 1 : (next! <= 0 ? 0 : (current / next!).clamp(0, 1));
}

TitleProgress progressOf(
  TitleId id,
  Achievements a,
  TitlesConfig c,
  List<int> ambassadorMins,
) {
  final thresholds = c.thresholds(id, ambassadorMins);
  final level = a.level(id);
  return TitleProgress(
    level: level,
    maxLevel: c.maxLevel(id, ambassadorMins),
    current: a.count(id),
    next: level < thresholds.length ? thresholds[level] : null,
  );
}

// Counted enough, but held back by a removal or low ratings.
bool titlePaused(TitleId id, Achievements a, TitlesConfig c) =>
    (id == TitleId.trusted || id == TitleId.sitter) &&
    a.level(id) == 0 &&
    a.count(id) >= (c.levels[id]?.first ?? 1);

// The title closest to its next level, to show as the next goal.
TitleId? nextGoal(Achievements a, TitlesConfig c, List<int> ambassadorMins) {
  TitleId? best;
  var bestFraction = -1.0;
  for (final id in [...TitleId.counted, TitleId.ambassador]) {
    if (c.off.contains(id) || a.revoked.contains(id)) continue;
    final p = progressOf(id, a, c, ambassadorMins);
    if (p.complete || titlePaused(id, a, c)) continue;
    if (p.fraction > bestFraction) {
      best = id;
      bestFraction = p.fraction;
    }
  }
  return best;
}

// The titles on show in the app: switched-off ones are left out.
List<TitleId> shownTitles(TitlesConfig c, Achievements a) => [
  for (final id in [...TitleId.counted, TitleId.ambassador])
    if (!c.off.contains(id)) id,
  for (final id in TitleId.manual)
    if (a.level(id) > 0) id,
];
