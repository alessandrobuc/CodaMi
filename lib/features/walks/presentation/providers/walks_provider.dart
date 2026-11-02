import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_languages.dart';
import '../../data/walks_repository.dart';
import '../../domain/walks.dart';

final walksRepositoryProvider = Provider((ref) => WalksRepository());

final walksConfigProvider = StreamProvider<WalksConfig>(
  (ref) => ref.watch(walksRepositoryProvider).watchConfig(),
);

final walksEnabledProvider = Provider<bool>(
  (ref) => ref.watch(walksConfigProvider).value?.enabled ?? false,
);

// Opened details stay for the session, so tapping a place again is free.
final walkDetailsProvider = FutureProvider.family<WalkDetails, String>(
  (ref, placeId) => ref
      .watch(walksRepositoryProvider)
      .details(placeId, language: currentAppLanguage.code),
);
