import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/petition.dart';

const petitionColor = Color(0xFF7C3AED);

extension PetitionTopicLabel on PetitionTopic {
  String label(AppLocalizations l10n) => switch (this) {
    PetitionTopic.pets => l10n.petitionTopicPets,
    PetitionTopic.wildlife => l10n.petitionTopicWildlife,
    PetitionTopic.farm => l10n.petitionTopicFarm,
    PetitionTopic.testing => l10n.petitionTopicTesting,
    PetitionTopic.entertainment => l10n.petitionTopicEntertainment,
    PetitionTopic.marine => l10n.petitionTopicMarine,
    PetitionTopic.other => l10n.petitionTopicOther,
  };

  IconData get icon => switch (this) {
    PetitionTopic.pets => Icons.pets_rounded,
    PetitionTopic.wildlife => Icons.forest_rounded,
    PetitionTopic.farm => Icons.agriculture_rounded,
    PetitionTopic.testing => Icons.science_rounded,
    PetitionTopic.entertainment => Icons.attractions_rounded,
    PetitionTopic.marine => Icons.water_rounded,
    PetitionTopic.other => Icons.volunteer_activism_rounded,
  };
}

extension PetitionStatusLabel on PetitionStatus {
  String label(AppLocalizations l10n) => switch (this) {
    PetitionStatus.active => l10n.petitionStatusActive,
    PetitionStatus.completed => l10n.petitionStatusCompleted,
    PetitionStatus.closed => l10n.petitionStatusClosed,
    PetitionStatus.unavailable => l10n.petitionStatusUnavailable,
  };

  Color get color => switch (this) {
    PetitionStatus.active => AppColors.primary,
    PetitionStatus.completed => const Color(0xFF2563EB),
    PetitionStatus.closed => AppColors.textMuted,
    PetitionStatus.unavailable => AppColors.danger,
  };
}

extension PetitionReviewLabel on PetitionReview {
  String label(AppLocalizations l10n) => switch (this) {
    PetitionReview.pending => l10n.petitionReviewPending,
    PetitionReview.approved => l10n.petitionReviewApproved,
    PetitionReview.rejected => l10n.petitionReviewRejected,
    PetitionReview.published => l10n.published,
  };

  Color get color => switch (this) {
    PetitionReview.pending => AppColors.accent,
    PetitionReview.approved => const Color(0xFF2563EB),
    PetitionReview.rejected => AppColors.danger,
    PetitionReview.published => AppColors.primary,
  };

  IconData get icon => switch (this) {
    PetitionReview.pending => Icons.hourglass_top_rounded,
    PetitionReview.approved => Icons.check_circle_outline_rounded,
    PetitionReview.rejected => Icons.block_rounded,
    PetitionReview.published => Icons.public_rounded,
  };
}

class PetitionBadge extends StatelessWidget {
  final String label;
  final Color color;

  const PetitionBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// The admin's image when there is one, otherwise the topic icon.
class PetitionImage extends StatelessWidget {
  final Petition petition;
  final double? height;
  final BorderRadius borderRadius;

  const PetitionImage({
    super.key,
    required this.petition,
    this.height,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    final url = petition.imageUrl;
    final placeholder = Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            petitionColor.withValues(alpha: 0.18),
            AppColors.primary.withValues(alpha: 0.14),
          ],
        ),
      ),
      child: Center(
        child: Icon(petition.topic.icon, size: 44, color: petitionColor),
      ),
    );
    return ClipRRect(
      borderRadius: borderRadius,
      child: url == null
          ? placeholder
          : CachedNetworkImage(
              imageUrl: url,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, _) => placeholder,
              errorWidget: (_, _, _) => placeholder,
            ),
    );
  }
}

class PetitionCard extends StatelessWidget {
  final Petition petition;
  final VoidCallback onTap;
  final VoidCallback onView;

  const PetitionCard({
    super.key,
    required this.petition,
    required this.onTap,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                PetitionImage(petition: petition, height: 150),
                if (!petition.canSign)
                  PositionedDirectional(
                    top: 10,
                    start: 10,
                    child: _SolidBadge(
                      label: petition.status.label(l10n),
                      color: petition.status.color,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    [
                      petition.topic.label(l10n),
                      if (petition.country.isNotEmpty) petition.country,
                    ].join(' · '),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: petitionColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    petition.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    petition.summary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.link_rounded,
                        size: 16,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          petition.source,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: petition.status == PetitionStatus.unavailable
                            ? null
                            : onView,
                        style: FilledButton.styleFrom(
                          backgroundColor: petitionColor,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.petitionView),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SolidBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _SolidBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Shown on Home while there are active petitions.
class PetitionsBanner extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const PetitionsBanner({super.key, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: petitionColor.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.campaign_rounded, color: petitionColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  context.l10n.petitionsBanner(count),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: petitionColor,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: petitionColor),
            ],
          ),
        ),
      ),
    );
  }
}
