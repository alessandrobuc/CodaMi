import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/heat.dart';

const heatColor = Color(0xFFC0397A);

String heatDate(AppLocalizations l10n, DateTime d) =>
    DateFormat.yMMMd(l10n.localeName).format(d);

String heatShortDate(AppLocalizations l10n, DateTime d) =>
    DateFormat.MMMd(l10n.localeName).format(d);

String heatRange(AppLocalizations l10n, DateTime a, DateTime b) =>
    '${heatShortDate(l10n, a)} – ${heatShortDate(l10n, b)}';

class HeatCard extends StatelessWidget {
  final Widget child;
  final Color? tint;

  const HeatCard({super.key, required this.child, this.tint});

  @override
  Widget build(BuildContext context) {
    // A Material, so list rows inside show their tap ripple.
    return Material(
      color: tint?.withValues(alpha: 0.07) ?? AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: tint?.withValues(alpha: 0.25) ?? AppColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}

class HeatTitle extends StatelessWidget {
  final String text;

  const HeatTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: AppColors.text,
        ),
      ),
    );
  }
}

// One month: recorded heat days in full colour, expected ones lighter.
class HeatMonthCalendar extends StatefulWidget {
  final List<HeatCycle> cycles;
  final HeatEstimate estimate;
  final DateTime today;

  const HeatMonthCalendar({
    super.key,
    required this.cycles,
    required this.estimate,
    required this.today,
  });

  @override
  State<HeatMonthCalendar> createState() => _HeatMonthCalendarState();
}

class _HeatMonthCalendarState extends State<HeatMonthCalendar> {
  late DateTime _month = DateTime.utc(widget.today.year, widget.today.month);

  void _move(int months) =>
      setState(() => _month = DateTime.utc(_month.year, _month.month + months));

  bool _recorded(DateTime day) {
    for (final c in widget.cycles) {
      final end =
          c.end ??
          (c.start.isAfter(widget.today)
              ? c.start
              : (widget.estimate.current?.id == c.id
                    ? widget.today
                    : c.start.add(
                        Duration(days: widget.estimate.heatDays - 1),
                      )));
      if (!day.isBefore(c.start) && !day.isAfter(end)) return true;
    }
    return false;
  }

  bool _expected(DateTime day) =>
      widget.estimate.upcoming.any((p) => p.contains(day));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final material = MaterialLocalizations.of(context);
    final first = material.firstDayOfWeekIndex;
    final names = [
      for (var i = 0; i < 7; i++) material.narrowWeekdays[(first + i) % 7],
    ];
    final offset = (_month.weekday % 7 - first) % 7;
    final daysInMonth = DateTime.utc(_month.year, _month.month + 1, 0).day;
    final cells = offset + daysInMonth;

    Widget cell(int index) {
      final dayNumber = index - offset + 1;
      if (dayNumber < 1 || dayNumber > daysInMonth) return const SizedBox();
      final day = DateTime.utc(_month.year, _month.month, dayNumber);
      final recorded = _recorded(day);
      final expected = !recorded && _expected(day);
      final isToday = day == widget.today;
      return Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: recorded
                ? heatColor
                : expected
                ? heatColor.withValues(alpha: 0.16)
                : null,
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: AppColors.text, width: 1.5)
                : null,
          ),
          child: Text(
            '$dayNumber',
            style: TextStyle(
              fontSize: 13,
              fontWeight: isToday || recorded
                  ? FontWeight.w800
                  : FontWeight.w500,
              color: recorded
                  ? Colors.white
                  : expected
                  ? heatColor
                  : AppColors.text,
            ),
          ),
        ),
      );
    }

    Widget legend(Color fill, String text, {bool ring = false}) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: ring ? null : fill,
            shape: BoxShape.circle,
            border: ring ? Border.all(color: fill, width: 1.5) : null,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ),
      ],
    );

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => _move(-1),
              icon: const Icon(Icons.chevron_left_rounded),
              tooltip: material.previousMonthTooltip,
            ),
            Expanded(
              child: Text(
                material.formatMonthYear(_month),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
            ),
            IconButton(
              onPressed: () => _move(1),
              icon: const Icon(Icons.chevron_right_rounded),
              tooltip: material.nextMonthTooltip,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            for (final n in names)
              Expanded(
                child: Text(
                  n,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemCount: (cells / 7).ceil() * 7,
          itemBuilder: (_, i) => cell(i),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: [
            legend(heatColor, l10n.heatLegendRecorded),
            legend(heatColor.withValues(alpha: 0.3), l10n.heatLegendEstimated),
            legend(AppColors.text, l10n.heatLegendToday, ring: true),
          ],
        ),
      ],
    );
  }
}
