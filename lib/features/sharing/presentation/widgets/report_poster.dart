import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../../reports/presentation/widgets/reports_widget.dart';
import '../../domain/sharing.dart';

const posterSize = 360.0;

String posterName(AppLocalizations l10n, Report r) =>
    r.petName.trim().isEmpty ? r.species.label(l10n) : r.petName.trim();

// The square image people share: photo, status, details, QR and CodaMi.
class ReportPoster extends StatelessWidget {
  final Report report;
  final ShareKind kind;
  final String link;

  const ReportPoster({
    super.key,
    required this.report,
    required this.kind,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final r = report;
    final home = kind == ShareKind.reunited;
    final color = home ? AppColors.primary : reportColor(r.type);
    final name = posterName(l10n, r);
    final date = DateFormat.MMMd(l10n.localeName).format(r.eventAt.toLocal());
    final badge = home
        ? (r.type == ReportType.lost
              ? l10n.shareBadgeHome
              : l10n.shareBadgeReunited)
        : (r.type == ReportType.lost
              ? l10n.shareBadgeLost
              : l10n.shareBadgeFound);
    final reward = home ? null : r.activeReward;
    final when = home
        ? l10n.shareHomeThanks
        : (r.type == ReportType.lost
              ? l10n.shareLostOn(date)
              : l10n.shareFoundOn(date));

    return SizedBox(
      width: posterSize,
      height: posterSize,
      child: ColoredBox(
        color: AppColors.surface,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _Photo(url: r.coverUrl),
                  PositionedDirectional(
                    top: 12,
                    start: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Color(0x33000000), blurRadius: 6),
                        ],
                      ),
                      child: Text(
                        home ? '🎉 $badge' : badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 12,
                    end: 12,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Color(0x33000000), blurRadius: 6),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              AppAssets.logo,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'CodaMi',
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w900,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          home ? l10n.shareHomeTitle(name) : name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 19,
                            height: 1.15,
                            fontWeight: FontWeight.w900,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${r.species.label(l10n)} · ${r.placeLabel(l10n)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              home
                                  ? Icons.favorite_rounded
                                  : Icons.event_rounded,
                              size: 14,
                              color: color,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                when,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                            if (reward != null) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '🎁 ${euroAmount(reward)}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.rewardText,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          home
                              ? l10n.shareHomeHelp
                              : (r.type == ReportType.lost
                                    ? l10n.shareSeenHelp(name)
                                    : l10n.shareYoursHelp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrImageView(
                        data: link,
                        size: 58,
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
                      const SizedBox(height: 2),
                      Text(
                        l10n.shareScan,
                        style: const TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 24,
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.pets_rounded, size: 12, color: Colors.white),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l10n.shareTagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Text(
                    'CodaMi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                    ),
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

// The whole photo is shown, never cropped; a blurred copy fills the sides.
class _Photo extends StatelessWidget {
  final String? url;

  const _Photo({required this.url});

  @override
  Widget build(BuildContext context) {
    const fallback = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Center(
        child: Icon(Icons.pets_rounded, size: 100, color: Color(0x33FFFFFF)),
      ),
    );
    if (url == null) return fallback;
    Image image(BoxFit fit) => Image.network(
      url!,
      fit: fit,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => fallback,
    );
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: image(BoxFit.cover),
          ),
          const ColoredBox(color: Color(0x26000000)),
          image(BoxFit.contain),
        ],
      ),
    );
  }
}
