import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../data/points_repository.dart';
import '../../domain/points.dart';
import '../widgets/points_widgets.dart';

// Edits `config/points`. The server checks every value and falls back to its default.
class AdminPointsSettingsScreen extends ConsumerStatefulWidget {
  const AdminPointsSettingsScreen({super.key});

  @override
  ConsumerState<AdminPointsSettingsScreen> createState() =>
      _AdminPointsSettingsScreenState();
}

class _AdminPointsSettingsScreenState
    extends ConsumerState<AdminPointsSettingsScreen> {
  final _c = <String, TextEditingController>{};
  final _levelFriends = <AmbassadorLevel, TextEditingController>{};
  final _levelBonus = <AmbassadorLevel, TextEditingController>{};
  bool _loading = true;
  bool _saving = false;

  TextEditingController _field(String key) =>
      _c.putIfAbsent(key, TextEditingController.new);

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final c in [
      ..._c.values,
      ..._levelFriends.values,
      ..._levelBonus.values,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final config = await ref.read(pointsRepositoryProvider).watchConfig().first;
    final map = config.toMap();
    for (final MapEntry(:key, :value) in map.entries) {
      if (value is int) _field(key).text = '$value';
    }
    for (final rule in config.levels) {
      _levelFriends[rule.level] = TextEditingController(
        text: '${rule.minFriends}',
      );
      _levelBonus[rule.level] = TextEditingController(text: '${rule.bonus}');
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    const d = PointsConfig();
    int read(String key, int fallback) => readInt(_field(key)) ?? fallback;
    final config = PointsConfig(
      dailyCheckin: read('dailyCheckin', d.dailyCheckin),
      dailyActive: read('dailyActive', d.dailyActive),
      activeMinutes: read('activeMinutes', d.activeMinutes),
      streakDays: read('streakDays', d.streakDays),
      streakBonus: read('streakBonus', d.streakBonus),
      referralQualified: read('referralQualified', d.referralQualified),
      referralWelcome: read('referralWelcome', d.referralWelcome),
      qualifyDays: read('qualifyDays', d.qualifyDays),
      qualifyWithinDays: read('qualifyWithinDays', d.qualifyWithinDays),
      codeEntryDays: read('codeEntryDays', d.codeEntryDays),
      maxQualifiedPerDay: read('maxQualifiedPerDay', d.maxQualifiedPerDay),
      feedbackPoints: read('feedbackPoints', d.feedbackPoints),
      feedbackAfterDays: read('feedbackAfterDays', d.feedbackAfterDays),
      reviewAfterDays: read('reviewAfterDays', d.reviewAfterDays),
      reviewMinActiveDays: read('reviewMinActiveDays', d.reviewMinActiveDays),
      reviewEveryDays: read('reviewEveryDays', d.reviewEveryDays),
      levels: [
        for (final rule in d.levels)
          LevelRule(
            rule.level,
            readInt(_levelFriends[rule.level]!) ?? rule.minFriends,
            readInt(_levelBonus[rule.level]!) ?? rule.bonus,
          ),
      ],
    );
    setState(() => _saving = true);
    try {
      await ref.read(pointsRepositoryProvider).saveConfig(config);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget field(String key, String label, [String? help]) =>
        SettingsNumberTile(controller: _field(key), label: label, help: help);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.pointsSettings),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: settingsListPadding(context),
              children: [
                SettingsHeader(
                  icon: Icons.stars_rounded,
                  color: AppColors.primary,
                  title: l10n.pointsSettingsSubtitle,
                  text: l10n.pointsSettingsIntro,
                ),
                SettingsSection(
                  title: l10n.dailyRewards,
                  icon: Icons.today_rounded,
                  color: AppColors.accent,
                  children: [
                    field('dailyCheckin', l10n.dailyCheckin, l10n.zeroTurnsOff),
                    field('dailyActive', l10n.dailyActive, l10n.zeroTurnsOff),
                    field('activeMinutes', l10n.settingsActiveMinutes),
                    field('streakDays', l10n.settingsStreakDays),
                    field('streakBonus', l10n.pointsStreakBonus),
                  ],
                ),
                SettingsSection(
                  title: l10n.inviteFriends,
                  icon: Icons.group_add_rounded,
                  children: [
                    field('referralQualified', l10n.settingsReferralPoints),
                    field(
                      'referralWelcome',
                      l10n.settingsWelcomePoints,
                      l10n.settingsWelcomePointsHelp,
                    ),
                    field('qualifyDays', l10n.settingsQualifyDays),
                    field('qualifyWithinDays', l10n.settingsQualifyWithinDays),
                    field('codeEntryDays', l10n.settingsCodeEntryDays),
                    field(
                      'maxQualifiedPerDay',
                      l10n.settingsMaxPerDay,
                      l10n.settingsMaxPerDayHelp,
                    ),
                  ],
                ),
                SettingsSection(
                  title: l10n.ambassadorLevels,
                  icon: Icons.military_tech_rounded,
                  color: AppColors.rewardText,
                  children: [
                    for (final (i, level) in AmbassadorLevel.values.indexed)
                      _LevelRow(
                        rank: i + 1,
                        name: level.label(l10n),
                        friends: _levelFriends[level]!,
                        bonus: _levelBonus[level]!,
                      ),
                  ],
                ),
                SettingsSection(
                  title: l10n.feedbackAndReviews,
                  icon: Icons.rate_review_rounded,
                  color: AppColors.accent,
                  children: [
                    field(
                      'feedbackPoints',
                      l10n.settingsFeedbackPoints,
                      l10n.zeroTurnsOff,
                    ),
                    field('feedbackAfterDays', l10n.settingsFeedbackAfterDays),
                    field('reviewMinActiveDays', l10n.settingsReviewActiveDays),
                    field('reviewAfterDays', l10n.settingsReviewAfterDays),
                    field(
                      'reviewEveryDays',
                      l10n.settingsReviewEveryDays,
                      l10n.settingsReviewHelp,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSaveButton(
                  label: l10n.save,
                  saving: _saving,
                  onPressed: _save,
                ),
              ],
            ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  final int rank;
  final String name;
  final TextEditingController friends;
  final TextEditingController bonus;

  const _LevelRow({
    required this.rank,
    required this.name,
    required this.friends,
    required this.bonus,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget column(String caption, TextEditingController c) => Column(
      children: [
        SettingsNumberBox(controller: c, width: 72),
        const SizedBox(height: 4),
        Text(
          caption,
          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$rank',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.rewardText,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
          column(l10n.settingsActiveFriends, friends),
          const SizedBox(width: 10),
          column(l10n.levelBonus, bonus),
        ],
      ),
    );
  }
}
