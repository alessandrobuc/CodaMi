import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/screen_space.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../notifications/domain/entities/notification_prefs.dart';
import '../../../notifications/presentation/providers/notification_settings_provider.dart';
import '../../../points/domain/invite_code.dart';
import '../../../points/presentation/providers/points_provider.dart';
import '../../../points/presentation/screens/invite_screen.dart';
import '../../data/direct_share.dart';
import '../../domain/sharing.dart';
import '../providers/sharing_provider.dart';
import '../share_sheet.dart' show ShareAppButton;
import '../../../feedback/domain/feedback.dart';
import '../../../feedback/presentation/providers/feedback_provider.dart';

// Where a share reminder leads: the user's invite link, ready to share.
class ShareAppScreen extends ConsumerStatefulWidget {
  final bool fromReminder;
  // Admins looking at it: nothing is counted.
  final bool preview;

  const ShareAppScreen({
    super.key,
    this.fromReminder = false,
    this.preview = false,
  });

  @override
  ConsumerState<ShareAppScreen> createState() => _ShareAppScreenState();
}

class _ShareAppScreenState extends ConsumerState<ShareAppScreen> {
  final _poster = GlobalKey();
  ShareTarget? _busy;

  @override
  void initState() {
    super.initState();
    if (!widget.preview) {
      ref.read(feedbackTrackerProvider).used(FeedbackArea.sharing);
    }
    if (widget.fromReminder && !widget.preview) {
      shareReminderOpenedAt = DateTime.now();
      unawaited(
        ref
            .read(sharingRepositoryProvider)
            .reminderEvent('opened', fromReminder: true),
      );
    }
  }

  String _message(String code, {bool hashtags = false}) {
    final l10n = context.l10n;
    return [
      l10n.shareAppMessage(code),
      '',
      '👉 ${inviteLink(code)}',
      if (hashtags) '\n#CodaMi ${l10n.shareTagLost}',
    ].join('\n');
  }

  Future<Uint8List?> _render() async {
    final boundary =
        _poster.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;
    final image = await boundary.toImage(
      pixelRatio: 1080 / boundary.size.width,
    );
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return data?.buffer.asUint8List();
  }

