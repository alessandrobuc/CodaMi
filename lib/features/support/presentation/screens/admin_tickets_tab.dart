import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../data/support_repository.dart';
import '../../domain/support_case.dart';
import '../providers/presence_provider.dart';
import '../providers/support_provider.dart';
import '../widgets/case_tile.dart';
import '../widgets/support_labels.dart';
import 'support_case_screen.dart';

class AdminTicketsTab extends ConsumerStatefulWidget {
  const AdminTicketsTab({super.key});

  @override
  ConsumerState<AdminTicketsTab> createState() => _AdminTicketsTabState();
}

class _AdminTicketsTabState extends ConsumerState<AdminTicketsTab> {
  CaseFilter _filter = CaseFilter.unanswered;
  final _search = TextEditingController();
  Future<List<SupportCase>>? _results;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  String _label(CaseFilter filter) => switch (filter) {
    CaseFilter.unanswered => context.l10n.filterUnanswered,
    CaseFilter.unassigned => context.l10n.filterUnassigned,
    CaseFilter.mine => context.l10n.filterMine,
    CaseFilter.active => context.l10n.filterActive,
    CaseFilter.done => context.l10n.filterDone,
  };

  void _select(CaseFilter filter) {
    ref.invalidate(supportCountsProvider);
    setState(() => _filter = filter);
  }

  void _runSearch(String text) {
    setState(() {
      _results = text.trim().isEmpty
          ? null
          : ref.read(supportRepositoryProvider).search(text);
    });
  }

  void _open(SupportCase c) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => SupportCaseScreen(caseId: c.id, asStaff: true),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final counts = ref.watch(supportCountsProvider).value;
    final unanswered = counts?.unanswered;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.adminTickets,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                        ),
                        if (unanswered != null)
                          Text(
                            unanswered == 0
                                ? l10n.ticketsAllClear
                                : l10n.ticketsWaiting(unanswered),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: unanswered == 0
                                  ? AppColors.primary
                                  : AppColors.accent,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const _PresenceToggle(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  _CountCard(
                    icon: Icons.mark_chat_unread_rounded,
                    color: AppColors.accent,
                    label: l10n.filterUnanswered,
                    value: counts?.unanswered,
                    selected: _filter == CaseFilter.unanswered,
                    onTap: () => _select(CaseFilter.unanswered),
                  ),
                  const SizedBox(width: 10),
                  _CountCard(
                    icon: Icons.inbox_rounded,
                    color: AppColors.lostPin,
                    label: l10n.filterUnassigned,
                    value: counts?.unassigned,
                    selected: _filter == CaseFilter.unassigned,
                    onTap: () => _select(CaseFilter.unassigned),
                  ),
                  const SizedBox(width: 10),
                  _CountCard(
                    icon: Icons.alarm_rounded,
                    color: AppColors.danger,
                    label: l10n.supportOverdue,
                    value: counts?.overdue,
                    selected: false,
                    onTap: () => _select(CaseFilter.unanswered),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: TextField(
                controller: _search,
                textInputAction: TextInputAction.search,
                onSubmitted: _runSearch,
                decoration: InputDecoration(
                  hintText: l10n.supportSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _results == null
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _search.clear();
                            _runSearch('');
                          },
                        ),
                  filled: true,
                  fillColor: AppColors.surface,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
              ),
            ),
            if (_results == null)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Row(
                  children: [
                    for (final filter in CaseFilter.values) ...[
                      ChoiceChip(
                        label: Text(_label(filter)),
                        selected: filter == _filter,
                        showCheckmark: false,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        side: BorderSide(
                          color: filter == _filter
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: filter == _filter
                              ? Colors.white
                              : AppColors.text,
                        ),
                        onSelected: (_) => _select(filter),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
            Expanded(
              child: _results == null
                  ? _FilteredList(filter: _filter, onOpen: _open)
                  : FutureBuilder<List<SupportCase>>(
                      future: _results,
                      builder: (context, snap) {
                        if (snap.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snap.hasError) {
                          return Center(child: Text(l10n.actionFailed));
                        }
                        return CaseList(cases: snap.data!, onOpen: _open);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PresenceToggle extends ConsumerWidget {
  const _PresenceToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final available = ref.watch(chatAvailabilityProvider);
    final state = available ? PresenceState.online : PresenceState.away;

    return Tooltip(
      message: l10n.presenceAvailableSubtitle,
      child: Material(
        color: state.color.withValues(alpha: 0.12),
        shape: const StadiumBorder(),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () =>
              ref.read(chatAvailabilityProvider.notifier).set(!available),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PresenceDot(state, size: 10),
                const SizedBox(width: 6),
                Text(
                  state.label(l10n),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: state.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int? value;
  final bool selected;
  final VoidCallback onTap;

  const _CountCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: selected ? color.withValues(alpha: 0.1) : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: selected ? color : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(height: 6),
                Text(
                  value?.toString() ?? '–',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilteredList extends ConsumerWidget {
  final CaseFilter filter;
  final void Function(SupportCase) onOpen;

  const _FilteredList({required this.filter, required this.onOpen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(staffCasesProvider(filter));
    final limit = ref.watch(supportLimitProvider(filter));
    if (state.isLoading && !state.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasError && !state.hasValue) {
      return Center(child: Text(context.l10n.actionFailed));
    }
    final all = state.value!;
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(supportCountsProvider),
      child: CaseList(
        cases: all.take(limit).toList(),
        onOpen: onOpen,
        onLoadMore: all.length > limit
            ? () => ref
                  .read(supportLimitProvider(filter).notifier)
                  .loadMore(loaded: all.length)
            : null,
      ),
    );
  }
}

class CaseList extends StatelessWidget {
  final List<SupportCase> cases;
  final void Function(SupportCase) onOpen;
  final VoidCallback? onLoadMore;

  const CaseList({
    super.key,
    required this.cases,
    required this.onOpen,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottom = 120 + MediaQuery.viewPaddingOf(context).bottom;
    if (cases.isEmpty) {
      return ListView(
        padding: EdgeInsets.fromLTRB(20, 40, 20, bottom),
        children: [
          EmptyState(
            icon: const Icon(Icons.inbox_rounded),
            title: l10n.supportNoCases,
            message: l10n.supportNoCasesMessage,
          ),
        ],
      );
    }
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 4, 20, bottom),
      itemCount: cases.length + (onLoadMore != null ? 1 : 0),
      itemBuilder: (context, i) {
        if (i == cases.length) {
          return Center(
            child: TextButton.icon(
              onPressed: onLoadMore,
              icon: const Icon(Icons.expand_more_rounded),
              label: Text(l10n.loadMore),
            ),
          );
        }
        final c = cases[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CaseTile(
            key: ValueKey(c.id),
            supportCase: c,
            forStaff: true,
            onTap: () => onOpen(c),
          ),
        );
      },
    );
  }
}
