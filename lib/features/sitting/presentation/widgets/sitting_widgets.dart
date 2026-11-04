import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../domain/sitting.dart';

const sittingColor = AppColors.primary;

extension SittingServiceView on SittingService {
  IconData get icon => switch (this) {
    SittingService.visits => Icons.home_outlined,
    SittingService.overnight => Icons.nights_stay_outlined,
    SittingService.walks => Icons.directions_walk_rounded,
    SittingService.daycare => Icons.wb_sunny_outlined,
    SittingService.boarding => Icons.house_siding_rounded,
  };

  String label(AppLocalizations l10n) => switch (this) {
    SittingService.visits => l10n.sitServiceVisits,
    SittingService.overnight => l10n.sitServiceOvernight,
    SittingService.walks => l10n.sitServiceWalks,
    SittingService.daycare => l10n.sitServiceDaycare,
    SittingService.boarding => l10n.sitServiceBoarding,
  };
}

extension SittingStatusView on SittingStatus {
  Color get color => switch (this) {
    SittingStatus.open => AppColors.primary,
    SittingStatus.booked => AppColors.rewardText,
    SittingStatus.done => AppColors.primaryDark,
    SittingStatus.closed => AppColors.textMuted,
  };

  String label(AppLocalizations l10n) => switch (this) {
    SittingStatus.open => l10n.sitStatusOpen,
    SittingStatus.booked => l10n.sitStatusBooked,
    SittingStatus.done => l10n.sitStatusDone,
    SittingStatus.closed => l10n.sitStatusClosed,
  };
}

extension OfferStatusView on OfferStatus {
  Color get color => switch (this) {
    OfferStatus.pending => AppColors.rewardText,
    OfferStatus.accepted => AppColors.primary,
    OfferStatus.declined || OfferStatus.withdrawn => AppColors.textMuted,
  };

  String label(AppLocalizations l10n) => switch (this) {
    OfferStatus.pending => l10n.sitOfferPending,
    OfferStatus.accepted => l10n.sitOfferAccepted,
    OfferStatus.declined => l10n.sitOfferDeclined,
    OfferStatus.withdrawn => l10n.sitOfferWithdrawn,
  };
}

String sittingDates(AppLocalizations l10n, DateTime a, DateTime b) {
  final f = DateFormat.MMMd(l10n.localeName);
  return a == b ? f.format(a) : '${f.format(a)} – ${f.format(b)}';
}

String speciesList(AppLocalizations l10n, List<PetSpecies> s) =>
    s.map((x) => x.label(l10n)).join(', ');

class SittingCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? tint;

  const SittingCard({super.key, required this.child, this.onTap, this.tint});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tint?.withValues(alpha: 0.07) ?? AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: tint?.withValues(alpha: 0.25) ?? AppColors.border,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

class SittingTitle extends StatelessWidget {
  final String text;

  const SittingTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: AppColors.text,
      ),
    ),
  );
}

class SittingChip extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const SittingChip(this.text, {super.key, required this.color, this.icon});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
        ],
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

class SittingAvatar extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final double radius;

  const SittingAvatar({
    super.key,
    required this.name,
    this.photoUrl,
    this.radius = 22,
  });

  @override
  Widget build(BuildContext context) {
    final url = photoUrl;
    final letter = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();
    return CircleAvatar(
      radius: radius,
      // Solid, so the letter stays readable on top of a coloured ring.
      backgroundColor: Color.alphaBlend(
        sittingColor.withValues(alpha: 0.14),
        AppColors.surface,
      ),
      foregroundImage: url == null || url.isEmpty ? null : NetworkImage(url),
      onForegroundImageError: url == null || url.isEmpty ? null : (_, _) {},
      child: Text(
        letter,
        style: TextStyle(
          fontSize: radius * 0.8,
          fontWeight: FontWeight.w800,
          color: sittingColor,
        ),
      ),
    );
  }
}

class StarRow extends StatelessWidget {
  final double value;
  final double size;

  const StarRow({super.key, required this.value, this.size = 16});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 1; i <= 5; i++)
        Icon(
          value >= i
              ? Icons.star_rounded
              : value >= i - 0.5
              ? Icons.star_half_rounded
              : Icons.star_outline_rounded,
          size: size,
          color: AppColors.accent,
        ),
    ],
  );
}

class RatingLine extends StatelessWidget {
  final SitterProfile sitter;

  const RatingLine({super.key, required this.sitter});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rating = sitter.rating;
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (rating != null) ...[
          StarRow(value: rating),
          Text(
            l10n.sitRatingSummary(
              NumberFormat('0.0', l10n.localeName).format(rating),
              sitter.reviewCount,
            ),
            style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
          ),
        ] else
          Text(
            l10n.sitNoReviewsYet,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
          ),
        if (sitter.completedCount > 0)
          SittingChip(
            l10n.sitCompletedCount(sitter.completedCount),
            color: AppColors.primary,
            icon: Icons.verified_rounded,
          ),
      ],
    );
  }
}

const sittingGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.primary, AppColors.primaryDark],
);

int sittingDays(DateTime a, DateTime b) => b.difference(a).inDays + 1;

// A small calendar page: month on top, day underneath.
class DateBadge extends StatelessWidget {
  final DateTime date;
  final Color color;

  const DateBadge({super.key, required this.date, this.color = sittingColor});

  @override
  Widget build(BuildContext context) {
    final locale = context.l10n.localeName;
    return Container(
      width: 54,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: color,
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              DateFormat.MMM(locale).format(date).toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              DateFormat.d(locale).format(date),
              style: TextStyle(
                fontSize: 22,
                height: 1.1,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        ],
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
    this.color = AppColors.textMuted,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

class StatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color = sittingColor,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
        Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            height: 1.2,
            color: AppColors.textMuted,
          ),
        ),
      ],
    ),
  );
}

// Tiles in equal rows.
class StatGrid extends StatelessWidget {
  final List<Widget> tiles;
  final int perRow;

  const StatGrid({super.key, required this.tiles, this.perRow = 2});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < tiles.length; i += perRow) ...[
        if (i > 0) const SizedBox(height: 8),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = i; j < i + perRow; j++) ...[
                if (j > i) const SizedBox(width: 8),
                Expanded(child: j < tiles.length ? tiles[j] : const SizedBox()),
              ],
            ],
          ),
        ),
      ],
    ],
  );
}

// Numbered title for the steps of a form.
class StepTitle extends StatelessWidget {
  final int number;
  final String text;

  const StepTitle(this.number, this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: sittingGradient,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    ),
  );
}

// Where a request is: published, booked, confirmed, reviewed.
class StatusTimeline extends StatelessWidget {
  final List<String> steps;
  final int reached;

  const StatusTimeline({super.key, required this.steps, required this.reached});

