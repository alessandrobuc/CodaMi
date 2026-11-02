import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/walks.dart';
import '../providers/walks_provider.dart';
import '../widgets/walk_widgets.dart';
import 'walks_screen.dart';

class AdminWalksScreen extends ConsumerStatefulWidget {
  const AdminWalksScreen({super.key});

  @override
  ConsumerState<AdminWalksScreen> createState() => _AdminWalksScreenState();
}

class _AdminWalksScreenState extends ConsumerState<AdminWalksScreen> {
  WalksConfig? _config;
  final _searches = TextEditingController();
  final _details = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _searches.dispose();
    _details.dispose();
    super.dispose();
  }

  void _load(WalksConfig c) {
    _config = c;
    _searches.text = '${c.dailySearches}';
    _details.text = '${c.dailyDetails}';
  }

  // Saved straight away, like hiding from the place sheet.
  Future<void> _unhide(WalksConfig live, String id) async {
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    try {
      await ref
          .read(walksRepositoryProvider)
          .saveConfig(live.unhide(id), adminId: adminId);
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
    }
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final adminId = ref.read(authStateProvider).value?.uid;
    final c = _config;
    if (adminId == null || c == null) return;
    final searches = readInt(_searches), details = readInt(_details);
    if (searches == null ||
        details == null ||
        searches < 1 ||
        details < 1 ||
        searches > 1000 ||
        details > 1000) {
      SnackbarUtils.showError(context, l10n.walkLimitInvalid);
      return;
    }
    setState(() => _saving = true);
    try {
      final live = ref.read(walksConfigProvider).value;
      await ref
          .read(walksRepositoryProvider)
          .saveConfig(
            c.copyWith(
              dailySearches: searches,
              dailyDetails: details,
              hiddenPlaceIds: live?.hiddenPlaceIds,
              hiddenNames: live?.hiddenNames,
            ),
            adminId: adminId,
          );
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Walk settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(walksConfigProvider);
    if (_config == null && state.hasValue) _load(state.value!);
    final live = state.value;
    // Places hidden from the place sheet show up here without a reload.
    final c = _config?.copyWith(
      hiddenPlaceIds: live?.hiddenPlaceIds,
      hiddenNames: live?.hiddenNames,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.walksTitle),
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
                    icon: Icons.park_rounded,
                    color: walkColor,
                    title: l10n.walksTitle,
                    text: l10n.walkAdminIntro,
                  ),
                  SettingsSection(
                    title: l10n.walkShowToUsers,
                    icon: Icons.visibility_rounded,
                    color: c.enabled ? AppColors.primary : AppColors.textMuted,
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: c.enabled,
                        onChanged: (v) =>
                            setState(() => _config = c.copyWith(enabled: v)),
                        title: Text(
                          c.enabled ? l10n.walkOnHelp : l10n.walkOffHelp,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.walkDefaultDistance,
                    icon: Icons.radar_rounded,
                    color: walkColor,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final km in walkRadiusOptionsKm)
                              ChoiceChip(
                                label: Text('$km km'),
                                selected: c.defaultRadiusKm == km,
                                showCheckmark: false,
                                shape: const StadiumBorder(),
                                onSelected: (_) => setState(
                                  () =>
                                      _config = c.copyWith(defaultRadiusKm: km),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.walkPlaceTypes,
                    icon: Icons.category_rounded,
                    color: walkColor,
                    children: [
                      for (final g in WalkGroup.values)
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          secondary: Icon(g.icon, color: g.color),
                          value: c.groups[g] ?? true,
                          onChanged: (v) => setState(
                            () => _config = c.copyWith(
                              groups: {...c.groups, g: v},
                            ),
                          ),
                          title: Text(
                            g.label(l10n),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.walkLimits,
                    icon: Icons.speed_rounded,
                    color: walkColor,
                    children: [
                      SettingsNumberTile(
                        controller: _searches,
                        label: l10n.walkDailySearches,
                        help: l10n.walkDailySearchesHelp,
                      ),
                      SettingsNumberTile(
                        controller: _details,
                        label: l10n.walkDailyDetails,
                        help: l10n.walkDailyDetailsHelp,
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.walkHiddenPlaces,
                    icon: Icons.visibility_off_rounded,
                    color: walkColor,
                    children: [
                      if (c.hiddenPlaceIds.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            l10n.walkHiddenEmpty,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      for (final id in c.hiddenPlaceIds)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(c.hiddenNames[id] ?? id),
                          trailing: TextButton(
                            onPressed: () => _unhide(live!, id),
                            child: Text(l10n.walkShowAgain),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const WalksScreen()),
                    ),
                    icon: const Icon(Icons.map_rounded),
                    label: Text(l10n.walkOpenScreen),
                  ),
                  const SizedBox(height: 16),
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
