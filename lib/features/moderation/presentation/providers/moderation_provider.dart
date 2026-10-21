import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
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

enum ReportedSection { photos, reports }

// null until a moderator picks a tab; the tab with waiting items opens first.
class ReportedSectionChoice extends Notifier<ReportedSection?> {
  @override
  ReportedSection? build() => null;

  void select(ReportedSection section) => state = section;
}

final reportedSectionProvider =
    NotifierProvider<ReportedSectionChoice, ReportedSection?>(
      ReportedSectionChoice.new,
    );

final photoReviewsProvider = StreamProvider<List<PhotoCheck>>(
  (ref) => ref
      .watch(moderationRepositoryProvider)
      .watchPhotoReviews(limit: flagsLimit),
);

// Storage paths of the signed-in user's photos that are waiting for a moderator.
final myHeldPhotosProvider = StreamProvider<Set<String>>((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value(const {});
  return ref.watch(moderationRepositoryProvider).watchHeldPaths(uid);
});

final heldPhotoUrlProvider = FutureProvider.family<String, String>(
  (ref, path) => ref.watch(moderationRepositoryProvider).heldPhotoUrl(path),
);
