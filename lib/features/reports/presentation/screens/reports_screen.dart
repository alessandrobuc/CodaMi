import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../map/presentation/providers/map_provider.dart';
import '../../domain/entities/reports_entity.dart';
import '../providers/reports_provider.dart';
import '../widgets/reports_widget.dart';
import 'report_detail_screen.dart';

class ReportsListView extends ConsumerWidget {
  final ReportType type;

  const ReportsListView({super.key, required this.type});

  static const _bottomPadding = 96.0;
  static const _loadMoreExtent = 600.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showResolved = type == ReportType.found;
    final state = ref.watch(areaReportsProvider(type));
    final resolvedState = showResolved
        ? ref.watch(areaResolvedReportsProvider)
        : const AsyncData(<Report>[]);
    final reports = state.value ?? const <Report>[];
    final resolved = resolvedState.value ?? const <Report>[];
    final hasMore = ref.watch(hasMoreReportsProvider(type));
    final loadingMore = ref.watch(openReportsProvider(type)).isLoading;

    final loading =
        (state.isLoading && !state.hasValue) ||
        (resolvedState.isLoading && !resolvedState.hasValue);
    final empty = reports.isEmpty && resolved.isEmpty;

    void loadMore() {
      if (!hasMore || loadingMore) return;
      final loaded = ref.read(openReportsProvider(type)).value?.length ?? 0;
      ref.read(reportsLimitProvider(type).notifier).loadMore(loaded: loaded);
    }

    Widget? placeholder;
    if (loading && empty) {
      placeholder = const ReportListSkeleton();
    } else if (state.hasError && !state.hasValue) {
      placeholder = const EmptyState(
        icon: Icon(Icons.cloud_off_rounded),
        color: AppColors.lostPin,
        title: 'Couldn\'t load reports',
        message: 'Check your connection and pull down to try again.',
      );
    } else if (empty && !hasMore) {
      placeholder = type == ReportType.lost
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
    }

    final slivers = <Widget>[
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      if (placeholder != null)
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(bottom: _bottomPadding),
            child: loading ? placeholder : Center(child: placeholder),
          ),
        )
      else ...[
        SliverList.builder(
          itemCount: reports.length,
          itemBuilder: (context, i) => _card(context, reports[i], i),
        ),
        SliverToBoxAdapter(
          child: _ListFooter(
            hasMore: hasMore,
            loading: loadingMore,
            shown: reports.length,
            onLoadMore: loadMore,
          ),
        ),
        if (resolved.isNotEmpty) ...[
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 6, bottom: 12),
              child: _SectionHeader(
                title: 'Back home',
                subtitle: 'Pets that found their way back to their families.',
              ),
            ),
          ),
          SliverList.builder(
            itemCount: resolved.length,
            itemBuilder: (context, i) => _card(context, resolved[i], i),
          ),
        ],
        const SliverToBoxAdapter(child: SizedBox(height: _bottomPadding)),
      ],
    ];

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => Future.wait([
        ref.refresh(openReportsProvider(type).future),
        if (showResolved) ref.refresh(resolvedReportsProvider.future),
      ]),
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n.metrics.axis == Axis.vertical &&
              n.metrics.extentAfter < _loadMoreExtent) {
            loadMore();
          }
          return false;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: slivers,
        ),
      ),
    );
  }

  Widget _card(BuildContext context, Report report, int index) {
    final delay = (45 * (index % reportsPageSize).clamp(0, 6)).ms;
    return Padding(
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
              .animate(key: ValueKey(report.id))
              .fadeIn(delay: delay, duration: 320.ms)
              .slideY(
                begin: 0.12,
                end: 0,
                delay: delay,
                curve: Curves.easeOutCubic,
              ),
    );
  }
}

class _ListFooter extends StatelessWidget {
  final bool hasMore;
  final bool loading;
  final int shown;
  final VoidCallback onLoadMore;

  const _ListFooter({
    required this.hasMore,
    required this.loading,
    required this.shown,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (hasMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: loading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    width: 26,
                    height: 26,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : TextButton.icon(
                    key: const ValueKey('more'),
                    onPressed: onLoadMore,
                    icon: const Icon(Icons.expand_more_rounded),
                    label: const Text('Load more'),
                  ),
          ),
        ),
      );
    }
    if (shown < reportsPageSize) return const SizedBox(height: 4);
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 16,
            color: AppColors.textMuted,
          ),
          SizedBox(width: 6),
          Text(
            'You\'re all caught up',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
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
