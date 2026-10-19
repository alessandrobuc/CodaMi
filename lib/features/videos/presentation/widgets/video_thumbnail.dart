import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/video_entity.dart';

class VideoThumbnail extends StatelessWidget {
  final Video video;
  final double playSize;
  final bool showDuration;

  const VideoThumbnail({
    super.key,
    required this.video,
    this.playSize = 40,
    this.showDuration = true,
  });

  @override
  Widget build(BuildContext context) {
    final url = video.thumbnailUrl;
    final duration = video.durationLabel;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (url != null)
          CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (_, _) => const VideoPlaceholder(),
            errorWidget: (_, _, _) => const VideoPlaceholder(),
          )
        else
          const VideoPlaceholder(),
        if (playSize > 0)
          Center(
            child: Container(
              width: playSize,
              height: playSize,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.7),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: playSize * 0.62,
              ),
            ),
          ),
        if (showDuration && duration != null)
          PositionedDirectional(
            end: 6,
            bottom: 6,
            child: DurationBadge(label: duration),
          ),
      ],
    );
  }
}

class DurationBadge extends StatelessWidget {
  final String label;

  const DurationBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

class VideoPlaceholder extends StatelessWidget {
  const VideoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.85, -0.75),
        child: FaIcon(FontAwesomeIcons.paw, color: Colors.white24, size: 28),
      ),
    );
  }
}

class CategoryPill extends StatelessWidget {
  final String label;
  final bool motivational;
  final bool onDark;

  const CategoryPill({
    super.key,
    required this.label,
    required this.motivational,
    this.onDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = motivational ? AppColors.accent : AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: onDark ? color : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            motivational ? Icons.emoji_events_rounded : Icons.school_rounded,
            size: 12,
            color: onDark
                ? Colors.white
                : motivational
                ? AppColors.rewardText
                : AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: onDark
                  ? Colors.white
                  : motivational
                  ? AppColors.rewardText
                  : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
