import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../domain/entities/reports_entity.dart';

Color reportColor(ReportType type) =>
    type == ReportType.lost ? AppColors.lostPin : AppColors.foundPin;

Color pinColor(Report report) =>
    report.isOpen ? reportColor(report.type) : AppColors.foundPin;

class ReportTypeBadge extends StatelessWidget {
  final ReportType type;
  final bool large;

  const ReportTypeBadge({super.key, required this.type, this.large = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 12 : 9,
        vertical: large ? 6 : 3,
      ),
      decoration: BoxDecoration(
        color: reportColor(type),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type.label.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: large ? 12 : 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class ResolvedBadge extends StatelessWidget {
  final String label;

  const ResolvedBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.home_rounded, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatefulWidget {
  final Report report;
  final VoidCallback onTap;

  const ReportCard({super.key, required this.report, required this.onTap});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final report = widget.report;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryDark.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 98,
                height: 98,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: 'report-photo-${report.id}',
                    child: PetImage.url(report.coverUrl),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        report.isOpen
                            ? ReportTypeBadge(type: report.type)
                            : ResolvedBadge(label: report.resolvedLabel),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            timeAgo(
                              report.resolvedAt ??
                                  report.createdAt ??
                                  report.eventAt,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        FaIcon(
                          speciesIcon(report.species),
                          size: 13,
                          color: speciesColor(report.species),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      report.petName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: pinColor(report),
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            report.placeLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      report.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportListSkeleton extends StatelessWidget {
  const ReportListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => const Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: SizedBox(height: 118, child: ShimmerBox(radius: 22)),
        ),
      ),
    );
  }
}
