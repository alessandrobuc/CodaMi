import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/schedule.dart';
import '../providers/schedule_provider.dart';
import '../widgets/schedule_widgets.dart';

class AdminScheduleScreen extends ConsumerStatefulWidget {
  const AdminScheduleScreen({super.key});

  @override
  ConsumerState<AdminScheduleScreen> createState() =>
      _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends ConsumerState<AdminScheduleScreen> {
  bool? _enabled;
  bool _saving = false;

  Future<void> _set(bool enabled) async {
    final l10n = context.l10n;
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    setState(() {
      _enabled = enabled;
      _saving = true;
    });
    try {
      await ref
          .read(scheduleRepositoryProvider)
          .saveConfig(ScheduleConfig(enabled: enabled), adminId: adminId);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Schedule switch not saved: $e');
      if (mounted) {
        setState(() => _enabled = !enabled);
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(scheduleConfigProvider);
    final enabled = _enabled ?? state.value?.enabled;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.schTitle),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: enabled == null
          ? Center(
              child: state.hasError
                  ? Text(l10n.actionFailed)
                  : const CircularProgressIndicator(),
            )
          : ListView(
              padding: settingsListPadding(context),
              children: [
                SettingsHeader(
                  icon: Icons.event_note_rounded,
                  color: scheduleColor,
                  title: l10n.schTitle,
                  text: l10n.schAdminIntro,
                ),
                SettingsSection(
                  title: l10n.walkShowToUsers,
                  icon: Icons.visibility_rounded,
                  color: enabled ? AppColors.primary : AppColors.textMuted,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: enabled,
                      onChanged: _saving ? null : _set,
                      title: Text(
                        enabled ? l10n.schOnHelp : l10n.schOffHelp,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
