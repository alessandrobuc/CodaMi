import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sharing_repository.dart';
import '../../domain/sharing.dart';

final sharingRepositoryProvider = Provider((ref) => SharingRepository());

final sharingConfigProvider = StreamProvider<SharingConfig>(
  (ref) => ref.watch(sharingRepositoryProvider).watchConfig(),
);

final reportShareStatsProvider = StreamProvider.family<ShareStats, String>(
  (ref, id) => ref.watch(sharingRepositoryProvider).watchReportStats(id),
);

final shareTotalsProvider = StreamProvider<ShareStats>(
  (ref) => ref.watch(sharingRepositoryProvider).watchTotals(),
);

final shareReminderConfigProvider = StreamProvider<ShareReminderConfig>(
  (ref) => ref.watch(sharingRepositoryProvider).watchReminderConfig(),
);

final shareReminderTotalsProvider = StreamProvider<ShareReminderStats>(
  (ref) => ref.watch(sharingRepositoryProvider).watchReminderTotals(),
);
