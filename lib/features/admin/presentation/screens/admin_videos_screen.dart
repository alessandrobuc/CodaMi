import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../../videos/domain/entities/video_entity.dart';
import '../../../videos/presentation/providers/videos_provider.dart';
import '../../../videos/presentation/screens/video_player_screen.dart';
import '../../../videos/presentation/widgets/video_labels.dart';
import '../../../videos/presentation/widgets/video_thumbnail.dart';
import 'admin_video_form_screen.dart';

enum _Filter { all, visible, hidden }

class AdminVideosScreen extends ConsumerStatefulWidget {
  const AdminVideosScreen({super.key});

  @override
  ConsumerState<AdminVideosScreen> createState() => _AdminVideosScreenState();
}

class _AdminVideosScreenState extends ConsumerState<AdminVideosScreen> {
  _Filter _filter = _Filter.all;

  Future<void> _delete(Video video) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteVideoTitle),
        content: Text(l10n.deleteVideoMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(videosRepositoryProvider).delete(video);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.videoDeleted);
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  void _openForm([Video? video]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AdminVideoFormScreen(video: video),
      ),
    );
  }

  void _play(Video video) => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => VideoPlayerScreen(video: video)));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(allVideosProvider);
    final all = state.value ?? const <Video>[];
    final visibleCount = all.where((v) => v.active).length;
    final counts = {
      _Filter.all: all.length,
      _Filter.visible: visibleCount,
      _Filter.hidden: all.length - visibleCount,
    };
    final videos = [
      for (final v in all)
        if (_filter == _Filter.all || (_filter == _Filter.visible) == v.active)
          v,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.adminVideos),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          onPressed: _openForm,
          icon: const Icon(Icons.video_call_rounded),
          label: Text(l10n.addVideo),
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.actionFailed)),
        data: (_) => all.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: EmptyState(
                    icon: const Icon(Icons.video_library_rounded),
                    color: AppColors.accent,
                    title: l10n.noVideosYetTitle,
                    message: l10n.noVideosYet,
                  ),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      children: [
                        for (final filter in _Filter.values)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 8),
                            child: ChoiceChip(
                              label: Text(
                                '${switch (filter) {
                                  _Filter.all => l10n.all,
                                  _Filter.visible => l10n.videoVisibleShort,
                                  _Filter.hidden => l10n.videoHidden,
                                }}  ${counts[filter]}',
                              ),
                              selected: _filter == filter,
                              showCheckmark: false,
                              selectedColor: AppColors.primary,
                              backgroundColor: AppColors.surface,
                              side: BorderSide(
                                color: _filter == filter
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _filter == filter
                                    ? Colors.white
                                    : AppColors.text,
                              ),
                              onSelected: (_) =>
                                  setState(() => _filter = filter),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        8,
                        20,
                        100 + MediaQuery.paddingOf(context).bottom,
                      ),
                      itemCount: videos.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final video = videos[i];
                        return _AdminVideoCard(
                          key: ValueKey(video.id),
                          video: video,
                          onPlay: () => _play(video),
                          onEdit: () => _openForm(video),
                          onDelete: () => _delete(video),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _AdminVideoCard extends StatelessWidget {
  final Video video;
  final VoidCallback onPlay;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AdminVideoCard({
    super.key,
    required this.video,
    required this.onPlay,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final language = appLanguageFor(video.language);
    final details = [
      video.tags.map((t) => videoTagLabel(t, l10n)).join(', '),
      language == null
          ? l10n.allLanguages
          : '${language.flag} ${language.nativeName}',
    ].join('  ·  ');

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: onPlay,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 112,
                    height: 72,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Opacity(
                          opacity: video.active ? 1 : 0.45,
                          child: VideoThumbnail(video: video, playSize: 28),
                        ),
                        if (!video.active)
                          PositionedDirectional(
                            start: 6,
                            top: 6,
                            child: _HiddenBadge(label: l10n.videoHidden),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryPill(
                      label: video.category.label(l10n),
                      motivational:
                          video.category == VideoCategory.motivational,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: video.active
                            ? AppColors.text
                            : AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      details,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<VoidCallback>(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.textMuted,
                ),
                onSelected: (action) => action(),
                itemBuilder: (context) => [
                  _menuItem(onPlay, Icons.play_arrow_rounded, l10n.play),
                  _menuItem(onEdit, Icons.edit_rounded, l10n.edit),
                  _menuItem(
                    onDelete,
                    Icons.delete_outline_rounded,
                    l10n.delete,
                    color: AppColors.danger,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<VoidCallback> _menuItem(
    VoidCallback action,
    IconData icon,
    String label, {
    Color color = AppColors.text,
  }) => PopupMenuItem(
    value: action,
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: color)),
      ],
    ),
  );
}

class _HiddenBadge extends StatelessWidget {
  final String label;

  const _HiddenBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.visibility_off_rounded,
            size: 11,
            color: Colors.white,
          ),
          const SizedBox(width: 3),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
