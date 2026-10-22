import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../data/emergency_repository.dart';

// Edits `config/emergency`. Defaults match `functions/src/emergency.ts`.
class AdminEmergencySettingsScreen extends ConsumerStatefulWidget {
  const AdminEmergencySettingsScreen({super.key});

  @override
  ConsumerState<AdminEmergencySettingsScreen> createState() =>
      _AdminEmergencySettingsScreenState();
}

class _AdminEmergencySettingsScreenState
    extends ConsumerState<AdminEmergencySettingsScreen> {
  static const _defaults = <String, num>{
    'minRecipients': 20,
    'maxRecipients': 300,
    'autoCloseHours': 72,
    'defaultAreaKm': 30,
    'maxSuggested': 5,
    'weightRecommended': 20,
    'weightVerified': 10,
    'weight24h': 5,
    'weightPerKm': 1,
  };

  final _fields = {for (final k in _defaults.keys) k: TextEditingController()};
  final _rings = TextEditingController();
  bool _emailEnabled = false;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final c in [..._fields.values, _rings]) {
      c.dispose();
    }
    super.dispose();
  }

  String _show(num value) =>
      value == value.roundToDouble() ? value.toInt().toString() : '$value';

  Future<void> _load() async {
    var data = <String, dynamic>{};
    try {
      data = await ref.read(emergencyRepositoryProvider).loadConfig();
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
    }
    for (final MapEntry(:key, :value) in _defaults.entries) {
      _fields[key]!.text = _show((data[key] as num?) ?? value);
    }
    final rings = data['ringsKm'];
    _rings.text = rings is List
        ? rings.map((r) => _show(r as num)).join(', ')
        : '5, 10, 25';
    _emailEnabled = data['emailEnabled'] == true;
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    setState(() => _saving = true);
    try {
      await ref.read(emergencyRepositoryProvider).saveConfig({
        for (final MapEntry(:key, :value) in _fields.entries)
          key: ?readDouble(value),
        'ringsKm': [
          for (final part in _rings.text.split(','))
            ?double.tryParse(part.trim()),
        ],
        'emailEnabled': _emailEnabled,
      });
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
        SettingsNumberTile(
          controller: _fields[key]!,
          label: label,
          help: help,
          decimal: key.startsWith('weight') || key.endsWith('Km'),
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.emergencySettings),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: settingsListPadding(context),
              children: [
                SettingsHeader(
                  icon: Icons.emergency_rounded,
                  color: AppColors.danger,
                  title: l10n.emergencySettingsSubtitle,
                  text: l10n.pointsSettingsIntro,
                ),
                SettingsSection(
                  title: l10n.settingsAlertsNearby,
                  icon: Icons.notifications_active_rounded,
                  color: AppColors.danger,
                  children: [
                    SettingsNumberTile(
                      controller: _rings,
                      label: l10n.settingsRings,
                      help: l10n.settingsRingsHelp,
                      decimal: true,
                      boxWidth: 120,
                    ),
                    field(
                      'minRecipients',
                      l10n.settingsMinRecipients,
                      l10n.settingsMinRecipientsHelp,
                    ),
                    field('maxRecipients', l10n.settingsMaxRecipients),
                    field(
                      'autoCloseHours',
                      l10n.settingsAutoCloseHours,
                      l10n.settingsAutoCloseHoursHelp,
                    ),
                  ],
                ),
                SettingsSection(
                  title: l10n.settingsContactsPriority,
                  icon: Icons.contact_phone_rounded,
                  children: [
                    field(
                      'defaultAreaKm',
                      l10n.settingsDefaultAreaKm,
                      l10n.settingsDefaultAreaKmHelp,
                    ),
                    field('maxSuggested', l10n.settingsMaxSuggested),
                    field(
                      'weightRecommended',
                      l10n.settingsWeightRecommended,
                      l10n.settingsWeightHelp,
                    ),
                    field('weightVerified', l10n.settingsWeightVerified),
                    field('weight24h', l10n.settingsWeight24h),
                    field(
                      'weightPerKm',
                      l10n.settingsWeightPerKm,
                      l10n.settingsWeightPerKmHelp,
                    ),
                  ],
                ),
                SettingsSection(
                  title: l10n.settingsEmailContacts,
                  icon: Icons.mail_rounded,
                  color: AppColors.accent,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.settingsEmailContactsHelp,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.35,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Switch(
                            value: _emailEnabled,
                            onChanged: (v) => setState(() => _emailEnabled = v),
                          ),
                        ],
                      ),
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
