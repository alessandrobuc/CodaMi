import '../../pets/domain/entities/pets_entity.dart';

// Must match REMINDER_DAYS in functions/src/heat.ts.
const heatReminderDays = [1, 3, 7, 14];
const defaultHeatReminderDays = 3;

// Cycles shorter or longer than this are typing mistakes, not a pattern.
const _minCycle = 7, _maxCycle = 400, _maxHeat = 60;

DateTime heatDay(DateTime d) => DateTime.utc(d.year, d.month, d.day);

String heatDayKey(DateTime d) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${d.year}-${two(d.month)}-${two(d.day)}';
}

DateTime? parseHeatDay(Object? value) {
  if (value is! String) return null;
  final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(value);
  if (m == null) return null;
  final d = DateTime.utc(int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!));
  return heatDayKey(d) == value ? d : null;
}

int daysBetween(DateTime a, DateTime b) =>
    heatDay(b).difference(heatDay(a)).inHours ~/ 24;

class HeatConfig {
  final bool enabled;
  // 0 means no typical value: estimates start after two records.
  final Map<PetSpecies, int> cycleDays;
  final Map<PetSpecies, int> heatDays;

  static const defaultCycleDays = {
    PetSpecies.dog: 180,
    PetSpecies.cat: 21,
    PetSpecies.other: 0,
  };
  static const defaultHeatDays = {
    PetSpecies.dog: 18,
    PetSpecies.cat: 7,
    PetSpecies.other: 7,
  };

  const HeatConfig({
    this.enabled = false,
    this.cycleDays = defaultCycleDays,
    this.heatDays = defaultHeatDays,
  });

  static bool validCycle(PetSpecies s, int v) =>
      (s == PetSpecies.other && v == 0) || (v >= _minCycle && v <= _maxCycle);
  static bool validHeat(int v) => v >= 1 && v <= _maxHeat;

  factory HeatConfig.fromMap(Map<String, dynamic>? map) {
    final cycles = map?['cycleDays'] as Map? ?? const {};
    final heats = map?['heatDays'] as Map? ?? const {};
    return HeatConfig(
      enabled: map?['enabled'] == true,
      cycleDays: {
        for (final s in PetSpecies.values)
          s: switch (cycles[s.name]) {
            final int v when validCycle(s, v) => v,
            _ => defaultCycleDays[s]!,
          },
      },
      heatDays: {
        for (final s in PetSpecies.values)
          s: switch (heats[s.name]) {
            final int v when validHeat(v) => v,
            _ => defaultHeatDays[s]!,
          },
      },
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'cycleDays': {for (final e in cycleDays.entries) e.key.name: e.value},
    'heatDays': {for (final e in heatDays.entries) e.key.name: e.value},
  };

  HeatConfig copyWith({
    bool? enabled,
    Map<PetSpecies, int>? cycleDays,
    Map<PetSpecies, int>? heatDays,
  }) => HeatConfig(
    enabled: enabled ?? this.enabled,
    cycleDays: cycleDays ?? this.cycleDays,
    heatDays: heatDays ?? this.heatDays,
  );
}

class HeatCycle {
  final String id;
  final String petId;
  final DateTime start;
  final DateTime? end;
  final String notes;

  const HeatCycle({
    required this.id,
    required this.petId,
    required this.start,
    this.end,
    this.notes = '',
  });

  int? get length => end == null ? null : daysBetween(start, end!) + 1;

  static HeatCycle? fromMap(String id, Map<String, dynamic> map) {
    final start = parseHeatDay(map['start']);
    if (start == null) return null;
    final end = parseHeatDay(map['end']);
    return HeatCycle(
      id: id,
      petId: map['petId'] as String? ?? '',
      start: start,
      end: end != null && !end.isBefore(start) ? end : null,
      notes: map['notes'] as String? ?? '',
    );
  }
}

class HeatPeriod {
  final DateTime start;
  final DateTime end;

