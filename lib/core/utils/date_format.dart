import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';

String timeAgo(AppLocalizations l10n, DateTime time, {DateTime? now}) {
  final current = now ?? DateTime.now();
  final diff = current.difference(time);
  if (diff.inMinutes < 1) return l10n.timeJustNow;
  if (diff.inMinutes < 60) return l10n.timeMinutesAgo(diff.inMinutes);
  if (diff.inHours < 24) return l10n.timeHoursAgo(diff.inHours);
  if (diff.inDays == 1) return l10n.timeYesterday;
  if (diff.inDays < 7) return l10n.timeDaysAgo(diff.inDays);
  return shortDate(l10n, time);
}

String shortDate(AppLocalizations l10n, DateTime time) =>
    (time.year == DateTime.now().year
            ? DateFormat.MMMd(l10n.localeName)
            : DateFormat.yMMMd(l10n.localeName))
        .format(time);

String clockTime(AppLocalizations l10n, DateTime time) =>
    DateFormat.Hm(l10n.localeName).format(time);

String dateTimeLabel(AppLocalizations l10n, DateTime time) =>
    '${DateFormat.E(l10n.localeName).format(time)} ${shortDate(l10n, time)}, '
    '${clockTime(l10n, time)}';
