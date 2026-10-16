import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../data/moderation_repository.dart';

const flagsLimit = 300;

final blockedUsersProvider = Provider<Map<String, String>>(
  (ref) => ref.watch(userProfileProvider).value?.blockedUsers ?? const {},
);

List<Report> withoutBlocked(
  List<Report> reports,
  Map<String, String> blocked,
) => blocked.isEmpty
    ? reports
    : [
        for (final r in reports)
          if (!blocked.containsKey(r.ownerId)) r,
      ];

final flaggedReportsProvider = StreamProvider<List<FlaggedReport>>(
  (ref) => ref
      .watch(moderationRepositoryProvider)
      .watchFlags(limit: flagsLimit)
      .map(FlaggedReport.group),
);

final reportFlagsProvider = StreamProvider.family<List<ReportFlag>, String>(
  (ref, reportId) =>
      ref.watch(moderationRepositoryProvider).watchFlagsFor(reportId),
);
