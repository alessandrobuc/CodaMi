import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/screens/admin_user_screen.dart';
import '../../../admin/presentation/screens/admin_users_screen.dart';
import '../../domain/points.dart';
import '../providers/points_provider.dart';
import '../widgets/invite_stats_widgets.dart';
import '../widgets/points_widgets.dart';

Widget _card({required Widget child, EdgeInsets? padding}) => Container(
  padding: padding ?? const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColors.border),
  ),
  child: child,
);

Widget _loadError(BuildContext context, VoidCallback retry) => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      context.l10n.invitesLoadError,
      textAlign: TextAlign.center,
      style: const TextStyle(color: AppColors.textMuted),
    ),
    TextButton(onPressed: retry, child: Text(context.l10n.videoRetry)),
  ],
);

// One user's invites on Admin → Users → user.
class AdminUserInvitesCard extends ConsumerWidget {
  final String uid;
  final String name;

  const AdminUserInvitesCard({
    super.key,
    required this.uid,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stats = ref.watch(adminInviteStatsProvider(uid));

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.group_add_rounded, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.adminInvites,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
              if (stats.value?.code case final code?)
                Tooltip(
                  message: l10n.inviteCodeLabel,
                  child: SelectableText(
                    code,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          switch (stats) {
            AsyncData(:final value) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InviteCountsGrid(counts: value.counts),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          AdminUserInvitesScreen(uid: uid, name: name),
                    ),
                  ),
                  icon: const Icon(Icons.people_alt_rounded),
                  label: Text(
                    '${l10n.seeInvitedFriends} (${value.friends.length})',
                  ),
                ),
              ],
            ),
            AsyncError() => _loadError(
              context,
              () => ref.invalidate(adminInviteStatsProvider(uid)),
            ),
            _ => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          },
        ],
      ),
    );
  }
}

class AdminUserInvitesScreen extends ConsumerWidget {
  final String uid;
  final String name;

