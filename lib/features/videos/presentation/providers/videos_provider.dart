import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/locale_provider.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/videos_repository.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/video_selection.dart';

final videosRepositoryProvider = Provider((ref) => VideosRepository());

final activeVideosProvider = StreamProvider<List<Video>>(
  (ref) => ref.watch(videosRepositoryProvider).watchActive(),
);

final allVideosProvider = StreamProvider<List<Video>>(
  (ref) => ref.watch(videosRepositoryProvider).watchAll(),
);

// Kept on the phone so the next session starts with videos not seen yet.
// Null until loaded.
class WatchedVideos extends Notifier<Set<String>?> {
  static const _key = 'watchedVideos';
  static const _limit = 30;

  @override
  Set<String>? build() {
    _load();
    return null;
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = {...prefs.getStringList(_key) ?? const <String>[]};
    } catch (_) {
      state = const {};
    }
  }

  Future<void> add(String id) async {
    final ids = [...?state?.where((v) => v != id), id];
    ids.removeRange(0, max(0, ids.length - _limit));
    state = ids.toSet();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, ids);
    } catch (_) {}
  }
}

final watchedVideosProvider = NotifierProvider<WatchedVideos, Set<String>?>(
  WatchedVideos.new,
);

// New seed each launch, so the mix changes between sessions but stays put while scrolling.
class VideoShuffle extends Notifier<int> {
  @override
  int build() => Random().nextInt(1 << 31);

  void reshuffle() => state = Random().nextInt(1 << 31);
}

final videoShuffleProvider = NotifierProvider<VideoShuffle, int>(
  VideoShuffle.new,
);

final petSpeciesProvider = Provider<Set<String>>(
  (ref) => {
    for (final pet in ref.watch(myPetsProvider).value ?? const <Pet>[])
      pet.species.name,
  },
);

final videosForYouProvider = Provider<List<Video>>((ref) {
  final videos = ref.watch(activeVideosProvider).value ?? const [];
  final loaded = ref.watch(watchedVideosProvider.select((s) => s != null));
  if (videos.isEmpty || !loaded) return const [];
  return selectVideos(
    videos,
    species: ref.watch(petSpeciesProvider),
    language: ref.watch(localeProvider).code,
    // Read, not watched: marking a video as seen shouldn't reorder the list.
    recentlyWatched: ref.read(watchedVideosProvider)!,
    random: Random(ref.watch(videoShuffleProvider)),
    count: videos.length,
  );
});
