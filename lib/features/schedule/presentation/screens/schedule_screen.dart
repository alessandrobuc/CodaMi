import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/screen_space.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../heat/presentation/screens/heat_calendar_screen.dart';
import '../../../heat/presentation/widgets/heat_widgets.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../sitting/presentation/widgets/sitting_widgets.dart'
    show SittingTabs;
import '../../domain/schedule.dart';
import '../providers/schedule_provider.dart';
import '../widgets/schedule_widgets.dart';
import 'schedule_form_screen.dart';
import '../../../feedback/domain/feedback.dart';
import '../../../feedback/presentation/providers/feedback_provider.dart';

Future<void> setOccurrenceDone(
  BuildContext context,
  WidgetRef ref,
  Occurrence o,
  bool done,
) async {
  final l10n = context.l10n;
  try {
    await saveScheduleEvent(ref, l10n, o.event.withDone(o.day, done));
  } catch (e) {
    debugPrint('Schedule done not saved: $e');
    if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
  }
}

// Null when the dialog is closed; true for "only this time".
Future<bool?> _askScope(BuildContext context, String title) {
  final l10n = context.l10n;
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(l10n.schRepeatScopeText),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.schAllTimes),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.schOnlyThis),
        ),
      ],
    ),
  );
}

Future<void> editOccurrence(BuildContext context, Occurrence o) async {
  final e = o.event;
  bool? only = false;
  if (e.repeat.repeats) {
    only = await _askScope(context, context.l10n.schEdit);
    if (only == null || !context.mounted) return;
  }
  await Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => only!
          ? ScheduleFormScreen(event: e.single(o.day), splitFrom: o)
          : ScheduleFormScreen(event: e),
    ),
  );
}

Future<bool> deleteOccurrence(
  BuildContext context,
  WidgetRef ref,
  Occurrence o,
) async {
  final l10n = context.l10n;
  final e = o.event;
  final repo = ref.read(scheduleRepositoryProvider);
  bool? only = false;
  if (e.repeat.repeats) {
    only = await _askScope(context, l10n.schDeleteConfirm);
  } else {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.schDeleteConfirm),
        content: Text(l10n.schDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (ok != true) return false;
  }
  if (only == null) return false;
  try {
    if (only) {
      await saveScheduleEvent(ref, l10n, e.withSkipped(o.day));
    } else {
      await repo.delete(e.id);
    }
    if (context.mounted) SnackbarUtils.showSuccess(context, l10n.schDeleted);
    return true;
  } catch (err) {
    debugPrint('Schedule event not deleted: $err');
    if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    return false;
  }
}

Future<void> showOccurrenceSheet(
  BuildContext context,
  WidgetRef ref,
  Occurrence o,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  backgroundColor: AppColors.surface,
  builder: (_) => _OccurrenceSheet(occurrence: o),
);

class _OccurrenceSheet extends ConsumerWidget {
  final Occurrence occurrence;

  const _OccurrenceSheet({required this.occurrence});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final events = ref.watch(scheduleEventsProvider).value;
    // Follows the saved event, so "done" updates while the sheet is open.
    final e =
        events?.where((x) => x.id == occurrence.event.id).firstOrNull ??
        occurrence.event;
    final o = Occurrence(e, occurrence.day);
    final now = DateTime.now();

