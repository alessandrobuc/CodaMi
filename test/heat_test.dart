import 'package:CodaMi/features/heat/data/heat_repository.dart';
import 'package:CodaMi/features/heat/domain/heat.dart';
import 'package:CodaMi/features/heat/presentation/providers/heat_provider.dart';
import 'package:CodaMi/features/heat/presentation/screens/admin_heat_screen.dart';
import 'package:CodaMi/features/heat/presentation/screens/heat_calendar_screen.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeHeatRepository implements HeatRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future<void>.value();
}

HeatCycle cycle(String start, [String? end, String id = '']) => HeatCycle(
  id: id.isEmpty ? start : id,
  petId: 'p',
  start: parseHeatDay(start)!,
  end: parseHeatDay(end),
);

void main() {
  const config = HeatConfig();
  final today = DateTime.utc(2026, 11, 4);

  test('no records: nothing to estimate yet', () {
    final e = estimateHeat(const [], PetSpecies.dog, config, today);
    expect(e.records, 0);
    expect(e.cycleDays, 180);
    expect(e.upcoming, isEmpty);
    expect(e.nextStart, isNull);
  });

  test('one record: typical cycle for the species, own heat length', () {
    final e = estimateHeat(
      [cycle('2026-06-01', '2026-06-14')],
      PetSpecies.dog,
      config,
      today,
    );
    expect(e.fromHistory, isFalse);
    expect(e.cycleDays, 180);
    expect(e.heatDays, 14);
    expect(heatDayKey(e.nextStart!), '2026-11-28');
    expect(heatDayKey(e.upcoming.first.end), '2026-12-11');
    expect(e.upcoming, hasLength(3));
  });

  test('two records: the pet\'s own cycle; typing mistakes ignored', () {
    final e = estimateHeat(
      [
        cycle('2026-01-10', '2026-01-27'),
        cycle('2026-07-10', '2026-07-27'),
        cycle('2026-07-12', '2026-07-20', 'typo'),
      ],
      PetSpecies.dog,
      config,
      today,
    );
    expect(e.fromHistory, isTrue);
    expect(e.cycleDays, 181);
    expect(heatDayKey(e.nextStart!), '2027-01-07');
  });

  test('missed estimates are skipped to the next one', () {
    final e = estimateHeat(
      [cycle('2025-01-01', '2025-01-18')],
      PetSpecies.dog,
      config,
      today,
    );
    expect(e.nextStart!.isAfter(today), isTrue);
    expect(e.upcoming.first.end.isBefore(today), isFalse);
  });

  test('an open heat is the current one', () {
    final e = estimateHeat(
      [cycle('2026-11-01')],
      PetSpecies.cat,
      config,
      today,
    );
    expect(e.current?.id, '2026-11-01');
    expect(e.cycleDays, 21);
    expect(heatDayKey(e.nextStart!), '2026-11-22');
  });

  test('other animals: no estimate until two records', () {
    final one = estimateHeat(
      [cycle('2026-09-01', '2026-09-05')],
      PetSpecies.other,
      config,
      today,
    );
    expect(one.cycleDays, isNull);
    expect(one.upcoming, isEmpty);
    final two = estimateHeat(
      [cycle('2026-09-01', '2026-09-05'), cycle('2026-10-01', '2026-10-05')],
      PetSpecies.other,
      config,
      today,
    );
    expect(two.cycleDays, 30);
    expect(heatDayKey(two.nextStart!), '2026-10-31');
  });

  test('reminder goes on the first heat whose reminder day is ahead', () {
    final e = estimateHeat(
      [cycle('2026-05-08', '2026-05-20')],
      PetSpecies.dog,
      config,
      today,
    );
    expect(heatDayKey(e.nextStart!), '2026-11-04');
    final plan = reminderPlan(e, 3, today)!;
    expect(heatDayKey(plan.nextStart), '2027-05-03');
    expect(heatDayKey(plan.remindOn), '2027-04-30');
    expect(plan.cycleDays, 180);
    expect(
      reminderPlan(
        estimateHeat(const [], PetSpecies.dog, config, today),
        3,
        today,
      ),
      isNull,
    );
  });

  test('settings: bad values fall back to the defaults', () {
    final c = HeatConfig.fromMap({
      'enabled': true,
      'cycleDays': {'dog': 3, 'cat': 25, 'other': 0},
      'heatDays': {'dog': 99},
    });
    expect(c.enabled, isTrue);
    expect(c.cycleDays[PetSpecies.dog], 180);
    expect(c.cycleDays[PetSpecies.cat], 25);
    expect(c.cycleDays[PetSpecies.other], 0);
    expect(c.heatDays[PetSpecies.dog], 18);
    expect(HeatConfig.validCycle(PetSpecies.dog, 0), isFalse);
    expect(HeatConfig.validCycle(PetSpecies.other, 0), isTrue);
    expect(parseHeatDay('2026-02-30'), isNull);
  });

  const pet = Pet(
    id: 'p',
    ownerId: 'u',
    name: 'Principessa Luna della Valle',
    species: PetSpecies.dog,
    sex: PetSex.female,
  );
  final now = DateTime.now();
  String ago(int days) => heatDayKey(now.subtract(Duration(days: days)));

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        heatRepositoryProvider.overrideWithValue(_FakeHeatRepository()),
        heatConfigProvider.overrideWith(
          (ref) => Stream.value(const HeatConfig(enabled: true)),
        ),
        petHeatCyclesProvider.overrideWith(
          (ref, id) => Stream.value([
            cycle(ago(2)),
            cycle(ago(190), ago(175)),
            cycle(ago(372), ago(355)),
          ]),
        ),
        heatReminderProvider.overrideWith(
          (ref, id) => Stream.value(HeatReminder(7, ago(-180), 182)),
        ),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );

    testWidgets('heat screens fit on a small phone ($locale)', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app(const HeatCalendarScreen(pet: pet)));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.drag(find.byType(ListView), const Offset(0, -2000));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byType(Switch).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(
        app(
          const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20),
              child: HeatPetCard(pet: pet),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(app(const AdminHeatScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