  Future<void> _shareImage(Uint8List bytes, String text) =>
      SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(bytes, mimeType: 'image/png', name: 'codami.png'),
          ],
          fileNameOverrides: const ['codami.png'],
          text: text,
        ),
      );

  Future<void> _go(ShareTarget target, String code) async {
    final l10n = context.l10n;
    setState(() => _busy = target);
    try {
      final bytes = await _render();
      switch (target) {
        case ShareTarget.whatsapp:
          final text = _message(code);
          if (bytes == null) throw StateError('No image');
          if (!await shareToApp(target, bytes, text)) {
            await _shareImage(bytes, text);
          }
        case ShareTarget.facebook ||
            ShareTarget.instagram ||
            ShareTarget.tiktok:
          if (bytes == null) throw StateError('No image');
          final caption = _message(
            code,
            hashtags: target != ShareTarget.facebook,
          );
          await Clipboard.setData(ClipboardData(text: caption));
          if (mounted) {
            SnackbarUtils.showSuccess(context, switch (target) {
              ShareTarget.facebook => l10n.shareCaptionCopiedFacebook,
              ShareTarget.instagram => l10n.shareCaptionCopiedInstagram,
              _ => l10n.shareCaptionCopiedTiktok,
            });
          }
          await Future<void>.delayed(const Duration(milliseconds: 700));
          if (!await shareToApp(target, bytes, caption)) {
            await _shareImage(bytes, caption);
          }
        case ShareTarget.save:
          if (bytes == null) throw StateError('No image');
          if (!await Gal.hasAccess() && !await Gal.requestAccess()) {
            if (mounted) {
              SnackbarUtils.showError(context, l10n.inviteSaveDenied);
            }
            return;
          }
          await Gal.putImageBytes(bytes, name: 'codami_invite');
          if (mounted) SnackbarUtils.showSuccess(context, l10n.shareImageSaved);
        case ShareTarget.copy:
          await Clipboard.setData(ClipboardData(text: _message(code)));
          if (mounted) SnackbarUtils.showSuccess(context, l10n.shareLinkCopied);
        case ShareTarget.more || ShareTarget.qr:
          if (bytes == null) {
            await SharePlus.instance.share(ShareParams(text: _message(code)));
          } else {
            await _shareImage(bytes, _message(code));
          }
      }
      HapticFeedback.selectionClick();
      if (!widget.preview) {
        unawaited(
          ref
              .read(sharingRepositoryProvider)
              .reminderEvent('shared', fromReminder: widget.fromReminder),
        );
      }
    } catch (e) {
      debugPrint('App not shared ($target): $e');
      if (mounted) SnackbarUtils.showError(context, l10n.shareFailed);
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  Future<void> _stopReminders() async {
    final l10n = context.l10n;
    if (widget.preview) {
      Navigator.of(context).pop();
      return;
    }
    try {
      await ref
          .read(notificationSettingsProvider)
          .setEnabled(AlertType.share, false);
      if (!mounted) return;
      SnackbarUtils.showSuccess(context, l10n.shareAppStopped);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Share reminders not turned off: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final codeState = ref.watch(myInviteCodeProvider);
    final code = codeState.value;
    final joined = (ref.watch(myInvitesProvider).value ?? const []).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.shareAppTitle),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 4, 20, endSpace(context)),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🐾', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 8),
                Text(
                  l10n.shareAppHeadline,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.shareAppText,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05),
          const SizedBox(height: 18),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.text.withValues(alpha: 0.14),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FittedBox(
                      child: RepaintBoundary(
                        key: _poster,
                        child: JoinPoster(code: code),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
          const SizedBox(height: 18),
          if (code == null)
            Center(
              child: codeState.hasError
                  ? TextButton(
                      onPressed: () => ref.invalidate(myInviteCodeProvider),
                      child: Text(l10n.actionFailed),
                    )
                  : const CircularProgressIndicator(),
            )
          else ...[
            Row(
              children: [
                for (final (target, icon, label) in [
                  (ShareTarget.whatsapp, FontAwesomeIcons.whatsapp, 'WhatsApp'),
                  (
                    ShareTarget.facebook,
                    FontAwesomeIcons.facebookF,
                    'Facebook',
                  ),
                  (
                    ShareTarget.instagram,
                    FontAwesomeIcons.instagram,
                    'Instagram',
                  ),
                  (ShareTarget.tiktok, FontAwesomeIcons.tiktok, 'TikTok'),
                ])
                  Expanded(
                    child: ShareAppButton(
                      icon: icon,
                      label: label,
                      busy: _busy == target,
                      onTap: _busy == null ? () => _go(target, code) : null,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final (target, icon, label) in [
                  (ShareTarget.more, Icons.ios_share_rounded, l10n.shareMore),
                  (ShareTarget.save, Icons.download_rounded, l10n.shareSave),
                  (ShareTarget.copy, Icons.link_rounded, l10n.shareCopyLink),
                ])
                  OutlinedButton.icon(
                    onPressed: _busy == null ? () => _go(target, code) : null,
                    icon: _busy == target
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(icon, size: 18),
                    label: Text(label),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 18),
          Material(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const InviteScreen())),
              leading: CircleAvatar(
                backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: AppColors.rewardText,
                ),
              ),
              title: Text(
                l10n.shareAppJoined(joined),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              subtitle: Text(l10n.shareAppSeeRewards),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          if (widget.fromReminder) ...[
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: _stopReminders,
                child: Text(
                  l10n.shareAppStop,
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// The square "Join CodaMi" image with the user's invite code.
class JoinPoster extends StatelessWidget {
  final String? code;

  const JoinPoster({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget benefit(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 15, color: AppColors.primary),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );

    return SizedBox(
      width: 360,
      height: 360,
      child: ColoredBox(
        color: AppColors.surface,
        child: Column(
          children: [
            Container(
              height: 128,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
              child: Stack(
                children: [
                  const PositionedDirectional(
                    end: -10,
                    bottom: -18,
                    child: Icon(
                      Icons.pets_rounded,
                      size: 120,
                      color: Color(0x1FFFFFFF),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              AppAssets.logo,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  l10n.shareAppPosterTitle,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.shareAppPosterText,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 14, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          benefit(
                            Icons.notifications_active_rounded,
                            l10n.shareAppBenefitAlerts,
                          ),
                          benefit(Icons.map_rounded, l10n.shareAppBenefitMap),
                          benefit(
                            Icons.diversity_1_rounded,
                            l10n.shareAppBenefitNeighbours,
                          ),
                          if (code != null) ...[
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${l10n.shareAppCode}: $code',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                  color: AppColors.rewardText,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (code != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrImageView(
                            data: inviteQrLink(code!),
                            size: 84,
                            padding: EdgeInsets.zero,
                            eyeStyle: const QrEyeStyle(
                              eyeShape: QrEyeShape.circle,
                              color: AppColors.primaryDark,
                            ),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.circle,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            l10n.shareScan,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Container(
              height: 26,
              color: AppColors.primary,
              alignment: Alignment.center,
              child: Text(
                l10n.shareAppFree,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
