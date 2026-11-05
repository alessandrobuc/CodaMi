import 'package:CodaMi/features/auth/presentation/providers/auth_provider.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/pets/presentation/providers/pets_provider.dart';
import 'package:CodaMi/features/schedule/data/schedule_repository.dart';
import 'package:CodaMi/features/schedule/domain/schedule.dart';
import 'package:CodaMi/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:CodaMi/features/schedule/presentation/screens/schedule_form_screen.dart';
import 'package:CodaMi/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:CodaMi/features/schedule/presentation/widgets/schedule_cards.dart';
import 'package:CodaMi/features/schedule/presentation/widgets/schedule_widgets.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeScheduleRepository implements ScheduleRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future<void>.value();
}

DateTime d(String key) => parseDay(key)!;
List<String> keys(Iterable<DateTime> days) => [for (final x in days) dayKey(x)];

ScheduleEvent event({
  String start = '2026-11-02',
  int? time = 600,
  ScheduleRepeat repeat = const ScheduleRepeat(),
  List<int> remind = const [],
  Set<String> done = const {},
  Set<String> skipped = const {},
  ScheduleType type = ScheduleType.vet,
}) => ScheduleEvent(
  id: 'e',
  ownerId: 'u',
  type: type,
  start: d(start),
  time: time,
  repeat: repeat,
  remind: remind,
  done: done,
  skipped: skipped,
);

({String title, String body}) _text(ScheduleEvent e, DateTime day, int m) =>
    (title: 'T', body: '${dayKey(day)} $m');

