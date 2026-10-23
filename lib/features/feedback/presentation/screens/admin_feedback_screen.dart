import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../data/feedback_repository.dart';

final _feedbackProvider = StreamProvider.autoDispose<List<FeedbackEntry>>(
  (ref) => ref.watch(feedbackRepositoryProvider).watchLatest(),
);

class AdminFeedbackScreen extends ConsumerStatefulWidget {
  const AdminFeedbackScreen({super.key});

  @override
  ConsumerState<AdminFeedbackScreen> createState() =>
      _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends ConsumerState<AdminFeedbackScreen> {
  int? _stars;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(_feedbackProvider);
    final all = state.value ?? const <FeedbackEntry>[];
    final shown = [
      for (final f in all)
        if (_stars == null || f.rating == _stars) f,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.adminFeedback),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.actionFailed)),
        data: (_) => all.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: EmptyState(
                    icon: const Icon(
                      Icons.rate_review_rounded,
                      size: 44,
                      color: AppColors.accent,
                    ),
                    color: AppColors.accent,
                    title: l10n.adminFeedback,
                    message: l10n.adminFeedbackEmpty,
                  ),
                ),
              )
            : ListView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  4,
                  16,
                  MediaQuery.paddingOf(context).bottom + 32,
                ),
                children: [
                  _Summary(
                    entries: all,
                    selected: _stars,
                    onSelect: (stars) =>
                        setState(() => _stars = _stars == stars ? null : stars),
                  ),
                  const SizedBox(height: 12),
                  for (final entry in shown) ...[
                    _FeedbackCard(entry: entry),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  final List<FeedbackEntry> entries;
  final int? selected;
  final ValueChanged<int> onSelect;

  const _Summary({
    required this.entries,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final counts = {
      for (var s = 1; s <= 5; s++)
        s: entries.where((e) => e.rating == s).length,
    };
    final average =
        entries.fold<int>(0, (sum, e) => sum + e.rating) / entries.length;
    final most = counts.values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                average.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              _Stars(rating: average.round(), size: 16),
              const SizedBox(height: 4),
              Text(
                l10n.feedbackRatingsCount(entries.length),
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                for (var s = 5; s >= 1; s--)
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => onSelect(s),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14,
                            child: Text(
                              '$s',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: selected == s
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: selected == s
                                    ? AppColors.primary
                                    : AppColors.textMuted,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                minHeight: 8,
                                value: most == 0 ? 0 : counts[s]! / most,
                                backgroundColor: AppColors.background,
                                color: selected == null || selected == s
                                    ? AppColors.accent
                                    : AppColors.border,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 28,
                            child: Text(
                              '${counts[s]}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
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

class _Stars extends StatelessWidget {
  final int rating;
  final double size;

  const _Stars({required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var s = 1; s <= 5; s++)
          Icon(
            s <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: s <= rating ? AppColors.accent : AppColors.border,
          ),
      ],
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final FeedbackEntry entry;

  const _FeedbackCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final time = entry.createdAt;
    final details = [
      if (entry.appVersion case final v? when v.isNotEmpty) 'v$v',
      ?entry.platform,
      if (time != null) timeAgo(l10n, time),
    ].join(' · ');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Stars(rating: entry.rating),
              const Spacer(),
              Text(
                details,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.comment.isEmpty ? l10n.feedbackNoComment : entry.comment,
            style: TextStyle(
              fontSize: 14.5,
              height: 1.4,
              fontStyle: entry.comment.isEmpty
                  ? FontStyle.italic
                  : FontStyle.normal,
              color: entry.comment.isEmpty
                  ? AppColors.textMuted
                  : AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            [entry.name, entry.email].where((t) => t.isNotEmpty).join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
