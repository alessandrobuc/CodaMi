import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../data/moderation_repository.dart';
import '../providers/moderation_provider.dart';
import 'flag_actions.dart';

class ModerationPanel extends ConsumerStatefulWidget {
  final Report report;

  const ModerationPanel({super.key, required this.report});

  @override
  ConsumerState<ModerationPanel> createState() => _ModerationPanelState();
}

class _ModerationPanelState extends ConsumerState<ModerationPanel> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action, String success) async {
    setState(() => _busy = true);
    try {
      await action();
      HapticFeedback.lightImpact();
      if (mounted) SnackbarUtils.showSuccess(context, success);
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.delete_outline_rounded,
          color: AppColors.danger,
          size: 32,
        ),
        title: Text(l10n.deleteListingTitle),
        content: Text(l10n.deleteListingMessage, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _busy = true);
    try {
      await ref.read(moderationRepositoryProvider).remove(widget.report);
      HapticFeedback.lightImpact();
      if (!mounted) return;
      SnackbarUtils.showSuccess(context, l10n.listingDeleted);
      navigator.pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _busy = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final report = widget.report;
    final repo = ref.read(moderationRepositoryProvider);
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final flags = ref.watch(reportFlagsProvider(report.id)).value ?? const [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.admin_panel_settings_rounded,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.moderation,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
              if (report.isHidden)
                Text(
                  l10n.hiddenListing,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (flags.isEmpty)
            Text(
              l10n.noFlagsOnListing,
              style: const TextStyle(color: AppColors.textMuted),
            )
          else ...[
            Text(
              l10n.flagCount(flags.length),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.danger,
              ),
            ),
            for (final flag in flags) _FlagLine(flag: flag),
          ],
          const SizedBox(height: 12),
          if (flags.isNotEmpty)
            OutlinedButton.icon(
              onPressed: _busy
                  ? null
                  : () => _run(
                      () => repo.dismissFlags(report.id),
                      l10n.flagsDismissed,
                    ),
              icon: const Icon(Icons.done_all_rounded),
              label: Text(l10n.dismissFlags),
            ),
          const SizedBox(height: 8),
          report.isHidden
              ? FilledButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(
                          () => repo.restore(report),
                          l10n.listingRestored,
                        ),
                  icon: const Icon(Icons.visibility_rounded),
                  label: Text(l10n.restoreListing),
                )
              : FilledButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(() => repo.hide(report), l10n.listingHidden),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.textMuted,
                  ),
                  icon: const Icon(Icons.visibility_off_rounded),
                  label: Text(l10n.hideListing),
                ),
          if (isAdmin) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _busy ? null : _delete,
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
              icon: const Icon(Icons.delete_outline_rounded),
              label: Text(l10n.deleteListing),
            ),
          ],
        ],
      ),
    );
  }
}

class _FlagLine extends StatelessWidget {
  final ReportFlag flag;

  const _FlagLine({required this.flag});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.flag_rounded, size: 16, color: AppColors.danger),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flag.reason.label(l10n),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                if (flag.note case final note?)
                  Text(note, style: const TextStyle(color: AppColors.text)),
                if (flag.createdAt case final at?)
                  Text(
                    timeAgo(l10n, at),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
