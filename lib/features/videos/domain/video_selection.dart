import 'dart:math';

import 'entities/video_entity.dart';

const matchingShare = 0.7;

// Mostly videos about the user's own animals, mixed with general ones.
// Without pets, only general videos are shown. Recently watched videos go last.
List<Video> selectVideos(
  List<Video> videos, {
  required Set<String> species,
  required String language,
  required Set<String> recentlyWatched,
  required Random random,
  int count = 6,
}) {
  var pool = videos
      .where((v) => v.language == allLanguages || v.language == language)
      .toList();
  if (pool.isEmpty) pool = videos;

  List<Video> ordered(Iterable<Video> items) {
    final list = items.toList()..shuffle(random);
    return [
      ...list.where((v) => !recentlyWatched.contains(v.id)),
      ...list.where((v) => recentlyWatched.contains(v.id)),
    ];
  }

  final matching = ordered(pool.where((v) => v.tags.any(species.contains)));
  final general = ordered(
    pool.where((v) => v.isGeneral && !v.tags.any(species.contains)),
  );

  final picked = <Video>[];
  while (picked.length < count && (matching.isNotEmpty || general.isNotEmpty)) {
    final useMatching =
        general.isEmpty ||
        (matching.isNotEmpty && random.nextDouble() < matchingShare);
    picked.add((useMatching ? matching : general).removeAt(0));
  }
  return picked;
}
