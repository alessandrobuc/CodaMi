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

  test('invites are grouped as active, inactive or waiting', () {
    expect(ReferralStatus.qualified.bucket, InviteBucket.active);
    expect(ReferralStatus.expired.bucket, InviteBucket.inactive);
    expect(ReferralStatus.rejected.bucket, InviteBucket.inactive);
    expect(ReferralStatus.pending.bucket, InviteBucket.waiting);
    expect(ReferralStatus.review.bucket, InviteBucket.waiting);

    Referral r(ReferralStatus status) => Referral(
      inviteeId: status.name,
      inviterId: 'me',
      inviteeName: '',
      status: status,
    );
    final counts = InviteCounts.ofReferrals([
      for (final s in ReferralStatus.values) r(s),
      r(ReferralStatus.qualified),
    ]);
    expect(counts.joined, 6);
    expect(counts.active, 2);
    expect(counts.inactive, 2);
    expect(counts.waiting, 2);
  });

  test('admin invite stats and ranking read the server answer', () {
    final stats = InviteStats.fromMap({
      'code': 'QWE789',
      'stillUsingDays': 30,
      'counts': {'qrOpens': 12, 'linkOpens': 4, 'joined': 3, 'active': 2},
      'friends': [
        {
          'inviteeId': 'f1',
          'name': 'Anna',
          'status': 'qualified',
          'createdAt': DateTime.utc(2026, 11, 1).millisecondsSinceEpoch,
          'lastActiveDay': '2026-11-03',
          'stillUsing': true,
        },
        {'inviteeId': 'f2', 'status': 'odd', 'lastActiveDay': null},
      ],
    });
    expect(stats.code, 'QWE789');
    expect(stats.counts.qrOpens, 12);
    expect(stats.counts.inactive, 0);
    expect(stats.friends.first.status, ReferralStatus.qualified);
    expect(stats.friends.first.lastActiveDay, DateTime(2026, 11, 3));
    expect(stats.friends.first.stillUsing, isTrue);
    expect(stats.friends.last.status, ReferralStatus.pending);
    expect(stats.friends.last.lastActiveDay, isNull);
    expect(stats.friends.last.createdAt, isNull);

    final ranking = InviteRanking.fromMap({
      'totals': {'joined': 9, 'stillUsing': 4},
      'inviters': 2,
      'stillUsingDays': 30,
      'rows': [
        {
          'uid': 'u1',
          'name': 'Marco',
          'email': 'm@x.it',
          'active': 5,
          'qrOpens': 7,
        },
      ],
    });
    expect(ranking.totals.joined, 9);
    expect(ranking.inviters, 2);
    expect(ranking.rows.single.counts.active, 5);
    expect(ranking.rows.single.counts.qrOpens, 7);
    expect(ranking.rows.single.code, isNull);
    expect(InviteRanking.fromMap(null).rows, isEmpty);
  });

  test('periods use plain day keys and the still-using days are saved', () {
    expect(dayKeyOf(DateTime(2026, 3, 7)), '2026-03-07');
    expect(dayKeyOf(DateTime(2026, 11, 0)), '2026-10-31');
    expect(const PointsConfig().stillUsingDays, 30);
    expect(PointsConfig.fromMap({'stillUsingDays': 14}).stillUsingDays, 14);
    expect(const PointsConfig().toMap()['stillUsingDays'], 30);
  });
}
