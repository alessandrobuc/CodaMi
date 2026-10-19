import 'dart:math';

import 'package:CodaMi/features/videos/domain/entities/video_entity.dart';
import 'package:CodaMi/features/videos/domain/video_selection.dart';
import 'package:flutter_test/flutter_test.dart';

Video _video(String id, List<String> tags, {String language = 'all'}) =>
    Video(
      id: id,
      title: id,
      category: VideoCategory.educational,
      tags: tags,
      language: language,
      videoUrl: 'https://v/$id',
      storagePath: 'videos/$id/video.mp4',
    );

final _videos = [
  for (var i = 0; i < 6; i++) _video('dog$i', ['dog']),
  for (var i = 0; i < 6; i++) _video('cat$i', ['cat']),
  for (var i = 0; i < 6; i++) _video('gen$i', ['general']),
];

List<Video> _select({
  Set<String> species = const {},
  String language = 'en',
  Set<String> watched = const {},
  int seed = 1,
  List<Video>? videos,
}) => selectVideos(
  videos ?? _videos,
  species: species,
  language: language,
  recentlyWatched: watched,
  random: Random(seed),
);

void main() {
  test('without pets only general videos are shown', () {
    final picked = _select();
    expect(picked, hasLength(6));
    expect(picked.every((v) => v.isGeneral), isTrue);
  });

  test('dog owners mostly see dog videos and never cat-only ones', () {
    var dog = 0;
    var total = 0;
    for (var seed = 0; seed < 50; seed++) {
      final picked = _select(species: {'dog'}, seed: seed);
      expect(picked.any((v) => v.tags.contains('cat')), isFalse);
      dog += picked.where((v) => v.tags.contains('dog')).length;
      total += picked.length;
    }
    expect(dog / total, inInclusiveRange(0.55, 0.85));
  });

  test('falls back to general videos when none match the pets', () {
    final picked = _select(species: {'other'});
    expect(picked.every((v) => v.isGeneral), isTrue);
  });

  test('recently watched videos come last', () {
    final watched = {for (var i = 0; i < 5; i++) 'gen$i'};
    final picked = _select(watched: watched);
    expect(picked.first.id, 'gen5');
  });

  test('videos in another language are skipped unless nothing else fits', () {
    final videos = [
      _video('it', ['general'], language: 'it'),
      _video('en', ['general'], language: 'en'),
    ];
    expect(_select(videos: videos).map((v) => v.id), ['en']);
    expect(_select(videos: videos, language: 'de'), hasLength(2));
  });

  test('the same seed gives the same list', () {
    expect(
      _select(species: {'cat'}, seed: 7).map((v) => v.id),
      _select(species: {'cat'}, seed: 7).map((v) => v.id),
    );
  });
}
