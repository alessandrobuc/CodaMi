import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../heat/domain/heat.dart';
import '../../../heat/presentation/providers/heat_provider.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/schedule_repository.dart';
import '../../domain/schedule.dart';
import '../widgets/schedule_widgets.dart';

final scheduleRepositoryProvider = Provider((ref) => ScheduleRepository());

final scheduleConfigProvider = StreamProvider<ScheduleConfig>(
  (ref) => ref.watch(scheduleRepositoryProvider).watchConfig(),
);

// Admins can use it before it's switched on for users.
final scheduleAvailableProvider = Provider<bool>(
  (ref) =>
      (ref.watch(scheduleConfigProvider).value?.enabled ?? false) ||
      ref.watch(userRoleProvider) == UserRole.admin,
);

final scheduleEventsProvider = StreamProvider<List<ScheduleEvent>>((ref) {
  final uid = ref.watch(authStateProvider.select((s) => s.value?.uid));
  if (uid == null) return Stream.value(const []);
  return ref.watch(scheduleRepositoryProvider).watchEvents(uid);
});

// The next events still to do, from today on.
final upcomingOccurrencesProvider = Provider.family<List<Occurrence>, String?>((
  ref,
  petId,
) {
  final events = ref.watch(scheduleEventsProvider).value ?? const [];
  final now = DateTime.now();
  return [
    for (final o in occurrencesOf(
      events.where((e) => petId == null || e.petIds.contains(petId)),
      now,
      now.add(const Duration(days: 366)),
    ))
      if (!o.done) o,
  ];
});

typedef ScheduleHeat = ({Pet pet, HeatPeriod period});

// Expected heats from the heat calendar, shown as estimates.
final scheduleHeatProvider = Provider<List<ScheduleHeat>>((ref) {
  if (!ref.watch(heatAvailableProvider)) return const [];
  final config = ref.watch(heatConfigProvider).value ?? const HeatConfig();
  final now = DateTime.now();
  return [
    for (final pet in ref.watch(myPetsProvider).value ?? const <Pet>[])
      if (pet.sex != PetSex.male)
        if (ref.watch(petHeatCyclesProvider(pet.id)).value case final cycles?)
          for (final period in estimateHeat(
            cycles,
            pet.species,
            config,
            now,
          ).upcoming)
            (pet: pet, period: period),
  ];
});

Future<String> saveScheduleEvent(
  WidgetRef ref,
  AppLocalizations l10n,
  ScheduleEvent e,
) => ref
    .read(scheduleRepositoryProvider)
    .save(e, planReminders(e, DateTime.now(), reminderText(l10n)));

// Tops up each event's reminders and rewrites them in the current language.
Future<void> syncScheduleReminders(
  ScheduleRepository repo,
  AppLocalizations l10n,
  String uid,
) async {
  try {
    final now = DateTime.now();
    for (final e in await repo.events(uid)) {
      final planned = planReminders(e, now, reminderText(l10n));
      final stored = e.reminders.where((r) => r.at.isAfter(now)).toList();
      if (listEquals(planned, stored)) continue;
      await repo.saveReminders(e.id, planned);
    }
  } catch (e) {
    debugPrint('Schedule reminders not synced: $e');
  }
}
