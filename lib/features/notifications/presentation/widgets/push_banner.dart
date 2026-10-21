import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../l10n/l10n.dart';
import '../../../support/presentation/screens/support_case_screen.dart';
import '../../data/push_service.dart';

void showPushBanner(RemoteMessage message, void Function() open) {
  final caseId = message.data['caseId'];
  if (caseId != null && caseId == visibleSupportCase.value) return;
  final title = message.notification?.title ?? '';
  final body = message.notification?.body ?? '';
  if (title.isEmpty && body.isEmpty) return;
  final messenger = appMessengerKey.currentState;
  if (messenger == null) return;

  HapticFeedback.mediumImpact();
  final isSupport = (message.data['kind'] as String? ?? '').startsWith(
    'support',
  );
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.text,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                isSupport
                    ? Icons.support_agent_rounded
                    : Icons.notifications_active_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  if (body.isNotEmpty)
                    Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        action:
            message.data.containsKey('caseId') ||
                message.data.containsKey('reportId') ||
                message.data['kind'] == photoReviewKind
            ? SnackBarAction(
                label: appL10n.pushOpen,
                textColor: AppColors.accent,
                onPressed: open,
              )
            : null,
      ),
    );
}
