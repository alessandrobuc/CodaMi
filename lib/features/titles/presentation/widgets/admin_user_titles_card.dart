import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/dialog_save_button.dart';
import '../../../../l10n/l10n.dart';
import '../../data/titles_repository.dart';
import '../../domain/titles.dart';
import '../providers/titles_provider.dart';
import '../screens/achievements_screen.dart';
import 'title_badge.dart';
import 'title_labels.dart';

final _achievementsOfProvider = StreamProvider.autoDispose
    .family<Achievements, String>(
      (ref, uid) => ref.watch(titlesRepositoryProvider).watchAchievements(uid),
    );

final _donationsOfProvider = StreamProvider.autoDispose
    .family<List<Donation>, String>(
      (ref, uid) => ref.watch(titlesRepositoryProvider).watchDonations(uid),
    );

// On the admin page of a user: their titles, titles given by hand, donations.
class AdminUserTitlesCard extends ConsumerStatefulWidget {
  final String uid;

  const AdminUserTitlesCard({super.key, required this.uid});

  @override
  ConsumerState<AdminUserTitlesCard> createState() =>
      _AdminUserTitlesCardState();
}

class _AdminUserTitlesCardState extends ConsumerState<AdminUserTitlesCard> {
  // The row or button whose change is being saved.
  String? _busy;

