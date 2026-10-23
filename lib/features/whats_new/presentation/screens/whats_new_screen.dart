import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../domain/release_note.dart';
import '../../data/release_notes_repository.dart';
import '../providers/notes_pager.dart';

// With [notes], shows those after an update with a "Got it" button.
// Without, lists the published versions page by page (Profile → What's new).
class WhatsNewScreen extends ConsumerStatefulWidget {
  final List<ReleaseNote>? notes;

  const WhatsNewScreen({super.key, this.notes});

  @override
  ConsumerState<WhatsNewScreen> createState() => _WhatsNewScreenState();
}

class _WhatsNewScreenState extends ConsumerState<WhatsNewScreen> {
  NotesPager? _pager;

  bool get _afterUpdate => widget.notes != null;

  @override
  void initState() {
    super.initState();
    if (!_afterUpdate) {
      _pager = NotesPager(
        ref.read(releaseNotesRepositoryProvider),
        publishedOnly: true,
      )..more();
    }
  }

  @override
  void dispose() {
    _pager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final pager = _pager;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.whatsNew),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: pager == null
          ? _list(widget.notes!, bottom: 24)
          : ListenableBuilder(
              listenable: pager,
              builder: (context, _) {
                if (!pager.loaded) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (pager.notes.isEmpty) {
                  return pager.failed
                      ? Center(child: Text(l10n.actionFailed))
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: EmptyState(
                              icon: const Icon(
                                Icons.auto_awesome_rounded,
                                size: 44,
                                color: AppColors.primary,
                              ),
                              title: l10n.whatsNew,
                              message: l10n.whatsNewEmpty,
                            ),
                          ),
                        );
                }
                return _list(
                  pager.notes,
                  bottom: bottom + 32,
                  footer: pager.hasMore
                      ? NotesLoadMore(loading: pager.loading, onTap: pager.more)
                      : null,
                );
              },
            ),
      bottomNavigationBar: _afterUpdate
          ? Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, bottom + 16),
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Text(l10n.whatsNewDone),
              ),
            )
          : null,
    );
  }

  Widget _list(
    List<ReleaseNote> notes, {
    required double bottom,
    Widget? footer,
  }) {
    final lang = ref.watch(localeProvider).code;
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 4, 16, bottom),
      children: [
        _Header(intro: _afterUpdate),
        const SizedBox(height: 16),
        for (final (i, note) in notes.indexed) ...[
          if (i > 0) const SizedBox(height: 12),
          _VersionCard(
            key: ValueKey(note.version),
            note: note,
            items: note.itemsFor(lang),
            latest: i == 0,
            expandable: !_afterUpdate,
          ),
        ],
        ?footer,
      ],
    );
  }
}

class NotesLoadMore extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;

  const NotesLoadMore({super.key, required this.loading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: loading
            ? const Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              )
            : OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(context.l10n.loadMore),
              ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool intro;

  const _Header({required this.intro});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.whatsNewTitle,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                if (intro) ...[
                  const SizedBox(height: 4),
                  Text(
                    l10n.whatsNewIntro,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.35,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension NoteSectionStyle on NoteSection {
  String label(AppLocalizations l10n) => switch (this) {
    NoteSection.added => l10n.whatsNewSectionNew,
    NoteSection.improved => l10n.whatsNewSectionImproved,
    NoteSection.fixed => l10n.whatsNewSectionFixed,
  };

  IconData get icon => switch (this) {
    NoteSection.added => Icons.auto_awesome_rounded,
    NoteSection.improved => Icons.trending_up_rounded,
    NoteSection.fixed => Icons.build_rounded,
  };

  Color get color => switch (this) {
    NoteSection.added => AppColors.primary,
    NoteSection.improved => AppColors.rewardText,
    NoteSection.fixed => AppColors.textMuted,
  };
}

// Closed, it shows the version, date and how many changes of each kind.
class _VersionCard extends StatefulWidget {
  final ReleaseNote note;
  final NoteItems items;
  final bool latest;
  final bool expandable;

  const _VersionCard({
    super.key,
    required this.note,
    required this.items,
    required this.latest,
    required this.expandable,
  });

  @override
  State<_VersionCard> createState() => _VersionCardState();
}

class _VersionCardState extends State<_VersionCard> {
  late bool _open = !widget.expandable || widget.latest;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = widget.items;
    final date = widget.note.updatedAt;
    final sections = [
      for (final s in NoteSection.values)
        if (items.of(s).isNotEmpty) s,
    ];

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: widget.latest
              ? AppColors.primary.withValues(alpha: 0.35)
              : AppColors.border,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.expandable ? () => setState(() => _open = !_open) : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.whatsNewVersion(widget.note.version),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        if (date != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            shortDate(l10n, date),
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (widget.expandable)
                    AnimatedRotation(
                      turns: _open ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.expand_more_rounded,
                        color: AppColors.textMuted,
                      ),
                    ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: _open
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final section in sections) ...[
                            const SizedBox(height: 12),
                            _SectionChip(section: section),
                            const SizedBox(height: 6),
                            for (final line in items.of(section))
                              _Bullet(text: line),
                          ],
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            for (final section in sections)
                              _SectionChip(
                                section: section,
                                count: items.of(section).length,
                              ),
                          ],
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

class _SectionChip extends StatelessWidget {
  final NoteSection section;
  final int? count;

  const _SectionChip({required this.section, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: section.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(section.icon, size: 14, color: section.color),
          const SizedBox(width: 5),
          Text(
            count == null
                ? section.label(context.l10n)
                : '$count ${section.label(context.l10n)}',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: section.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsetsDirectional.only(top: 7, end: 10, start: 4),
            decoration: const BoxDecoration(
              color: AppColors.textMuted,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.4,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
