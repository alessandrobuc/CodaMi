import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../moderation/data/moderation_repository.dart';
import '../../../moderation/presentation/providers/moderation_provider.dart';
import '../../../moderation/presentation/widgets/flag_actions.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../../reports/presentation/providers/reports_provider.dart';
import '../../../reports/presentation/screens/report_detail_screen.dart';
import '../../../reports/presentation/widgets/reports_widget.dart';

class AdminReportedTab extends ConsumerWidget {
  const AdminReportedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(flaggedReportsProvider);
    final items = state.value ?? const <FlaggedReport>[];

    final Widget body;
    if (state.isLoading && !state.hasValue) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state.hasError && !state.hasValue) {
      body = Center(child: Text(l10n.actionFailed));
    } else if (items.isEmpty) {
      body = Center(
        child: EmptyState(
          icon: const Icon(Icons.verified_user_rounded),
          title: l10n.noReportedContent,
          message: l10n.noReportedContentMessage,
        ),
      );
    } else {
      body = ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) =>
            _FlaggedItem(key: ValueKey(items[i].reportId), item: items[i]),
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
                l10n.adminReportedContent,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _FlaggedItem extends ConsumerWidget {
  final FlaggedReport item;

  const _FlaggedItem({super.key, required this.item});

  Future<void> _dismiss(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(moderationRepositoryProvider).dismissFlags(item.reportId);
    } catch (_) {
      if (context.mounted) {
        SnackbarUtils.showError(context, context.l10n.actionFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final reportState = ref.watch(reportProvider(item.reportId));
    final report = reportState.value;
    final missing = reportState.hasValue && report == null;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: report == null
            ? null
            : () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReportDetailScreen(report: report),
                ),
              ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: PetImage.url(report?.coverUrl),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (report != null)
                          report.isOpen
                              ? ReportTypeBadge(type: report.type)
                              : ResolvedBadge(
                                  label: report.resolvedLabel(l10n),
                                  hidden: report.isHidden,
                                ),
                        const Spacer(),
                        if (item.latest case final at?)
                          Text(
                            timeAgo(l10n, at),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      missing ? l10n.listingUnavailable : report?.petName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.flagCount(item.flags.length),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.danger,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final reason in item.reasons)
                          _ReasonChip(label: reason.label(l10n)),
                      ],
                    ),
                    if (missing)
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () => _dismiss(context, ref),
                          child: Text(l10n.dismissFlags),
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

class _ReasonChip extends StatelessWidget {
  final String label;

  const _ReasonChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: AppColors.danger,
        ),
      ),
    );
  }
}
