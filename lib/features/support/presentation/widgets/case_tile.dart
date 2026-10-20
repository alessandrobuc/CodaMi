import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/support_case.dart';
import 'support_labels.dart';

// One case in a list. Staff also see the user, the operator and the waiting time.
class CaseTile extends StatelessWidget {
  final SupportCase supportCase;
  final bool forStaff;
  final VoidCallback onTap;

  const CaseTile({
    super.key,
    required this.supportCase,
    required this.onTap,
    this.forStaff = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = supportCase;
    final waiting = forStaff ? c.waitingFor() : null;
    final late = forStaff && c.overdue;
    final accent = late ? AppColors.danger : c.status.color;
    final who = forStaff
        ? (c.userName.isEmpty ? c.userEmail : c.userName)
        : c.kind.label(l10n);
    final unreadForUser =
        !forStaff && c.lastMessageByStaff && c.status.isActive;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: late
              ? AppColors.danger.withValues(alpha: 0.45)
              : AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: accent),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _Avatar(
                              text: who,
                              icon: forStaff ? null : c.kind.icon,
                              color: accent,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    who,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.text,
                                    ),
                                  ),
                                  Text(
                                    forStaff
                                        ? '${c.reference} · ${c.kind.label(l10n)}'
                                        : c.reference,
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (c.lastMessageAt != null)
                              Text(
                                timeAgo(l10n, c.lastMessageAt!),
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: unreadForUser
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: unreadForUser
                                      ? AppColors.primary
                                      : AppColors.textMuted,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          c.subject,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5,
                            color: AppColors.text,
                          ),
                        ),
                        if (c.lastMessageText.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (c.lastMessageByStaff)
                                const Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    top: 1,
                                    end: 4,
                                  ),
                                  child: Icon(
                                    Icons.support_agent_rounded,
                                    size: 15,
                                    color: AppColors.primary,
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  c.lastMessageText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.3,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            StatusBadge(c.status),
                            if (forStaff)
                              InfoPill(
                                icon: Icons.support_agent_rounded,
                                text: c.assignedName ?? l10n.supportUnassigned,
                                color: c.isAssigned
                                    ? AppColors.primary
                                    : AppColors.lostPin,
                              ),
                            if (waiting != null)
                              InfoPill(
                                icon: late
                                    ? Icons.alarm_rounded
                                    : Icons.schedule_rounded,
                                text: l10n.supportWaitingFor(
                                  formatDuration(l10n, waiting),
                                ),
                                color: late
                                    ? AppColors.danger
                                    : AppColors.accent,
                              ),
                            if (!forStaff)
                              InfoPill(
                                icon: c.category.icon,
                                text: c.category.label(l10n),
                                color: AppColors.textMuted,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color color;

  const _Avatar({required this.text, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    final letter = text.trim().characters.firstOrNull?.toUpperCase() ?? '?';
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        shape: BoxShape.circle,
      ),
      child: icon != null
          ? Icon(icon, size: 17, color: color)
          : Text(
              letter,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
    );
  }
}
