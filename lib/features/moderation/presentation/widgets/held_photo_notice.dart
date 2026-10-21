import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../data/moderation_repository.dart';
import '../providers/moderation_provider.dart';

// Shown to owners while one of their photos waits for a moderator.
class HeldPhotoNotice extends ConsumerWidget {
  final List<String> photoUrls;

  const HeldPhotoNotice({super.key, required this.photoUrls});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final held = ref.watch(myHeldPhotosProvider).value ?? const {};
    if (!photoUrls.any((url) => held.contains(PhotoCheck.pathOfUrl(url)))) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.hourglass_top_rounded,
            size: 20,
            color: AppColors.rewardText,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.photoUnderReview,
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.rewardText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
