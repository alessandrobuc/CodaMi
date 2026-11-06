import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/feedback_repository.dart';
import '../../domain/feedback.dart';
import '../providers/feedback_provider.dart';

class AdminFeedbackSettingsScreen extends ConsumerStatefulWidget {
  const AdminFeedbackSettingsScreen({super.key});

  @override
  ConsumerState<AdminFeedbackSettingsScreen> createState() =>
      _AdminFeedbackSettingsScreenState();
}

class _AdminFeedbackSettingsScreenState
    extends ConsumerState<AdminFeedbackSettingsScreen> {
  FeedbackAskConfig? _config;
  final _usesMin = TextEditingController();
  final _usesMax = TextEditingController();
  final _pause = TextEditingController();
  final _max = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_usesMin, _usesMax, _pause, _max]) {
      c.dispose();
    }
    super.dispose();
  }

  void _load(FeedbackAskConfig c) {
    _config = c;
    _usesMin.text = '${c.usesMin}';
    _usesMax.text = '${c.usesMax}';
    _pause.text = '${c.pauseDays}';
    _max.text = '${c.maxAsks}';
  }

  Future<void> _write(FeedbackAskConfig c) async {
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    await ref
        .read(feedbackRepositoryProvider)
        .saveAskConfig(c, adminId: adminId);
  }

  // Saved straight away; typed numbers wait for the Save button.
  Future<void> _setEnabled(FeedbackAskConfig c, bool enabled) async {
    final l10n = context.l10n;
    final saved = ref.read(feedbackAskConfigProvider).value ?? c;
    setState(() {
      _config = c.copyWith(enabled: enabled);
      _saving = true;
    });
    try {
      await _write(saved.copyWith(enabled: enabled));
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Feedback question switch not saved: $e');
      if (mounted) {
        setState(() => _config = _config?.copyWith(enabled: !enabled));
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final c = _config;
    if (c == null) return;
    final min = readInt(_usesMin), max = readInt(_usesMax);
    final pause = readInt(_pause), asks = readInt(_max);
    if (min == null ||
        max == null ||
        pause == null ||
        asks == null ||
        !FeedbackAskConfig.validUsesMin(min) ||
        !FeedbackAskConfig.validUsesMax(max, min) ||
        !FeedbackAskConfig.validPause(pause) ||
        !FeedbackAskConfig.validMax(asks)) {
      SnackbarUtils.showError(context, l10n.fbSetInvalid);
      return;
    }
    setState(() => _saving = true);
    try {
      await _write(
        c.copyWith(usesMin: min, usesMax: max, pauseDays: pause, maxAsks: asks),
      );
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Feedback question settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(feedbackAskConfigProvider);
    if (_config == null && state.hasValue) _load(state.value!);
    final c = _config;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.fbAdminSettings),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: c == null
          ? Center(
              child: state.hasError
                  ? Text(l10n.actionFailed)
                  : const CircularProgressIndicator(),
            )
          : AbsorbPointer(
              absorbing: _saving,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: settingsListPadding(context),
                children: [
                  SettingsHeader(
                    icon: Icons.rate_review_rounded,
                    color: AppColors.primary,
                    title: l10n.fbAdminSettings,
                    text: l10n.fbSetIntro,
                  ),
                  SettingsSection(
                    title: l10n.walkShowToUsers,
                    icon: Icons.visibility_rounded,
                    color: c.enabled ? AppColors.primary : AppColors.textMuted,
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: c.enabled,
                        onChanged: (v) => _setEnabled(c, v),
                        title: Text(
                          c.enabled ? l10n.fbSetOnHelp : l10n.fbSetOffHelp,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.fbSetWhen,
                    icon: Icons.schedule_rounded,
                    children: [
                      SettingsNumberTile(
                        controller: _usesMin,
                        label: l10n.fbSetUsesMin,
                      ),
                      SettingsNumberTile(
                        controller: _usesMax,
                        label: l10n.fbSetUsesMax,
                      ),
                      SettingsNumberTile(
                        controller: _pause,
                        label: l10n.fbSetPause,
                      ),
                      SettingsNumberTile(
                        controller: _max,
                        label: l10n.fbSetMax,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      l10n.fbSetHelp,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  SettingsSaveButton(
                    label: l10n.save,
                    saving: _saving,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
    );
  }
}
