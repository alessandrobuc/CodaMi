import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../domain/heat.dart';
import '../providers/heat_provider.dart';
import '../widgets/heat_widgets.dart';

class AdminHeatScreen extends ConsumerStatefulWidget {
  const AdminHeatScreen({super.key});

  @override
  ConsumerState<AdminHeatScreen> createState() => _AdminHeatScreenState();
}

class _AdminHeatScreenState extends ConsumerState<AdminHeatScreen> {
  HeatConfig? _config;
  final _cycle = {
    for (final s in PetSpecies.values) s: TextEditingController(),
  };
  final _heat = {for (final s in PetSpecies.values) s: TextEditingController()};
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [..._cycle.values, ..._heat.values]) {
      c.dispose();
    }
    super.dispose();
  }

  void _load(HeatConfig c) {
    _config = c;
    for (final s in PetSpecies.values) {
      _cycle[s]!.text = '${c.cycleDays[s]}';
      _heat[s]!.text = '${c.heatDays[s]}';
    }
  }

  Future<void> _write(HeatConfig config) async {
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    await ref.read(heatRepositoryProvider).saveConfig(config, adminId: adminId);
  }

  // Saved straight away; typed numbers wait for the Save button.
  Future<void> _setEnabled(HeatConfig c, bool enabled) async {
    final l10n = context.l10n;
    final saved = ref.read(heatConfigProvider).value ?? c;
    setState(() {
      _config = c.copyWith(enabled: enabled);
      _saving = true;
    });
    try {
      await _write(saved.copyWith(enabled: enabled));
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Heat switch not saved: $e');
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
    final cycles = <PetSpecies, int>{};
    final heats = <PetSpecies, int>{};
    for (final s in PetSpecies.values) {
      final cycle = readInt(_cycle[s]!), heat = readInt(_heat[s]!);
      if (cycle == null ||
          heat == null ||
          !HeatConfig.validCycle(s, cycle) ||
          !HeatConfig.validHeat(heat)) {
        SnackbarUtils.showError(context, l10n.heatInvalidValues);
        return;
      }
      cycles[s] = cycle;
      heats[s] = heat;
    }
    setState(() => _saving = true);
    try {
      await _write(c.copyWith(cycleDays: cycles, heatDays: heats));
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Heat settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(heatConfigProvider);
    if (_config == null && state.hasValue) _load(state.value!);
    final c = _config;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.heatCalendar),
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
                    icon: Icons.calendar_month_rounded,
                    color: heatColor,
                    title: l10n.heatCalendar,
                    text: l10n.heatAdminIntro,
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
                          c.enabled ? l10n.heatOnHelp : l10n.heatOffHelp,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (final s in PetSpecies.values)
                    SettingsSection(
                      title: s.label(l10n),
                      icon: Icons.pets_rounded,
                      color: heatColor,
                      children: [
                        SettingsNumberTile(
                          controller: _cycle[s]!,
                          label: l10n.heatTypicalCycle,
                        ),
                        SettingsNumberTile(
                          controller: _heat[s]!,
                          label: l10n.heatTypicalHeat,
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      l10n.heatTypicalHelp,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
