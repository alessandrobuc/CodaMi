import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/sharing.dart';
import '../providers/sharing_provider.dart';

class AdminSharingScreen extends ConsumerStatefulWidget {
  const AdminSharingScreen({super.key});

  @override
  ConsumerState<AdminSharingScreen> createState() => _AdminSharingScreenState();
}

class _AdminSharingScreenState extends ConsumerState<AdminSharingScreen> {
  bool? _popup;
  bool _saving = false;

  Future<void> _set(bool popup) async {
    final l10n = context.l10n;
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    setState(() {
      _popup = popup;
      _saving = true;
    });
    try {
      await ref
          .read(sharingRepositoryProvider)
          .saveConfig(SharingConfig(popup: popup), adminId: adminId);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Sharing switch not saved: $e');
      if (mounted) {
        setState(() => _popup = !popup);
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(sharingConfigProvider);
    final popup = _popup ?? state.value?.popup;
    final stats = ref.watch(shareTotalsProvider).value;

    String targetLabel(String key) => switch (key) {
      'whatsapp' => 'WhatsApp',
      'facebook' => 'Facebook',
      'instagram' => 'Instagram',
      'tiktok' => 'TikTok',
      'save' => l10n.shareSave,
      'copy' => l10n.shareCopyLink,
      'qr' => l10n.shareFromQr,
      'direct' => l10n.shareDirect,
      _ => l10n.shareMore,
    };

    Widget targetIcon(String key) => switch (key) {
      'whatsapp' => const FaIcon(
        FontAwesomeIcons.whatsapp,
        size: 18,
        color: AppColors.primary,
      ),
      'facebook' => const FaIcon(
        FontAwesomeIcons.facebookF,
        size: 18,
        color: AppColors.primary,
      ),
      'instagram' => const FaIcon(
        FontAwesomeIcons.instagram,
        size: 18,
        color: AppColors.primary,
      ),
      'tiktok' => const FaIcon(
        FontAwesomeIcons.tiktok,
        size: 18,
        color: AppColors.primary,
      ),
      'save' => const Icon(
        Icons.download_rounded,
        size: 20,
        color: AppColors.primary,
      ),
      'copy' => const Icon(
        Icons.link_rounded,
        size: 20,
        color: AppColors.primary,
      ),
      'qr' => const Icon(
        Icons.qr_code_2_rounded,
        size: 20,
        color: AppColors.primary,
      ),
      'direct' => const Icon(
        Icons.open_in_browser_rounded,
        size: 20,
        color: AppColors.primary,
      ),
      _ => const Icon(
        Icons.ios_share_rounded,
        size: 20,
        color: AppColors.primary,
      ),
    };

    List<Widget> bars(Map<String, int> counts) {
      final sorted = counts.entries.where((e) => e.value > 0).toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      if (sorted.isEmpty) {
        return [
          Text(
            l10n.shareNoneYet,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        ];
      }
      final top = sorted.first.value;
      return [
        for (final e in sorted)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(width: 26, child: targetIcon(e.key)),
                SizedBox(
                  width: 92,
                  child: Text(
                    targetLabel(e.key),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13.5),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: e.value / top,
                      minHeight: 10,
                      color: AppColors.primary,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 44,
                  child: Text(
                    '${e.value}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
      ];
    }

    Widget big(String value, String label) => Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
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
        title: Text(l10n.shareAdminTitle),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: popup == null
          ? Center(
              child: state.hasError
                  ? Text(l10n.actionFailed)
                  : const CircularProgressIndicator(),
            )
          : ListView(
              padding: settingsListPadding(context),
              children: [
                SettingsHeader(
                  icon: Icons.campaign_rounded,
                  color: AppColors.primary,
                  title: l10n.shareAdminTitle,
                  text: l10n.shareAdminIntro,
                ),
                SettingsSection(
                  title: l10n.shareAdminPopup,
                  icon: Icons.visibility_rounded,
                  color: popup ? AppColors.primary : AppColors.textMuted,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: popup,
                      onChanged: _saving ? null : _set,
                      title: Text(
                        popup ? l10n.shareAdminOnHelp : l10n.shareAdminOffHelp,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ],
                ),
                SettingsSection(
                  title: l10n.shareAdminLast30,
                  icon: Icons.insights_rounded,
                  color: AppColors.primary,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          big('${stats?.shares ?? 0}', l10n.shareAdminShares),
                          big('${stats?.views ?? 0}', l10n.shareAdminViews),
                        ],
                      ),
                    ),
                  ],
                ),
                SettingsSection(
                  title: l10n.shareAdminByApp,
                  icon: Icons.ios_share_rounded,
                  color: AppColors.primary,
                  children: bars(stats?.byTarget ?? const {}),
                ),
                SettingsSection(
                  title: l10n.shareAdminVisitsFrom,
                  icon: Icons.open_in_browser_rounded,
                  color: AppColors.primary,
                  children: bars(stats?.viewsBy ?? const {}),
                ),
              ],
            ),
    );
  }
}
