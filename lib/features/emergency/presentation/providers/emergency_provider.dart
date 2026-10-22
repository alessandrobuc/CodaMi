import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/geo.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/emergency_repository.dart';
import '../../domain/emergency.dart';

// Active emergencies count as "near you" within this distance of the home city.
const nearbyEmergencyKm = 25.0;
const emergencyListLimit = 100;

final emergencyProvider = StreamProvider.family<Emergency?, String>(
  (ref, id) => ref.watch(emergencyRepositoryProvider).watch(id),
);

final activeEmergenciesProvider = StreamProvider<List<Emergency>>(
  (ref) => ref
      .watch(emergencyRepositoryProvider)
      .watchActive(limit: emergencyListLimit),
);

final nearbyEmergenciesProvider = Provider<List<Emergency>>((ref) {
  final profile = ref.watch(userProfileProvider).value;
  final all = ref.watch(activeEmergenciesProvider).value ?? const [];
  final lat = profile?.homeLat;
  final lng = profile?.homeLng;
  final blocked = profile?.blockedUsers ?? const {};
  return [
    for (final e in all)
      if (!blocked.containsKey(e.ownerId) &&
          (lat == null ||
              lng == null ||
              metersBetween(lat, lng, e.lat, e.lng) / 1000 <=
                  nearbyEmergencyKm))
        e,
  ];
});

final myEmergenciesProvider = StreamProvider<List<Emergency>>((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(emergencyRepositoryProvider).watchMine(uid);
});

final allEmergenciesProvider = StreamProvider<List<Emergency>>(
  (ref) => ref
      .watch(emergencyRepositoryProvider)
      .watchAll(limit: emergencyListLimit),
);

final activeContactsProvider = StreamProvider<List<EmergencyContact>>(
  (ref) => ref.watch(emergencyRepositoryProvider).watchActiveContacts(),
);

final allContactsProvider = StreamProvider<List<EmergencyContact>>(
  (ref) => ref.watch(emergencyRepositoryProvider).watchAllContacts(),
);

// The directory for browsing: real contacts before test placeholders, then nearest.
List<EmergencyContact> sortedForBrowsing(
  List<EmergencyContact> contacts, {
  double? lat,
  double? lng,
}) {
  double distance(EmergencyContact c) => lat == null || lng == null
      ? 0
      : metersBetween(lat, lng, c.lat, c.lng) / 1000;
  return [...contacts]..sort((a, b) {
    if (a.isTest != b.isTest) return a.isTest ? 1 : -1;
    return distance(a).compareTo(distance(b));
  });
}
