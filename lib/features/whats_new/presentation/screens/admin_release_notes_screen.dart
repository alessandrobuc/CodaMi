import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/release_note.dart';
import '../../data/release_notes_repository.dart';
import '../providers/notes_pager.dart';
import '../providers/whats_new_provider.dart';
import 'whats_new_screen.dart';
import 'admin_release_note_form_screen.dart';

class AdminReleaseNotesScreen extends ConsumerStatefulWidget {
  const AdminReleaseNotesScreen({super.key});

  @override
  ConsumerState<AdminReleaseNotesScreen> createState() =>
      _AdminReleaseNotesScreenState();
}

class _AdminReleaseNotesScreenState
    extends ConsumerState<AdminReleaseNotesScreen> {
  late final _pager = NotesPager(
    ref.read(releaseNotesRepositoryProvider),
    publishedOnly: false,
  )..more();

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  Future<void> _open([ReleaseNote? note]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AdminReleaseNoteFormScreen(note: note),
      ),
    );
    if (mounted) _pager.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final version = ref.watch(appVersionProvider).value;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.whatsNew),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          onPressed: _open,
          icon: const Icon(Icons.add_rounded),
          label: Text(l10n.releaseAdd),
        ),
      ),
      body: ListenableBuilder(
        listenable: _pager,
        builder: (context, _) {
          if (!_pager.loaded) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_pager.notes.isEmpty) {
            return _pager.failed
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
                        message: l10n.releaseNone,
                      ),
                    ),
                  );
          }
          return RefreshIndicator(
            onRefresh: _pager.refresh,
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                16,
                4,
                16,
                MediaQuery.paddingOf(context).bottom + 96,
              ),
              children: [
                if (version != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
                    child: Text(
                      l10n.releaseThisApp(version),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                for (final note in _pager.notes) ...[
                  _NoteTile(note: note, onTap: () => _open(note)),
                  const SizedBox(height: 10),
                ],
                if (_pager.hasMore)
                  NotesLoadMore(loading: _pager.loading, onTap: _pager.more),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NoteTile extends StatelessWidget {
  final ReleaseNote note;
  final VoidCallback onTap;

  const _NoteTile({required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final english = note.itemsFor('en');
    final count = NoteSection.values.fold<int>(
      0,
      (sum, s) => sum + english.of(s).length,
    );
    final flags = [
      for (final lang in appLanguages)
        if (note.notes.containsKey(lang.code)) lang.flag,
    ].join(' ');
    final date = note.updatedAt;
    final color = note.published ? AppColors.primary : AppColors.textMuted;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  note.published
                      ? Icons.auto_awesome_rounded
                      : Icons.edit_note_rounded,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.whatsNewVersion(note.version),
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      [
                        '$count',
                        if (flags.isNotEmpty) flags,
                        if (date != null) shortDate(l10n, date),
                      ].join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  note.published ? l10n.published : l10n.releaseDraft,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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