  const AdminUserInvitesScreen({
    super.key,
    required this.uid,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stats = ref.watch(adminInviteStatsProvider(uid));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(name.isEmpty ? l10n.invitedFriendsTitle : name),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: switch (stats) {
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: () => ref.refresh(adminInviteStatsProvider(uid).future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
            children: [
              InviteCountsGrid(counts: value.counts),
              const SizedBox(height: 12),
              InviteCountsHelp(stillUsingDays: value.stillUsingDays),
              const SizedBox(height: 22),
              Text(
                l10n.invitedFriendsTitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 10),
              if (value.friends.isEmpty)
                Text(
                  l10n.adminNoInvites,
                  style: const TextStyle(color: AppColors.textMuted),
                )
              else
                for (final friend in value.friends) ...[
                  _FriendTile(friend: friend),
                  const SizedBox(height: 10),
                ],
            ],
          ),
        ),
        AsyncError() => Center(
          child: _loadError(
            context,
            () => ref.invalidate(adminInviteStatsProvider(uid)),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _FriendTile extends StatelessWidget {
  final InvitedFriend friend;

  const _FriendTile({required this.friend});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bucket = friend.status.bucket;
    final name = friend.name.isEmpty ? l10n.aFriend : friend.name;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AdminUserScreen(uid: friend.inviteeId),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: bucket.color.withValues(alpha: 0.15),
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    color: bucket.color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        UserChip(
                          label: bucket.label(l10n),
                          color: bucket.color,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      friend.status.label(l10n),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.text,
                      ),
                    ),
                    if (friend.createdAt case final created?)
                      Text(
                        l10n.inviteJoinedOn(shortDate(l10n, created)),
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    if (friend.lastActiveDay case final last?)
                      Text(
                        l10n.inviteLastInApp(shortDate(l10n, last)),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: friend.stillUsing
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: friend.stillUsing
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Period { allTime, thisMonth, lastMonth, custom }

// Admin → More → Invites: totals and the users who invited the most.
class AdminInvitesScreen extends ConsumerStatefulWidget {
  const AdminInvitesScreen({super.key});

  @override
  ConsumerState<AdminInvitesScreen> createState() => _AdminInvitesScreenState();
}

class _AdminInvitesScreenState extends ConsumerState<AdminInvitesScreen> {
  _Period _period = _Period.allTime;
  DateTimeRange? _custom;
  InviteSort _sort = InviteSort.active;

  InvitePeriod get _range {
    final now = DateTime.now();
    return switch (_period) {
      _Period.allTime => (from: null, to: null),
      _Period.thisMonth => (
        from: dayKeyOf(DateTime(now.year, now.month)),
        to: dayKeyOf(now),
      ),
      _Period.lastMonth => (
        from: dayKeyOf(DateTime(now.year, now.month - 1)),
        to: dayKeyOf(DateTime(now.year, now.month, 0)),
      ),
      _Period.custom => (
        from: dayKeyOf(_custom!.start),
        to: dayKeyOf(_custom!.end),
      ),
    };
  }

  Future<void> _chooseDates() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: now,
      initialDateRange:
          _custom ??
          DateTimeRange(start: DateTime(now.year, now.month), end: now),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _custom = picked;
      _period = _Period.custom;
    });
  }

  String _periodLabel(AppLocalizations l10n, _Period period) =>
      switch (period) {
        _Period.allTime => l10n.periodAllTime,
        _Period.thisMonth => l10n.periodThisMonth,
        _Period.lastMonth => l10n.periodLastMonth,
        _Period.custom => l10n.periodChooseDates,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final range = _range;
    final key = (range, _sort);
    final ranking = ref.watch(adminInviteRankingProvider(key));
    final dates = DateFormat.yMMMd(l10n.localeName);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.adminInvites),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(adminInviteRankingProvider(key).future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final period in _Period.values)
                  ChoiceChip(
                    label: Text(_periodLabel(l10n, period)),
                    selected: _period == period,
                    onSelected: (_) => period == _Period.custom
                        ? _chooseDates()
                        : setState(() => _period = period),
                  ),
              ],
            ),
            if (range.from case final from?) ...[
              const SizedBox(height: 8),
              Text(
                '${dates.format(DateTime.parse(from))} – '
                '${dates.format(DateTime.parse(range.to!))}',
                style: const TextStyle(color: AppColors.textMuted),
              ),
            ],
            const SizedBox(height: 16),
            switch (ranking) {
              AsyncData(:final value) => _RankingBody(
                ranking: value,
                sort: _sort,
                onSort: (sort) => setState(() => _sort = sort),
              ),
              AsyncError() => Padding(
                padding: const EdgeInsets.only(top: 40),
                child: _loadError(
                  context,
                  () => ref.invalidate(adminInviteRankingProvider(key)),
                ),
              ),
              _ => const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Center(child: CircularProgressIndicator()),
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _RankingBody extends StatelessWidget {
  final InviteRanking ranking;
  final InviteSort sort;
  final ValueChanged<InviteSort> onSort;

  const _RankingBody({
    required this.ranking,
    required this.sort,
    required this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (ranking.inviters == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: EmptyState(
          icon: const Icon(Icons.group_add_rounded),
          title: l10n.noInvitesInPeriod,
          message: l10n.noInvitesInPeriodMessage,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.inviteWholeApp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 12),
              InviteCountsGrid(counts: ranking.totals),
              const SizedBox(height: 12),
              InviteCountsHelp(stillUsingDays: ranking.stillUsingDays),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.inviteRanking,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ),
            Text(
              l10n.inviteRankingUsers(ranking.inviters),
              style: const TextStyle(color: AppColors.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SegmentedButton<InviteSort>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: InviteSort.active,
              label: Text(l10n.sortMostActive),
            ),
            ButtonSegment(
              value: InviteSort.joined,
              label: Text(l10n.sortMostInvited),
            ),
          ],
          selected: {sort},
          onSelectionChanged: (s) => onSort(s.single),
        ),
        const SizedBox(height: 12),
        for (final (i, row) in ranking.rows.indexed) ...[
          _RankRow(rank: i + 1, row: row, sort: sort),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _RankRow extends StatelessWidget {
  final int rank;
  final InviteRankingRow row;
  final InviteSort sort;

  const _RankRow({required this.rank, required this.row, required this.sort});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = row.counts;
    final name = row.name.isNotEmpty ? row.name : row.email;
    final main = sort == InviteSort.active ? c.active : c.joined;

    Widget stat(String label, int value, Color color) =>
        UserChip(label: '$label $value', color: color);

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AdminUserScreen(uid: row.uid)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: rank <= 3
                    ? pointsColor
                    : AppColors.primary.withValues(alpha: 0.12),
                child: Text(
                  '$rank',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: rank <= 3 ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    if (row.code case final code?)
                      Text(
                        code,
                        style: const TextStyle(
                          fontSize: 12.5,
                          letterSpacing: 1.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        stat(
                          l10n.inviteBucketActive,
                          c.active,
                          InviteBucket.active.color,
                        ),
                        stat(
                          l10n.inviteBucketInactive,
                          c.inactive,
                          InviteBucket.inactive.color,
                        ),
                        stat(
                          l10n.inviteBucketWaiting,
                          c.waiting,
                          InviteBucket.waiting.color,
                        ),
                        stat(
                          l10n.inviteQrScans,
                          c.qrOpens,
                          AppColors.primaryDark,
                        ),
                        stat(
                          l10n.inviteLinkOpens,
                          c.linkOpens,
                          AppColors.primaryDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$main',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: sort == InviteSort.active
                      ? InviteBucket.active.color
                      : AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
