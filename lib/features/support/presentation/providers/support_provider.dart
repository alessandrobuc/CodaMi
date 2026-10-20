import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/support_repository.dart';
import '../../domain/support_case.dart';

const supportPageSize = 30;

String? _uid(Ref ref) => ref.watch(authStateProvider).value?.uid;

final myCasesProvider = StreamProvider<List<SupportCase>>((ref) {
  final uid = _uid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(supportRepositoryProvider).watchMyCases(uid);
});

final supportCaseProvider = StreamProvider.family<SupportCase?, String>(
  (ref, id) => ref.watch(supportRepositoryProvider).watchCase(id),
);

String messagesKey(String caseId) => 'messages_$caseId';

// One more than the limit, so the chat knows whether older messages exist.
final supportMessagesProvider =
    StreamProvider.family<List<SupportMessage>, String>((ref, id) {
      final limit = ref.watch(supportLimitProvider(messagesKey(id)));
      return ref
          .watch(supportRepositoryProvider)
          .watchMessages(id, limit: limit + 1);
    });

final supportEventsProvider = StreamProvider.family<List<SupportEvent>, String>(
  (ref, id) => ref.watch(supportRepositoryProvider).watchEvents(id),
);

final liveChatAvailableProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.watch(supportRepositoryProvider).liveChatAvailable(),
);

class SupportLimit extends Notifier<int> {
  SupportLimit(this.key);

  final Object key;

  @override
  int build() => supportPageSize;

  void loadMore({required int loaded}) {
    if (loaded > state) state += supportPageSize;
  }
}

final supportLimitProvider = NotifierProvider.family<SupportLimit, int, Object>(
  SupportLimit.new,
);

final staffCasesProvider = StreamProvider.family<List<SupportCase>, CaseFilter>(
  (ref, filter) {
    final uid = _uid(ref);
    if (uid == null) return Stream.value(const []);
    final limit = ref.watch(supportLimitProvider(filter));
    return ref
        .watch(supportRepositoryProvider)
        .watchStaffCases(filter, uid: uid, limit: limit + 1);
  },
);

final operatorCasesProvider = StreamProvider.family<List<SupportCase>, String>((
  ref,
  uid,
) {
  final limit = ref.watch(supportLimitProvider('operator_$uid'));
  return ref
      .watch(supportRepositoryProvider)
      .watchOperatorCases(uid, limit: limit + 1);
});

final staffStatsProvider = StreamProvider.family<StaffStats, String>(
  (ref, uid) => ref.watch(supportRepositoryProvider).watchStats(uid),
);

final staffPresenceProvider = StreamProvider<Map<String, StaffPresence>>(
  (ref) => ref.watch(supportRepositoryProvider).watchPresence(),
);

final operatorActiveCountProvider = FutureProvider.autoDispose
    .family<int, String>(
      (ref, uid) => ref.watch(supportRepositoryProvider).activeCount(uid),
    );

final supportCountsProvider = FutureProvider.autoDispose<SupportCounts>(
  (ref) => ref.watch(supportRepositoryProvider).counts(),
);
