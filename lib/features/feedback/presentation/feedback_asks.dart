import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/locale_provider.dart';
import '../../profile/presentation/providers/profile_provider.dart';
import '../../sharing/domain/sharing.dart';
import '../data/feedback_repository.dart';
import '../domain/feedback.dart';
import 'providers/feedback_provider.dart';
import 'widgets/feedback_sheet.dart';

bool _asking = false;

// Waits until the user is back on the main screens with nothing open.
Future<void> askFeedbackWhenIdle(
  BuildContext context,
  WidgetRef ref,
  FeedbackArea area, {
  required bool Function() isIdle,
}) async {
  for (var i = 0; i < 100; i++) {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!context.mounted) return;
    if (isIdle()) {
      await askFeedback(context, ref, area);
      return;
    }
  }
}

// Checks again, saves that it was asked, then shows the question.
Future<bool> askFeedback(
  BuildContext context,
  WidgetRef ref,
  FeedbackArea area,
) async {
  if (_asking) return false;
  _asking = true;
  try {
    final profile = ref.read(userProfileProvider).value;
    final now = DateTime.now();
    // A share reminder already asked something of the user today.
    if (profile == null || openedShareReminderToday(now)) return false;
    final config = await askConfigOrDefault(
      ref.read(feedbackAskConfigProvider.future),
    );
    final facts = feedbackFactsOf(
      profile,
      config,
      ref.read(sharedPreferencesProvider),
    );
    if (!canAskFeedback(facts, now) || facts.state.asked.contains(area)) {
      return false;
    }
    await ref.read(feedbackRepositoryProvider).markAsked(profile.uid, area);
    if (!context.mounted) return true;
    await showFeedbackSheet(context, area: area, asked: true);
    return true;
  } catch (e) {
    debugPrint('Feedback question skipped: $e');
    return false;
  } finally {
    _asking = false;
  }
}
