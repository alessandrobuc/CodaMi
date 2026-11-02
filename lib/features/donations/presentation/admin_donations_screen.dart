import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../core/widgets/form_fields.dart';
import '../../../l10n/l10n.dart';
import '../../admin/presentation/widgets/settings_fields.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../data/donations_repository.dart';
import '../domain/donations.dart';
import 'support_screen.dart';

class AdminDonationsScreen extends ConsumerStatefulWidget {
  const AdminDonationsScreen({super.key});

  @override
  ConsumerState<AdminDonationsScreen> createState() =>
      _AdminDonationsScreenState();
}

class _AdminDonationsScreenState extends ConsumerState<AdminDonationsScreen> {
  DonationsConfig? _config;
  final _days = TextEditingController();
  final _amounts = TextEditingController();
  bool _showErrors = false;
  bool _saving = false;

  @override
  void dispose() {
    _days.dispose();
    _amounts.dispose();
    super.dispose();
  }

  void _load(DonationsConfig c) {
    _config = c;
    _days.text = '${c.daysBetweenPrompts}';
    _amounts.text = amountsInput(c.amountsCents);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final c = _config;
    final adminId = ref.read(authStateProvider).value?.uid;
    if (c == null || adminId == null) return;
    final days = readInt(_days);
    final amounts = parseAmounts(_amounts.text);
    if (days == null || days < 1 || days > 365 || amounts == null) {
      setState(() => _showErrors = true);
      SnackbarUtils.showError(context, l10n.shopFixFields);
      return;
    }
    setState(() => _saving = true);
    try {
      await ref
          .read(donationsRepositoryProvider)
          .saveConfig(
            c.copyWith(daysBetweenPrompts: days, amountsCents: amounts),
            adminId: adminId,
          );
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Donation settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(donationsConfigProvider);
    if (_config == null && state.hasValue) _load(state.value!);
    final c = _config;

    Widget toggle(String title, bool value, DonationsConfig next) =>
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: value,
          onChanged: c!.enabled ? (_) => setState(() => _config = next) : null,
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, color: AppColors.text),
          ),
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.supportCodami),
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
                    icon: Icons.volunteer_activism_rounded,
                    color: supportColor,
                    title: l10n.supportCodami,
                    text: l10n.supportAdminIntro,
                  ),
                  if (!c.paymentsReady)
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        l10n.supportPaymentsNotReady,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.rewardText,
                        ),
                      ),
                    ),
                  SettingsSection(
                    title: l10n.supportShowToUsers,
                    icon: Icons.visibility_rounded,
                    color: c.enabled ? AppColors.primary : AppColors.textMuted,
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: c.enabled,
                        onChanged: (v) =>
                            setState(() => _config = c.copyWith(enabled: v)),
                        title: Text(
                          c.enabled ? l10n.supportOnHelp : l10n.supportOffHelp,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.supportWhere,
                    icon: Icons.place_rounded,
                    color: supportColor,
                    children: [
                      toggle(
                        l10n.supportWhereProfile,
                        c.showInProfile,
                        c.copyWith(showInProfile: !c.showInProfile),
                      ),
                      toggle(
                        l10n.supportWhereReport,
                        c.afterReport,
                        c.copyWith(afterReport: !c.afterReport),
                      ),
                      toggle(
                        l10n.supportWhereFound,
                        c.afterFound,
                        c.copyWith(afterFound: !c.afterFound),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: l10n.supportSettings,
                    icon: Icons.tune_rounded,
                    color: supportColor,
                    children: [
                      SettingsNumberTile(
                        controller: _days,
                        label: l10n.supportDaysBetween,
                        help: l10n.supportDaysBetweenHelp,
                      ),
                      LabeledField(
                        label: l10n.supportAmounts,
                        hasError:
                            _showErrors && parseAmounts(_amounts.text) == null,
                        child: TextField(
                          controller: _amounts,
                          keyboardType: TextInputType.text,
                          onChanged: (_) {
                            if (_showErrors) setState(() {});
                          },
                          decoration: fieldDecoration(
                            hint: '1, 3, 5, 10, 25',
                            help: l10n.supportAmountsHelp,
                            error:
                                _showErrors &&
                                    parseAmounts(_amounts.text) == null
                                ? l10n.supportAmountsInvalid
                                : null,
                            focusColor: supportColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SupportScreen()),
                    ),
                    icon: const Icon(Icons.visibility_rounded),
                    label: Text(l10n.supportPreview),
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
