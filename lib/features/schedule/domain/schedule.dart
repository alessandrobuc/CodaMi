import '../../heat/domain/heat.dart' show heatDay, heatDayKey, parseHeatDay;

enum ScheduleType {
  vet,
  vaccine,
  medicine,
  grooming,
  feeding,
  walk,
  note,
  other,
}

enum RepeatFreq { none, daily, weekly, monthly, yearly }

// Minutes before the event. Must match REMIND_OPTIONS in functions/src/schedule.ts.
const remindOptions = [0, 15, 60, 1440, 10080];
const maxReminders = 2;
// All-day events remind as if they started at this hour.
const allDayHour = 9;
// Reminders planned ahead; the app tops them up each time it starts.
const maxPlannedReminders = 60;
const reminderHorizonDays = 180;
const _maxKeptDays = 1000;

List<int> defaultRemindersFor(ScheduleType type) => switch (type) {
  ScheduleType.vet ||
  ScheduleType.vaccine ||
  ScheduleType.grooming => const [1440, 60],
  ScheduleType.medicine || ScheduleType.feeding => const [0],
  ScheduleType.walk => const [15],
  ScheduleType.note => const [],
  ScheduleType.other => const [0],
};

bool defaultAllDayFor(ScheduleType type) => type == ScheduleType.note;

String dayKey(DateTime d) => heatDayKey(d);
DateTime? parseDay(Object? v) => parseHeatDay(v);
DateTime toDay(DateTime d) => heatDay(d);

class ScheduleConfig {
  final bool enabled;

  const ScheduleConfig({this.enabled = false});

  factory ScheduleConfig.fromMap(Map<String, dynamic>? map) =>
      ScheduleConfig(enabled: map?['enabled'] == true);

  Map<String, Object> toMap() => {'enabled': enabled};
}

class ScheduleRepeat {
  final RepeatFreq freq;
  final int every;
  // 1 = Monday … 7 = Sunday, for weekly repeats.
  final Set<int> weekdays;
  final DateTime? until;
  final int? count;

  const ScheduleRepeat({
    this.freq = RepeatFreq.none,
    this.every = 1,
    this.weekdays = const {},
    this.until,
    this.count,
  });

  bool get repeats => freq != RepeatFreq.none;

  factory ScheduleRepeat.fromMap(Object? value) {
    if (value is! Map) return const ScheduleRepeat();
    final freq = RepeatFreq.values.asNameMap()[value['freq']];
    if (freq == null || freq == RepeatFreq.none) return const ScheduleRepeat();
    final every = value['every'];
    final count = value['count'];
    return ScheduleRepeat(
      freq: freq,
      every: every is int && every >= 1 && every <= 99 ? every : 1,
      weekdays: {
        for (final d in value['weekdays'] as List? ?? const [])
          if (d is int && d >= 1 && d <= 7) d,
      },
      until: parseDay(value['until']),
      count: count is int && count >= 1 && count <= 999 ? count : null,
    );
  }

  Map<String, Object?> toMap() => {
    'freq': freq.name,
    'every': every,
    'weekdays': (weekdays.toList()..sort()),
    'until': until == null ? null : dayKey(until!),
    'count': count,
  };
}

class PlannedReminder {
  final DateTime at;
  final String title;
  final String body;

  const PlannedReminder(this.at, this.title, this.body);

  @override
  bool operator ==(Object other) =>
      other is PlannedReminder &&
      other.at.isAtSameMomentAs(at) &&
      other.title == title &&
      other.body == body;

  @override
  int get hashCode => Object.hash(at.millisecondsSinceEpoch, title, body);
}

class ScheduleEvent {
  final String id;
  final String ownerId;
  final ScheduleType type;
  final String title;
  final String notes;
  final String place;
  final String detail;
  final List<String> petIds;
  final List<String> petNames;
  final DateTime start;
  // Minutes after midnight; null for an all-day event.
  final int? time;
  final ScheduleRepeat repeat;
  final List<int> remind;
  final Set<String> done;
  final Set<String> skipped;
  final List<PlannedReminder> reminders;

  const ScheduleEvent({
    this.id = '',
    required this.ownerId,
    required this.type,
    this.title = '',
    this.notes = '',
    this.place = '',
    this.detail = '',
    this.petIds = const [],
    this.petNames = const [],
    required this.start,
    this.time,
    this.repeat = const ScheduleRepeat(),
    this.remind = const [],
    this.done = const {},
    this.skipped = const {},
    this.reminders = const [],
  });