  const HeatPeriod(this.start, this.end);

  bool contains(DateTime day) => !day.isBefore(start) && !day.isAfter(end);
}

class HeatEstimate {
  // Null when there is nothing to base an estimate on yet.
  final int? cycleDays;
  final int heatDays;
  // True when the cycle length comes from the pet's own records.
  final bool fromHistory;
  final HeatCycle? current;
  final List<HeatPeriod> upcoming;
  final int records;

  const HeatEstimate({
    required this.cycleDays,
    required this.heatDays,
    required this.fromHistory,
    required this.current,
    required this.upcoming,
    required this.records,
  });

  DateTime? get nextStart => upcoming.isEmpty ? null : upcoming.first.start;
}

int _average(List<int> values) =>
    (values.reduce((a, b) => a + b) / values.length).round();

List<T> _last<T>(List<T> list, int n) =>
    list.length <= n ? list : list.sublist(list.length - n);

HeatEstimate estimateHeat(
  List<HeatCycle> cycles,
  PetSpecies species,
  HeatConfig config,
  DateTime now,
) {
  final today = heatDay(now);
  final sorted = [...cycles]..sort((a, b) => a.start.compareTo(b.start));
  // A second entry within a week of another is a duplicate, not a new heat.
  final clean = <HeatCycle>[];
  for (final c in sorted) {
    if (clean.isEmpty || daysBetween(clean.last.start, c.start) >= _minCycle) {
      clean.add(c);
    }
  }
  final intervals = <int>[
    for (var i = 1; i < clean.length; i++)
      daysBetween(clean[i - 1].start, clean[i].start),
  ].where((d) => d <= _maxCycle).toList();
  final lengths = [
    for (final c in sorted)
      if (c.length case final l? when l <= _maxHeat) l,
  ];
  final typical = config.cycleDays[species] ?? 0;
  final cycleDays = intervals.isNotEmpty
      ? _average(_last(intervals, 4))
      : (typical > 0 ? typical : null);
  final heatDays = lengths.isNotEmpty
      ? _average(_last(lengths, 4))
      : config.heatDays[species] ?? 7;

  HeatCycle? current;
  for (final c in sorted.reversed) {
    final open = c.end == null && daysBetween(c.start, today) < _maxHeat;
    if (!c.start.isAfter(today) &&
        (open || (c.end != null && !c.end!.isBefore(today)))) {
      current = c;
      break;
    }
  }

  final upcoming = <HeatPeriod>[];
  if (cycleDays != null && clean.isNotEmpty) {
    var start = clean.last.start.add(Duration(days: cycleDays));
    while (start.add(Duration(days: heatDays - 1)).isBefore(today)) {
      start = start.add(Duration(days: cycleDays));
    }
    for (var i = 0; i < 3; i++) {
      upcoming.add(HeatPeriod(start, start.add(Duration(days: heatDays - 1))));
      start = start.add(Duration(days: cycleDays));
    }
  }

  return HeatEstimate(
    cycleDays: cycleDays,
    heatDays: heatDays,
    fromHistory: intervals.isNotEmpty,
    current: current,
    upcoming: upcoming,
    records: sorted.length,
  );
}

class HeatReminderPlan {
  final DateTime nextStart;
  final DateTime remindOn;
  final int cycleDays;

  const HeatReminderPlan(this.nextStart, this.remindOn, this.cycleDays);
}

// The first expected start whose reminder day hasn't passed yet.
HeatReminderPlan? reminderPlan(
  HeatEstimate estimate,
  int daysBefore,
  DateTime now,
) {
  final cycle = estimate.cycleDays;
  if (cycle == null) return null;
  final today = heatDay(now);
  for (final p in estimate.upcoming) {
    final remindOn = p.start.subtract(Duration(days: daysBefore));
    if (!remindOn.isBefore(today)) {
      return HeatReminderPlan(p.start, remindOn, cycle);
    }
  }
  return null;
}
