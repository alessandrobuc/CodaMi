import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../points/domain/points.dart';
import '../../../points/presentation/providers/points_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/titles_repository.dart';
import '../../domain/titles.dart';

final titlesConfigProvider = StreamProvider<TitlesConfig>(
  (ref) => ref.watch(titlesRepositoryProvider).watchConfig(),
);

// Admins can use it before it's switched on for users.
final titlesAvailableProvider = Provider<bool>(
  (ref) =>
      (ref.watch(titlesConfigProvider).value?.enabled ?? false) ||
      ref.watch(userRoleProvider) == UserRole.admin,
);

final myAchievementsProvider = StreamProvider<Achievements>((ref) {
  final uid = ref.watch(authStateProvider.select((a) => a.value?.uid));
  if (uid == null) return Stream.value(const Achievements());
  return ref.watch(titlesRepositoryProvider).watchAchievements(uid);
});

final publicTitlesProvider = StreamProvider.autoDispose
    .family<PublicTitles, String>(
      (ref, uid) => ref.watch(titlesRepositoryProvider).watchPublic(uid),
    );

// The invite levels from Points and rewards, used for the Ambassador title.
final ambassadorMinsProvider = Provider<List<int>>(
  (ref) => [
    for (final l
        in (ref.watch(pointsConfigProvider).value ?? const PointsConfig())
            .levels)
      l.minFriends,
  ]..sort(),
);
