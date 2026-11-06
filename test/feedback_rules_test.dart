import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CodaMi/features/auth/data/models/user_model.dart';
import 'package:CodaMi/features/feedback/domain/feedback.dart';
import 'package:CodaMi/features/feedback/domain/feedback_rules.dart';
import 'package:CodaMi/features/points/domain/points.dart';

void main() {
  final now = DateTime(2026, 11, 6, 12);
  const config = FeedbackAskConfig();

  FeedbackAskFacts facts({
    int days = 20,
    int active = 12,
    FeedbackAskState state = const FeedbackAskState(),
    FeedbackAskConfig c = config,
    DateTime? reviewAskedAt,
  }) => FeedbackAskFacts(
    uid: 'user-1',
    joinedAt: now.subtract(Duration(days: days)),
    activeDays: active,
    state: state,
    config: c,
    reviewAskedAt: reviewAskedAt,
  );

  group('settings', () {
    test('fall back to the agreed numbers', () {
      final c = FeedbackAskConfig.fromMap(null);
      expect(
        [c.enabled, c.usesMin, c.usesMax, c.pauseDays, c.maxAsks],
        [true, 10, 20, 14, 4],
      );
    });

    test('wrong numbers are ignored', () {
      final c = FeedbackAskConfig.fromMap({
        'enabled': false,
        'usesMin': 15,
        'usesMax': 12,
        'pauseDays': 1,
        'maxAsks': 99,
      });
      expect(c.enabled, isFalse);
      expect(c.usesMin, 15);
      expect(c.usesMax, 20, reason: '"to" below "from" keeps the default');
      expect(c.pauseDays, 14);
      expect(c.maxAsks, 4);
    });
  });

  group('uses needed', () {
    test('always inside the range and the same every time', () {
      for (final area in FeedbackArea.values) {
        for (final uid in ['a', 'user-1', 'xYz123', 'Fe9sQ2']) {
          final n = usesNeeded(uid, area, config);
          expect(n, inInclusiveRange(10, 20));
          expect(usesNeeded(uid, area, config), n);
        }
      }
      const fixed = FeedbackAskConfig(usesMin: 7, usesMax: 7);
      expect(usesNeeded('anyone', FeedbackArea.map, fixed), 7);
    });

    test('differ between users and parts of the app', () {
      final numbers = {
        for (var i = 0; i < 40; i++)
          usesNeeded('user-$i', FeedbackArea.map, config),
      };
      expect(numbers.length, greaterThan(3));
    });
  });

  group('asking about a part of the app', () {
    final needed = usesNeeded('user-1', FeedbackArea.map, config);

    test('only after enough uses', () {
      expect(
        shouldAskAbout(FeedbackArea.map, needed - 1, facts(), now),
        isFalse,
      );
      expect(shouldAskAbout(FeedbackArea.map, needed, facts(), now), isTrue);
    });

    test('once per part of the app', () {
      final asked = facts(
        state: FeedbackAskState(
          lastAt: now.subtract(const Duration(days: 40)),
          count: 1,
          asked: const {FeedbackArea.map},
        ),
      );
      expect(shouldAskAbout(FeedbackArea.map, 99, asked, now), isFalse);
      expect(shouldAskAbout(FeedbackArea.shop, 99, asked, now), isTrue);
    });

    test('never in the first days, during the pause, or after the limit', () {
      expect(
        shouldAskAbout(FeedbackArea.map, 99, facts(days: 2), now),
        isFalse,
      );
      final recent = facts(
        state: FeedbackAskState(lastAt: now.subtract(const Duration(days: 13))),
      );
      expect(shouldAskAbout(FeedbackArea.map, 99, recent, now), isFalse);
      final paused = facts(
        state: FeedbackAskState(lastAt: now.subtract(const Duration(days: 14))),
      );
      expect(shouldAskAbout(FeedbackArea.map, 99, paused, now), isTrue);
      final many = facts(state: const FeedbackAskState(count: 4));
      expect(shouldAskAbout(FeedbackArea.map, 99, many, now), isFalse);
    });

    test('the store window also starts the pause', () {
      final rated = facts(reviewAskedAt: now.subtract(const Duration(days: 3)));
      expect(shouldAskAbout(FeedbackArea.map, 99, rated, now), isFalse);
    });

    test('never after "don\'t ask again" or when switched off', () {
      final optOut = facts(state: const FeedbackAskState(optOut: true));
      expect(shouldAskAbout(FeedbackArea.map, 99, optOut, now), isFalse);
      final off = facts(c: const FeedbackAskConfig(enabled: false));
      expect(shouldAskAbout(FeedbackArea.map, 99, off, now), isFalse);
    });
  });

  group('general question', () {
    test('only for regular users, on some app starts, once', () {
      expect(shouldAskGeneral(facts(), now, 0.1), isTrue);
      expect(shouldAskGeneral(facts(), now, 0.9), isFalse);
      expect(shouldAskGeneral(facts(active: 4), now, 0.1), isFalse);
      final asked = facts(
        state: const FeedbackAskState(asked: {FeedbackArea.general}),
      );
      expect(shouldAskGeneral(asked, now, 0.1), isFalse);
    });
  });

  group('store rating window', () {
    const points = PointsConfig();
    final usage = UsageFacts(
      joinedAt: now.subtract(const Duration(days: 20)),
      activeDays: 6,
    );

    test('waits for its own days', () {
      expect(
        shouldAskReview(
          usage,
          const PromptHistory(),
          points,
          now,
          pauseDays: 14,
        ),
        isTrue,
      );
      final young = UsageFacts(
        joinedAt: now.subtract(const Duration(days: 8)),
        activeDays: 6,
      );
      expect(
        shouldAskReview(
          young,
          const PromptHistory(),
          points,
          now,
          pauseDays: 14,
        ),
        isFalse,
      );
      final rated = PromptHistory(
        reviewAskedAt: now.subtract(const Duration(days: 60)),
      );
      expect(
        shouldAskReview(usage, rated, points, now, pauseDays: 14),
        isFalse,
      );
    });

    test('never within the pause after our own question', () {
      final asked = PromptHistory(
        feedbackAskedAt: now.subtract(const Duration(days: 10)),
      );
      expect(
        shouldAskReview(usage, asked, points, now, pauseDays: 14),
        isFalse,
      );
      final earlier = PromptHistory(
        feedbackAskedAt: now.subtract(const Duration(days: 15)),
      );
      expect(
        shouldAskReview(usage, earlier, points, now, pauseDays: 14),
        isTrue,
      );
    });
  });

  group('saved data', () {
    test('the ask state is read from the account', () {
      final user = UserModel.fromMap({
        'uid': 'u1',
        'feedbackAsk': {
          'lastAt': Timestamp.fromDate(DateTime(2026, 11, 1)),
          'count': 2,
          'asked': ['map', 'shop', 'unknown'],
          'optOut': true,
        },
      });
      final s = user.feedbackAsk;
      expect(s.lastAt, DateTime(2026, 11, 1));
      expect(s.count, 2);
      expect(s.asked, {FeedbackArea.map, FeedbackArea.shop});
      expect(s.optOut, isTrue);
      expect(UserModel.fromMap({'uid': 'u2'}).feedbackAsk.count, 0);
    });

    test('feedback entries keep old ones readable', () {
      final old = FeedbackEntry.fromMap('a', {
        'uid': 'u1',
        'rating': 4,
        'comment': 'Nice',
      });
      expect(old.type, FeedbackType.general);
      expect(old.area, FeedbackArea.general);
      expect(old.status, FeedbackStatus.open);
      final full = FeedbackEntry.fromMap('b', {
        'uid': 'u1',
        'type': 'bug',
        'area': 'map',
        'rating': 0,
        'status': 'in_progress',
        'screenshotPath': 'feedback/u1/1.jpg',
        'thankedAt': Timestamp.now(),
      });
      expect(full.type, FeedbackType.bug);
      expect(full.area, FeedbackArea.map);
      expect(full.status, FeedbackStatus.progress);
      expect(full.screenshotPath, 'feedback/u1/1.jpg');
      expect(full.thanked, isTrue);
    });

    test('stars or a few words are needed', () {
      expect(feedbackReady(0, ''), isFalse);
      expect(feedbackReady(0, ' ok '), isFalse);
      expect(feedbackReady(0, 'Add dark mode'), isTrue);
      expect(feedbackReady(3, ''), isTrue);
    });
  });

  test('overview counts the last 30 days, weakest part first', () {
    FeedbackEntry e(FeedbackType t, FeedbackArea a, int stars, int daysAgo) =>
        FeedbackEntry(
          id: '$t$a$stars$daysAgo',
          uid: 'u',
          type: t,
          area: a,
          rating: stars,
          createdAt: now.subtract(Duration(days: daysAgo)),
        );
    final o = overviewOf([
      e(FeedbackType.bug, FeedbackArea.map, 2, 1),
      e(FeedbackType.bug, FeedbackArea.map, 4, 2),
      e(FeedbackType.suggestion, FeedbackArea.shop, 5, 3),
      e(FeedbackType.problem, FeedbackArea.shop, 0, 4),
      e(FeedbackType.bug, FeedbackArea.walks, 1, 40),
    ], now);
    expect(o.total, 4);
    expect(o.byType[FeedbackType.bug], 2);
    expect(o.byType[FeedbackType.suggestion], 1);
    expect(o.starsByArea.map((s) => s.area), [
      FeedbackArea.map,
      FeedbackArea.shop,
    ]);
    expect(o.starsByArea.first.average, 3);
    expect(o.starsByArea.last.count, 1, reason: 'no stars is not a rating');
  });
}
