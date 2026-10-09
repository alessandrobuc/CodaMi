import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/reports_entity.dart';
import '../../domain/repositories/reports_repository.dart';
import '../providers/reports_provider.dart';

Future<bool> resolveReport(
  BuildContext context,
  WidgetRef ref,
  Report r, {
  ValueChanged<bool>? onBusy,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.celebration_rounded,
        color: AppColors.primary,
        size: 32,
      ),
      title: Text(
        r.type == ReportType.lost
            ? context.l10n.resolveLostTitle(r.petName)
            : context.l10n.resolveFoundTitle,
      ),
      content: Text(
        r.type == ReportType.lost
            ? context.l10n.resolveLostMessage(r.petName)
            : context.l10n.resolveFoundMessage,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(context.l10n.notYet),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(context.l10n.yesResolved),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return false;

  return _run(
    context,
    onBusy: onBusy,
    action: () => ref.read(reportsRepositoryProvider).markResolved(r),
    success: context.l10n.reportResolvedSuccess,
  );
}

Future<bool> deleteReport(
  BuildContext context,
  WidgetRef ref,
  Report r, {
  ValueChanged<bool>? onBusy,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.delete_outline_rounded,
        color: AppColors.danger,
        size: 32,
      ),
      title: Text(context.l10n.deleteReportTitle),
      content: Text(
        r.isOpen
            ? context.l10n.deleteOpenReportMessage(r.petName)
            : context.l10n.deleteResolvedReportMessage,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(context.l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          child: Text(context.l10n.delete),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return false;

  return _run(
    context,
    onBusy: onBusy,
    action: () => ref.read(reportsRepositoryProvider).deleteReport(r),
    success: context.l10n.reportDeleted,
  );
}

Future<bool> _run(
  BuildContext context, {
  required Future<void> Function() action,
  required String success,
  ValueChanged<bool>? onBusy,
}) async {
  onBusy?.call(true);
  try {
    await action();
    HapticFeedback.lightImpact();
    if (context.mounted) SnackbarUtils.showSuccess(context, success);
    return true;
  } on ReportsException catch (e) {
    if (context.mounted) SnackbarUtils.showError(context, e.message);
    return false;
  } finally {
    onBusy?.call(false);
  }
}
