import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/screen_space.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/form_fields.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../domain/schedule.dart';
import '../providers/schedule_provider.dart';
import '../widgets/schedule_widgets.dart';

enum _Ends { never, onDate, afterCount }

class ScheduleFormScreen extends ConsumerStatefulWidget {
  final ScheduleEvent? event;
  final DateTime? day;
  final String? petId;
  // Editing one day of a series: the series skips that day once this is saved.
  final Occurrence? splitFrom;

  const ScheduleFormScreen({
    super.key,
    this.event,
    this.day,
    this.petId,
    this.splitFrom,
  });

  @override
  ConsumerState<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends ConsumerState<ScheduleFormScreen> {
  late final ScheduleEvent? _old = widget.event;
  late ScheduleType _type = _old?.type ?? ScheduleType.vet;
  late final _title = TextEditingController(text: _old?.title);
  late final _notes = TextEditingController(text: _old?.notes);
  late final _place = TextEditingController(text: _old?.place);
  late final _detail = TextEditingController(text: _old?.detail);
  late final _every = TextEditingController(text: '${_old?.repeat.every ?? 1}');
  late final _count = TextEditingController(
    text: _old?.repeat.count == null ? '' : '${_old!.repeat.count}',
  );
  late final Set<String> _pets = {
    ...?_old?.petIds,
    if (_old == null && widget.petId != null) widget.petId!,
  };
  late DateTime _start = _old?.start ?? toDay(widget.day ?? DateTime.now());
  late bool _allDay = _old?.allDay ?? defaultAllDayFor(_type);
  late TimeOfDay _time = _old?.time == null
      ? _defaultTime()
      : TimeOfDay(hour: _old!.time! ~/ 60, minute: _old.time! % 60);
  late RepeatFreq _freq = _old?.repeat.freq ?? RepeatFreq.none;
  late Set<int> _weekdays = {...?_old?.repeat.weekdays};
  late _Ends _ends = _old?.repeat.until != null
      ? _Ends.onDate
      : (_old?.repeat.count != null ? _Ends.afterCount : _Ends.never);
  late DateTime _until =
      _old?.repeat.until ?? _start.add(const Duration(days: 30));
  late List<int> _remind = [...(_old?.remind ?? defaultRemindersFor(_type))];
  bool _remindTouched = false;
  bool _saving = false;
  String? _everyError, _countError, _untilError;

  TimeOfDay _defaultTime() {
    final now = DateTime.now();
    if (toDay(widget.day ?? now) == toDay(now) && now.hour < 23) {
      return TimeOfDay(hour: now.hour + 1, minute: 0);
    }
    return const TimeOfDay(hour: 10, minute: 0);
  }

  @override
  void dispose() {
    for (final c in [_title, _notes, _place, _detail, _every, _count]) {
      c.dispose();
    }
    super.dispose();
  }

  void _setType(ScheduleType t) => setState(() {
    _type = t;
    if (_old == null && !_remindTouched) {
      _allDay = defaultAllDayFor(t);
      _remind = [...defaultRemindersFor(t)];
    }
  });

  void _toggleRemind(int m) {
    setState(() => _remindTouched = true);
    if (_remind.contains(m)) {
      setState(() => _remind.remove(m));
    } else if (_remind.length >= maxReminders) {
      SnackbarUtils.showError(context, context.l10n.schRemindMax);
    } else {
      setState(() => _remind.add(m));
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _start,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _start = toDay(picked));
  }

  Future<void> _pickUntil() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _until.isBefore(_start) ? _start : _until,
      firstDate: _start,
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _until = toDay(picked));
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    final repeats = _freq != RepeatFreq.none;
    final every = int.tryParse(_every.text.trim());
    final count = int.tryParse(_count.text.trim());
    setState(() {
      _everyError = repeats && (every == null || every < 1 || every > 99)
          ? l10n.schInvalidEvery
          : null;
      _countError =
          repeats &&
              _ends == _Ends.afterCount &&
              (count == null || count < 1 || count > 999)
          ? l10n.schInvalidCount
          : null;
      _untilError = repeats && _ends == _Ends.onDate && _until.isBefore(_start)
          ? l10n.schUntilBeforeStart
          : null;
    });
    if (_everyError != null || _countError != null || _untilError != null) {
      return;
    }
    final pets = ref.read(myPetsProvider).value ?? const <Pet>[];
    final chosen = [
      for (final p in pets)
        if (_pets.contains(p.id)) p,
    ];
    final usesDetail =
        _type == ScheduleType.vaccine || _type == ScheduleType.medicine;
    final usesPlace =
        _type == ScheduleType.vet ||
        _type == ScheduleType.grooming ||
        _type == ScheduleType.vaccine ||
        _type == ScheduleType.walk ||
        _type == ScheduleType.other;
    final base =
        _old ?? ScheduleEvent(ownerId: uid, type: _type, start: _start);
    final event = base.copyWith(
      type: _type,
      title: _title.text,
      notes: _notes.text,
      place: usesPlace ? _place.text : '',
      detail: usesDetail ? _detail.text : '',
      petIds: [for (final p in chosen) p.id],
      petNames: [
        for (final p in chosen)
          p.name.length <= 60 ? p.name : p.name.substring(0, 60),
      ],
      start: _start,
      time: () => _allDay ? null : _time.hour * 60 + _time.minute,
      repeat: repeats
          ? ScheduleRepeat(
              freq: _freq,
              every: every!,
              weekdays: _freq == RepeatFreq.weekly
                  ? (_weekdays.isEmpty ? {_start.weekday} : _weekdays)
                  : const {},
              until: _ends == _Ends.onDate ? _until : null,
              count: _ends == _Ends.afterCount ? count : null,
            )
          : const ScheduleRepeat(),
      remind: [
        for (final m in remindOptions)
          if (_remind.contains(m) && (!_allDay || m >= 1440 || m == 0)) m,
      ],
    );
    setState(() => _saving = true);
    try {
      await saveScheduleEvent(ref, l10n, event);
      final split = widget.splitFrom;
      if (split != null) {
        await saveScheduleEvent(ref, l10n, split.event.withSkipped(split.day));
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
      SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (e) {
      debugPrint('Schedule event not saved: $e');
      if (mounted) {
        setState(() => _saving = false);
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    }
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 2, top: 12, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
    ),
  );

  Widget _pickerTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    String? error,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Material(
        color: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: error != null ? AppColors.danger : AppColors.border,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 15, color: AppColors.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      if (error != null)
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 6),
          child: Text(
            error,
            style: const TextStyle(fontSize: 12, color: AppColors.danger),
          ),
        ),
    ],
  );

  Widget _section(List<Widget> children) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: ScheduleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pets = ref.watch(myPetsProvider).value ?? const <Pet>[];
    final repeats = _freq != RepeatFreq.none;
    final unit = switch (_freq) {
      RepeatFreq.weekly => l10n.schUnitWeeks(int.tryParse(_every.text) ?? 1),
      RepeatFreq.monthly => l10n.schUnitMonths(int.tryParse(_every.text) ?? 1),
      RepeatFreq.yearly => l10n.schUnitYears(int.tryParse(_every.text) ?? 1),
      _ => l10n.schUnitDays(int.tryParse(_every.text) ?? 1),
    };
    final weekdayNames = DateFormat(
      null,
      l10n.localeName,
    ).dateSymbols.SHORTWEEKDAYS;
    final remindChoices = [
      for (final m in remindOptions)
        if (!_allDay || m == 0 || m >= 1440) m,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_old == null ? l10n.schAddEvent : l10n.schEditEvent),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: AbsorbPointer(
        absorbing: _saving,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(16, 8, 16, endSpace(context)),
          children: [
            _section([
              _label(l10n.schType),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in ScheduleType.values)
                    ChoiceChip(
                      selected: _type == t,
                      onSelected: (_) => _setType(t),
                      showCheckmark: false,
                      avatar: Icon(
                        t.icon,
                        size: 18,
                        color: _type == t ? Colors.white : t.color,
                      ),
                      label: Text(t.label(l10n)),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: _type == t ? Colors.white : AppColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              AppTextField(
                controller: _title,
                label: l10n.schEventTitle,
                hint: l10n.schTitleHint(_type.label(l10n)),
                maxLength: 80,
              ),
              if (_type == ScheduleType.vaccine ||
                  _type == ScheduleType.medicine)
                AppTextField(
                  controller: _detail,
                  label: _type == ScheduleType.vaccine
                      ? l10n.schVaccineName
                      : l10n.schMedicineName,
                  hint: _type == ScheduleType.vaccine
                      ? l10n.schVaccineHint
                      : l10n.schMedicineHint,
                  maxLength: 120,
                ),
              if (pets.isNotEmpty) ...[
                _label(l10n.schForPets),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in pets)
                      FilterChip(
                        selected: _pets.contains(p.id),
                        onSelected: (v) => setState(
                          () => v ? _pets.add(p.id) : _pets.remove(p.id),
                        ),
                        label: Text(p.name),
                        selectedColor: AppColors.primary.withValues(
                          alpha: 0.15,
                        ),
                        checkmarkColor: AppColors.primary,
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 2),
                  child: Text(
                    l10n.schForPetsHelp,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ]),
            _section([
              _label(l10n.schDate),
              _pickerTile(
                icon: Icons.calendar_today_rounded,
                text: DateFormat.yMMMMEEEEd(l10n.localeName).format(_start),
                onTap: _pickDate,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _allDay,
                onChanged: (v) => setState(() {
                  _allDay = v;
                  _remindTouched = true;
                  if (v) _remind.removeWhere((m) => m > 0 && m < 1440);
                }),
                title: Text(l10n.schAllDay),
              ),
              if (!_allDay)
                _pickerTile(
                  icon: Icons.schedule_rounded,
                  text: _time.format(context),
                  onTap: _pickTime,
                ),
            ]),
            _section([
              _label(l10n.schRepeat),
              DropdownButtonFormField<RepeatFreq>(
                initialValue: _freq,
                decoration: fieldDecoration(),
                items: [
                  for (final f in RepeatFreq.values)
                    DropdownMenuItem(
                      value: f,
                      child: Text(switch (f) {
                        RepeatFreq.none => l10n.schRepeatNone,
                        RepeatFreq.daily => l10n.schRepeatDaily,
                        RepeatFreq.weekly => l10n.schRepeatWeekly,
                        RepeatFreq.monthly => l10n.schRepeatMonthly,
                        RepeatFreq.yearly => l10n.schRepeatYearly,
                      }),
                    ),
                ],
                onChanged: (f) => setState(() {
                  _freq = f ?? RepeatFreq.none;
                  if (_freq == RepeatFreq.weekly && _weekdays.isEmpty) {
                    _weekdays = {_start.weekday};
                  }
                }),
              ),
              if (repeats) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      l10n.schEvery,
                      style: const TextStyle(color: AppColors.text),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 72,
                      child: TextField(
                        controller: _every,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (_) => setState(() {}),
                        decoration: fieldDecoration(
                          error: _everyError == null ? null : '',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        unit,
                        style: const TextStyle(color: AppColors.text),
                      ),
                    ),
                  ],
                ),
                if (_everyError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 2),
                    child: Text(
                      _everyError!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                if (_freq == RepeatFreq.weekly) ...[
                  _label(l10n.schOnDays),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (var d = 1; d <= 7; d++)
                        FilterChip(
                          selected: _weekdays.contains(d),
                          showCheckmark: false,
                          onSelected: (v) => setState(() {
                            if (v) {
                              _weekdays.add(d);
                            } else if (_weekdays.length > 1) {
                              _weekdays.remove(d);
                            }
                          }),
                          label: Text(weekdayNames[d % 7]),
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: _weekdays.contains(d)
                                ? Colors.white
                                : AppColors.text,
                          ),
                        ),
                    ],
                  ),
                ],
                _label(l10n.schEnds),
                DropdownButtonFormField<_Ends>(
                  initialValue: _ends,
                  decoration: fieldDecoration(),
                  items: [
                    DropdownMenuItem(
                      value: _Ends.never,
                      child: Text(l10n.schEndsNever),
                    ),
                    DropdownMenuItem(
                      value: _Ends.onDate,
                      child: Text(l10n.schEndsOn),
                    ),
                    DropdownMenuItem(
                      value: _Ends.afterCount,
                      child: Text(l10n.schEndsAfter),
                    ),
                  ],
                  onChanged: (v) => setState(() => _ends = v ?? _Ends.never),
                ),
                if (_ends == _Ends.onDate) ...[
                  const SizedBox(height: 10),
                  _pickerTile(
                    icon: Icons.event_busy_rounded,
                    text: DateFormat.yMMMd(l10n.localeName).format(_until),
                    onTap: _pickUntil,
                    error: _untilError,
                  ),
                ],
                if (_ends == _Ends.afterCount)
                  AppTextField(
                    controller: _count,
                    label: l10n.schTimes,
                    keyboard: TextInputType.number,
                    error: _countError,
                  ),
              ],
            ]),
            _section([
              _label(l10n.schRemind),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final m in remindChoices)
                    FilterChip(
                      selected: _remind.contains(m),
                      onSelected: (_) => _toggleRemind(m),
                      label: Text(remindLabel(l10n, m, allDay: _allDay)),
                      selectedColor: AppColors.primary.withValues(alpha: 0.15),
                      checkmarkColor: AppColors.primary,
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 2),
                child: Text(
                  l10n.schRemindHelp,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ]),
            _section([
              if (_type != ScheduleType.medicine &&
                  _type != ScheduleType.feeding &&
                  _type != ScheduleType.note)
                AppTextField(
                  controller: _place,
                  label: l10n.schPlace,
                  hint: l10n.schPlaceHint,
                  maxLength: 120,
                ),
              AppTextField(
                controller: _notes,
                label: l10n.schNotes,
                lines: 3,
                maxLength: 1000,
              ),
            ]),
            const SizedBox(height: 4),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.check_rounded),
              label: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
