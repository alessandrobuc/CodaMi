import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:CodaMi/features/support/domain/support_case.dart';
import 'package:CodaMi/features/support/presentation/widgets/support_labels.dart';
import 'package:CodaMi/l10n/app_localizations_en.dart';

void main() {
  final t0 = DateTime(2026, 10, 20, 9);
  Timestamp at(Duration d) => Timestamp.fromDate(t0.add(d));

  test('reads a case and its timings', () {
    final c = SupportCase.fromMap('c1', {
      'reference': 'CM-1042',
      'kind': 'chat',
      'category': 'listing',
      'subject': 'Wrong photo',
      'status': 'waiting_user',
      'userId': 'u1',
      'assignedTo': 's1',
      'assignedName': 'Sam',
      'lastMessageBy': 'staff',
      'responseCount': 2,
      'responseSecondsTotal': 300,
      'handlingSeconds': 600,
      'createdAt': at(Duration.zero),
      'assignedAt': at(const Duration(minutes: 2)),
      'firstResponseAt': at(const Duration(minutes: 3)),
      'workStartedAt': at(const Duration(minutes: 20)),
    });
    expect(c.status, CaseStatus.waitingUser);
    expect(c.category, CaseCategory.listing);
    expect(c.lastMessageByStaff, isTrue);
    expect(c.waitToTakeOver, const Duration(minutes: 2));
    expect(c.firstResponseTime, const Duration(minutes: 3));
    expect(c.averageResponseTime, const Duration(seconds: 150));
    expect(
      c.handlingTime(now: t0.add(const Duration(minutes: 25))),
      const Duration(minutes: 15),
    );
  });

  test('unknown values fall back safely', () {
    final c = SupportCase.fromMap('c2', {'status': 'weird', 'kind': 'call'});
    expect(c.status, CaseStatus.open);
    expect(c.kind, CaseKind.ticket);
    expect(c.isAssigned, isFalse);
    expect(c.averageResponseTime, isNull);
    expect(c.handlingTime(), Duration.zero);
  });

  test('events and stats', () {
    final e = SupportEvent.fromMap('e1', {
      'type': 'status',
      'to': 'resolved',
      'byName': 'Sam',
    });
    expect(e.toStatus, CaseStatus.resolved);
    expect(
      SupportEvent.fromMap('e2', {'type': 'auto_closed'}).type,
      CaseEventType.autoClosed,
    );
    expect(SupportEvent.fromMap('e3', {'type': 'reopened'}).byUser, isTrue);

    final stats = StaffStats.fromMap({
      'responses': 4,
      'responseSecondsTotal': 240,
      'casesResolved': 2,
      'handlingSecondsTotal': 1200,
    });
    expect(stats.averageResponse, const Duration(minutes: 1));
    expect(stats.averageHandling, const Duration(minutes: 10));
    expect(StaffStats.fromMap(null).averageResponse, isNull);
  });

  test('presence goes offline without a heartbeat', () {
    final p = StaffPresence.fromMap({
      'state': 'online',
      'lastSeen': Timestamp.fromDate(t0),
    });
    expect(
      p.current(now: t0.add(const Duration(minutes: 4))),
      PresenceState.online,
    );
    expect(
      p.current(now: t0.add(const Duration(minutes: 6))),
      PresenceState.offline,
    );
    expect(const StaffPresence().current(), PresenceState.offline);
  });

  test('durations read naturally', () {
    final l10n = AppLocalizationsEn();
    expect(formatDuration(l10n, const Duration(seconds: 42)), '42 s');
    expect(formatDuration(l10n, const Duration(minutes: 5)), '5 min');
    expect(formatDuration(l10n, const Duration(minutes: 135)), '2 h 15 min');
    expect(formatDuration(l10n, const Duration(hours: 50)), '2 d 2 h');
    expect(formatDuration(l10n, const Duration(seconds: -5)), '0 s');
  });
}
