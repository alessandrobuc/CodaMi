import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../data/moderation_repository.dart';

extension FlagReasonLabel on FlagReason {
  String label(AppLocalizations l10n) => switch (this) {
    FlagReason.spam => l10n.flagReasonSpam,
    FlagReason.scam => l10n.flagReasonScam,
    FlagReason.inappropriate => l10n.flagReasonInappropriate,
    FlagReason.wrongInfo => l10n.flagReasonWrongInfo,
    FlagReason.other => l10n.flagReasonOther,
  };
}

Future<void> flagReport(
  BuildContext context,
  WidgetRef ref,
  Report report,
) async {
  final l10n = context.l10n;
  final uid = ref.read(authStateProvider).value?.uid;
  if (uid == null) return;
  final repo = ref.read(moderationRepositoryProvider);
  try {
    if (await repo.hasFlagged(uid, report.id)) {
      if (context.mounted) SnackbarUtils.showInfo(context, l10n.alreadyFlagged);
      return;
    }
  } catch (_) {
    // A failed check falls through; the rules still allow one flag per user.
  }
  if (!context.mounted) return;
  final sent = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => _FlagSheet(reporterId: uid, report: report),
  );
  if (sent == true && context.mounted) {
    HapticFeedback.lightImpact();
    SnackbarUtils.showSuccess(context, l10n.flagSent);
  }
}

Future<bool> blockOwner(
  BuildContext context,
  WidgetRef ref,
  Report report,
) async {
  final l10n = context.l10n;
  final uid = ref.read(authStateProvider).value?.uid;
  if (uid == null) return false;
  final name = report.ownerName;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.block_rounded, color: AppColors.danger, size: 32),
      title: Text(l10n.blockUserTitle(name)),
      content: Text(l10n.blockUserMessage, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          child: Text(l10n.block),
        ),
      ],
    ),
  );
  if (confirmed != true) return false;
  try {
    await ref
        .read(moderationRepositoryProvider)
        .block(uid, userId: report.ownerId, name: name);
    if (context.mounted) {
      SnackbarUtils.showSuccess(context, l10n.userBlocked(name));
    }
    return true;
  } catch (_) {
    if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    return false;
  }
}

class _FlagSheet extends ConsumerStatefulWidget {
  final String reporterId;
  final Report report;

  const _FlagSheet({required this.reporterId, required this.report});

  @override
  ConsumerState<_FlagSheet> createState() => _FlagSheetState();
}

class _FlagSheetState extends ConsumerState<_FlagSheet> {
  final _note = TextEditingController();
  FlagReason? _reason;
  bool _busy = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final reason = _reason;
    if (reason == null) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(moderationRepositoryProvider)
          .flag(
            reporterId: widget.reporterId,
            report: widget.report,
            reason: reason,
            note: _note.text,
          );
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _busy = false);
      SnackbarUtils.showError(context, context.l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                l10n.flagTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.flagHint,
                style: const TextStyle(color: AppColors.textMuted),
              ),
              const SizedBox(height: 8),
              RadioGroup<FlagReason>(
                groupValue: _reason,
                onChanged: (r) {
                  if (!_busy) setState(() => _reason = r);
                },
                child: Column(
                  children: [
                    for (final reason in FlagReason.values)
                      RadioListTile<FlagReason>(
                        value: reason,
                        contentPadding: EdgeInsets.zero,
                        title: Text(reason.label(l10n)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _note,
                enabled: !_busy,
                maxLength: 300,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(hintText: l10n.flagNoteHint),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _reason == null || _busy ? null : _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _busy
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.flagSubmit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
