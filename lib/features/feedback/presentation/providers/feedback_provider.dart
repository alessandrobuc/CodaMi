import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/locale_provider.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/feedback_repository.dart';
import '../../domain/feedback.dart';

final feedbackAskConfigProvider = StreamProvider<FeedbackAskConfig>(
  (ref) => ref.watch(feedbackRepositoryProvider).watchAskConfig(),
);

Future<FeedbackAskConfig> askConfigOrDefault(
  Future<FeedbackAskConfig> pending,
) => pending.timeout(
  const Duration(seconds: 8),
  onTimeout: () => const FeedbackAskConfig(),
);

FeedbackAskFacts feedbackFactsOf(
  UserModel profile,
  FeedbackAskConfig config,
  SharedPreferences prefs,
) => FeedbackAskFacts(
  uid: profile.uid,
  joinedAt: profile.createdAt,
  activeDays: profile.activeDays,
  state: profile.feedbackAsk,
  config: config,
  reviewAskedAt: PromptHistoryStore(prefs, profile.uid).reviewAskedAt,
);

// The part of the app the user should be asked about once they are free.
class PendingFeedbackAsk extends Notifier<FeedbackArea?> {
  @override
  FeedbackArea? build() => null;

  void ask(FeedbackArea area) => state ??= area;

  void clear() => state = null;
}

final pendingFeedbackAskProvider =
    NotifierProvider<PendingFeedbackAsk, FeedbackArea?>(PendingFeedbackAsk.new);

class FeedbackTracker {
  final Ref _ref;

  FeedbackTracker(this._ref);

  Future<void> used(FeedbackArea area) async {
    try {
      final profile = _ref.read(userProfileProvider).value;
      if (profile == null || profile.role != UserRole.user) return;
      final prefs = _ref.read(sharedPreferencesProvider);
      final uses = await FeedbackUsage(prefs, profile.uid).add(area);
      final config = await askConfigOrDefault(
        _ref.read(feedbackAskConfigProvider.future),
      );
      final facts = feedbackFactsOf(profile, config, prefs);
      if (shouldAskAbout(area, uses, facts, DateTime.now())) {
        _ref.read(pendingFeedbackAskProvider.notifier).ask(area);
      }
    } catch (e) {
      debugPrint('Feedback use not counted: $e');
    }
  }
}

final feedbackTrackerProvider = Provider(FeedbackTracker.new);
