import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/heat_repository.dart';
import '../../domain/heat.dart';

final heatRepositoryProvider = Provider((ref) => HeatRepository());

final heatConfigProvider = StreamProvider<HeatConfig>(
  (ref) => ref.watch(heatRepositoryProvider).watchConfig(),
);

// Admins can use it before it's switched on for users.
final heatAvailableProvider = Provider<bool>(
  (ref) =>
      (ref.watch(heatConfigProvider).value?.enabled ?? false) ||
      ref.watch(userRoleProvider) == UserRole.admin,
);

final petHeatCyclesProvider = StreamProvider.family<List<HeatCycle>, String>((
  ref,
  petId,
) {
  final uid = ref.watch(authStateProvider.select((s) => s.value?.uid));
  if (uid == null) return Stream.value(const []);
  return ref.watch(heatRepositoryProvider).watchCycles(uid, petId);
});

final heatReminderProvider = StreamProvider.family<HeatReminder?, String>(
  (ref, petId) => ref.watch(heatRepositoryProvider).watchReminder(petId),
);
