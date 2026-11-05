import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/schedule.dart';

const scheduleColor = AppColors.primary;

extension ScheduleTypeView on ScheduleType {
  IconData get icon => switch (this) {
    ScheduleType.vet => Icons.local_hospital_rounded,
    ScheduleType.vaccine => Icons.vaccines_rounded,
    ScheduleType.medicine => Icons.medication_rounded,
    ScheduleType.grooming => Icons.content_cut_rounded,
    ScheduleType.feeding => Icons.restaurant_rounded,
    ScheduleType.walk => Icons.directions_walk_rounded,
    ScheduleType.note => Icons.sticky_note_2_rounded,
    ScheduleType.other => Icons.event_rounded,
  };

  Color get color => switch (this) {
    ScheduleType.vet => AppColors.danger,
    ScheduleType.vaccine => AppColors.primaryDark,
    ScheduleType.medicine => AppColors.rewardText,
    ScheduleType.grooming => AppColors.lostPin,
    ScheduleType.feeding => AppColors.accent,
    ScheduleType.walk => AppColors.primary,
    ScheduleType.note || ScheduleType.other => AppColors.textMuted,
  };

  String label(AppLocalizations l10n) => switch (this) {
    ScheduleType.vet => l10n.schTypeVet,
    ScheduleType.vaccine => l10n.schTypeVaccine,
    ScheduleType.medicine => l10n.schTypeMedicine,
    ScheduleType.grooming => l10n.schTypeGrooming,
    ScheduleType.feeding => l10n.schTypeFeeding,
    ScheduleType.walk => l10n.schTypeWalk,
    ScheduleType.note => l10n.schTypeNote,
    ScheduleType.other => l10n.schTypeOther,
  };
}

String eventTitle(AppLocalizations l10n, ScheduleEvent e) =>
    e.title.trim().isEmpty ? e.type.label(l10n) : e.title.trim();

String scheduleTime(AppLocalizations l10n, DateTime at) =>
    DateFormat.jm(l10n.localeName).format(at);

String scheduleDate(AppLocalizations l10n, DateTime day) =>
    DateFormat.MMMEd(l10n.localeName).format(day);

String dayHeading(AppLocalizations l10n, DateTime day, DateTime now) {
  final today = toDay(now);
  final d = toDay(day);
  if (d == today) return l10n.schToday;
  if (d == today.add(const Duration(days: 1))) return l10n.schTomorrow;
  return DateFormat.MMMMEEEEd(l10n.localeName).format(d);
}

// "Tomorrow · 10:30", "Today · All day", "Mon 9 Nov · 10:30".
String whenText(AppLocalizations l10n, Occurrence o, DateTime now) {
  final day = dayHeading(l10n, o.day, now);
  final time = o.event.allDay ? l10n.schAllDay : scheduleTime(l10n, o.at);
  return '$day · $time';
}

String remindLabel(
  AppLocalizations l10n,
  int minutes, {
  required bool allDay,
}) => switch (minutes) {
  0 => allDay ? l10n.schRemindAllDay : l10n.schRemindAtTime,
  15 => l10n.schRemind15,
  60 => l10n.schRemind60,
  1440 => l10n.schRemindDay,
  _ => l10n.schRemindWeek,
};

String repeatText(AppLocalizations l10n, ScheduleRepeat r) {
  final every = switch (r.freq) {
    RepeatFreq.none => l10n.schRepeatNone,
    RepeatFreq.daily => l10n.schEveryDays(r.every),
    RepeatFreq.weekly => l10n.schEveryWeeks(r.every),
    RepeatFreq.monthly => l10n.schEveryMonths(r.every),
    RepeatFreq.yearly => l10n.schEveryYears(r.every),
  };
  final parts = [every];
  if (r.freq == RepeatFreq.weekly && r.weekdays.isNotEmpty) {
    final names = DateFormat(null, l10n.localeName).dateSymbols.SHORTWEEKDAYS;
    parts.add(
      [for (final d in r.weekdays.toList()..sort()) names[d % 7]].join(', '),
    );
  }
  if (r.until != null) {
    parts.add(
      l10n.schUntil(DateFormat.yMMMd(l10n.localeName).format(r.until!)),
    );
  }
  if (r.count != null) parts.add(l10n.schTimesCount(r.count!));
  return parts.join(' · ');
}

// The push text, written on the phone in the user's language.
ReminderText reminderText(AppLocalizations l10n) => (e, day, minutes) {
  final title = [
    eventTitle(l10n, e),
    if (e.petNames.isNotEmpty) e.petNames.join(', '),
  ].join(' · ');
  final when = switch (minutes) {
    0 => e.allDay ? l10n.schToday : l10n.schWhenNow,
    15 => l10n.schWhenInMinutes(15),
    60 => l10n.schWhenInHour,
    1440 => l10n.schTomorrow,
    _ => l10n.schWhenOn(DateFormat.MMMMEEEEd(l10n.localeName).format(day)),
  };
  final body = [
    when,
    if (!e.allDay) scheduleTime(l10n, e.at(day)),
    if (e.detail.trim().isNotEmpty) e.detail.trim(),
    if (e.place.trim().isNotEmpty) e.place.trim(),
  ].join(' · ');
  return (
    title: title.length <= 120 ? title : title.substring(0, 120),
    body: body.length <= 200 ? body : body.substring(0, 200),
  );
};

class ScheduleTypeIcon extends StatelessWidget {
  final ScheduleType type;
  final double size;

  const ScheduleTypeIcon(this.type, {super.key, this.size = 40});

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: type.color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(size * 0.32),
    ),
    child: Icon(type.icon, color: type.color, size: size * 0.52),
  );
}

class ScheduleCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? tint;
  final EdgeInsets padding;

  const ScheduleCard({
    super.key,
    required this.child,
    this.onTap,
    this.tint,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) => Material(
    color: tint?.withValues(alpha: 0.07) ?? AppColors.surface,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: tint?.withValues(alpha: 0.25) ?? AppColors.border,
      ),
    ),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: SizedBox(width: double.infinity, child: child),
      ),
    ),
  );
}

// One event on one day, as a list row.
class OccurrenceTile extends StatelessWidget {
  final Occurrence occurrence;
  final DateTime now;
  final VoidCallback onTap;
  final ValueChanged<bool>? onDone;
  final bool showDay;

  const OccurrenceTile({
    super.key,
    required this.occurrence,
    required this.now,
    required this.onTap,
    this.onDone,
    this.showDay = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final e = occurrence.event;
    final done = occurrence.done;
    final sub = [
      if (showDay)
        whenText(l10n, occurrence, now)
      else
        e.allDay ? l10n.schAllDay : scheduleTime(l10n, occurrence.at),
      if (e.petNames.isNotEmpty) e.petNames.join(', '),
      if (e.repeat.repeats) '↻',
    ].join(' · ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ScheduleCard(
        onTap: onTap,
        padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
        child: Row(
          children: [
            ScheduleTypeIcon(e.type),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventTitle(l10n, e),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: done ? AppColors.textMuted : AppColors.text,
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sub,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (onDone != null)
              IconButton(
                tooltip: done ? l10n.schUndoDone : l10n.schMarkDone,
                onPressed: () => onDone!(!done),
                icon: Icon(
                  done
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: done ? AppColors.primary : AppColors.textMuted,
                ),
              )
            else
              const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class ScheduleSectionTitle extends StatelessWidget {
  final String text;
  final Widget? trailing;

  const ScheduleSectionTitle(this.text, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
    child: Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
        ),
        ?trailing,
      ],
    ),
  );
}
