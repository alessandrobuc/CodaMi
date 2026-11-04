import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../data/heat_repository.dart';
import '../../domain/heat.dart';
import '../providers/heat_provider.dart';
import '../widgets/heat_widgets.dart';
import '../../../../core/utils/screen_space.dart';

class HeatCalendarScreen extends ConsumerStatefulWidget {
  final Pet pet;

  const HeatCalendarScreen({super.key, required this.pet});

  @override
  ConsumerState<HeatCalendarScreen> createState() => _HeatCalendarScreenState();
}

class _HeatCalendarScreenState extends ConsumerState<HeatCalendarScreen> {
  String? _synced;

  Pet get pet => widget.pet;

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      debugPrint('Heat calendar change failed: $e');
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
    }
  }

  Future<void> _edit([HeatCycle? cycle]) async {
    final draft = await showModalBottomSheet<_HeatDraft>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _HeatSheet(cycle: cycle),
    );
    if (draft == null || !mounted) return;
    if (draft.delete) {
      await _run(() => ref.read(heatRepositoryProvider).deleteCycle(cycle!.id));
      return;
    }
    await _run(
      () => ref
          .read(heatRepositoryProvider)
          .saveCycle(
            ownerId: pet.ownerId,
            petId: pet.id,
            id: cycle?.id,
            start: draft.start,
            end: draft.end,
            notes: draft.notes,
          ),
    );
  }

  Future<void> _endToday(HeatCycle c) => _run(
    () => ref
        .read(heatRepositoryProvider)
        .saveCycle(
          ownerId: pet.ownerId,
          petId: pet.id,
          id: c.id,
          start: c.start,
          end: heatDay(DateTime.now()),
          notes: c.notes,
        ),
  );

  Future<void> _setReminder(HeatEstimate estimate, int? daysBefore) async {
    final repo = ref.read(heatRepositoryProvider);
    if (daysBefore == null) {
      await _run(() => repo.deleteReminder(pet.id));
      return;
    }
    final plan = reminderPlan(estimate, daysBefore, DateTime.now());
    if (plan == null) return;
    await _run(() => repo.saveReminder(pet, plan, daysBefore: daysBefore));
  }

  // Keeps the stored reminder on the latest estimate after records change.
  void _syncReminder(HeatEstimate estimate, HeatReminder? reminder) {
    if (reminder == null) return;
    final plan = reminderPlan(estimate, reminder.daysBefore, DateTime.now());
    final want = plan == null
        ? 'none'
        : '${heatDayKey(plan.nextStart)}|${plan.cycleDays}';
    if (want == '${reminder.nextStart}|${reminder.cycleDays}' ||
        want == _synced) {
      return;
    }
    _synced = want;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = ref.read(heatRepositoryProvider);
      if (plan == null) {
        repo.deleteReminder(pet.id).catchError((_) {});
      } else {
        repo
            .saveReminder(pet, plan, daysBefore: reminder.daysBefore)
            .catchError((_) {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final config = ref.watch(heatConfigProvider).value ?? const HeatConfig();
    final cyclesState = ref.watch(petHeatCyclesProvider(pet.id));
    final reminder = ref.watch(heatReminderProvider(pet.id)).value;
    final cycles = cyclesState.value ?? const <HeatCycle>[];
    final now = DateTime.now();
    final today = heatDay(now);
    final estimate = estimateHeat(cycles, pet.species, config, now);
    if (cyclesState.hasValue) _syncReminder(estimate, reminder);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.heatCalendarOf(pet.name)),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: heatColor,
        foregroundColor: Colors.white,
        onPressed: () => _edit(),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.heatRecord),
      ),
      body: !cyclesState.hasValue
          ? Center(
              child: cyclesState.hasError
                  ? Text(l10n.actionFailed)
                  : const CircularProgressIndicator(),
            )
          : ListView(
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                endSpace(context, floatingButton: true),
              ),
              children: [
                _Status(
                  estimate: estimate,
                  today: today,
                  onEndToday: _endToday,
                ),
                const SizedBox(height: 12),
                HeatCard(
                  child: HeatMonthCalendar(
                    cycles: cycles,
                    estimate: estimate,
                    today: today,
                  ),
                ),
                if (estimate.upcoming.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  HeatCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeatTitle(l10n.heatUpcoming),
                        for (final p in estimate.upcoming)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.event_outlined,
                                  size: 18,
                                  color: heatColor.withValues(alpha: 0.8),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    heatRange(l10n, p.start, p.end),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                                Text(
                                  l10n.heatInDays(
                                    daysBetween(today, p.start).clamp(0, 9999),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                _Reminders(
                  estimate: estimate,
                  reminder: reminder,
                  onChanged: (days) => _setReminder(estimate, days),
                ),
                const SizedBox(height: 12),
                HeatCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeatTitle(l10n.heatHistory),
                      if (cycles.isEmpty)
                        Text(
                          l10n.heatHistoryEmpty,
                          style: const TextStyle(color: AppColors.textMuted),
                        ),
                      for (final c in cycles)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () => _edit(c),
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundColor: heatColor.withValues(alpha: 0.12),
                            child: const Icon(
                              Icons.water_drop_outlined,
                              size: 18,
                              color: heatColor,
                            ),
                          ),
                          title: Text(
                            c.end == null
                                ? heatDate(l10n, c.start)
                                : heatRange(l10n, c.start, c.end!),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                          subtitle: Text(
                            [
                              c.length == null
                                  ? l10n.heatOngoing
                                  : l10n.heatLengthDays(c.length!),
                              if (c.notes.isNotEmpty) c.notes,
                            ].join(' · '),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: AppColors.textMuted,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 17,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.heatEstimateNote,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class _Status extends StatelessWidget {
  final HeatEstimate estimate;
  final DateTime today;
  final void Function(HeatCycle) onEndToday;

  const _Status({
    required this.estimate,
    required this.today,
    required this.onEndToday,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final current = estimate.current;
    final next = estimate.nextStart;
    final big = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: AppColors.text,
    );
    final muted = const TextStyle(
      fontSize: 13,
      height: 1.4,
      color: AppColors.textMuted,
    );
    return HeatCard(
      tint: heatColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (current != null) ...[
            Text(
              l10n.heatInHeatNow,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: heatColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              l10n.heatDayNumber(daysBetween(current.start, today) + 1),
              style: big,
            ),
            if (current.end == null) ...[
              const SizedBox(height: 10),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: heatColor),
                onPressed: () => onEndToday(current),
                icon: const Icon(Icons.check_rounded),
                label: Text(l10n.heatEndToday),
              ),
            ],
          ] else if (next != null) ...[
            Text(
              l10n.heatNextExpected,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: heatColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(heatDate(l10n, next), style: big),
            const SizedBox(height: 2),
            Text(
              l10n.heatInDays(daysBetween(today, next).clamp(0, 9999)),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ] else
            Text(
              estimate.records == 0
                  ? l10n.heatNoEstimate
                  : l10n.heatNoEstimateMore,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          if (estimate.cycleDays != null) ...[
            const SizedBox(height: 10),
            Text(
              l10n.heatCycleSummary(estimate.cycleDays!, estimate.heatDays),
              style: muted,
            ),
            Text(
              estimate.fromHistory
                  ? l10n.heatBasedOn(estimate.records)
                  : l10n.heatBasedOnTypical,
              style: muted,
            ),
          ],
        ],
      ),
    );
  }
}

class _Reminders extends StatelessWidget {
  final HeatEstimate estimate;
  final HeatReminder? reminder;
  final void Function(int? daysBefore) onChanged;

  const _Reminders({
    required this.estimate,
    required this.reminder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canRemind =
        estimate.cycleDays != null && estimate.upcoming.isNotEmpty;
    final on = reminder != null;
    final next = parseHeatDay(reminder?.nextStart);
    return HeatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeatTitle(l10n.heatReminders),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeThumbColor: heatColor,
            value: on,
            onChanged: canRemind || on
                ? (v) => onChanged(v ? defaultHeatReminderDays : null)
                : null,
            title: Text(
              l10n.heatRemindMe,
              style: const TextStyle(fontSize: 14, color: AppColors.text),
            ),
            subtitle: canRemind ? null : Text(l10n.heatRemindNeedsEstimate),
          ),
          if (on) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final d in heatReminderDays)
                  ChoiceChip(
                    label: Text(l10n.heatRemindDaysBefore(d)),
                    selected: reminder!.daysBefore == d,
                    showCheckmark: false,
                    shape: const StadiumBorder(),
                    onSelected: (_) => onChanged(d),
                  ),
              ],
            ),
            if (next != null) ...[
              const SizedBox(height: 10),
              Text(
                l10n.heatNextReminder(
                  heatDate(
                    l10n,
                    next.subtract(Duration(days: reminder!.daysBefore)),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _HeatDraft {
  final DateTime start;
  final DateTime? end;
  final String notes;
  final bool delete;

  const _HeatDraft(this.start, this.end, this.notes, {this.delete = false});
}

class _HeatSheet extends StatefulWidget {
  final HeatCycle? cycle;

  const _HeatSheet({this.cycle});

  @override
  State<_HeatSheet> createState() => _HeatSheetState();
}

class _HeatSheetState extends State<_HeatSheet> {
  late DateTime _start = widget.cycle?.start ?? heatDay(DateTime.now());
  late DateTime? _end = widget.cycle?.end;
  late final _notes = TextEditingController(text: widget.cycle?.notes);
  String? _error;

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<DateTime?> _pick(DateTime initial, DateTime first) async {
    final today = heatDay(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(today) ? today : initial,
      firstDate: first,
      lastDate: today,
    );
    return picked == null ? null : heatDay(picked);
  }

  Future<void> _confirmDelete() async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.heatDeleteConfirm),
        content: Text(l10n.heatDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.heatDelete),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      Navigator.of(context).pop(_HeatDraft(_start, _end, '', delete: true));
    }
  }

  void _save() {
    final end = _end;
    if (end != null && end.isBefore(_start)) {
      setState(() => _error = context.l10n.heatEndBeforeStart);
      return;
    }
    Navigator.of(context).pop(_HeatDraft(_start, end, _notes.text));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget dateRow(String label, String value, VoidCallback onTap) => ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(
        label,
        style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
        ),
      ),
      trailing: const Icon(Icons.calendar_month_outlined, color: heatColor),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeatTitle(widget.cycle == null ? l10n.heatRecord : l10n.heatEdit),
              dateRow(l10n.heatStart, heatDate(l10n, _start), () async {
                final d = await _pick(_start, DateTime.utc(2000));
                if (d != null) setState(() => _start = d);
              }),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeThumbColor: heatColor,
                value: _end == null,
                onChanged: (still) => setState(
                  () => _end = still ? null : heatDay(DateTime.now()),
                ),
                title: Text(l10n.heatStillInHeat),
              ),
              if (_end != null)
                dateRow(l10n.heatEnd, heatDate(l10n, _end!), () async {
                  final d = await _pick(_end!, _start);
                  if (d != null) setState(() => _end = d);
                }),
              const SizedBox(height: 8),
              TextField(
                controller: _notes,
                maxLength: 500,
                maxLines: 3,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: l10n.heatNotes,
                  hintText: l10n.heatNotesHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 4),
                Text(_error!, style: const TextStyle(color: AppColors.danger)),
              ],
              const SizedBox(height: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: heatColor,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: _save,
                child: Text(l10n.save),
              ),
              if (widget.cycle != null) ...[
                const SizedBox(height: 6),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.danger,
                  ),
                  onPressed: _confirmDelete,
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: Text(l10n.heatDelete),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// On a pet's page: status and a way into the calendar.
class HeatPetCard extends ConsumerWidget {
  final Pet pet;

  const HeatPetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final config = ref.watch(heatConfigProvider).value ?? const HeatConfig();
    final cycles = ref.watch(petHeatCyclesProvider(pet.id)).value;
    final now = DateTime.now();
    final estimate = cycles == null
        ? null
        : estimateHeat(cycles, pet.species, config, now);
    final today = heatDay(now);
    final current = estimate?.current;
    final next = estimate?.nextStart;
    final text = current != null
        ? l10n.heatCardInHeat(daysBetween(current.start, today) + 1)
        : next != null
        ? l10n.heatCardNext(heatDate(l10n, next))
        : l10n.heatCardRecordFirst;
    return Material(
      color: heatColor.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => HeatCalendarScreen(pet: pet))),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: heatColor.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 21,
                backgroundColor: heatColor,
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.heatCalendar,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: heatColor),
            ],
          ),
        ),
      ),
    );
  }
}
