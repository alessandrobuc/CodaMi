import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../providers/admin_provider.dart';

class AdminDashboardTab extends ConsumerWidget {
  const AdminDashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final info = ref.watch(currentUserInfoProvider);
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final stats = ref.watch(dashboardStatsProvider);

    final cards = [
      if (isAdmin)
        (
          Icons.people_alt_rounded,
          AppColors.primaryDark,
          l10n.statUsers,
          stats.value?.users,
        ),
      (
        Icons.campaign_rounded,
        AppColors.lostPin,
        l10n.statOpenLost,
        stats.value?.openLost,
      ),
      (
        Icons.volunteer_activism_rounded,
        AppColors.primary,
        l10n.statOpenFound,
        stats.value?.openFound,
      ),
      (
        Icons.home_rounded,
        AppColors.accent,
        l10n.statBackHome,
        stats.value?.backHome,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(dashboardStatsProvider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            children: [
              Text(
                l10n.adminPanel,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${info.name} · ${isAdmin ? l10n.roleAdmin : l10n.roleSupport}',
                style: const TextStyle(color: AppColors.textMuted),
              ),
              const SizedBox(height: 20),
              if (stats.hasError)
                Text(
                  l10n.actionFailed,
                  style: const TextStyle(color: AppColors.danger),
                ),
              for (var row = 0; row < cards.length; row += 2)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var i = row; i < row + 2; i++) ...[
                          if (i > row) const SizedBox(width: 12),
                          Expanded(
                            child: i >= cards.length
                                ? const SizedBox.shrink()
                                : _StatCard(
                                        icon: cards[i].$1,
                                        color: cards[i].$2,
                                        label: cards[i].$3,
                                        value: cards[i].$4,
                                      )
                                      .animate()
                                      .fadeIn(
                                        delay: (60 * i).ms,
                                        duration: 350.ms,
                                      )
                                      .slideY(begin: 0.1),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int? value;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 19, color: color),
          ),
          const SizedBox(height: 14),
          Text(
            value?.toString() ?? '–',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