  bool get allDay => time == null;

  // When the event happens on a given day, in the phone's time.
  DateTime at(DateTime day) => DateTime(
    day.year,
    day.month,
    day.day,
    time == null ? allDayHour : time! ~/ 60,
    time == null ? 0 : time! % 60,
  );

  bool isDone(DateTime day) => done.contains(dayKey(day));

  static ScheduleEvent? fromMap(String id, Map<String, dynamic> map) {
    final type = ScheduleType.values.asNameMap()[map['type']];
    final start = parseDay(map['start']);
    if (type == null || start == null) return null;
    final time = map['time'];
    List<String> strings(Object? v) => [
      for (final s in v as List? ?? const [])
        if (s is String) s,
    ];
    return ScheduleEvent(
      id: id,
      ownerId: map['ownerId'] as String? ?? '',
      type: type,
      title: map['title'] as String? ?? '',
      notes: map['notes'] as String? ?? '',
      place: map['place'] as String? ?? '',
      detail: map['detail'] as String? ?? '',
      petIds: strings(map['petIds']),
      petNames: strings(map['petNames']),
      start: start,
      time: time is int && time >= 0 && time < 1440 ? time : null,
      repeat: ScheduleRepeat.fromMap(map['repeat']),
      remind: [
        for (final m in map['remind'] as List? ?? const [])
          if (m is int && remindOptions.contains(m)) m,
      ],
      done: strings(map['done']).toSet(),
      skipped: strings(map['skipped']).toSet(),
      reminders: [
        for (final r in map['reminders'] as List? ?? const [])
          if (r is Map && r['at'] is DateTime)
            PlannedReminder(
              r['at'] as DateTime,
              r['title'] as String? ?? '',
              r['body'] as String? ?? '',
            ),
      ],
    );
  }

  // The newest days are kept if a long series fills the list.
  static List<String> _kept(Set<String> days) {
    final list = days.toList()..sort();
    return list.length <= _maxKeptDays
        ? list
        : list.sublist(list.length - _maxKeptDays);
  }

  Map<String, Object?> toMap() => {
    'ownerId': ownerId,
    'type': type.name,
    'title': title.trim(),
    'notes': notes.trim(),
    'place': place.trim(),
    'detail': detail.trim(),
    'petIds': petIds,
    'petNames': petNames,
    'start': dayKey(start),
    'time': time,
    'repeat': repeat.toMap(),
    'remind': remind,
    'done': _kept(done),
    'skipped': _kept(skipped),
  };

  ScheduleEvent copyWith({
    String? id,
    ScheduleType? type,
    String? title,
    String? notes,
    String? place,
    String? detail,
    List<String>? petIds,
    List<String>? petNames,
    DateTime? start,
    int? Function()? time,
    ScheduleRepeat? repeat,
    List<int>? remind,
    Set<String>? done,
    Set<String>? skipped,
  }) => ScheduleEvent(
    id: id ?? this.id,
    ownerId: ownerId,
    type: type ?? this.type,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    place: place ?? this.place,
    detail: detail ?? this.detail,
    petIds: petIds ?? this.petIds,
    petNames: petNames ?? this.petNames,
    start: start ?? this.start,
    time: time == null ? this.time : time(),
    repeat: repeat ?? this.repeat,
    remind: remind ?? this.remind,
    done: done ?? this.done,
    skipped: skipped ?? this.skipped,
    reminders: reminders,
  );

  ScheduleEvent withDone(DateTime day, bool value) => copyWith(
    done: value ? {...done, dayKey(day)} : ({...done}..remove(dayKey(day))),
  );

  ScheduleEvent withSkipped(DateTime day) =>
      copyWith(skipped: {...skipped, dayKey(day)});

  // One day of a series as its own event, to edit it alone.
  ScheduleEvent single(DateTime day) => copyWith(
    id: '',
    start: day,
    repeat: const ScheduleRepeat(),
    done: isDone(day) ? {dayKey(day)} : const {},
    skipped: const {},
  );
}