    Widget line(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: AppColors.textMuted),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.35, color: AppColors.text),
            ),
          ),
        ],
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, endSpace(context) - 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ScheduleTypeIcon(e.type, size: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventTitle(l10n, e),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        e.type.label(l10n),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: e.type.color,
                        ),
                      ),
                    ],
                  ),
                ),
                if (o.done)
                  Chip(
                    avatar: const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    label: Text(l10n.schDoneLabel),
                    side: BorderSide.none,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            line(
              Icons.schedule_rounded,
              '${DateFormat.yMMMMEEEEd(l10n.localeName).format(o.day)} · '
              '${e.allDay ? l10n.schAllDay : scheduleTime(l10n, o.at)}',
            ),
            if (e.repeat.repeats)
              line(Icons.repeat_rounded, repeatText(l10n, e.repeat)),
            if (e.petNames.isNotEmpty)
              line(Icons.pets_rounded, e.petNames.join(', ')),
            if (e.detail.isNotEmpty) line(Icons.info_outline_rounded, e.detail),
            if (e.place.isNotEmpty) line(Icons.place_outlined, e.place),
            line(
              Icons.notifications_none_rounded,
              e.remind.isEmpty
                  ? l10n.schNoReminders
                  : [
                      for (final m in e.remind)
                        remindLabel(l10n, m, allDay: e.allDay),
                    ].join(' · '),
            ),
            if (e.notes.isNotEmpty) line(Icons.notes_rounded, e.notes),
            const SizedBox(height: 20),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: o.done
                    ? AppColors.textMuted
                    : AppColors.primary,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () => setOccurrenceDone(context, ref, o, !o.done),
              icon: Icon(o.done ? Icons.undo_rounded : Icons.check_rounded),
              label: Text(o.done ? l10n.schUndoDone : l10n.schMarkDone),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await editOccurrence(context, o);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(l10n.edit),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.danger,
                    ),
                    onPressed: () async {
                      if (await deleteOccurrence(context, ref, o) &&
                          context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: Text(l10n.delete),
                  ),
                ),
              ],
            ),
            if (e.repeat.repeats &&
                !o.done &&
                !toDay(o.day).isBefore(toDay(now)))
              TextButton.icon(
                onPressed: () async {
                  try {
                    await saveScheduleEvent(ref, l10n, e.withSkipped(o.day));
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      SnackbarUtils.showSuccess(context, l10n.schSkipped);
                    }
                  } catch (err) {
                    debugPrint('Schedule skip not saved: $err');
                    if (context.mounted) {
                      SnackbarUtils.showError(context, l10n.actionFailed);
                    }
                  }
                },
                icon: const Icon(Icons.redo_rounded),
                label: Text(l10n.schSkip),
              ),
          ],
        ),
      ),
    );
  }
}

class ScheduleScreen extends ConsumerStatefulWidget {
  final String? petId;
  final String? openEventId;

