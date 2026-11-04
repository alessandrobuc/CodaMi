import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/breed_scan.dart';
import '../providers/scanner_provider.dart';
import '../widgets/scanner_widgets.dart';
import 'scanner_screen.dart';

class AdminScannerScreen extends ConsumerStatefulWidget {
  const AdminScannerScreen({super.key});

  @override
  ConsumerState<AdminScannerScreen> createState() => _AdminScannerScreenState();
}

class _AdminScannerScreenState extends ConsumerState<AdminScannerScreen> {
  ScannerConfig? _config;
  final _scans = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _scans.dispose();
    super.dispose();
  }

  void _load(ScannerConfig c) {
    _config = c;
    _scans.text = '${c.dailyScans}';
  }

  // Saved straight away; other unsaved changes stay for the Save button.
  Future<void> _setEnabled(ScannerConfig c, bool enabled) async {
    final l10n = context.l10n;
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    final saved = ref.read(scannerConfigProvider).value ?? c;
    setState(() {
      _config = c.copyWith(enabled: enabled);
      _saving = true;
    });
    try {
      await ref
          .read(scannerRepositoryProvider)
          .saveConfig(saved.copyWith(enabled: enabled), adminId: adminId);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Scanner switch not saved: $e');
      if (mounted) {
        setState(() => _config = _config?.copyWith(enabled: !enabled));
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickModel(ScannerConfig c) async {
    final model = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ModelSheet(selected: c.model),
    );
    if (model != null && mounted) {
      setState(() => _config = c.copyWith(model: model));
    }
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final adminId = ref.read(authStateProvider).value?.uid;
    final c = _config;
    if (adminId == null || c == null) return;
    final scans = readInt(_scans);
    if (scans == null || scans < 1 || scans > 100) {
      SnackbarUtils.showError(context, l10n.scannerLimitInvalid);
      return;
    }
    final model = c.model;
    if (!scannerModelPattern.hasMatch(model)) {
      SnackbarUtils.showError(context, l10n.scannerModelInvalid);
      return;
    }
    setState(() => _saving = true);
    try {
      await ref
          .read(scannerRepositoryProvider)
          .saveConfig(c.copyWith(dailyScans: scans), adminId: adminId);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Scanner settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(scannerConfigProvider);
    if (_config == null && state.hasValue) _load(state.value!);
    final c = _config;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.breedScanner),
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
                    icon: Icons.document_scanner_rounded,
                    color: scannerColor,
                    title: l10n.breedScanner,
                    text: l10n.scannerAdminIntro,
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
                          c.enabled ? l10n.scannerOnHelp : l10n.scannerOffHelp,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.scannerSettings,
                    icon: Icons.tune_rounded,
                    color: scannerColor,
                    children: [
                      SettingsNumberTile(
                        controller: _scans,
                        label: l10n.scannerDailyScans,
                        help: l10n.scannerDailyScansHelp,
                      ),
                      _ModelTile(
                        model: c.model,
                        gone:
                            ref
                                .watch(scannerModelsProvider)
                                .value
                                ?.offers(c.model) ==
                            false,
                        onTap: () => _pickModel(c),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ScannerScreen()),
                    ),
                    icon: const Icon(Icons.document_scanner_rounded),
                    label: Text(l10n.scannerOpen),
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

class _ModelTile extends StatelessWidget {
  final String model;
  final bool gone;
  final VoidCallback onTap;

  const _ModelTile({
    required this.model,
    required this.gone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.scannerModel,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            l10n.scannerModelHelp,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.3,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 10),
          Material(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      size: 20,
                      color: scannerColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            modelTierOf(model).label(l10n),
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.unfold_more_rounded,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (gone) ...[
            const SizedBox(height: 8),
            ScannerNote(
              icon: Icons.warning_amber_rounded,
              text: l10n.scannerModelGone,
              color: ScanConfidence.low.color,
            ),
          ],
        ],
      ),
    );
  }
}

class _ModelSheet extends ConsumerWidget {
  final String selected;

  const _ModelSheet({required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(scannerModelsProvider);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        ),
        child: switch (state) {
          AsyncData(:final value) => ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              ScannerSectionTitle(l10n.scannerModelChoose),
              ScannerNote(
                icon: value.fromGoogle
                    ? Icons.cloud_done_outlined
                    : Icons.cloud_off_rounded,
                text: value.fromGoogle
                    ? l10n.scannerModelFromGoogle
                    : l10n.scannerModelOffline,
              ),
              const SizedBox(height: 8),
              if (!value.offers(selected))
                _ModelOption(
                  id: selected,
                  tier: modelTierOf(selected),
                  selected: true,
                  warning: l10n.scannerModelGone,
                ),
              for (final (id, tier) in value.options)
                _ModelOption(
                  id: id,
                  tier: tier,
                  selected: id == selected,
                  recommended: id == value.recommended,
                ),
            ],
          ),
          AsyncError() => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.actionFailed, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => ref.invalidate(scannerModelsProvider),
                  child: Text(l10n.scannerModelRetry),
                ),
              ],
            ),
          ),
          _ => const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: CircularProgressIndicator()),
          ),
        },
      ),
    );
  }
}

class _ModelOption extends StatelessWidget {
  final String id;
  final ModelTier tier;
  final bool selected;
  final bool recommended;
  final String? warning;

  const _ModelOption({
    required this.id,
    required this.tier,
    required this.selected,
    this.recommended = false,
    this.warning,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: warning == null ? () => Navigator.of(context).pop(id) : null,
      leading: Icon(
        selected
            ? Icons.radio_button_checked_rounded
            : Icons.radio_button_off_rounded,
        color: selected ? scannerColor : AppColors.textMuted,
      ),
      title: Wrap(
        spacing: 8,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            id,
            textDirection: TextDirection.ltr,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          if (recommended)
            ScannerChip(
              text: l10n.scannerModelRecommended,
              color: AppColors.primary,
            ),
        ],
      ),
      subtitle: Text(
        warning ?? tier.label(l10n),
        style: TextStyle(
          color: warning == null
              ? AppColors.textMuted
              : ScanConfidence.low.color,
        ),
      ),
    );
  }
}