DateTime _monthDay(int year, int month, int day) {
  final last = DateTime.utc(year, month + 1, 0).day;
  return DateTime.utc(year, month, day > last ? last : day);
}

// Every day the event happens, in order, skipped days included.
Iterable<DateTime> _allDays(ScheduleEvent e) sync* {
  final r = e.repeat;
  final start = e.start;
  var produced = 0;
  bool ended(DateTime d) =>
      (r.until != null && d.isAfter(r.until!)) ||
      (r.count != null && produced >= r.count!);

  if (!r.repeats) {
    yield start;
    return;
  }
  for (var n = 0; n < 20000; n++) {
    final List<DateTime> days;
    switch (r.freq) {
      case RepeatFreq.daily:
        days = [start.add(Duration(days: n * r.every))];
      case RepeatFreq.weekly:
        final monday = start.subtract(Duration(days: start.weekday - 1));
        final week = monday.add(Duration(days: 7 * n * r.every));
        final weekdays = r.weekdays.isEmpty
            ? [start.weekday]
            : (r.weekdays.toList()..sort());
        days = [
          for (final w in weekdays)
            if (!week.add(Duration(days: w - 1)).isBefore(start))
              week.add(Duration(days: w - 1)),
        ];
      case RepeatFreq.monthly:
        days = [_monthDay(start.year, start.month + n * r.every, start.day)];
      case RepeatFreq.yearly:
        days = [_monthDay(start.year + n * r.every, start.month, start.day)];
      case RepeatFreq.none:
        return;
    }
    for (final d in days) {
      if (ended(d)) return;
      produced++;
      yield d;
    }
  }
}

// Days in [from, to] the event happens on, without skipped ones.
List<DateTime> occurrencesBetween(ScheduleEvent e, DateTime from, DateTime to) {
  final first = toDay(from), last = toDay(to);
  return [
    for (final d in _allDays(e).takeWhile((d) => !d.isAfter(last)))
      if (!d.isBefore(first) && !e.skipped.contains(dayKey(d))) d,
  ];
}

typedef ReminderText =
    ({String title, String body}) Function(
      ScheduleEvent event,
      DateTime day,
      int minutesBefore,
    );

// The next reminders to send, without done days or times already passed.
List<PlannedReminder> planReminders(
  ScheduleEvent e,
  DateTime now,
  ReminderText text,
) {
  if (e.remind.isEmpty) return const [];
  final horizon = now.add(const Duration(days: reminderHorizonDays));
  final longest = e.remind.reduce((a, b) => a > b ? a : b);
  final days = occurrencesBetween(
    e,
    now.subtract(const Duration(days: 1)),
    horizon.add(Duration(minutes: longest)),
  );
  final planned = <PlannedReminder>[];
  for (final day in days) {
    if (e.isDone(day)) continue;
    for (final m in e.remind) {
      final at = e.at(day).subtract(Duration(minutes: m));
      if (!at.isAfter(now) || at.isAfter(horizon)) continue;
      final t = text(e, day, m);
      planned.add(PlannedReminder(at, t.title, t.body));
    }
    if (planned.length >= maxPlannedReminders + maxReminders) break;
  }
  planned.sort((a, b) => a.at.compareTo(b.at));
  return planned.length <= maxPlannedReminders
      ? planned
      : planned.sublist(0, maxPlannedReminders);
}

class Occurrence {
  final ScheduleEvent event;
  final DateTime day;

  const Occurrence(this.event, this.day);

  DateTime get at => event.at(day);
  bool get done => event.isDone(day);
}

List<Occurrence> occurrencesOf(
  Iterable<ScheduleEvent> events,
  DateTime from,
  DateTime to,
) {
  final list = [
    for (final e in events)
      for (final d in occurrencesBetween(e, from, to)) Occurrence(e, d),
  ];
  list.sort((a, b) {
    final day = a.day.compareTo(b.day);
    if (day != 0) return day;
    // All-day first, then by time.
    return (a.event.time ?? -1).compareTo(b.event.time ?? -1);
  });
  return list;
}

// Done days, newest first.
List<Occurrence> doneOccurrences(Iterable<ScheduleEvent> events) {
  final list = [
    for (final e in events)
      for (final key in e.done)
        if (parseDay(key) case final d?) Occurrence(e, d),
  ];
  list.sort((a, b) => b.at.compareTo(a.at));
  return list;
}
