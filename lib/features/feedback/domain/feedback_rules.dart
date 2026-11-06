import '../../points/domain/points.dart';

class PromptHistory {
  final DateTime? feedbackAskedAt;
  final DateTime? reviewAskedAt;

  const PromptHistory({this.feedbackAskedAt, this.reviewAskedAt});
}

class UsageFacts {
  final DateTime joinedAt;
  final int activeDays;

  const UsageFacts({required this.joinedAt, required this.activeDays});
}

// Google's own rating window. It never follows our feedback question within
// the pause, and nothing in the app asks the user's opinion before it.
bool shouldAskReview(
  UsageFacts usage,
  PromptHistory history,
  PointsConfig config,
  DateTime now, {
  required int pauseDays,
}) =>
    now.difference(usage.joinedAt).inDays >= config.reviewAfterDays &&
    usage.activeDays >= config.reviewMinActiveDays &&
    (history.reviewAskedAt == null ||
        now.difference(history.reviewAskedAt!).inDays >=
            config.reviewEveryDays) &&
    (history.feedbackAskedAt == null ||
        now.difference(history.feedbackAskedAt!).inDays >= pauseDays);
