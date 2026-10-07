import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/reports_entity.dart';
import '../providers/reports_provider.dart';
import '../widgets/reports_widget.dart';
import 'report_detail_screen.dart';

class ReportsListView extends ConsumerWidget {
  final ReportType type;

  const ReportsListView({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showResolved = type == ReportType.found;
    final state = ref.watch(openReportsProvider(type));
    final resolvedState = showResolved
        ? ref.watch(resolvedReportsProvider)
        : const AsyncData(<Report>[]);
    final reports = state.value ?? const <Report>[];
    final resolved = resolvedState.value ?? const <Report>[];
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 96;

    final loading =
        (state.isLoading && !state.hasValue) ||
        (resolvedState.isLoading && !resolvedState.hasValue);
    final empty = reports.isEmpty && resolved.isEmpty;

    Widget content;
    if (loading && empty) {
      content = const ReportListSkeleton();
    } else if (state.hasError && !state.hasValue) {
      content = const EmptyState(
        icon: Icon(Icons.cloud_off_rounded),
        color: AppColors.lostPin,
        title: 'Couldn\'t load reports',
        message: 'Check your connection and pull down to try again.',
      );
    } else if (empty) {
      content = type == ReportType.lost
          ? const EmptyState(
              icon: Icon(Icons.search_rounded),
              color: AppColors.lostPin,
              title: 'No lost pets nearby',
              message:
                  'Good news! Nobody has reported a lost pet in your area yet.',
            )
          : const EmptyState(
              icon: Icon(Icons.volunteer_activism_rounded),
              color: AppColors.foundPin,
              title: 'No found pets yet',
              message: 'Pets found by your neighbours will show up here.',
            );
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ..._cards(context, reports),
          if (resolved.isNotEmpty) ...[
            if (reports.isNotEmpty) const SizedBox(height: 10),
            const _SectionHeader(
              title: 'Back home',
              subtitle: 'Pets that found their way back to their families.',
            ),
            const SizedBox(height: 12),
            ..._cards(context, resolved, offset: reports.length),
          ],
        ],
      );
    }

    final centered = empty && !loading;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => Future.wait([
        ref.refresh(openReportsProvider(type).future),
        if (showResolved) ref.refresh(resolvedReportsProvider.future),
      ]),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(0, 16, 0, bottomPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: centered
                  ? (constraints.maxHeight - 16 - bottomPadding).clamp(
                      0,
                      double.infinity,
                    )
                  : 0,
            ),
            child: centered ? Center(child: content) : content,
          ),
        ),
      ),
    );
  }

  List<Widget> _cards(
    BuildContext context,
    List<Report> reports, {
    int offset = 0,
  }) {
    return [
      for (final (i, report) in reports.indexed)
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child:
              ReportCard(
                    key: ValueKey(report.id),
                    report: report,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ReportDetailScreen(report: report),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: (50 * (i + offset)).ms, duration: 350.ms)
                  .slideY(
                    begin: 0.15,
                    end: 0,
                    delay: (50 * (i + offset)).ms,
                    curve: Curves.easeOutCubic,
                  ),
        ),
    ];
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.home_rounded,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