  const ScheduleScreen({super.key, this.petId, this.openEventId});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  late String? _pet = widget.petId;
  ScheduleType? _type;
  late DateTime _month = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
  );
  DateTime _selected = toDay(DateTime.now());
  bool _opened = false;

  bool _matches(ScheduleEvent e) =>
      (_pet == null || e.petIds.contains(_pet)) &&
      (_type == null || e.type == _type);

  void _openWanted(List<ScheduleEvent> events) {
    final id = widget.openEventId;
    if (_opened || id == null) return;
    final e = events.where((x) => x.id == id).firstOrNull;
    if (e == null) return;
    _opened = true;
    final now = DateTime.now();
    final next = occurrencesBetween(
      e,
      now.subtract(const Duration(days: 1)),
      now.add(const Duration(days: 400)),
    );
    final day = next.where((d) => !e.isDone(d)).firstOrNull ?? e.start;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) showOccurrenceSheet(context, ref, Occurrence(e, day));
    });
  }

  Future<void> _add([DateTime? day]) => Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => ScheduleFormScreen(day: day, petId: _pet),
    ),
  );

  @override
  void initState() {
    super.initState();
    ref.read(feedbackTrackerProvider).used(FeedbackArea.schedule);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(scheduleEventsProvider);
    final all = state.value ?? const <ScheduleEvent>[];
    _openWanted(all);
    final events = all.where(_matches).toList();
    final pets = ref.watch(myPetsProvider).value ?? const <Pet>[];
    final heat = _type == null
        ? ref
              .watch(scheduleHeatProvider)
              .where((h) => _pet == null || h.pet.id == _pet)
              .toList()
        : const <ScheduleHeat>[];
    final fixedPet = widget.petId == null
        ? null
        : pets.where((p) => p.id == widget.petId).firstOrNull;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            fixedPet == null ? l10n.schTitle : l10n.schTitleOf(fixedPet.name),
          ),
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          actions: [
            PopupMenuButton<ScheduleType?>(
              tooltip: l10n.schType,
              icon: Badge(
                isLabelVisible: _type != null,
                smallSize: 8,
                child: const Icon(Icons.filter_list_rounded),
              ),
              onSelected: (t) => setState(() => _type = t),
              itemBuilder: (_) => [
                CheckedPopupMenuItem(
                  value: null,
                  checked: _type == null,
                  child: Text(l10n.schAllTypes),
                ),
                for (final t in ScheduleType.values)
                  CheckedPopupMenuItem(
                    value: t,
                    checked: _type == t,
                    child: Text(t.label(l10n)),
                  ),
              ],
            ),
          ],
          bottom: SittingTabs(
            tabs: [
              Tab(text: l10n.schTabCalendar),
              Tab(text: l10n.schTabUpcoming),
              Tab(text: l10n.schTabDone),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          onPressed: () => _add(_selected),
          icon: const Icon(Icons.add_rounded),
          label: Text(l10n.schAddEvent),
        ),
        body: state.hasError && !state.hasValue
            ? Center(
                child: EmptyState(
                  icon: const Icon(Icons.cloud_off_rounded),
                  color: AppColors.lostPin,
                  title: l10n.actionFailed,
                  message: l10n.checkConnection,
                ),
              )
            : !state.hasValue
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (widget.petId == null && pets.length > 1)
                    SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          for (final p in [null, ...pets])
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                selected: _pet == p?.id,
                                showCheckmark: false,
                                onSelected: (_) => setState(() => _pet = p?.id),
                                label: Text(p?.name ?? l10n.schAllPets),
                                selectedColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  color: _pet == p?.id
                                      ? Colors.white
                                      : AppColors.text,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _calendar(events, heat),
                        _upcoming(events, heat),
                        _done(events),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  EdgeInsets get _listPadding =>
      EdgeInsets.fromLTRB(16, 8, 16, endSpace(context, floatingButton: true));

  Widget _heatTile(ScheduleHeat h) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ScheduleCard(
        tint: heatColor,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => HeatCalendarScreen(pet: h.pet)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: heatColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: heatColor,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.schHeatExpected(h.pet.name),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    '${heatRange(l10n, h.period.start, h.period.end)} · ${l10n.schEstimate}',
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
    );
  }

  Widget _calendar(List<ScheduleEvent> events, List<ScheduleHeat> heat) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final today = toDay(now);
    final monthEnd = DateTime.utc(_month.year, _month.month + 1, 0);
    final inMonth = occurrencesOf(events, _month, monthEnd);
    final byDay = <DateTime, List<Occurrence>>{};
    for (final o in inMonth) {
      byDay.putIfAbsent(o.day, () => []).add(o);
    }
    bool heatOn(DateTime d) => heat.any((h) => h.period.contains(d));
    final dayItems = byDay[_selected] ?? const <Occurrence>[];
    final dayHeat = heat.where((h) => h.period.start == _selected).toList();

    final material = MaterialLocalizations.of(context);
    final first = material.firstDayOfWeekIndex;
    final offset = (_month.weekday % 7 - first) % 7;
    final cells = offset + monthEnd.day;

    Widget cell(int index) {
      final n = index - offset + 1;
      if (n < 1 || n > monthEnd.day) return const SizedBox();
      final day = DateTime.utc(_month.year, _month.month, n);
      final items = byDay[day] ?? const <Occurrence>[];
      final selected = day == _selected;
      final isToday = day == today;
      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _selected = day),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : null,
            borderRadius: BorderRadius.circular(12),
            border: isToday && !selected
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$n',
                style: TextStyle(
                  fontWeight: isToday || selected
                      ? FontWeight.w800
                      : FontWeight.w500,
                  color: selected ? Colors.white : AppColors.text,
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                height: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final o in items.take(3))
                      _Dot(
                        selected
                            ? Colors.white
                            : (o.done ? AppColors.border : o.event.type.color),
                      ),
                    if (heatOn(day)) _Dot(selected ? Colors.white : heatColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: _listPadding,
      children: [
        ScheduleCard(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(
                      () =>
                          _month = DateTime.utc(_month.year, _month.month - 1),
                    ),
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat.yMMMM(l10n.localeName).format(_month),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(
                      () =>
                          _month = DateTime.utc(_month.year, _month.month + 1),
                    ),
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
              Row(
                children: [
                  for (var i = 0; i < 7; i++)
                    Expanded(
                      child: Center(
                        child: Text(
                          material.narrowWeekdays[(first + i) % 7],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.95,
                children: [for (var i = 0; i < cells; i++) cell(i)],
              ),
              if (_month != DateTime.utc(today.year, today.month))
                TextButton(
                  onPressed: () => setState(() {
                    _month = DateTime.utc(today.year, today.month);
                    _selected = today;
                  }),
                  child: Text(l10n.schToday),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ScheduleSectionTitle(
          dayHeading(l10n, _selected, now),
          trailing: TextButton.icon(
            onPressed: () => _add(_selected),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(l10n.add),
          ),
        ),
        for (final h in dayHeat) _heatTile(h),
        if (dayItems.isEmpty && dayHeat.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
            child: Text(
              l10n.schEmptyDay,
              style: const TextStyle(color: AppColors.textMuted),
            ),
          ),
        for (final o in dayItems)
          OccurrenceTile(
            occurrence: o,
            now: now,
            onTap: () => showOccurrenceSheet(context, ref, o),
            onDone: (v) => setOccurrenceDone(context, ref, o, v),
          ),
      ],
    );
  }

  Widget _upcoming(List<ScheduleEvent> events, List<ScheduleHeat> heat) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final today = toDay(now);
    final missed = [
      for (final o in occurrencesOf(
        events,
        today.subtract(const Duration(days: 7)),
        today.subtract(const Duration(days: 1)),
      ))
        if (!o.done && o.event.type != ScheduleType.note) o,
    ].reversed.toList();
    final next = [
      for (final o in occurrencesOf(
        events,
        today,
        today.add(const Duration(days: 366)),
      ))
        if (!o.done) o,
    ].take(100).toList();
    final nextHeat = {
      for (final h in heat.reversed)
        if (!h.period.end.isBefore(today)) h.pet.id: h,
    }.values.toList();

    if (missed.isEmpty && next.isEmpty && nextHeat.isEmpty) {
      return ListView(
        padding: _listPadding,
        children: [
          const SizedBox(height: 40),
          EmptyState(
            icon: const Icon(Icons.event_available_rounded),
            color: AppColors.primary,
            title: l10n.schEmptyTitle,
            message: l10n.schEmptyUpcoming,
          ),
        ],
      );
    }

    final children = <Widget>[];
    if (missed.isNotEmpty) {
      children.add(ScheduleSectionTitle(l10n.schMissed));
      for (final o in missed) {
        children.add(
          OccurrenceTile(
            occurrence: o,
            now: now,
            showDay: true,
            onTap: () => showOccurrenceSheet(context, ref, o),
            onDone: (v) => setOccurrenceDone(context, ref, o, v),
          ),
        );
      }
    }
    DateTime? lastDay;
    var heatIndex = 0;
    nextHeat.sort((a, b) => a.period.start.compareTo(b.period.start));
    for (final o in next) {
      while (heatIndex < nextHeat.length &&
          !nextHeat[heatIndex].period.start.isAfter(o.day)) {
        children.add(_heatTile(nextHeat[heatIndex++]));
      }
      if (o.day != lastDay) {
        lastDay = o.day;
        children.add(ScheduleSectionTitle(dayHeading(l10n, o.day, now)));
      }
      children.add(
        OccurrenceTile(
          occurrence: o,
          now: now,
          onTap: () => showOccurrenceSheet(context, ref, o),
          onDone: (v) => setOccurrenceDone(context, ref, o, v),
        ),
      );
    }
    while (heatIndex < nextHeat.length) {
      children.add(_heatTile(nextHeat[heatIndex++]));
    }
    return ListView(padding: _listPadding, children: children);
  }

  Widget _done(List<ScheduleEvent> events) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final done = doneOccurrences(events).take(200).toList();
    if (done.isEmpty) {
      return ListView(
        padding: _listPadding,
        children: [
          const SizedBox(height: 40),
          EmptyState(
            icon: const Icon(Icons.task_alt_rounded),
            color: AppColors.primary,
            title: l10n.schTabDone,
            message: l10n.schEmptyDone,
          ),
        ],
      );
    }
    return ListView(
      padding: _listPadding,
      children: [
        for (final o in done)
          OccurrenceTile(
            occurrence: o,
            now: now,
            showDay: true,
            onTap: () => showOccurrenceSheet(context, ref, o),
            onDone: (v) => setOccurrenceDone(context, ref, o, v),
          ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;

  const _Dot(this.color);

  @override
  Widget build(BuildContext context) => Container(
    width: 5,
    height: 5,
    margin: const EdgeInsets.symmetric(horizontal: 1),
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
