import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/sharing.dart';
import '../providers/sharing_provider.dart';
import 'share_app_screen.dart';

class AdminShareRemindersScreen extends ConsumerStatefulWidget {
  const AdminShareRemindersScreen({super.key});

  @override
  ConsumerState<AdminShareRemindersScreen> createState() =>
      _AdminShareRemindersScreenState();
}

class _AdminShareRemindersScreenState
    extends ConsumerState<AdminShareRemindersScreen> {
  ShareReminderConfig? _config;
  final _first = TextEditingController();
  final _every = TextEditingController();
  final _max = TextEditingController();
  bool _saving = false;
  bool _testing = false;

  @override
  void dispose() {
    for (final c in [_first, _every, _max]) {
      c.dispose();
    }
    super.dispose();
  }

  void _load(ShareReminderConfig c) {
    _config = c;
    _first.text = '${c.firstDays}';
    _every.text = '${c.everyDays}';
    _max.text = '${c.maxCount}';
  }

  Future<void> _write(ShareReminderConfig c) async {
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    await ref
        .read(sharingRepositoryProvider)
        .saveReminderConfig(c, adminId: adminId);
  }

  // Saved straight away; typed numbers wait for the Save button.
  Future<void> _setEnabled(ShareReminderConfig c, bool enabled) async {
    final l10n = context.l10n;
    final saved = ref.read(shareReminderConfigProvider).value ?? c;
    setState(() {
      _config = c.copyWith(enabled: enabled);
      _saving = true;
    });
    try {
      await _write(saved.copyWith(enabled: enabled));
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Share reminder switch not saved: $e');
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
    final first = readInt(_first), every = readInt(_every), max = readInt(_max);
    if (first == null ||
        every == null ||
        max == null ||
        !ShareReminderConfig.validFirst(first) ||
        !ShareReminderConfig.validEvery(every) ||
        !ShareReminderConfig.validMax(max)) {
      SnackbarUtils.showError(context, l10n.shareRemInvalid);
      return;
    }
    setState(() => _saving = true);
    try {
      await _write(
        c.copyWith(firstDays: first, everyDays: every, maxCount: max),
      );
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Share reminder settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _test() async {
    final l10n = context.l10n;
    setState(() => _testing = true);
    try {
      final sent = await ref.read(sharingRepositoryProvider).sendTestReminder();
      if (!mounted) return;
      sent
          ? SnackbarUtils.showSuccess(context, l10n.shareRemTestSent)
          : SnackbarUtils.showError(context, l10n.shareRemTestFailed);
    } catch (e) {
      debugPrint('Test reminder failed: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.shareRemTestFailed);
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(shareReminderConfigProvider);
    if (_config == null && state.hasValue) _load(state.value!);
    final c = _config;
    final stats =
        ref.watch(shareReminderTotalsProvider).value ??
        const ShareReminderStats();

    Widget big(String value, String label) => Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryDark,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.shareRemAdminTitle),
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
                    icon: Icons.campaign_rounded,
                    color: AppColors.primary,
                    title: l10n.shareRemAdminTitle,
                    text: l10n.shareRemAdminIntro,
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
                          c.enabled
                              ? l10n.shareRemOnHelp
                              : l10n.shareRemOffHelp,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.shareRemWhen,
                    icon: Icons.schedule_rounded,
                    children: [
                      SettingsNumberTile(
                        controller: _first,
                        label: l10n.shareRemFirstDays,
                      ),
                      SettingsNumberTile(
                        controller: _every,
                        label: l10n.shareRemEveryDays,
                      ),
                      SettingsNumberTile(
                        controller: _max,
                        label: l10n.shareRemMax,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      l10n.shareRemHelp,
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
                  SettingsSection(
                    title: l10n.shareAdminLast30,
                    icon: Icons.insights_rounded,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            big('${stats.sent}', l10n.shareRemSent),
                            big(
                              '${stats.opened} (${stats.openRate}%)',
                              l10n.shareRemOpened,
                            ),
                            big('${stats.shares}', l10n.shareRemShares),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.shareRemTry,
                    icon: Icons.science_rounded,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.phone_iphone_rounded,
                          color: AppColors.primary,
                        ),
                        title: Text(l10n.shareRemPreview),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ShareAppScreen(
                              fromReminder: true,
                              preview: true,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: _testing
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.notifications_active_rounded,
                                color: AppColors.primary,
                              ),
                        title: Text(l10n.shareRemTest),
                        onTap: _testing ? null : _test,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