  Future<void> _run(String key, Future<void> Function() action) async {
    final l10n = context.l10n;
    setState(() => _busy = key);
    try {
      await action();
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Title change failed: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  // Dialogs save themselves and close only once it worked.
  Future<void> _openDialog(Widget dialog) async {
    final l10n = context.l10n;
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => dialog,
    );
    if (saved == true && mounted) {
      SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final uid = widget.uid;
    final repo = ref.read(titlesRepositoryProvider);
    final a =
        ref.watch(_achievementsOfProvider(uid)).value ?? const Achievements();
    final donations = ref.watch(_donationsOfProvider(uid)).value ?? const [];
    final mins = ref.watch(ambassadorMinsProvider);
    final config =
        ref.watch(titlesConfigProvider).value ?? const TitlesConfig();
    final total = donations.fold<int>(0, (sum, d) => sum + d.cents);
    final date = DateFormat.yMMMd(l10n.localeName);
    final idle = _busy == null;

    Widget heading(IconData icon, String text) => Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heading(Icons.workspace_premium_rounded, l10n.ttlAdminUserBox),
            const SizedBox(height: 10),
            if (a.unlocked.isEmpty && a.revoked.isEmpty)
              Text(
                l10n.ttlNoTitle,
                style: const TextStyle(color: AppColors.textMuted),
              ),
            for (final t in a.unlocked)
              _Row(
                chip: TitleChip(t, small: true),
                note: a.granted.containsKey(t.id) ? l10n.ttlAdminGiven : null,
                action: l10n.ttlAdminTakeAway,
                busy: _busy == 'take_${t.id.name}',
                onAction: idle
                    ? () => _run(
                        'take_${t.id.name}',
                        () => repo.adminSetTitle(uid, t.id, 0),
                      )
                    : null,
              ),
            for (final id in a.revoked)
              _Row(
                chip: Opacity(
                  opacity: 0.5,
                  child: TitleChip(TitleLevel(id, 1), small: true),
                ),
                note: l10n.ttlAdminTakenAway,
                action: l10n.ttlAdminAllowAgain,
                busy: _busy == 'allow_${id.name}',
                onAction: idle
                    ? () => _run(
                        'allow_${id.name}',
                        () => repo.adminSetTitle(uid, id, null),
                      )
                    : null,
              ),
            const SizedBox(height: 6),
            OutlinedButton.icon(
              onPressed: idle
                  ? () => _openDialog(
                      _GiveDialog(
                        config: config,
                        mins: mins,
                        onSave: (t) => repo.adminSetTitle(uid, t.id, t.level),
                      ),
                    )
                  : null,
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.ttlAdminGive),
            ),
            const Divider(height: 28),
            heading(Icons.favorite_rounded, l10n.ttlAdminDonations),
            const SizedBox(height: 4),
            Text(
              l10n.ttlAdminRecordHelp,
              style: const TextStyle(
                fontSize: 12.5,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            if (donations.isEmpty)
              Text(
                l10n.ttlAdminNoDonations,
                style: const TextStyle(color: AppColors.textMuted),
              )
            else
              Text(
                l10n.ttlAdminTotal(centsLabel(total)),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            for (final d in donations)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(centsLabel(d.cents)),
                subtitle: Text(
                  [
                    if (d.createdAt != null) date.format(d.createdAt!),
                    if (d.note.isNotEmpty) d.note,
                  ].join(' · '),
                ),
                trailing: _busy == 'delete_${d.id}'
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : IconButton(
                        tooltip: l10n.delete,
                        icon: const Icon(Icons.delete_outline_rounded),
                        onPressed: idle
                            ? () async {
                                final sure = await showDialog<bool>(
                                  context: context,
                                  builder: (dialog) => AlertDialog(
                                    title: Text(l10n.ttlAdminDeleteDonation),
                                    content: Text(centsLabel(d.cents)),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(dialog).pop(false),
                                        child: Text(l10n.cancel),
                                      ),
                                      FilledButton(
                                        onPressed: () =>
                                            Navigator.of(dialog).pop(true),
                                        child: Text(l10n.delete),
                                      ),
                                    ],
                                  ),
                                );
                                if (sure == true && mounted) {
                                  await _run(
                                    'delete_${d.id}',
                                    () => repo.deleteDonation(d.id),
                                  );
                                }
                              }
                            : null,
                      ),
              ),
            const SizedBox(height: 6),
            OutlinedButton.icon(
              onPressed: idle
                  ? () => _openDialog(
                      _DonationDialog(
                        onSave: (cents, note) =>
                            repo.recordDonation(uid, cents, note),
                      ),
                    )
                  : null,
              icon: const Icon(Icons.add_card_rounded),
              label: Text(l10n.ttlAdminRecord),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final Widget chip;
  final String? note;
  final String action;
  final bool busy;
  final VoidCallback? onAction;

  const _Row({
    required this.chip,
    required this.note,
    required this.action,
    required this.busy,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Flexible(child: chip),
          if (note != null) ...[
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                note!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
          const Spacer(),
          busy
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : TextButton(onPressed: onAction, child: Text(action)),
        ],
      ),
    );
  }
}

class _GiveDialog extends StatefulWidget {
  final TitlesConfig config;
  final List<int> mins;
  final Future<void> Function(TitleLevel title) onSave;

  const _GiveDialog({
    required this.config,
    required this.mins,
    required this.onSave,
  });

  @override
  State<_GiveDialog> createState() => _GiveDialogState();
}

class _GiveDialogState extends State<_GiveDialog> {
  TitleId _id = TitleId.partner;
  int _level = 1;
  bool _saving = false;
  String? _error;

  Future<void> _save() async {
    final l10n = context.l10n;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(TitleLevel(_id, _level));
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      debugPrint('Title not given: $e');
      if (mounted) {
        setState(() {
          _saving = false;
          _error = l10n.actionFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final max = widget.config.maxLevel(_id, widget.mins);
    return AlertDialog(
      title: Text(l10n.ttlAdminGive),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<TitleId>(
            initialValue: _id,
            isExpanded: true,
            items: [
              for (final id in [
                ...TitleId.manual,
                ...TitleId.counted,
                TitleId.ambassador,
              ])
                DropdownMenuItem(
                  value: id,
                  child: Text('${id.emoji()}  ${id.name(l10n)}'),
                ),
            ],
            onChanged: _saving
                ? null
                : (id) => setState(() {
                    _id = id ?? _id;
                    _level = 1;
                  }),
          ),
          if (max > 1) ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              key: ValueKey(_id),
              initialValue: _level,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.ttlAdminChooseLevel),
              items: [
                for (var l = 1; l <= max; l++)
                  DropdownMenuItem(
                    value: l,
                    child: Text(TitleLevel(_id, l).name(l10n)),
                  ),
              ],
              onChanged: _saving
                  ? null
                  : (l) => setState(() => _level = l ?? 1),
            ),
          ],
          DialogError(_error),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        DialogSaveButton(
          label: l10n.ttlAdminGive,
          saving: _saving,
          onPressed: _save,
        ),
      ],
    );
  }
}

class _DonationDialog extends StatefulWidget {
  final Future<void> Function(int cents, String note) onSave;

  const _DonationDialog({required this.onSave});

  @override
  State<_DonationDialog> createState() => _DonationDialogState();
}

class _DonationDialogState extends State<_DonationDialog> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  int? get _cents {
    final value = double.tryParse(_amount.text.trim().replaceAll(',', '.'));
    if (value == null || value <= 0 || value > 100000) return null;
    return (value * 100).round();
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final cents = _cents;
    if (cents == null) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(cents, _note.text.trim());
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      debugPrint('Donation not recorded: $e');
      if (mounted) {
        setState(() {
          _saving = false;
          _error = l10n.actionFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.ttlAdminRecord),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amount,
              enabled: !_saving,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(labelText: l10n.ttlAdminAmount),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _note,
              enabled: !_saving,
              maxLength: 200,
              decoration: InputDecoration(labelText: l10n.ttlAdminNoteField),
            ),
            DialogError(_error),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        DialogSaveButton(
          label: l10n.save,
          saving: _saving,
          onPressed: _cents == null ? null : _save,
        ),
      ],
    );
  }
}
