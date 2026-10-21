import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../data/moderation_repository.dart';
import '../providers/moderation_provider.dart';

extension PhotoCheckLabels on PhotoCheck {
  String reasonLabel(AppLocalizations l10n) {
    final reason = switch (this.reason) {
      PhotoCheckReason.adult => l10n.reasonAdult,
      PhotoCheckReason.racy => l10n.reasonRacy,
      PhotoCheckReason.violence => l10n.reasonViolence,
    };
    final level = switch (this.level) {
      Likelihood.possible => l10n.likelihoodPossible,
      Likelihood.likely => l10n.likelihoodLikely,
      Likelihood.veryLikely => l10n.likelihoodVeryLikely,
    };
    return '$reason · $level';
  }
}

class PhotoReviewCard extends ConsumerStatefulWidget {
  final PhotoCheck check;

  const PhotoReviewCard({super.key, required this.check});

  @override
  ConsumerState<PhotoReviewCard> createState() => _PhotoReviewCardState();
}

class _PhotoReviewCardState extends ConsumerState<PhotoReviewCard> {
  // Photos stay blurred until a moderator chooses to look.
  bool _revealed = false;
  bool _busy = false;

  Future<void> _review({required bool approve}) async {
    final l10n = context.l10n;
    if (!approve) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(
            Icons.hide_image_rounded,
            color: AppColors.danger,
            size: 32,
          ),
          title: Text(l10n.removePhotoTitle),
          content: Text(l10n.removePhotoMessage, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              child: Text(l10n.remove),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    setState(() => _busy = true);
    try {
      await ref
          .read(moderationRepositoryProvider)
          .reviewPhoto(widget.check.id, approve: approve);
      if (mounted) {
        SnackbarUtils.showSuccess(
          context,
          approve ? l10n.photoApproved : l10n.photoRemovedDone,
        );
      }
    } catch (_) {
      if (mounted) {
        setState(() => _busy = false);
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final check = widget.check;
    final url = ref.watch(heldPhotoUrlProvider(check.path)).value;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => setState(() => _revealed = !_revealed),
            child: SizedBox(
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ImageFiltered(
                    enabled: !_revealed,
                    imageFilter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: PetImage.url(url),
                  ),
                  if (!_revealed)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.visibility_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              l10n.tapToView,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _Chip(label: check.reasonLabel(l10n)),
                    if (check.blocked) _Chip(label: l10n.hiddenByAi),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  [
                    check.isPetPhoto ? l10n.petPhoto : l10n.listingPhoto,
                    if (check.ownerName.isNotEmpty)
                      l10n.uploadedBy(check.ownerName),
                    if (check.createdAt case final at?) timeAgo(l10n, at),
                  ].join(' · '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _busy ? null : () => _review(approve: false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                          side: const BorderSide(color: AppColors.danger),
                        ),
                        child: Text(l10n.remove),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton(
                        onPressed: _busy ? null : () => _review(approve: true),
                        child: Text(l10n.approvePhoto),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;

  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: AppColors.danger,
        ),
      ),
    );
  }
}
