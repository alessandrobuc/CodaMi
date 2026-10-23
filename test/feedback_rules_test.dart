import 'package:flutter_test/flutter_test.dart';
import 'package:CodaMi/features/feedback/domain/feedback_rules.dart';
import 'package:CodaMi/features/points/domain/points.dart';

void main() {
  const config = PointsConfig();
  final now = DateTime(2026, 10, 23, 12);
  UsageFacts usage({int days = 20, int active = 6, bool sent = false}) =>
      UsageFacts(
        joinedAt: now.subtract(Duration(days: days)),
        activeDays: active,
        feedbackSent: sent,
      );

  test('feedback is not asked right after sign-up or before real use', () {
    const none = PromptHistory();
    expect(shouldAskFeedback(usage(), none, config, now), isTrue);
    expect(shouldAskFeedback(usage(days: 2), none, config, now), isFalse);
    expect(shouldAskFeedback(usage(active: 2), none, config, now), isFalse);
    expect(shouldAskFeedback(usage(sent: true), none, config, now), isFalse);
  });

  test('feedback is asked at most every 30 days and 3 times', () {
    final recent = PromptHistory(
      feedbackAskedAt: now.subtract(const Duration(days: 10)),
      feedbackAsks: 1,
    );
    final old = PromptHistory(
      feedbackAskedAt: now.subtract(const Duration(days: 40)),
      feedbackAsks: 1,
    );
    final many = PromptHistory(
      feedbackAskedAt: now.subtract(const Duration(days: 40)),
      feedbackAsks: 3,
    );
    expect(shouldAskFeedback(usage(), recent, config, now), isFalse);
    expect(shouldAskFeedback(usage(), old, config, now), isTrue);
    expect(shouldAskFeedback(usage(), many, config, now), isFalse);
  });

  test('the store window waits for its own days and never follows feedback', () {
    const none = PromptHistory();
    expect(shouldAskReview(usage(), none, config, now), isTrue);
    expect(shouldAskReview(usage(days: 8), none, config, now), isFalse);
    final justAsked = PromptHistory(
      feedbackAskedAt: now.subtract(const Duration(hours: 2)),
    );
    expect(shouldAskReview(usage(), justAsked, config, now), isFalse);
    final reviewed = PromptHistory(
      reviewAskedAt: now.subtract(const Duration(days: 60)),
    );
    expect(shouldAskReview(usage(), reviewed, config, now), isFalse);
  });
}
