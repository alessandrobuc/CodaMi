import 'package:cloud_firestore/cloud_firestore.dart';

enum VideoCategory {
  motivational,
  educational;

  static VideoCategory fromValue(Object? value) =>
      values.where((c) => c.name == value).firstOrNull ?? educational;
}

// Pet species names, plus `general` for videos meant for everyone.
const videoTags = ['dog', 'cat', 'other', 'general'];
const generalTag = 'general';
const allLanguages = 'all';

class Video {
  final String id;
  final String title;
  final VideoCategory category;
  final List<String> tags;
  final String language;
  final String videoUrl;
  final String storagePath;
  final String? thumbnailUrl;
  final String? thumbnailPath;
  final int? durationSeconds;
  final bool active;
  final DateTime? createdAt;

  const Video({
    required this.id,
    required this.title,
    required this.category,
    required this.tags,
    required this.language,
    required this.videoUrl,
    required this.storagePath,
    this.thumbnailUrl,
    this.thumbnailPath,
    this.durationSeconds,
    this.active = true,
    this.createdAt,
  });

  factory Video.fromMap(String id, Map<String, dynamic> map) => Video(
    id: id,
    title: map['title'] as String? ?? '',
    category: VideoCategory.fromValue(map['category']),
    tags: [
      for (final tag in map['tags'] as List? ?? const [])
        if (videoTags.contains(tag)) tag as String,
    ],
    language: map['language'] as String? ?? allLanguages,
    videoUrl: map['videoUrl'] as String? ?? '',
    storagePath: map['storagePath'] as String? ?? '',
    thumbnailUrl: map['thumbnailUrl'] as String?,
    thumbnailPath: map['thumbnailPath'] as String?,
    durationSeconds: (map['durationSeconds'] as num?)?.toInt(),
    active: map['active'] == true,
    createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
  );

  bool get isGeneral => tags.contains(generalTag);

  String? get durationLabel {
    final seconds = durationSeconds;
    if (seconds == null) return null;
    return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
  }
}
