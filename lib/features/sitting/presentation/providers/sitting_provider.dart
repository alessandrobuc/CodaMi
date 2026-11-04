import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../moderation/presentation/providers/moderation_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/sitting_repository.dart';
import '../../domain/sitting.dart';

final sittingRepositoryProvider = Provider((ref) => SittingRepository());

final _uidProvider = Provider<String?>(
  (ref) => ref.watch(authStateProvider.select((s) => s.value?.uid)),
);

final sittingConfigProvider = StreamProvider<SittingConfig>(
  (ref) => ref.watch(sittingRepositoryProvider).watchConfig(),
);

// Admins can use it before it's switched on for users.
final sittingAvailableProvider = Provider<bool>(
  (ref) =>
      (ref.watch(sittingConfigProvider).value?.enabled ?? false) ||
      ref.watch(userRoleProvider) == UserRole.admin,
);

final mySitterProfileProvider = StreamProvider<SitterProfile?>((ref) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return Stream.value(null);
  return ref.watch(sittingRepositoryProvider).watchSitter(uid);
});

final sitterProfileProvider = StreamProvider.family<SitterProfile?, String>(
  (ref, uid) => ref.watch(sittingRepositoryProvider).watchSitter(uid),
);

final openRequestsProvider = StreamProvider<List<SittingRequest>>((ref) {
  final uid = ref.watch(_uidProvider);
  final blocked = ref.watch(blockedUsersProvider);
  return ref
      .watch(sittingRepositoryProvider)
      .watchOpenRequests()
      .map(
        (list) => [
          for (final r in list)
            if (r.ownerId != uid && !blocked.containsKey(r.ownerId)) r,
        ],
      );
});

final sittersProvider = StreamProvider<List<SitterProfile>>((ref) {
  final uid = ref.watch(_uidProvider);
  final blocked = ref.watch(blockedUsersProvider);
  return ref
      .watch(sittingRepositoryProvider)
      .watchSitters()
      .map(
        (list) => [
          for (final s in list)
            if (s.uid != uid && !blocked.containsKey(s.uid)) s,
        ],
      );
});

final myRequestsProvider = StreamProvider<List<SittingRequest>>((ref) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return Stream.value(const []);
  return ref.watch(sittingRepositoryProvider).watchMyRequests(uid);
});

final sittingRequestProvider = StreamProvider.family<SittingRequest?, String>(
  (ref, id) => ref.watch(sittingRepositoryProvider).watchRequest(id),
);

final offersOnProvider = StreamProvider.family<List<SittingOffer>, String>((
  ref,
  requestId,
) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return Stream.value(const []);
  return ref.watch(sittingRepositoryProvider).watchOffersOn(requestId, uid);
});

final myOffersProvider = StreamProvider<List<SittingOffer>>((ref) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return Stream.value(const []);
  return ref.watch(sittingRepositoryProvider).watchMyOffers(uid);
});

final sitterReviewsProvider =
    StreamProvider.family<List<SittingReview>, String>(
      (ref, uid) => ref.watch(sittingRepositoryProvider).watchReviews(uid),
    );

final reviewedProvider = StreamProvider.family<bool, String>(
  (ref, requestId) =>
      ref.watch(sittingRepositoryProvider).watchReviewed(requestId),
);

final myChatsProvider = StreamProvider<List<SittingChat>>((ref) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return Stream.value(const []);
  return ref.watch(sittingRepositoryProvider).watchChats(uid);
});

final unreadChatsProvider = Provider<int>((ref) {
  final uid = ref.watch(_uidProvider);
  final blocked = ref.watch(blockedUsersProvider);
  return [
    for (final c in ref.watch(myChatsProvider).value ?? const <SittingChat>[])
      if (uid != null &&
          c.unreadFor(uid) &&
          !blocked.containsKey(c.otherOf(uid)))
        c,
  ].length;
});

final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>(
  (ref, chatId) => ref.watch(sittingRepositoryProvider).watchMessages(chatId),
);

final sittingFlagsProvider = StreamProvider<List<SittingFlag>>(
  (ref) => ref.watch(sittingRepositoryProvider).watchFlags(),
);

final latestRequestsProvider = StreamProvider<List<SittingRequest>>(
  (ref) => ref.watch(sittingRepositoryProvider).watchLatestRequests(),
);

final latestSittersProvider = StreamProvider<List<SitterProfile>>(
  (ref) => ref.watch(sittingRepositoryProvider).watchLatestSitters(),
);

final latestReviewsProvider = StreamProvider<List<SittingReview>>(
  (ref) => ref.watch(sittingRepositoryProvider).watchLatestReviews(),
);
