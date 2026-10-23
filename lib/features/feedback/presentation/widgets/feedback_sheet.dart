import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../points/data/points_repository.dart';
import '../../../points/domain/points.dart';
import '../../../points/presentation/providers/points_provider.dart';
import '../../../points/presentation/widgets/points_widgets.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../whats_new/presentation/providers/whats_new_provider.dart';

Future<void> showFeedbackSheet(BuildContext context) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: AppColors.surface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
  ),
  builder: (_) => const _FeedbackSheet(),
);

class _FeedbackSheet extends ConsumerStatefulWidget {
  const _FeedbackSheet();

  @override
  ConsumerState<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends ConsumerState<_FeedbackSheet> {
  final _comment = TextEditingController();
  int _rating = 0;
  bool _sending = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_rating == 0 || _sending) return;
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    setState(() => _sending = true);
    try {
      final points = await ref
          .read(pointsRepositoryProvider)
          .submitFeedback(
            rating: _rating,
            comment: _comment.text.trim(),
            appVersion: ref.read(appVersionProvider).value ?? '',
            lang: ref.read(localeProvider).code,
          );
      if (!mounted) return;
      SnackbarUtils.showSuccess(
        context,
        points > 0 ? l10n.feedbackThanksPoints(points) : l10n.feedbackThanks,
      );
      navigator.pop();
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      SnackbarUtils.showError(context, switch (e.code) {
        'resource-exhausted' => l10n.feedbackAlreadyToday,
        'unavailable' || 'deadline-exceeded' => l10n.checkConnection,
        _ => l10n.actionFailed,
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _sending = false);
      SnackbarUtils.showError(context, l10n.checkConnection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final config =
        ref.watch(pointsConfigProvider).value ?? const PointsConfig();
    final sent = ref.watch(userProfileProvider).value?.feedbackSent ?? false;
    final offer = !sent && config.feedbackPoints > 0;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          24,
          12,
          24,
          MediaQuery.paddingOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.feedbackTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.feedbackBody,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.4,
                color: AppColors.textMuted,
              ),
            ),
            if (offer) ...[
              const SizedBox(height: 14),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: pointsColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.stars_rounded,
                        size: 18,
                        color: AppColors.rewardText,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l10n.feedbackPointsOffer(config.feedbackPoints),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.rewardText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var star = 1; star <= 5; star++)
                  IconButton(
                    iconSize: 40,
                    tooltip: '$star',
                    onPressed: _sending
                        ? null
                        : () {
                            HapticFeedback.selectionClick();
                            setState(() => _rating = star);
                          },
                    icon: AnimatedScale(
                      scale: star <= _rating ? 1.1 : 1,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(
                        star <= _rating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: star <= _rating
                            ? AppColors.accent
                            : AppColors.border,
                      ),
                    ),
                  ),
              ],
            ),
            if (_rating == 0)
              Text(
                l10n.feedbackStarsHint,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMuted,
                ),
              ),
            const SizedBox(height: 14),
            TextField(
              controller: _comment,
              enabled: !_sending,
              minLines: 3,
              maxLines: 5,
              maxLength: 1000,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: l10n.feedbackCommentHint,
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _rating == 0 || _sending ? null : _send,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: _sending
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.feedbackSend),
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: _sending ? null : () => Navigator.of(context).pop(),
              child: Text(l10n.feedbackLater),
            ),
          ],
        ),
      ),
    );
  }
}
