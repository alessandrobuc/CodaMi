import '../../points/domain/points.dart';

const feedbackAskEveryDays = 30;
const feedbackMaxAsks = 3;
// The store window never comes right after our own question (store rule).
const reviewGapAfterFeedback = Duration(days: 1);

class PromptHistory {
  final DateTime? feedbackAskedAt;
  final int feedbackAsks;
  final DateTime? reviewAskedAt;

  const PromptHistory({
    this.feedbackAskedAt,
    this.feedbackAsks = 0,
    this.reviewAskedAt,
  });
}

class UsageFacts {
  final DateTime joinedAt;
  final int activeDays;
  final bool feedbackSent;

  const UsageFacts({
    required this.joinedAt,
    required this.activeDays,
    required this.feedbackSent,
  });
}

bool _daysSince(DateTime? time, DateTime now, int days) =>
    time == null || now.difference(time).inDays >= days;

bool shouldAskFeedback(
  UsageFacts usage,
  PromptHistory history,
  PointsConfig config,
  DateTime now,
) =>
    !usage.feedbackSent &&
    now.difference(usage.joinedAt).inDays >= config.feedbackAfterDays &&
    usage.activeDays >= config.reviewMinActiveDays &&
    history.feedbackAsks < feedbackMaxAsks &&
    _daysSince(history.feedbackAskedAt, now, feedbackAskEveryDays);

bool shouldAskReview(
  UsageFacts usage,
  PromptHistory history,
  PointsConfig config,
  DateTime now,
) =>
    now.difference(usage.joinedAt).inDays >= config.reviewAfterDays &&
    usage.activeDays >= config.reviewMinActiveDays &&
    _daysSince(history.reviewAskedAt, now, config.reviewEveryDays) &&
    (history.feedbackAskedAt == null ||
        now.difference(history.feedbackAskedAt!) >= reviewGapAfterFeedback);
