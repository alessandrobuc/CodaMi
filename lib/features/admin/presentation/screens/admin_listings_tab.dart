import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../../reports/presentation/screens/report_detail_screen.dart';
import '../../../reports/presentation/widgets/reports_widget.dart';
import '../providers/admin_provider.dart';

class AdminListingsTab extends ConsumerStatefulWidget {
  const AdminListingsTab({super.key});

  @override
  ConsumerState<AdminListingsTab> createState() => _AdminListingsTabState();
}

class _AdminListingsTabState extends ConsumerState<AdminListingsTab> {
  ReportStatus _status = ReportStatus.open;

  String _label(ReportStatus status) => switch (status) {
    ReportStatus.open => context.l10n.filterOpen,
    ReportStatus.resolved => context.l10n.filterResolved,
    _ => context.l10n.filterHidden,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(adminReportsProvider(_status));
    final limit = ref.watch(adminLimitProvider(_status));
    final all = state.value ?? const <Report>[];
    final hasMore = all.length > limit;
    final reports = all.take(limit).toList();

    final Widget body;
    if (state.isLoading && !state.hasValue) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state.hasError && !state.hasValue) {
      body = Center(child: Text(l10n.actionFailed));
    } else if (reports.isEmpty) {
      body = Center(
        child: EmptyState(
          icon: const Icon(Icons.campaign_rounded),
          title: l10n.noListings,
          message: l10n.tryAnotherFilter,
        ),
      );
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
        itemCount: reports.length + (hasMore ? 1 : 0),
        itemBuilder: (context, i) {
          if (i == reports.length) {
            return Center(
              child: TextButton.icon(
                onPressed: () => ref
                    .read(adminLimitProvider(_status).notifier)
                    .loadMore(loaded: all.length),
                icon: const Icon(Icons.expand_more_rounded),
                label: Text(l10n.loadMore),
              ),
            );
          }
          final report = reports[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ReportCard(
              key: ValueKey(report.id),
              report: report,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReportDetailScreen(report: report),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                l10n.adminListings,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                children: [
                  for (final status in [
                    ReportStatus.open,
                    ReportStatus.resolved,
                    ReportStatus.hidden,
                  ]) ...[
                    ChoiceChip(
                      label: Text(_label(status)),
                      selected: status == _status,
                      showCheckmark: false,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: status == _status
                            ? Colors.white
                            : AppColors.text,
                      ),
                      onSelected: (_) => setState(() => _status = status),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