  @override
  Widget build(BuildContext context) {
    Widget dot(int i) {
      final done = i <= reached;
      return Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: done ? sittingGradient : null,
          color: done ? null : AppColors.background,
          border: done ? null : Border.all(color: AppColors.border, width: 2),
        ),
        child: done
            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
            : null,
      );
    }

    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < steps.length; i++) ...[
              dot(i),
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: i < reached ? sittingColor : AppColors.border,
                    ),
                  ),
                ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            for (var i = 0; i < steps.length; i++)
              Expanded(
                child: Text(
                  steps[i],
                  textAlign: i == 0
                      ? TextAlign.start
                      : i == steps.length - 1
                      ? TextAlign.end
                      : TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: i <= reached
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: i <= reached ? AppColors.text : AppColors.textMuted,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class RequestCard extends StatelessWidget {
  final SittingRequest request;
  final double? km;
  final VoidCallback onTap;

  const RequestCard({
    super.key,
    required this.request,
    required this.onTap,
    this.km,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final r = request;
    return SittingCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateBadge(
            date: r.start,
            color: r.status == SittingStatus.open
                ? sittingColor
                : r.status.color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(r.service.icon, size: 18, color: sittingColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        r.service.label(l10n),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SittingChip(r.status.label(l10n), color: r.status.color),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    for (final s in r.species) ...[
                      FaIcon(
                        speciesIcon(s),
                        size: 13,
                        color: AppColors.primaryDark,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        r.petNames.join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    InfoPill(
                      icon: Icons.date_range_rounded,
                      text: sittingDates(l10n, r.start, r.end),
                    ),
                    InfoPill(
                      icon: Icons.place_outlined,
                      text: km == null
                          ? r.city
                          : l10n.sitCityDistance(r.city, km!.round()),
                    ),
                    if (r.budget.isNotEmpty)
                      InfoPill(
                        icon: Icons.payments_outlined,
                        text: r.budget,
                        color: AppColors.primary,
                      ),
                    if (r.offerCount > 0 && r.status == SittingStatus.open)
                      InfoPill(
                        icon: Icons.local_offer_outlined,
                        text: l10n.sitOffersTitle(r.offerCount),
                        color: AppColors.rewardText,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SitterCard extends StatelessWidget {
  final SitterProfile sitter;
  final double? km;
  final VoidCallback onTap;

  const SitterCard({
    super.key,
    required this.sitter,
    required this.onTap,
    this.km,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final s = sitter;
    final rating = s.rating;
    return SittingCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      gradient: sittingGradient,
                      shape: BoxShape.circle,
                    ),
                    child: SittingAvatar(
                      name: s.name,
                      photoUrl: s.photoUrl,
                      radius: 26,
                    ),
                  ),
                  if (rating != null)
                    PositionedDirectional(
                      bottom: -6,
                      end: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.surface,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 11,
                              color: Colors.white,
                            ),
                            Text(
                              NumberFormat(
                                '0.0',
                                l10n.localeName,
                              ).format(rating),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            s.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                        if (s.completedCount > 0) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        InfoPill(
                          icon: Icons.place_outlined,
                          text: km == null
                              ? s.city
                              : l10n.sitCityDistance(s.city, km!.round()),
                        ),
                        if (s.completedCount > 0)
                          InfoPill(
                            icon: Icons.task_alt_rounded,
                            text: l10n.sitCompletedCount(s.completedCount),
                            color: AppColors.primary,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            s.about,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.35,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final sv in s.services.take(5))
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Tooltip(
                    message: sv.label(l10n),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: sittingColor.withValues(alpha: 0.1),
                      child: Icon(sv.icon, size: 16, color: sittingColor),
                    ),
                  ),
                ),
              const Spacer(),
              for (final sp in s.species)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 6),
                  child: FaIcon(
                    speciesIcon(sp),
                    size: 14,
                    color: AppColors.primaryDark,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class SittingEmpty extends StatelessWidget {
  final IconData icon;
  final String text;

  const SittingEmpty({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
    child: Column(
      children: [
        Icon(icon, size: 40, color: AppColors.textMuted),
        const SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textMuted),
        ),
      ],
    ),
  );
}

class SafetyNote extends StatelessWidget {
  const SafetyNote({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SittingCard(
      tint: AppColors.accent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.shield_outlined, color: AppColors.rewardText),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.sitSafetyTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.sitSafetyText,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Shortcut in the Pets tab, with the unread chat count.
class SittingPromoCard extends StatelessWidget {
  final int unread;
  final VoidCallback onTap;

  const SittingPromoCard({
    super.key,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SittingCard(
      tint: sittingColor,
      onTap: onTap,
      child: Row(
        children: [
          Badge(
            isLabelVisible: unread > 0,
            label: Text('$unread'),
            child: const CircleAvatar(
              radius: 21,
              backgroundColor: sittingColor,
              child: Icon(
                Icons.volunteer_activism_rounded,
                color: Colors.white,
                size: 21,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.sitTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.sitPromo,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: sittingColor),
        ],
      ),
    );
  }
}

// The app's standard tabs: white track, green pill (as on Home and My reports).
class SittingTabs extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final bool scrollable;

  const SittingTabs({super.key, required this.tabs, this.scrollable = false});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
    child: Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: TabBar(
        isScrollable: scrollable,
        tabAlignment: scrollable ? TabAlignment.start : null,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textMuted,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        splashBorderRadius: BorderRadius.circular(20),
        labelPadding: scrollable
            ? const EdgeInsets.symmetric(horizontal: 14)
            : null,
        tabs: tabs,
      ),
    ),
  );
}

enum BusyKind { filled, outlined, text }

// A button that shows a spinner and ignores taps while its action runs.
class BusyButton extends StatefulWidget {
  final BusyKind kind;
  final Future<void> Function() onPressed;
  // Asked first, before the spinner (for example a confirmation dialog).
  final Future<bool> Function()? before;
  final Widget label;
  final Widget? icon;
  final ButtonStyle? style;

  const BusyButton({
    super.key,
    required this.kind,
    required this.onPressed,
    required this.label,
    this.before,
    this.icon,
    this.style,
  });

  @override
  State<BusyButton> createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  bool _busy = false;

  Future<void> _run() async {
    if (_busy) return;
    if (widget.before != null && !await widget.before!()) return;
    if (!mounted) return;
    setState(() => _busy = true);
    try {
      await widget.onPressed();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final spinner = SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: widget.kind == BusyKind.filled ? Colors.white : sittingColor,
      ),
    );
    final icon = _busy ? spinner : widget.icon;
    void onPressed() => _busy ? null : _run();
    return switch ((widget.kind, icon)) {
      (BusyKind.filled, final i?) => FilledButton.icon(
        style: widget.style,
        onPressed: onPressed,
        icon: i,
        label: widget.label,
      ),
      (BusyKind.filled, null) => FilledButton(
        style: widget.style,
        onPressed: onPressed,
        child: widget.label,
      ),
      (BusyKind.outlined, final i?) => OutlinedButton.icon(
        style: widget.style,
        onPressed: onPressed,
        icon: i,
        label: widget.label,
      ),
      (BusyKind.outlined, null) => OutlinedButton(
        style: widget.style,
        onPressed: onPressed,
        child: widget.label,
      ),
      (BusyKind.text, final i?) => TextButton.icon(
        style: widget.style,
        onPressed: onPressed,
        icon: i,
        label: widget.label,
      ),
      (BusyKind.text, null) => TextButton(
        style: widget.style,
        onPressed: onPressed,
        child: widget.label,
      ),
    };
  }
}