void main() {
  group('repeats', () {
    test('one-off event happens once', () {
      final e = event();
      expect(keys(occurrencesBetween(e, d('2026-11-01'), d('2026-12-31'))), [
        '2026-11-02',
      ]);
      expect(occurrencesBetween(e, d('2026-11-03'), d('2026-12-31')), isEmpty);
    });

    test('every 2 days, until a date', () {
      final e = event(
        repeat: ScheduleRepeat(
          freq: RepeatFreq.daily,
          every: 2,
          until: d('2026-11-08'),
        ),
      );
      expect(keys(occurrencesBetween(e, d('2026-11-01'), d('2026-12-31'))), [
        '2026-11-02',
        '2026-11-04',
        '2026-11-06',
        '2026-11-08',
      ]);
    });

    test('weekly on chosen days, a number of times, skipped days left out', () {
      // 2 Nov 2026 is a Monday.
      final e = event(
        repeat: const ScheduleRepeat(
          freq: RepeatFreq.weekly,
          weekdays: {1, 3, 5},
          count: 5,
        ),
        skipped: {'2026-11-04'},
      );
      expect(keys(occurrencesBetween(e, d('2026-11-01'), d('2026-12-31'))), [
        '2026-11-02',
        '2026-11-06',
        '2026-11-09',
        '2026-11-11',
      ]);
    });

    test('every 2 weeks starting midweek skips days before the start', () {
      final e = event(
        start: '2026-11-04',
        repeat: const ScheduleRepeat(
          freq: RepeatFreq.weekly,
          every: 2,
          weekdays: {1, 3},
        ),
      );
      expect(keys(occurrencesBetween(e, d('2026-11-01'), d('2026-11-30'))), [
        '2026-11-04',
        '2026-11-16',
        '2026-11-18',
        '2026-11-30',
      ]);
    });

    test('monthly on the 31st falls back to the last day of short months', () {
      final e = event(
        start: '2026-01-31',
        repeat: const ScheduleRepeat(freq: RepeatFreq.monthly),
      );
      expect(keys(occurrencesBetween(e, d('2026-01-01'), d('2026-04-30'))), [
        '2026-01-31',
        '2026-02-28',
        '2026-03-31',
        '2026-04-30',
      ]);
    });

    test('yearly vaccine', () {
      final e = event(
        start: '2026-03-15',
        repeat: const ScheduleRepeat(freq: RepeatFreq.yearly),
      );
      expect(keys(occurrencesBetween(e, d('2026-01-01'), d('2028-12-31'))), [
        '2026-03-15',
        '2027-03-15',
        '2028-03-15',
      ]);
    });
  });

  group('reminders', () {
    final now = DateTime(2026, 11, 3, 12);

    test('past times and done days get no reminder; sorted by time', () {
      final e = event(
        repeat: const ScheduleRepeat(freq: RepeatFreq.daily, count: 4),
        remind: const [1440, 60],
        done: {'2026-11-04'},
      );
      final r = planReminders(e, now, _text);
      // 3 Nov's reminders have passed; 4 Nov is done; 5 Nov gets both.
      expect(
        [for (final x in r) x.at],
        [DateTime(2026, 11, 4, 10), DateTime(2026, 11, 5, 9)],
      );
      expect(r.first.body, '2026-11-05 1440');
    });

    test('all-day events remind at 9:00', () {
      final e = event(start: '2026-11-10', time: null, remind: const [0]);
      expect(planReminders(e, now, _text).single.at, DateTime(2026, 11, 10, 9));
    });

    test('no reminders chosen: nothing planned', () {
      expect(planReminders(event(start: '2026-12-01'), now, _text), isEmpty);
    });

    test('long series are capped and stay within the horizon', () {
      final e = event(
        repeat: const ScheduleRepeat(freq: RepeatFreq.daily),
        remind: const [0, 15],
      );
      final r = planReminders(e, now, _text);
      expect(r.length, maxPlannedReminders);
      expect(r.first.at.isAfter(now), isTrue);
      for (var i = 1; i < r.length; i++) {
        expect(r[i].at.isBefore(r[i - 1].at), isFalse);
      }
    });

    test('defaults per type', () {
      expect(defaultRemindersFor(ScheduleType.vet), [1440, 60]);
      expect(defaultRemindersFor(ScheduleType.medicine), [0]);
      expect(defaultRemindersFor(ScheduleType.walk), [15]);
      expect(defaultRemindersFor(ScheduleType.note), isEmpty);
      expect(defaultAllDayFor(ScheduleType.note), isTrue);
    });
  });

  test('saved fields read back the same', () {
    final e = event(
      repeat: ScheduleRepeat(
        freq: RepeatFreq.weekly,
        every: 2,
        weekdays: const {2, 4},
        until: d('2027-01-01'),
      ),
      remind: const [1440, 60],
      done: {'2026-11-03'},
    ).copyWith(title: ' Check-up ', petIds: ['p'], petNames: ['Luna']);
    final back = ScheduleEvent.fromMap('e', e.toMap())!;
    expect(back.title, 'Check-up');
    expect(back.repeat.freq, RepeatFreq.weekly);
    expect(back.repeat.every, 2);
    expect(back.repeat.weekdays, {2, 4});
    expect(dayKey(back.repeat.until!), '2027-01-01');
    expect(back.remind, [1440, 60]);
    expect(back.done, {'2026-11-03'});
    expect(back.petNames, ['Luna']);
    expect(
      ScheduleEvent.fromMap('x', {'type': 'party', 'start': '2026-11-01'}),
      isNull,
    );
  });

  test('editing one day of a series makes a separate one-off event', () {
    final e = event(repeat: const ScheduleRepeat(freq: RepeatFreq.daily));
    final one = e.single(d('2026-11-05'));
    expect(one.id, isEmpty);
    expect(one.repeat.repeats, isFalse);
    expect(dayKey(one.start), '2026-11-05');
    expect(e.withSkipped(d('2026-11-05')).skipped, {'2026-11-05'});
  });

  test('done days are listed newest first', () {
    final e = event(done: {'2026-11-02', '2026-11-09'});
    expect(keys(doneOccurrences([e]).map((o) => o.day)), [
      '2026-11-09',
      '2026-11-02',
    ]);
  });

  const pet = Pet(
    id: 'p',
    ownerId: 'u',
    name: 'Principessa Luna della Valle',
    species: PetSpecies.dog,
    sex: PetSex.female,
  );
  final today = DateTime.now();
  final events = [
    ScheduleEvent(
      id: 'a',
      ownerId: 'u',
      type: ScheduleType.medicine,
      title: 'Antibiotic for the ear infection, twice a day after food',
      detail: 'Amoxicillin 250 mg, 1 tablet',
      petIds: const ['p'],
      petNames: const ['Principessa Luna della Valle'],
      start: toDay(today.subtract(const Duration(days: 3))),
      time: 480,
      repeat: const ScheduleRepeat(freq: RepeatFreq.daily, count: 14),
      remind: const [0],
      done: {dayKey(toDay(today.subtract(const Duration(days: 3))))},
    ),
    ScheduleEvent(
      id: 'b',
      ownerId: 'u',
      type: ScheduleType.vet,
      place: 'Clinica Veterinaria San Francesco, Via Roma 12',
      start: toDay(today.add(const Duration(days: 1))),
      time: 630,
      remind: const [1440, 60],
    ),
    ScheduleEvent(
      id: 'c',
      ownerId: 'u',
      type: ScheduleType.note,
      title: 'Buy food',
      start: toDay(today),
    ),
  ];

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        scheduleRepositoryProvider.overrideWithValue(_FakeScheduleRepository()),
        scheduleEventsProvider.overrideWith((ref) => Stream.value(events)),
        scheduleHeatProvider.overrideWithValue(const []),
        myPetsProvider.overrideWith((ref) => Stream.value(const [pet])),
        authStateProvider.overrideWith((ref) => Stream.value(null)),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );

    testWidgets('schedule screens fit on a small phone ($locale)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app(const ScheduleScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      for (final tab in [1, 2, 0]) {
        await tester.tap(find.byType(Tab).at(tab));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }

      await tester.tap(find.byType(Tab).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OccurrenceTile).first);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(app(ScheduleFormScreen(event: events.first)));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.drag(find.byType(ListView), const Offset(0, -3000));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(app(const ScheduleFormScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(
        app(
          const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SchedulePromoCard(),
                  PetScheduleCard(pet: pet),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
