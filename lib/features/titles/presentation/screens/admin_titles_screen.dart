import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/titles_repository.dart';
import '../../domain/titles.dart';
import '../providers/titles_provider.dart';
import '../widgets/title_labels.dart';

final _holdersProvider = FutureProvider.autoDispose.family<int, TitleId>(
  (ref, id) => ref.watch(titlesRepositoryProvider).holders(id),
);

class AdminTitlesScreen extends ConsumerStatefulWidget {
  const AdminTitlesScreen({super.key});

  @override
  ConsumerState<AdminTitlesScreen> createState() => _AdminTitlesScreenState();
}

class _AdminTitlesScreenState extends ConsumerState<AdminTitlesScreen> {
  TitlesConfig? _config;
  final _levels = {
    for (final id in TitleId.counted)
      id: [for (var i = 0; i < 3; i++) TextEditingController()],
  };
  final _bonus = [for (var i = 0; i < 3; i++) TextEditingController()];
  final _donor = [for (var i = 0; i < 5; i++) TextEditingController()];
  bool _saving = false;

  Iterable<TextEditingController> get _all => [
    for (final l in _levels.values) ...l,
    ..._bonus,
    ..._donor,
  ];

  @override
  void dispose() {
    for (final c in _all) {
      c.dispose();
    }
    super.dispose();
  }

  void _load(TitlesConfig c) {
    _config = c;
    for (final id in TitleId.counted) {
      for (var i = 0; i < 3; i++) {
        _levels[id]![i].text = '${c.levels[id]![i]}';
      }
    }
    for (var i = 0; i < 3; i++) {
      _bonus[i].text = '${c.bonus[i]}';
    }
    for (var i = 0; i < 5; i++) {
      _donor[i].text = '${c.donorCents[i] ~/ 100}';
    }
  }

  Future<void> _write(TitlesConfig c) async {
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    await ref.read(titlesRepositoryProvider).saveConfig(c, adminId: adminId);
  }

  // Switches are saved straight away; numbers wait for the Save button.
  Future<void> _saveSwitch(TitlesConfig Function(TitlesConfig) change) async {
    final l10n = context.l10n;
    final saved = ref.read(titlesConfigProvider).value ?? _config!;
    final before = _config;
    setState(() {
      _config = change(_config!);
      _saving = true;
    });
    try {
      await _write(change(saved));
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Titles switch not saved: $e');
      if (mounted) {
        setState(() => _config = before);
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
    List<int>? read(List<TextEditingController> list) {
      final out = [for (final t in list) readInt(t)];
      return out.contains(null) ? null : out.cast<int>();
    }

    final levels = {for (final id in TitleId.counted) id: read(_levels[id]!)};
    final bonus = read(_bonus);
    final euros = read(_donor);
    final donor = euros == null ? null : [for (final e in euros) e * 100];
    if (levels.values.any((l) => l == null || !TitlesConfig.validLevels(l)) ||
        bonus == null ||
        !TitlesConfig.validBonus(bonus) ||
        donor == null ||
        !TitlesConfig.validDonor(donor)) {
      SnackbarUtils.showError(context, l10n.ttlAdminInvalid);
      return;
    }
    setState(() => _saving = true);
    try {
      await _write(
        c.copyWith(
          levels: {for (final e in levels.entries) e.key: e.value!},
          bonus: bonus,
          donorCents: donor,
        ),
      );
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Titles settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  TitlesConfig Function(TitlesConfig) _toggle(TitleId id, bool on) =>
      (c) => c.copyWith(off: on ? ({...c.off}..remove(id)) : {...c.off, id});

  Widget _boxes(List<TextEditingController> list, List<String> labels) => Row(
    children: [
      for (var i = 0; i < list.length; i++) ...[
        if (i > 0) const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              Text(
                labels[i],
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              SettingsNumberBox(controller: list[i], width: double.infinity),
            ],
          ),
        ),
      ],
    ],
  );

  Widget _showSwitch(TitlesConfig c, TitleId id) => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    value: !c.off.contains(id),
    onChanged: (v) => _saveSwitch(_toggle(id, v)),
    title: Text(
      context.l10n.ttlAdminShown,
      style: const TextStyle(fontSize: 14, color: AppColors.text),
    ),
    subtitle: switch (ref.watch(_holdersProvider(id)).value) {
      final n? => Text(context.l10n.ttlAdminHolders(n)),
      null => null,
    },
  );

  Widget _help(String text) => Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 10),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        height: 1.35,
        color: AppColors.textMuted,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(titlesConfigProvider);
    if (_config == null && state.hasValue) _load(state.value!);
    final c = _config;
    const starLabels = ['★', '★★', '★★★'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.ttlAdminTitle),
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
                    icon: Icons.workspace_premium_rounded,
                    color: AppColors.primary,
                    title: l10n.ttlAdminTitle,
                    text: l10n.ttlAdminIntro,
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
                            _saveSwitch((x) => x.copyWith(enabled: v)),
                        title: Text(
                          c.enabled
                              ? l10n.ttlAdminOnHelp
                              : l10n.ttlAdminOffHelp,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (final id in TitleId.counted)
                    SettingsSection(
                      title: '${id.emoji()}  ${id.name(l10n)}',
                      icon: Icons.emoji_events_rounded,
                      color: c.off.contains(id)
                          ? AppColors.textMuted
                          : AppColors.primary,
                      children: [
                        _help(id.how(l10n)),
                        _boxes(_levels[id]!, starLabels),
                        _showSwitch(c, id),
                      ],
                    ),
                  SettingsSection(
                    title:
                        '${TitleId.ambassador.emoji()}  ${l10n.ttlAmbassador}',
                    icon: Icons.emoji_events_rounded,
                    children: [
                      _help(l10n.ttlAdminAmbassadorHelp),
                      _showSwitch(c, TitleId.ambassador),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.ttlAdminBonus,
                    icon: Icons.stars_rounded,
                    color: AppColors.accent,
                    children: [
                      _help(l10n.ttlAdminBonusHelp),
                      _boxes(_bonus, starLabels),
                      const SizedBox(height: 10),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.ttlAdminDonor,
                    icon: Icons.favorite_rounded,
                    color: AppColors.accent,
                    children: [
                      _help(l10n.ttlAdminDonorHelp),
                      _boxes(_donor, [
                        for (var level = 2; level <= donorLevels; level++)
                          donorTierName(l10n, level),
                      ]),
                      _showSwitch(c, TitleId.donor),
                    ],
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
