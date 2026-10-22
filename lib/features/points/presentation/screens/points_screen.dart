import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../l10n/l10n.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../domain/points.dart';
import '../providers/points_provider.dart';
import '../widgets/points_widgets.dart';
import 'invite_screen.dart';

class PointsScreen extends ConsumerWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final profile = ref.watch(userProfileProvider).value;
    final config =
        ref.watch(pointsConfigProvider).value ?? const PointsConfig();
    final ledger = ref.watch(pointsLedgerProvider).value ?? const [];
    final friends = profile?.referralCount ?? 0;
    final level = profile?.ambassadorLevel;
    final next = config.nextLevel(friends);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.myPoints),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF7B276), Color(0xFFE9803A)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.pointsTotal(profile?.points ?? 0),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  level == null ? l10n.noLevelYet : level.label(l10n),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  next == null
                      ? l10n.topLevelReached
                      : l10n.nextLevelHint(
                          next.minFriends - friends,
                          next.level.label(l10n),
                        ),
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
                ),
                if (next != null) ...[
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: friends / next.minFriends,
                      minHeight: 8,
                      color: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => showDailySheet(context),
                  icon: const Icon(Icons.event_available_rounded, size: 18),
                  label: Text(l10n.dailyRewards),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const InviteScreen()),
                  ),
                  icon: const Icon(Icons.group_add_rounded, size: 18),
                  label: Text(l10n.inviteFriends),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            l10n.pointsHistory,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          if (ledger.isEmpty)
            Text(
              l10n.noPointsYet,
              style: const TextStyle(color: AppColors.textMuted),
            )
          else
            for (final entry in ledger)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  entry.label(l10n),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: entry.createdAt == null
                    ? null
                    : Text(timeAgo(l10n, entry.createdAt!)),
                trailing: Text(
                  entry.points > 0 ? '+${entry.points}' : '${entry.points}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: entry.points > 0
                        ? AppColors.primary
                        : AppColors.danger,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
