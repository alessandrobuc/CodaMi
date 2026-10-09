import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/reports_entity.dart';
import '../providers/reports_provider.dart';
import '../widgets/report_actions.dart';
import '../widgets/reports_widget.dart';
import 'create_report_screen.dart';
import 'report_detail_screen.dart';

class MyReportsScreen extends ConsumerWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myReportsProvider);
    final reports = state.value ?? const <Report>[];
    final active = reports.where((r) => r.isOpen).toList();
    final resolved = reports.where((r) => !r.isOpen).toList();
    final l10n = context.l10n;

    final Widget body;
    if (state.isLoading && !state.hasValue) {
      body = const Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ReportListSkeleton(),
      );
    } else if (state.hasError && !state.hasValue) {
      body = _Message(
        child: EmptyState(
          icon: const Icon(Icons.cloud_off_rounded),
          color: AppColors.lostPin,
          title: l10n.myReportsLoadError,
          message: l10n.checkConnection,
        ),
      );
    } else {
      body = TabBarView(
        children: [
          _ReportsList(
            reports: active,
            empty: EmptyState(
              icon: const Icon(Icons.campaign_rounded),
              color: AppColors.lostPin,
              title: l10n.noActiveReports,
              message: l10n.noActiveReportsMessage,
              action: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateReportScreen()),
                ),
                icon: const Icon(Icons.add_rounded),
                label: Text(l10n.reportAPet),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          _ReportsList(
            reports: resolved,
            empty: EmptyState(
              icon: const Icon(Icons.home_rounded),
              title: l10n.nothingResolved,
              message: l10n.nothingResolvedMessage,
            ),
          ),
        ],
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
                child: Row(
                  children: [
                    const BackButton(color: AppColors.text),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.myReports,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text,
                                ),
                          ),
                          Text(
                            l10n.myReportsSubtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _StatsCard(
                  active: state.hasValue ? active.length : null,
                  resolved: state.hasValue ? resolved.length : null,
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: _PillTabs(
                  labels: [l10n.reportActive, l10n.reportResolved],
                  counts: state.hasValue
                      ? [active.length, resolved.length]
                      : const [0, 0],
                ),
              ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final int? active;
  final int? resolved;

  const _StatsCard({required this.active, required this.resolved});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final total = active == null || resolved == null
        ? null
        : active! + resolved!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _Stat(
              icon: Icons.campaign_rounded,
              value: active,
              label: l10n.reportActive,
            ),
            const _StatDivider(),
            _Stat(
              icon: Icons.home_rounded,
              value: resolved,
              label: l10n.backHome,
            ),
            const _StatDivider(),
            _Stat(
              icon: Icons.pets_rounded,
              value: total,
              label: l10n.statTotal,
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final int? value;
  final String label;

  const _Stat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.white.withValues(alpha: 0.75)),
          const SizedBox(height: 6),
          Text(
            value?.toString() ?? '–',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: 1,
      thickness: 1,
      indent: 6,
      endIndent: 6,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}

class _PillTabs extends StatelessWidget {
  final List<String> labels;
  final List<int> counts;

  const _PillTabs({required this.labels, required this.counts});

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: TabBar(
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
        tabs: [
          for (var i = 0; i < labels.length; i++)
            Tab(
              child: AnimatedBuilder(
                animation: controller.animation!,
                builder: (context, _) {
                  final selected = controller.index == i;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(labels[i], overflow: TextOverflow.ellipsis),
                      ),
                      if (counts[i] > 0) ...[
                        const SizedBox(width: 6),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.white.withValues(alpha: 0.22)
                                : AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${counts[i]}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: selected
                                  ? Colors.white
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final Widget child;

  const _Message({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

class _ReportsList extends StatelessWidget {
  final List<Report> reports;
  final Widget empty;

  const _ReportsList({required this.reports, required this.empty});

  @override
  Widget build(BuildContext context) {
    if (reports.isEmpty) return _Message(child: empty);

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        24 + MediaQuery.paddingOf(context).bottom,
      ),
      itemCount: reports.length,
      itemBuilder: (context, i) {
        final delay = (45 * i.clamp(0, 6)).ms;
        return _MyReportItem(key: ValueKey(reports[i].id), report: reports[i])
            .animate()
            .fadeIn(delay: delay, duration: 320.ms)
            .slideY(begin: 0.12, end: 0, delay: delay);
      },
    );
  }
}

class _MyReportItem extends ConsumerStatefulWidget {
  final Report report;

  const _MyReportItem({super.key, required this.report});

  @override
  ConsumerState<_MyReportItem> createState() => _MyReportItemState();
}

class _MyReportItemState extends ConsumerState<_MyReportItem> {
  bool _busy = false;

  void _setBusy(bool value) {
    if (mounted) setState(() => _busy = value);
  }

  @override
  Widget build(BuildContext context) {
    final report = widget.report;
    final l10n = context.l10n;
    final posted = report.createdAt ?? report.eventAt;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ReportCard(
        report: report,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ReportDetailScreen(report: report)),
        ),
        footer: Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 0, 0),
          child: Row(
            children: [
              if (report.isOpen)
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: _PillButton(
                      icon: Icons.check_circle_rounded,
                      label: report.type == ReportType.lost
                          ? l10n.markAsFound
                          : l10n.returnedToOwner,
                      color: AppColors.primary,
                      onTap: _busy
                          ? null
                          : () => resolveReport(
                              context,
                              ref,
                              report,
                              onBusy: _setBusy,
                            ),
                    ),
                  ),
                )
              else ...[
                const Icon(
                  Icons.event_rounded,
                  size: 15,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    l10n.postedOn(shortDate(posted)),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 8),
              _busy
                  ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.all(11),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : IconButton(
                      onPressed: () =>
                          deleteReport(context, ref, report, onBusy: _setBusy),
                      tooltip: l10n.deleteReport,
                      icon: const Icon(Icons.delete_outline_rounded, size: 20),
                      style: IconButton.styleFrom(
                        foregroundColor: AppColors.danger,
                        backgroundColor: AppColors.danger.withValues(
                          alpha: 0.08,
                        ),
                        minimumSize: const Size(40, 40),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _PillButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17, color: color),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
