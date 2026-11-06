import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/feedback.dart';

extension FeedbackTypeLabels on FeedbackType {
  String label(AppLocalizations l10n) => switch (this) {
    FeedbackType.suggestion => l10n.fbTypeSuggestion,
    FeedbackType.bug => l10n.fbTypeBug,
    FeedbackType.problem => l10n.fbTypeProblem,
    FeedbackType.improvement => l10n.fbTypeImprovement,
    FeedbackType.general => l10n.fbTypeGeneral,
  };

  String hint(AppLocalizations l10n) => switch (this) {
    FeedbackType.suggestion => l10n.fbHintSuggestion,
    FeedbackType.bug => l10n.fbHintBug,
    FeedbackType.problem => l10n.fbHintProblem,
    FeedbackType.improvement => l10n.fbHintImprovement,
    FeedbackType.general => l10n.feedbackCommentHint,
  };

  IconData get icon => switch (this) {
    FeedbackType.suggestion => Icons.lightbulb_rounded,
    FeedbackType.bug => Icons.bug_report_rounded,
    FeedbackType.problem => Icons.report_problem_rounded,
    FeedbackType.improvement => Icons.auto_fix_high_rounded,
    FeedbackType.general => Icons.chat_bubble_rounded,
  };

  Color get color => switch (this) {
    FeedbackType.suggestion => AppColors.primary,
    FeedbackType.bug => AppColors.danger,
    FeedbackType.problem => AppColors.accent,
    FeedbackType.improvement => AppColors.primaryDark,
    FeedbackType.general => AppColors.textMuted,
  };
}

extension FeedbackAreaLabels on FeedbackArea {
  String label(AppLocalizations l10n) => switch (this) {
    FeedbackArea.general => l10n.fbAreaGeneral,
    FeedbackArea.reports => l10n.fbAreaReports,
    FeedbackArea.map => l10n.fbAreaMap,
    FeedbackArea.walks => l10n.fbAreaWalks,
    FeedbackArea.sitting => l10n.fbAreaSitting,
    FeedbackArea.schedule => l10n.fbAreaSchedule,
    FeedbackArea.heat => l10n.fbAreaHeat,
    FeedbackArea.scanner => l10n.fbAreaScanner,
    FeedbackArea.shop => l10n.fbAreaShop,
    FeedbackArea.sharing => l10n.fbAreaSharing,
  };

  IconData get icon => switch (this) {
    FeedbackArea.general => Icons.apps_rounded,
    FeedbackArea.reports => Icons.pets_rounded,
    FeedbackArea.map => Icons.map_rounded,
    FeedbackArea.walks => Icons.directions_walk_rounded,
    FeedbackArea.sitting => Icons.volunteer_activism_rounded,
    FeedbackArea.schedule => Icons.event_note_rounded,
    FeedbackArea.heat => Icons.calendar_month_rounded,
    FeedbackArea.scanner => Icons.center_focus_strong_rounded,
    FeedbackArea.shop => Icons.shopping_bag_rounded,
    FeedbackArea.sharing => Icons.share_rounded,
  };
}

extension FeedbackStatusLabels on FeedbackStatus {
  String label(AppLocalizations l10n) => switch (this) {
    FeedbackStatus.open => l10n.fbStatusNew,
    FeedbackStatus.progress => l10n.fbStatusProgress,
    FeedbackStatus.done => l10n.fbStatusDone,
  };

  Color get color => switch (this) {
    FeedbackStatus.open => AppColors.accent,
    FeedbackStatus.progress => AppColors.primary,
    FeedbackStatus.done => AppColors.textMuted,
  };
}

class FeedbackStars extends StatelessWidget {
  final int rating;
  final double size;

  const FeedbackStars({super.key, required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var s = 1; s <= 5; s++)
          Icon(
            s <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: s <= rating ? AppColors.accent : AppColors.border,
          ),
      ],
    );
  }
}
