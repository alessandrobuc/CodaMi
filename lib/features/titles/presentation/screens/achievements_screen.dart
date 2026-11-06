import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/screen_space.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../donations/data/donations_repository.dart';
import '../../../donations/presentation/support_screen.dart';
import '../../data/titles_repository.dart';
import '../../domain/titles.dart';
import '../providers/titles_provider.dart';
import '../widgets/title_labels.dart';

String centsLabel(int cents) => NumberFormat.currency(
  locale: currentAppLanguage.code,
  symbol: '€',
  decimalDigits: cents % 100 == 0 ? 0 : 2,
).format(cents / 100);

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({super.key});

  @override
  ConsumerState<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    try {
      await ref.read(titlesRepositoryProvider).refresh();
    } catch (e) {
      debugPrint('Titles not refreshed: $e');
    }
  }

  Future<void> _setPrefs({TitleId? main, required bool hideDonor}) async {
    final l10n = context.l10n;
    try {
      await ref
          .read(titlesRepositoryProvider)
          .setPrefs(main: main, hideDonor: hideDonor);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Title choice not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  Future<void> _chooseMain(Achievements a) async {
    final picked = await showModalBottomSheet<_Choice>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _MainChooser(achievements: a),
    );
    if (picked == null || !mounted) return;
    await _setPrefs(main: picked.id, hideDonor: a.hideDonor);
  }

  void _openTitle(TitleId id, Achievements a, TitlesConfig c, List<int> mins) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _TitleSheet(
        id: id,
        achievements: a,
        config: c,
        ambassadorMins: mins,
        onSetMain: () {
          Navigator.of(context).pop();
          _setPrefs(main: id, hideDonor: a.hideDonor);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final config =
        ref.watch(titlesConfigProvider).value ?? const TitlesConfig();
    final a = ref.watch(myAchievementsProvider).value ?? const Achievements();
    final mins = ref.watch(ambassadorMinsProvider);
    final uid = ref.watch(authStateProvider).value?.uid ?? '';
    final main = ref.watch(publicTitlesProvider(uid)).value?.title;
    final shown = shownTitles(config, a);
    final unlocked =
        shown.where((id) => a.level(id) > 0).length +
        (a.level(TitleId.donor) > 0 ? 1 : 0);
    final goal = nextGoal(a, config, mins);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.ttlAchievements),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: EdgeInsets.fromLTRB(16, 4, 16, endSpace(context)),
          children: [
            _Hero(
              main: main,
              unlocked: unlocked,
              total: shown.length + 1,
              onChange: a.unlocked.isEmpty ? null : () => _chooseMain(a),
            ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.08, end: 0),
            if (goal != null) ...[
              const SizedBox(height: 14),
              _NextGoal(
                id: goal,
                progress: progressOf(goal, a, config, mins),
                onTap: () => _openTitle(goal, a, config, mins),
              ),
            ],
            _Heading(l10n.ttlAllTitles),
            for (final (i, id) in shown.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    _TitleCard(
                          id: id,
                          progress: progressOf(id, a, config, mins),
                          isMain: main?.id == id,
                          paused: titlePaused(id, a, config),
                          revoked: a.revoked.contains(id),
                          onTap: () => _openTitle(id, a, config, mins),
                        )
                        .animate(delay: (40 * i).ms)
                        .fadeIn(duration: 300.ms)
                        .slideX(begin: 0.04, end: 0),
              ),
            _Heading(l10n.ttlDonorSection),
            _DonorCard(
              achievements: a,
              config: config,
              isMain: main?.id == TitleId.donor,
              onShowChanged: (show) =>
                  _setPrefs(main: a.main, hideDonor: !show),
              onSetMain: () => _setPrefs(main: TitleId.donor, hideDonor: false),
            ),
          ],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;

  const _Heading(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 22, 4, 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: AppColors.text,
        ),
      ),
    );
  }
}

class _Emoji extends StatelessWidget {
  final String emoji;
  final double size;
  final bool locked;
  final Color background;

