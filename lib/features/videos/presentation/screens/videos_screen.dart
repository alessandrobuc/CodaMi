import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/video_entity.dart';
import '../providers/videos_provider.dart';
import '../widgets/video_labels.dart';
import '../widgets/video_thumbnail.dart';
import 'video_player_screen.dart';

class VideosScreen extends ConsumerStatefulWidget {
  const VideosScreen({super.key});

  @override
  ConsumerState<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends ConsumerState<VideosScreen> {
  VideoCategory? _category;

  void _open(Video video) => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => VideoPlayerScreen(video: video)));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(activeVideosProvider);
    final hasPets = ref.watch(petSpeciesProvider).isNotEmpty;
    final watched = ref.watch(watchedVideosProvider) ?? const {};
    final videos = [
      for (final v in ref.watch(videosForYouProvider))
        if (_category == null || v.category == _category) v,
    ];
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.read(videoShuffleProvider.notifier).reshuffle(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverSafeArea(
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 12, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.navVideos,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.text,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hasPets
                                  ? l10n.videosForYourPets
                                  : l10n.videosGeneral,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (videos.isNotEmpty)
                        IconButton.filledTonal(
                          tooltip: l10n.videosShuffle,
                          onPressed: () => ref
                              .read(videoShuffleProvider.notifier)
                              .reshuffle(),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.1,
                            ),
                            foregroundColor: AppColors.primary,
                          ),
                          icon: const Icon(Icons.shuffle_rounded),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.hasValue && state.value!.isNotEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 56,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
                    children: [
                      for (final category in [null, ...VideoCategory.values])
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: ChoiceChip(
                            label: Text(category?.label(l10n) ?? l10n.all),
                            selected: _category == category,
                            showCheckmark: false,
                            selectedColor: AppColors.primary,
                            backgroundColor: AppColors.surface,
                            side: BorderSide(
                              color: _category == category
                                  ? AppColors.primary
                                  : AppColors.border,
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _category == category
                                  ? Colors.white
                                  : AppColors.text,
                            ),
                            onSelected: (_) =>
                                setState(() => _category = category),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            if (state.isLoading && !state.hasValue)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (videos.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset),
                    child: EmptyState(
                      icon: const Icon(Icons.smart_display_rounded),
                      color: AppColors.accent,
                      title: state.hasError
                          ? l10n.videoLoadError
                          : l10n.videosEmptyTitle,
                      message: state.hasError
                          ? l10n.checkConnection
                          : l10n.videosEmptyMessage,
                    ),
                  ),
                ),
              )
            else ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: _FeaturedCard(
                    key: ValueKey(videos.first.id),
                    video: videos.first,
                    watched: watched.contains(videos.first.id),
                    onTap: () => _open(videos.first),
                  ).animate().fadeIn(duration: 350.ms),
                ),
              ),
              if (videos.length > 1)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
                    child: Text(
                      l10n.moreVideos,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.separated(
                  itemCount: videos.length - 1,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final video = videos[i + 1];
                    return _VideoRow(
                          key: ValueKey(video.id),
                          video: video,
                          watched: watched.contains(video.id),
                          onTap: () => _open(video),
                        )
                        .animate()
                        .fadeIn(delay: (40 * i).ms, duration: 300.ms)
                        .slideY(begin: 0.08, end: 0, curve: Curves.easeOut);
                  },
                ),
              ),
            ],
            SliverToBoxAdapter(child: SizedBox(height: bottomInset + 24)),
          ],
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final Video video;
  final bool watched;
  final VoidCallback onTap;

  const _FeaturedCard({
    super.key,
    required this.video,
    required this.watched,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final duration = video.durationLabel;

    return Material(
      color: AppColors.primaryDark,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Stack(
            fit: StackFit.expand,
            children: [
              VideoThumbnail(video: video, playSize: 0, showDuration: false),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.35, 1],
                    colors: [Colors.transparent, Color(0xD9000000)],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ),
              ),
              PositionedDirectional(
                start: 16,
                end: 16,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CategoryPill(
                          label: video.category.label(l10n),
                          motivational:
                              video.category == VideoCategory.motivational,
                          onDark: true,
                        ),
                        const SizedBox(width: 8),
                        if (duration != null) DurationBadge(label: duration),
                        if (watched) ...[
                          const SizedBox(width: 8),
                          _WatchedBadge(onDark: true),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
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

class _VideoRow extends StatelessWidget {
  final Video video;
  final bool watched;
  final VoidCallback onTap;

  const _VideoRow({
    super.key,
    required this.video,
    required this.watched,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 128,
                  height: 80,
                  child: VideoThumbnail(video: video, playSize: 32),
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
                    const SizedBox(height: 6),
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                        height: 1.25,
                      ),
                    ),
                    if (watched) ...[
                      const SizedBox(height: 4),
                      _WatchedBadge(),
                    ],
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

class _WatchedBadge extends StatelessWidget {
  final bool onDark;

  const _WatchedBadge({this.onDark = false});

  @override
  Widget build(BuildContext context) {
    final color = onDark ? Colors.white70 : AppColors.textMuted;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_rounded, size: 13, color: color),
        const SizedBox(width: 3),
        Text(
          context.l10n.videoWatched,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
