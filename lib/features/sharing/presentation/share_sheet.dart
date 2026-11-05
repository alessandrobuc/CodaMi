import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gal/gal.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/number_format.dart';
import '../../../core/utils/screen_space.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../../auth/data/models/user_model.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../profile/presentation/providers/profile_provider.dart';
import '../../reports/domain/entities/reports_entity.dart';
import '../../reports/presentation/providers/reports_provider.dart';
import '../data/direct_share.dart';
import '../domain/sharing.dart';
import 'providers/sharing_provider.dart';
import 'widgets/report_poster.dart';

// Admins see the pop-up while it's off for users.
bool sharePopupOn(WidgetRef ref) =>
    (ref.read(sharingConfigProvider).value?.popup ?? false) ||
    ref.read(userRoleProvider) == UserRole.admin;

Future<void> showReportShareSheet(
  BuildContext context,
  Report report, {
  ShareKind kind = ShareKind.announce,
  bool prompt = false,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  backgroundColor: AppColors.surface,
  builder: (_) => ShareSheet(report: report, kind: kind, prompt: prompt),
);

String shareMessage(
  AppLocalizations l10n,
  Report r,
  ShareKind kind,
  String link, {
  bool hashtags = false,
}) {
  final name = posterName(l10n, r);
  final date = DateFormat.MMMd(l10n.localeName).format(r.eventAt.toLocal());
  final species = r.species.label(l10n);
  final place = r.placeLabel(l10n);
  final reward = kind == ShareKind.announce ? r.activeReward : null;
  final lines = [
    switch ((kind, r.type)) {
      (ShareKind.reunited, _) => l10n.shareMessageHome(name),
      (_, ReportType.lost) => l10n.shareMessageLost(name, species, place, date),
      (_, ReportType.found) => l10n.shareMessageFound(species, place, date),
    },
    if (reward != null) '🎁 ${l10n.rewardAmount(euroAmount(reward))}',
    '',
    '👉 $link',
    '',
    l10n.shareMessageFooter,
    if (hashtags)
      [
        '#CodaMi',
        switch ((kind, r.type)) {
          (ShareKind.reunited, _) => l10n.shareTagHome,
          (_, ReportType.lost) => l10n.shareTagLost,
          (_, ReportType.found) => l10n.shareTagFound,
        },
        if (cityTag(r.city).isNotEmpty) '#${cityTag(r.city)}',
      ].join(' '),
  ];
  return lines.join('\n');
}

class ShareSheet extends ConsumerStatefulWidget {
  final Report report;
  final ShareKind kind;
  // Shown on its own after publishing or resolving: offers "Not now".
  final bool prompt;

  const ShareSheet({
    super.key,
    required this.report,
    required this.kind,
    this.prompt = false,
  });

  @override
  ConsumerState<ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends ConsumerState<ShareSheet> {
  final _poster = GlobalKey();
  ShareTarget? _busy;

  Report get _report =>
      ref.read(reportProvider(widget.report.id)).value ?? widget.report;

  String _link(ShareTarget target) =>
      reportLink(_report.id, lang: context.l10n.localeName, source: target);

  Future<Uint8List?> _render() async {
    final url = _report.coverUrl;
    if (url != null) {
      await precacheImage(NetworkImage(url), context).catchError((_) {});
      await WidgetsBinding.instance.endOfFrame;
    }
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

  XFile _file(Uint8List bytes) => XFile.fromData(
    bytes,
    mimeType: 'image/png',
    name: 'codami_${_report.id}.png',
  );

  Future<bool> _launch(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  Future<void> _shareImage(Uint8List bytes, {String? text}) =>
      SharePlus.instance.share(
        ShareParams(
          files: [_file(bytes)],
          fileNameOverrides: ['codami_${_report.id}.png'],
          text: text,
        ),
      );

  Future<void> _go(ShareTarget target) async {
    final l10n = context.l10n;
    final r = _report;
    final link = _link(target);
    setState(() => _busy = target);
    try {
      switch (target) {
        case ShareTarget.whatsapp:
          // Image with the text and link as its caption.
          final bytes = await _render();
          final text = shareMessage(l10n, r, widget.kind, link);
          if (bytes == null) {
            await _launch(
              Uri.parse('https://wa.me/?text=${Uri.encodeComponent(text)}'),
            );
          } else if (!await shareToApp(target, bytes, text)) {
            await _shareImage(bytes, text: text);
          }
        case ShareTarget.facebook ||
            ShareTarget.instagram ||
            ShareTarget.tiktok:
          // These apps drop text from other apps: the image goes, the
          // caption with the link is copied to paste.
          final bytes = await _render();
          final caption = shareMessage(
            l10n,
            r,
            widget.kind,
            link,
            hashtags: target != ShareTarget.facebook,
          );
          await Clipboard.setData(ClipboardData(text: caption));
          if (bytes == null) {
            if (target != ShareTarget.facebook) throw StateError('No image');
            await _launch(
              Uri.parse(
                'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(link)}',
              ),
            );
            break;
          }
          if (mounted) {
            SnackbarUtils.showSuccess(context, switch (target) {
              ShareTarget.facebook => l10n.shareCaptionCopiedFacebook,
              ShareTarget.instagram => l10n.shareCaptionCopiedInstagram,
              _ => l10n.shareCaptionCopiedTiktok,
            });
          }
          await Future<void>.delayed(const Duration(milliseconds: 700));
          if (!await shareToApp(target, bytes, caption)) {
            await _shareImage(bytes, text: caption);
          }
        case ShareTarget.more || ShareTarget.qr:
          final bytes = await _render();
          final text = shareMessage(l10n, r, widget.kind, link);
          if (bytes == null) {
            await SharePlus.instance.share(ShareParams(text: text));
          } else {
            await _shareImage(bytes, text: text);
          }
        case ShareTarget.save:
          final bytes = await _render();
          if (bytes == null) throw StateError('No image');
          if (!await Gal.hasAccess() && !await Gal.requestAccess()) {
            if (mounted) {
              SnackbarUtils.showError(context, l10n.inviteSaveDenied);
            }
            return;
          }
          await Gal.putImageBytes(bytes, name: 'codami_${r.id}');
          if (mounted) SnackbarUtils.showSuccess(context, l10n.shareImageSaved);
        case ShareTarget.copy:
          await Clipboard.setData(ClipboardData(text: link));
          if (mounted) SnackbarUtils.showSuccess(context, l10n.shareLinkCopied);
      }
      HapticFeedback.selectionClick();
      unawaited(
        ref.read(sharingRepositoryProvider).logShare(r.id, target, widget.kind),
      );
    } catch (e) {
      debugPrint('Report not shared ($target): $e');
      if (mounted) SnackbarUtils.showError(context, l10n.shareFailed);
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final r =
        ref.watch(reportProvider(widget.report.id)).value ?? widget.report;
    final name = posterName(l10n, r);
    final home = widget.kind == ShareKind.reunited;
    final isOwner = ref.watch(authStateProvider).value?.uid == r.ownerId;
    final stats = isOwner
        ? ref.watch(reportShareStatsProvider(r.id)).value
        : null;
    final title = home
        ? l10n.shareSheetTitleHome
        : (r.type == ReportType.lost
              ? l10n.shareSheetTitleLost(name)
              : l10n.shareSheetTitleFound);
    final text = home
        ? l10n.shareSheetTextHome
        : (r.type == ReportType.lost
              ? l10n.shareSheetTextLost(name)
              : l10n.shareSheetTextFound);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, endSpace(context) - 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.text,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.background,
                  ),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
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
                              child: ReportPoster(
                                report: r,
                                kind: widget.kind,
                                link: reportLink(
                                  r.id,
                                  lang: l10n.localeName,
                                  source: ShareTarget.qr,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .scale(
                  begin: const Offset(0.94, 0.94),
                  curve: Curves.easeOutBack,
                ),
            if (stats != null && stats.shares > 0) ...[
              const SizedBox(height: 14),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.shareStatsLine(stats.shares, stats.views),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 18),
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
                      onTap: _busy == null ? () => _go(target) : null,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
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
                    onPressed: _busy == null ? () => _go(target) : null,
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
            const SizedBox(height: 12),
            Text(
              l10n.shareTip,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.5,
                color: AppColors.textMuted,
              ),
            ),
            if (widget.prompt) ...[
              const SizedBox(height: 6),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.shareNotNow),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ShareAppButton extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final bool busy;
  final VoidCallback? onTap;

  const ShareAppButton({
    super.key,
    required this.icon,
    required this.label,
    required this.busy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Center(
              child: busy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : FaIcon(icon, size: 24, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    ),
  );
}
