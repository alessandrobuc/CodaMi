import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/support_case.dart';

extension CaseStatusLabels on CaseStatus {
  String label(AppLocalizations l10n) => switch (this) {
    CaseStatus.open => l10n.caseStatusOpen,
    CaseStatus.inProgress => l10n.caseStatusInProgress,
    CaseStatus.waitingUser => l10n.caseStatusWaitingUser,
    CaseStatus.resolved => l10n.caseStatusResolved,
    CaseStatus.closed => l10n.caseStatusClosed,
  };

  Color get color => switch (this) {
    CaseStatus.open => AppColors.lostPin,
    CaseStatus.inProgress => AppColors.primary,
    CaseStatus.waitingUser => AppColors.accent,
    CaseStatus.resolved => AppColors.primaryDark,
    CaseStatus.closed => AppColors.textMuted,
  };
}

extension CaseCategoryLabels on CaseCategory {
  String label(AppLocalizations l10n) => switch (this) {
    CaseCategory.account => l10n.categoryAccount,
    CaseCategory.listing => l10n.categoryListing,
    CaseCategory.app => l10n.categoryApp,
    CaseCategory.other => l10n.categoryOther,
  };

  IconData get icon => switch (this) {
    CaseCategory.account => Icons.person_outline_rounded,
    CaseCategory.listing => Icons.campaign_outlined,
    CaseCategory.app => Icons.phone_android_rounded,
    CaseCategory.other => Icons.help_outline_rounded,
  };
}

extension CaseKindLabels on CaseKind {
  String label(AppLocalizations l10n) =>
      this == CaseKind.chat ? l10n.kindChat : l10n.kindTicket;

  IconData get icon => this == CaseKind.chat
      ? Icons.forum_rounded
      : Icons.confirmation_number_rounded;
}

extension PresenceLabels on PresenceState {
  String label(AppLocalizations l10n) => switch (this) {
    PresenceState.online => l10n.presenceOnline,
    PresenceState.away => l10n.presenceAway,
    PresenceState.offline => l10n.presenceOffline,
  };

  Color get color => switch (this) {
    PresenceState.online => const Color(0xFF16A34A),
    PresenceState.away => AppColors.accent,
    PresenceState.offline => AppColors.textMuted,
  };
}

String formatDuration(AppLocalizations l10n, Duration duration) {
  final d = duration.isNegative ? Duration.zero : duration;
  if (d.inMinutes < 1) return l10n.durationSeconds(d.inSeconds);
  if (d.inHours < 1) return l10n.durationMinutes(d.inMinutes);
  if (d.inDays < 1) return l10n.durationHours(d.inHours, d.inMinutes % 60);
  return l10n.durationDays(d.inDays, d.inHours % 24);
}

class StatusBadge extends StatelessWidget {
  final CaseStatus status;

  const StatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label(context.l10n),
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: status.color,
        ),
      ),
    );
  }
}

class PresenceDot extends StatelessWidget {
  final PresenceState state;
  final double size;

  const PresenceDot(this.state, {super.key, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: state.color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surface, width: 1.5),
      ),
    );
  }
}

class InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const InfoPill({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 170),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
