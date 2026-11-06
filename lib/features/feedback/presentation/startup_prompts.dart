import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../l10n/locale_provider.dart';
import '../../app_update/presentation/update_widgets.dart';
import '../../points/domain/points.dart';
import '../../points/presentation/providers/points_provider.dart';
import '../../profile/presentation/providers/profile_provider.dart';
import '../../whats_new/data/release_notes_repository.dart';
import '../../whats_new/domain/release_note.dart';
import '../../whats_new/presentation/providers/whats_new_provider.dart';
import '../../whats_new/presentation/screens/whats_new_screen.dart';
import '../../auth/data/models/user_model.dart';
import '../../sharing/domain/sharing.dart';
import '../data/feedback_repository.dart';
import '../domain/feedback.dart';
import '../domain/feedback_rules.dart';
import 'feedback_asks.dart';
import 'providers/feedback_provider.dart';

// Waits so nothing pops up while the user is starting to do something.
const _calmDelay = Duration(seconds: 25);

// At most one of these per app start: the update message, the notes of a
// new version, the general feedback question, or the store rating window.
Future<void> runStartupPrompts(
  BuildContext context,
  WidgetRef ref, {
  required bool Function() isIdle,
}) async {
  try {
    if (await showUpdateIfNeeded(context, ref)) return;
    if (!context.mounted || await _showWhatsNew(context, ref)) return;
    await Future<void>.delayed(_calmDelay);
    if (!context.mounted || !isIdle()) return;
    await _askFeedbackOrReview(context, ref);
  } catch (e) {
    debugPrint('Startup prompts skipped: $e');
  }
}

Future<bool> _showWhatsNew(BuildContext context, WidgetRef ref) async {
  final profile = ref.read(userProfileProvider).value;
  if (profile == null) return false;
  final version = await ref.read(appVersionProvider.future);
  final store = NotesSeenStore(ref.read(sharedPreferencesProvider));
  // Accounts older than a day had the app before this screen existed.
  final seen =
      store.read() ??
      await store.start(
        version,
        updated: DateTime.now().difference(profile.createdAt).inDays >= 1,
      );
  final after = notesToCheckAfter(seen, version);
  if (after == null) return false;
  final notes = await ref
      .read(releaseNotesRepositoryProvider)
      .unseen(afterCode: after, upToCode: versionCode(version))
      .timeout(const Duration(seconds: 10));
  final unseen = unseenNotes(notes, version, seen);
  if (unseen.isEmpty || !context.mounted) return false;
  await store.markShown(unseen.map((n) => n.version));
  if (!context.mounted) return true;
  await Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => WhatsNewScreen(notes: unseen),
    ),
  );
  return true;
}

Future<void> _askFeedbackOrReview(BuildContext context, WidgetRef ref) async {
  final profile = ref.read(userProfileProvider).value;
  final now = DateTime.now();
  // A share reminder already asked something of the user today.
  if (profile == null ||
      profile.role != UserRole.user ||
      openedShareReminderToday(now)) {
    return;
  }
  final prefs = ref.read(sharedPreferencesProvider);
  final askConfig = await askConfigOrDefault(
    ref.read(feedbackAskConfigProvider.future),
  );
  final facts = feedbackFactsOf(profile, askConfig, prefs);
  if (shouldAskGeneral(facts, now, Random().nextDouble())) {
    if (context.mounted) await askFeedback(context, ref, FeedbackArea.general);
    return;
  }

  final config = await ref
      .read(pointsConfigProvider.future)
      .timeout(
        const Duration(seconds: 10),
        onTimeout: () => const PointsConfig(),
      );
  final store = PromptHistoryStore(prefs, profile.uid);
  final usage = UsageFacts(
    joinedAt: profile.createdAt,
    activeDays: profile.activeDays,
  );
  final history = store.read(feedbackAskedAt: profile.feedbackAsk.lastAt);
  if (shouldAskReview(
    usage,
    history,
    config,
    now,
    pauseDays: askConfig.pauseDays,
  )) {
    final review = InAppReview.instance;
    if (!await review.isAvailable()) return;
    await store.reviewAsked(now);
    await review.requestReview();
  }
}
