import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/points_repository.dart';
import '../../domain/points.dart';
import '../providers/points_provider.dart';
import '../screens/invite_screen.dart';
import '../screens/points_screen.dart';

const pointsColor = Color(0xFFE9803A);

extension AmbassadorLevelLabel on AmbassadorLevel {
  String label(AppLocalizations l10n) => switch (this) {
    AmbassadorLevel.supporter => l10n.levelSupporter,
    AmbassadorLevel.ambassador => l10n.levelAmbassador,
    AmbassadorLevel.superAmbassador => l10n.levelSuperAmbassador,
    AmbassadorLevel.champion => l10n.levelChampion,
  };
}

extension PointsEntryLabel on PointsEntry {
  String label(AppLocalizations l10n) => switch (action) {
    'daily_checkin' => l10n.pointsDailyCheckin,
    'daily_active' => l10n.pointsDailyActive,
    'streak_bonus' => l10n.pointsStreakBonus,
    'referral_qualified' => l10n.pointsFriendJoined,
    'referral_welcome' => l10n.pointsWelcome,
    'level_bonus' => l10n.pointsLevelBonus,
    'manual' => note ?? l10n.pointsAdjusted,
    _ => l10n.pointsOther,
  };
}

extension DailyTaskLabel on DailyTask {
  String label(AppLocalizations l10n) => switch (this) {
    DailyTask.checkin => l10n.dailyCheckin,
    DailyTask.active => l10n.dailyActive,
  };
}

// Header chip on Home: the points total, with a dot when a reward is waiting.
class PointsChip extends ConsumerWidget {
  const PointsChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(userProfileProvider).value?.points ?? 0;
    final waiting = ref.watch(dailyViewProvider).hasClaimable;
    return Material(
      color: AppColors.surface,
      shape: const StadiumBorder(side: BorderSide(color: AppColors.border)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: () => showDailySheet(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.stars_rounded, color: pointsColor, size: 22),
                  if (waiting)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: AppColors.danger,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surface,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 6),
              Text(
                '$points',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showDailySheet(BuildContext context) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: AppColors.surface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
  ),
  builder: (_) => const _DailySheet(),
);

class _DailySheet extends ConsumerStatefulWidget {
  const _DailySheet();

  @override
  ConsumerState<_DailySheet> createState() => _DailySheetState();
}

class _DailySheetState extends ConsumerState<_DailySheet> {
  DailyTask? _claiming;

  Future<void> _claim(DailyTask task) async {
    final l10n = context.l10n;
    setState(() => _claiming = task);
    try {
      final result = await ref.read(pointsRepositoryProvider).claim(task);
      HapticFeedback.mediumImpact();
      if (mounted) {
        SnackbarUtils.showSuccess(
          context,
          result.bonus > 0
              ? l10n.claimedWithBonus(result.points, result.bonus)
              : l10n.claimedPoints(result.points),
        );
      }
    } on FirebaseFunctionsException catch (e) {
      if (mounted && e.code != 'already-exists') {
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _claiming = null);
    }
  }

  void _open(Widget screen) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final view = ref.watch(dailyViewProvider);
    final points = ref.watch(userProfileProvider).value?.points ?? 0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.dailyRewards,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                ),
                const Icon(Icons.stars_rounded, color: pointsColor),
                const SizedBox(width: 4),
                Text(
                  l10n.pointsTotal(points),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  size: 18,
                  color: pointsColor,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    l10n.streakLine(
                      view.streak,
                      view.streakDays,
                      view.streakBonus,
                    ),
                    style: const TextStyle(color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (final task in view.tasks) ...[
              _TaskRow(
                task: task,
                progress: task.task == DailyTask.active && !task.ready
                    ? l10n.activeProgress(view.minutesToday, view.activeMinutes)
                    : null,
                busy: _claiming == task.task,
                onClaim: () => _claim(task.task),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _open(const PointsScreen()),
                    icon: const Icon(Icons.history_rounded, size: 18),
                    label: Text(l10n.myPoints),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _open(const InviteScreen()),
                    icon: const Icon(Icons.group_add_rounded, size: 18),
                    label: Text(l10n.inviteFriends),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final DailyTaskView task;
  final String? progress;
  final bool busy;
  final VoidCallback onClaim;

  const _TaskRow({
    required this.task,
    required this.progress,
    required this.busy,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: task.claimed
            ? AppColors.primary.withValues(alpha: 0.06)
            : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            task.task == DailyTask.checkin
                ? Icons.event_available_rounded
                : Icons.timer_rounded,
            color: task.claimed ? AppColors.primary : pointsColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.task.label(l10n),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  progress ?? l10n.plusPoints(task.points),
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (task.claimed)
            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  l10n.claimed,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            )
          else
            FilledButton(
              onPressed: task.ready && !busy ? onClaim : null,
              style: FilledButton.styleFrom(backgroundColor: pointsColor),
              child: busy
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.claim),
            ),
        ],
      ),
    );
  }
}
