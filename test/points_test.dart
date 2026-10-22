import 'package:CodaMi/features/points/domain/points.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('days follow Italian time, including summer time', () {
    // Winter: UTC+1.
    expect(romeDayKey(DateTime.utc(2026, 1, 10, 22, 59)), '2026-01-10');
    expect(romeDayKey(DateTime.utc(2026, 1, 10, 23, 0)), '2026-01-11');
    // Summer: UTC+2.
    expect(romeDayKey(DateTime.utc(2026, 7, 10, 21, 59)), '2026-07-10');
    expect(romeDayKey(DateTime.utc(2026, 7, 10, 22, 0)), '2026-07-11');
    // Summer time ends on the last Sunday of October 2026 (the 25th) at 01:00 UTC.
    expect(romeDayKey(DateTime.utc(2026, 10, 24, 22, 30)), '2026-10-25');
    expect(romeDayKey(DateTime.utc(2026, 10, 25, 22, 30)), '2026-10-25');
  });

  test('points config reads overrides and keeps defaults', () {
    final config = PointsConfig.fromMap({
      'dailyCheckin': 8,
      'levels': {
        'ambassador': {'minFriends': 3, 'bonus': 40},
      },
    });
    expect(config.dailyCheckin, 8);
    expect(config.dailyActive, 10);
    expect(config.pointsFor(DailyTask.checkin), 8);
    final ambassador = config.levels.firstWhere(
      (l) => l.level == AmbassadorLevel.ambassador,
    );
    expect(ambassador.minFriends, 3);
    expect(ambassador.bonus, 40);
    expect(config.nextLevel(0)?.level, AmbassadorLevel.supporter);
    expect(config.nextLevel(1)?.level, AmbassadorLevel.ambassador);
    expect(config.nextLevel(30), isNull);
    expect(PointsConfig.fromMap(config.toMap()).toMap(), config.toMap());
  });

  test('daily state knows what was claimed today and the live streak', () {
    final state = DailyState.fromMap({
      'day': '2026-10-22',
      'claimed': ['checkin', 'unknown'],
      'streak': 4,
      'streakDay': '2026-10-22',
    });
    expect(state.claimed, {DailyTask.checkin});
    expect(state.claimedToday(DailyTask.checkin, '2026-10-22'), isTrue);
    expect(state.claimedToday(DailyTask.active, '2026-10-22'), isFalse);
    expect(state.claimedToday(DailyTask.checkin, '2026-10-23'), isFalse);
    expect(state.currentStreak('2026-10-23', '2026-10-22'), 4);
    expect(state.currentStreak('2026-10-25', '2026-10-24'), 0);
    expect(DailyState.fromMap(null).streak, 0);
  });

  test('referrals and levels read the server values', () {
    final r = Referral.fromMap('u2', {
      'inviterId': 'u1',
      'inviteeName': 'Fede',
      'status': 'review',
      'flags': ['same_device_as_inviter'],
    });
    expect(r.status, ReferralStatus.review);
    expect(r.flags, ['same_device_as_inviter']);
    expect(ReferralStatus.fromValue('nope'), ReferralStatus.pending);
    expect(
      AmbassadorLevel.fromValue('super_ambassador'),
      AmbassadorLevel.superAmbassador,
    );
    expect(AmbassadorLevel.fromValue(null), isNull);
  });
}
