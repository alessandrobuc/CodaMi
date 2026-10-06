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
    final state = ref.watch(openReportsProvider(type));
    final reports = state.value ?? const <Report>[];
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 96;

    Widget content;
    if (state.isLoading && !state.hasValue) {
      content = const ReportListSkeleton();
    } else if (state.hasError && !state.hasValue) {
      content = const EmptyState(
        icon: Icon(Icons.cloud_off_rounded),
        color: AppColors.lostPin,
        title: 'Couldn\'t load reports',
        message: 'Check your connection and pull down to try again.',
      );
    } else if (reports.isEmpty) {
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
        children: [
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
                      .fadeIn(delay: (50 * i).ms, duration: 350.ms)
                      .slideY(
                        begin: 0.15,
                        end: 0,
                        delay: (50 * i).ms,
                        curve: Curves.easeOutCubic,
                      ),
            ),
        ],
      );
    }

    final centered = reports.isEmpty && !(state.isLoading && !state.hasValue);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(openReportsProvider(type).future),
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
}
