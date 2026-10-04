import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_constants.dart';

class EmptyState extends StatelessWidget {
  final Widget icon;
  final Color color;
  final String title;
  final String message;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.color = AppColors.primary,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.08),
                border: Border.all(
                  color: color.withValues(alpha: 0.15),
                  width: 10,
                ),
              ),
              child: Center(
                child: IconTheme(
                  data: IconThemeData(color: color, size: 44),
                  child: icon,
                ),
              ),
            )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .moveY(
              begin: -5,
              end: 5,
              duration: 1800.ms,
              curve: Curves.easeInOut,
            ),
        const SizedBox(height: 22),
        Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
            height: 1.5,
          ),
        ),
        if (action != null) ...[const SizedBox(height: 24), action!],
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08, end: 0);
  }
}