  const _Emoji(
    this.emoji, {
    this.size = 48,
    this.locked = false,
    this.background = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: Opacity(
        opacity: locked ? 0.35 : 1,
        child: Text(emoji, style: TextStyle(fontSize: size * 0.48)),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final TitleLevel? main;
  final int unlocked;
  final int total;
  final VoidCallback? onChange;

  const _Hero({
    required this.main,
    required this.unlocked,
    required this.total,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = main;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Emoji(
                title?.emoji ?? '🏆',
                size: 64,
                locked: title == null,
                background: AppColors.surface,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.ttlMainTitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title?.name(l10n) ?? l10n.ttlNoTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              if (onChange != null)
                TextButton(
                  onPressed: onChange,
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: Text(l10n.ttlChange),
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (title == null)
            Text(
              l10n.ttlNoTitleBody,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.35,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          if (title == null) const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: total == 0 ? 0 : unlocked / total,
              color: AppColors.accent,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.ttlUnlockedCount(unlocked, total),
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _NextGoal extends StatelessWidget {
  final TitleId id;
  final TitleProgress progress;
  final VoidCallback onTap;

  const _NextGoal({
    required this.id,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final next = TitleLevel(id, progress.level + 1);
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              _Emoji(next.emoji, size: 46, locked: true),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.ttlNextGoal,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.rewardText,
                      ),
                    ),
                    Text(
                      next.name(l10n),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _Bar(progress: progress, color: AppColors.accent),
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

class _Bar extends StatelessWidget {
  final TitleProgress progress;
  final Color color;

  const _Bar({required this.progress, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              minHeight: 7,
              value: progress.fraction,
              color: color,
              backgroundColor: AppColors.background,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          progress.complete
              ? l10n.ttlAllDone
              : l10n.ttlProgress(progress.current, progress.next!),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _Stars extends StatelessWidget {
  final int level;
  final int max;

  const _Stars({required this.level, required this.max});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= max; i++)
          Icon(
            i <= level ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 16,
            color: i <= level ? AppColors.accent : AppColors.border,
          ),
      ],
    );
  }
}

class _TitleCard extends StatelessWidget {
  final TitleId id;
  final TitleProgress progress;
  final bool isMain;
  final bool paused;
  final bool revoked;
  final VoidCallback onTap;

  const _TitleCard({
    required this.id,
    required this.progress,
    required this.isMain,
    required this.paused,
    required this.revoked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locked = progress.level == 0;
    final name = locked
        ? id.name(l10n)
        : TitleLevel(id, progress.level).name(l10n);
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isMain ? AppColors.primary : AppColors.border,
              width: isMain ? 1.6 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Emoji(id.emoji(progress.level.clamp(1, 6)), locked: locked),
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
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: locked
                                  ? AppColors.textMuted
                                  : AppColors.text,
                            ),
                          ),
                        ),
                        if (isMain)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              l10n.ttlMainTitle,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (progress.maxLevel > 1) ...[
                      const SizedBox(height: 2),
                      _Stars(level: progress.level, max: progress.maxLevel),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      revoked
                          ? l10n.ttlAdminTakenAway
                          : paused
                          ? (id == TitleId.trusted
                                ? l10n.ttlPausedTrusted
                                : l10n.ttlPausedSitter)
                          : id.how(l10n),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: paused || revoked
                            ? AppColors.rewardText
                            : AppColors.textMuted,
                      ),
                    ),
                    if (!id.isManual) ...[
                      const SizedBox(height: 8),
                      _Bar(progress: progress),
                    ],
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

class _TitleSheet extends StatelessWidget {
  final TitleId id;
  final Achievements achievements;
  final TitlesConfig config;
  final List<int> ambassadorMins;
  final VoidCallback onSetMain;

  const _TitleSheet({
    required this.id,
    required this.achievements,
    required this.config,
    required this.ambassadorMins,
    required this.onSetMain,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final a = achievements;
    final thresholds = config.thresholds(id, ambassadorMins);
    final level = a.level(id);
    final date = DateFormat.yMMMd(l10n.localeName);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: _Emoji(
                id.emoji(level.clamp(1, 6)),
                size: 72,
                locked: level == 0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              level == 0 ? id.name(l10n) : TitleLevel(id, level).name(l10n),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              id.how(l10n),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            for (final (i, need) in thresholds.indexed)
              _LevelRow(
                title: TitleLevel(id, i + 1),
                need: need,
                current: a.count(id),
                reached: level > i,
                unlockedAt: a.unlockedAt['${id.name}_${i + 1}'],
                bonus: id.isCounted && config.enabled
                    ? config.bonus.elementAtOrNull(i) ?? 0
                    : 0,
                date: date,
              ),
            if (id.isManual)
              _LevelRow(
                title: TitleLevel(id, 1),
                need: 0,
                current: 0,
                reached: level > 0,
                unlockedAt: a.unlockedAt['${id.name}_1'],
                bonus: 0,
                date: date,
              ),
            const SizedBox(height: 12),
            if (level > 0 && a.main != id)
              FilledButton.icon(
                onPressed: onSetMain,
                icon: const Icon(Icons.workspace_premium_rounded),
                label: Text(l10n.ttlSetMain),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  final TitleLevel title;
  final int need;
  final int current;
  final bool reached;
  final DateTime? unlockedAt;
  final int bonus;
  final DateFormat date;

  const _LevelRow({
    required this.title,
    required this.need,
    required this.current,
    required this.reached,
    required this.unlockedAt,
    required this.bonus,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final detail = [
      if (title.id.isManual)
        l10n.ttlHowManual
      else if (title.id == TitleId.donor)
        need <= 1 ? l10n.ttlAnyDonation : l10n.ttlFrom(centsLabel(need))
      else
        reached ? l10n.ttlNeeded(need) : l10n.ttlProgress(current, need),
      if (reached && unlockedAt != null)
        l10n.ttlUnlockedOn(date.format(unlockedAt!)),
      if (bonus > 0) l10n.ttlBonus(bonus),
    ].join(' · ');
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: reached
            ? AppColors.primary.withValues(alpha: 0.07)
            : AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(title.emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.name(l10n),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: reached ? AppColors.text : AppColors.textMuted,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            reached ? Icons.check_circle_rounded : Icons.lock_outline_rounded,
            color: reached ? AppColors.primary : AppColors.border,
          ),
        ],
      ),
    );
  }
}

class _DonorCard extends ConsumerWidget {
  final Achievements achievements;
  final TitlesConfig config;
  final bool isMain;
  final ValueChanged<bool> onShowChanged;
  final VoidCallback onSetMain;

  const _DonorCard({
    required this.achievements,
    required this.config,
    required this.isMain,
    required this.onShowChanged,
    required this.onSetMain,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final a = achievements;
    final level = a.level(TitleId.donor);
    final total = a.count(TitleId.donor);
    final thresholds = config.thresholds(TitleId.donor, const []);
    final canDonate =
        ref.watch(donationsConfigProvider).value?.enabled ?? false;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.ttlDonorIntro,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, box) {
                final width = (box.maxWidth - 16) / 3;
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 1; i <= donorLevels; i++)
                      _DonorTier(
                        width: width,
                        level: i,
                        need: thresholds[i - 1],
                        reached: level >= i,
                        current: level == i,
                      ),
                  ],
                );
              },
            ),
            if (total > 0) ...[
              const SizedBox(height: 14),
              Text(
                '${l10n.ttlYourTotal(centsLabel(total))} · ${l10n.ttlOnlyYou}',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ],
            if (level > 0) ...[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: !a.hideDonor,
                onChanged: onShowChanged,
                title: Text(
                  l10n.ttlShowDonor,
                  style: const TextStyle(fontSize: 14, color: AppColors.text),
                ),
              ),
              if (!isMain && !a.hideDonor)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: onSetMain,
                    icon: const Icon(Icons.workspace_premium_rounded, size: 18),
                    label: Text(l10n.ttlSetMain),
                  ),
                ),
            ],
            if (canDonate) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SupportScreen()),
                ),
                icon: const Icon(Icons.favorite_rounded, size: 18),
                label: Text(l10n.supportCodami),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(46),
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DonorTier extends StatelessWidget {
  final double width;
  final int level;
  final int need;
  final bool reached;
  final bool current;

  const _DonorTier({
    required this.width,
    required this.level,
    required this.need,
    required this.reached,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = TitleLevel(TitleId.donor, level);
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        color: reached
            ? AppColors.accent.withValues(alpha: 0.12)
            : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: current ? AppColors.accent : Colors.transparent,
          width: 1.6,
        ),
      ),
      child: Column(
        children: [
          Opacity(
            opacity: reached ? 1 : 0.4,
            child: Text(title.emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 4),
          Text(
            title.name(l10n),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: reached ? AppColors.rewardText : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            level == 1 ? l10n.ttlAnyDonation : l10n.ttlFrom(centsLabel(need)),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _Choice {
  final TitleId? id;

  const _Choice(this.id);
}

class _MainChooser extends StatelessWidget {
  final Achievements achievements;

  const _MainChooser({required this.achievements});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final a = achievements;
    final options = [
      for (final t in a.unlocked)
        if (!(t.id == TitleId.donor && a.hideDonor)) t,
    ];
    Widget tile(Widget leading, String text, TitleId? id) => ListTile(
      leading: leading,
      title: Text(text),
      trailing: a.main == id
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
          : null,
      onTap: () => Navigator.of(context).pop(_Choice(id)),
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
              child: Text(
                l10n.ttlChooseMain,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Text(
                l10n.ttlChooseMainBody,
                style: const TextStyle(color: AppColors.textMuted),
              ),
            ),
            tile(
              const Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
              l10n.ttlAutomatic,
              null,
            ),
            for (final t in options)
              tile(
                Text(t.emoji, style: const TextStyle(fontSize: 24)),
                t.name(l10n),
                t.id,
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
