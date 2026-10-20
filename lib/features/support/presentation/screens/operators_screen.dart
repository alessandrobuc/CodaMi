import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/data/admin_repository.dart';
import '../../../admin/presentation/providers/admin_provider.dart';
import '../../domain/support_case.dart';
import '../providers/support_provider.dart';
import '../widgets/support_labels.dart';
import 'admin_tickets_tab.dart';
import 'support_case_screen.dart';

// Admin view of each operator's activity and performance.
class OperatorsScreen extends ConsumerWidget {
  const OperatorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final staff = ref.watch(supportStaffProvider);
    final presence = ref.watch(staffPresenceProvider).value ?? const {};
    final list = staff.value ?? const <StaffMember>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l10n.supportOperators)),
      body: staff.isLoading && !staff.hasValue
          ? const Center(child: CircularProgressIndicator())
          : list.isEmpty
          ? Center(
              child: EmptyState(
                icon: const Icon(Icons.support_agent_rounded),
                title: l10n.supportOperators,
                message: l10n.noOperators,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                100 + MediaQuery.viewPaddingOf(context).bottom,
              ),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final member = list[i];
                final state = (presence[member.uid] ?? const StaffPresence())
                    .current();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _OperatorCard(
                    member: member,
                    presence: state,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OperatorScreen(member: member),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _OperatorCard extends ConsumerWidget {
  final StaffMember member;
  final PresenceState presence;
  final VoidCallback onTap;

  const _OperatorCard({
    required this.member,
    required this.presence,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stats = ref.watch(staffStatsProvider(member.uid)).value;
    final open = ref.watch(operatorActiveCountProvider(member.uid)).value;
    String time(Duration? d) => d == null ? '–' : formatDuration(l10n, d);

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.12,
                        ),
                        child: const Icon(
                          Icons.support_agent_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      Positioned(
                        right: -1,
                        bottom: -1,
                        child: PresenceDot(presence, size: 13),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name.isEmpty ? member.email : member.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        Text(
                          stats?.lastActiveAt == null
                              ? presence.label(l10n)
                              : '${presence.label(l10n)} · ${l10n.operatorLastActive(timeAgo(l10n, stats!.lastActiveAt!))}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: presence.color),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _Figure(l10n.operatorOpenCases, open?.toString() ?? '–'),
                  _Figure(
                    l10n.operatorResolved,
                    '${stats?.casesResolved ?? 0}',
                  ),
                  _Figure(l10n.supportAvgReply, time(stats?.averageResponse)),
                  _Figure(
                    l10n.operatorAvgHandling,
                    time(stats?.averageHandling),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  final String label;
  final String value;

  const _Figure(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: AppColors.text,
            ),
          ),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class OperatorScreen extends ConsumerWidget {
  final StaffMember member;

  const OperatorScreen({super.key, required this.member});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stats = ref.watch(staffStatsProvider(member.uid)).value;
    final open = ref.watch(operatorActiveCountProvider(member.uid)).value;
    final cases = ref.watch(operatorCasesProvider(member.uid));
    final key = 'operator_${member.uid}';
    final limit = ref.watch(supportLimitProvider(key));
    String time(Duration? d) => d == null ? '–' : formatDuration(l10n, d);

    final figures = [
      (l10n.operatorOpenCases, open?.toString() ?? '–'),
      (l10n.operatorTaken, '${stats?.casesTaken ?? 0}'),
      (l10n.operatorResolved, '${stats?.casesResolved ?? 0}'),
      (l10n.operatorReplies, '${stats?.responses ?? 0}'),
      (l10n.supportAvgReply, time(stats?.averageResponse)),
      (l10n.operatorAvgHandling, time(stats?.averageHandling)),
    ];
    final all = cases.value ?? const <SupportCase>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(member.name.isEmpty ? member.email : member.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final (label, value) in figures)
                  SizedBox(
                    width: (MediaQuery.sizeOf(context).width - 60) / 3,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Text(
              l10n.operatorCases,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: cases.isLoading && !cases.hasValue
                ? const Center(child: CircularProgressIndicator())
                : CaseList(
                    cases: all.take(limit).toList(),
                    onOpen: (c) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            SupportCaseScreen(caseId: c.id, asStaff: true),
                      ),
                    ),
                    onLoadMore: all.length > limit
                        ? () => ref
                              .read(supportLimitProvider(key).notifier)
                              .loadMore(loaded: all.length)
                        : null,
                  ),
          ),
        ],
      ),
    );
  }
}
