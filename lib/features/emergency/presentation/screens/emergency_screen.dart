import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/emergency_repository.dart';
import '../../domain/emergency.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_widgets.dart';
import 'emergency_contacts_screen.dart';

class EmergencyScreen extends ConsumerStatefulWidget {
  final String emergencyId;
  final bool justSent;

  const EmergencyScreen({
    super.key,
    required this.emergencyId,
    this.justSent = false,
  });

  @override
  ConsumerState<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends ConsumerState<EmergencyScreen> {
  bool _busy = false;

  Future<void> _act(
    Emergency e,
    EmergencyAction action, {
    String? confirmTitle,
    String? confirmMessage,
    String? done,
  }) async {
    final l10n = context.l10n;
    if (confirmTitle != null) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(confirmTitle),
          content: confirmMessage == null ? null : Text(confirmMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.confirm),
            ),
          ],
        ),
      );
      if (confirmed != true || !mounted) return;
    }
    setState(() => _busy = true);
    try {
      await ref.read(emergencyRepositoryProvider).act(e.id, action);
      if (mounted && done != null) SnackbarUtils.showSuccess(context, done);
    } on FirebaseFunctionsException catch (err) {
      if (!mounted) return;
      SnackbarUtils.showError(
        context,
        err.code == 'already-exists'
            ? l10n.emergencyAlreadyReported
            : l10n.actionFailed,
      );
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(emergencyProvider(widget.emergencyId));
    final e = state.value;
    if (e == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.background),
        body: Center(
          child: state.isLoading
              ? const CircularProgressIndicator()
              : Text(l10n.emergencyUnavailable),
        ),
      );
    }

    final uid = ref.watch(authStateProvider).value?.uid;
    final isOwner = uid == e.ownerId;
    final isStaff = ref.watch(userRoleProvider).isStaff;
    final helping = uid != null && e.helpers.contains(uid);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(e.type.label(l10n)),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (!isOwner && !isStaff)
            PopupMenuButton<String>(
              onSelected: (_) => _act(
                e,
                EmergencyAction.reportFalse,
                confirmTitle: l10n.emergencyReportFalseTitle,
                confirmMessage: l10n.emergencyReportFalseMessage,
                done: l10n.emergencyReportFalseDone,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'false',
                  child: Text(l10n.emergencyReportFalse),
                ),
              ],
            ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          4,
          20,
          MediaQuery.paddingOf(context).bottom + 32,
        ),
        children: [
          if (widget.justSent) ...[
            _Notice(
              icon: Icons.check_circle_rounded,
              color: AppColors.primary,
              text: l10n.emergencySent,
            ),
            const SizedBox(height: 14),
          ],
          if (e.photoUrls.isNotEmpty) ...[
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView(
                  children: [for (final url in e.photoUrls) PetImage.url(url)],
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
          Row(
            children: [
              EmergencyStatusChip(status: e.status),
              const SizedBox(width: 8),
              Text(
                [
                  e.species.label(l10n),
                  if (e.createdAt != null) timeAgo(l10n, e.createdAt!),
                ].join(' · '),
                style: const TextStyle(color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            e.description,
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.45,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 14),
          _PlaceRow(emergency: e),
          if (!isOwner && e.contactPhone != null) ...[
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => openLink(
                context,
                Uri(scheme: 'tel', path: e.contactPhone),
                l10n.callFailed,
              ),
              icon: const Icon(Icons.call_rounded),
              label: Text(l10n.emergencyCallReporter),
            ),
          ],
          const SizedBox(height: 14),
          if (e.helpers.isNotEmpty || (isOwner && e.alertedUsers != null))
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                [
                  if (e.helpers.isNotEmpty)
                    l10n.emergencyHelpersCount(e.helpers.length),
                  if (isOwner && e.alertedUsers != null)
                    l10n.emergencyAlertedCount(e.alertedUsers!),
                ].join(' · '),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ..._actions(e, isOwner: isOwner, isStaff: isStaff, helping: helping),
          const SizedBox(height: 18),
          const EmergencyDisclaimer(),
          const SizedBox(height: 22),
          Text(
            l10n.emergencySuggestedContacts,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.emergencySuggestedContactsHint,
            style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 12),
          if (e.suggestedContacts == null)
            Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 10),
                Text(l10n.emergencyFindingContacts),
              ],
            )
          else if (e.suggestedContacts!.isEmpty)
            Text(
              l10n.emergencyNoContacts,
              style: const TextStyle(color: AppColors.textMuted),
            )
          else
            for (final c in e.suggestedContacts!) ...[
              ContactCard(contact: c),
              const SizedBox(height: 10),
            ],
          TextButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const EmergencyContactsScreen(),
              ),
            ),
            icon: const Icon(Icons.contacts_rounded),
            label: Text(l10n.emergencyAllContacts),
          ),
        ],
      ),
    );
  }

  List<Widget> _actions(
    Emergency e, {
    required bool isOwner,
    required bool isStaff,
    required bool helping,
  }) {
    final l10n = context.l10n;
    final buttons = <Widget>[
      if (!isOwner && e.status == EmergencyStatus.open)
        FilledButton.icon(
          onPressed: _busy
              ? null
              : () => _act(
                  e,
                  EmergencyAction.helping,
                  confirmTitle: l10n.emergencyHelpTitle,
                  confirmMessage: l10n.emergencyHelpMessage,
                  done: l10n.emergencyHelpDone,
                ),
          icon: const Icon(Icons.directions_run_rounded),
          label: Text(l10n.emergencyImHelping),
        ),
      if (helping && e.status.isActive)
        _Notice(
          icon: Icons.directions_run_rounded,
          color: AppColors.accent,
          text: l10n.emergencyYouAreHelping,
        ),
      if ((isOwner || isStaff) && e.status.isActive)
        FilledButton.icon(
          onPressed: _busy
              ? null
              : () => _act(
                  e,
                  EmergencyAction.resolved,
                  confirmTitle: l10n.emergencyResolveTitle,
                  done: l10n.emergencyResolved,
                ),
          style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
          icon: const Icon(Icons.check_rounded),
          label: Text(l10n.emergencyMarkResolved),
        ),
      if ((isOwner || isStaff) && e.status.isActive)
        OutlinedButton(
          onPressed: _busy
              ? null
              : () => _act(
                  e,
                  EmergencyAction.closed,
                  confirmTitle: l10n.emergencyCloseTitle,
                ),
          child: Text(l10n.emergencyClose),
        ),
      if ((isOwner || isStaff) && !e.status.isActive)
        OutlinedButton(
          onPressed: _busy ? null : () => _act(e, EmergencyAction.reopen),
          child: Text(l10n.emergencyReopen),
        ),
      if (isStaff && e.status != EmergencyStatus.falseAlarm)
        TextButton(
          onPressed: _busy
              ? null
              : () => _act(
                  e,
                  EmergencyAction.falseAlarm,
                  confirmTitle: l10n.emergencyFalseAlarmTitle,
                ),
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          child: Text(l10n.emergencyMarkFalseAlarm),
        ),
      if (isStaff && e.falseReports > 0)
        Text(
          l10n.emergencyFalseReports(e.falseReports),
          style: const TextStyle(color: AppColors.danger),
        ),
    ];
    return [
      for (final b in buttons) ...[b, const SizedBox(height: 8)],
    ];
  }
}

class _PlaceRow extends StatelessWidget {
  final Emergency emergency;

  const _PlaceRow({required this.emergency});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final e = emergency;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => openLink(
          context,
          Uri.parse(
            'https://www.google.com/maps/dir/?api=1&destination=${e.lat},${e.lng}',
          ),
          l10n.openMapFailed,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.location_on_rounded, color: emergencyColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  e.placeLabel ?? e.city ?? l10n.emergencyPinned,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
              ),
              Text(
                l10n.directions,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _Notice({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
