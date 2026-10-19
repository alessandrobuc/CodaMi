import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../domain/entities/video_entity.dart';

class VideoDraft {
  final String title;
  final VideoCategory category;
  final List<String> tags;
  final String language;
  final bool active;

  const VideoDraft({
    required this.title,
    required this.category,
    required this.tags,
    required this.language,
    required this.active,
  });

  Map<String, Object?> toMap() => {
    'title': title.trim(),
    'category': category.name,
    'tags': tags,
    'language': language,
    'active': active,
  };
}

// Files live under `videos/{id}/` in Storage; only admins can write there.
class VideosRepository {
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  VideosRepository({FirebaseFirestore? db, FirebaseStorage? storage})
    : _db = db ?? FirebaseFirestore.instance,
      _storage = storage ?? FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get _videos =>
      _db.collection('videos');

  List<Video> _parse(QuerySnapshot<Map<String, dynamic>> snap) =>
      snap.docs.map((d) => Video.fromMap(d.id, d.data())).toList();

  Stream<List<Video>> watchActive() =>
      _videos.where('active', isEqualTo: true).snapshots().map(_parse);

  Stream<List<Video>> watchAll() =>
      _videos.orderBy('createdAt', descending: true).snapshots().map(_parse);

  Future<void> create({
    required VideoDraft draft,
    required File video,
    File? thumbnail,
    int? durationSeconds,
    required String createdBy,
    void Function(double progress)? onProgress,
  }) async {
    final doc = _videos.doc();
    final videoPath = 'videos/${doc.id}/video.${_extension(video.path, 'mp4')}';
    final thumbPath = thumbnail == null
        ? null
        : _thumbnailPath(doc.id, thumbnail);
    final videoBytes = await video.length();
    final thumbBytes = thumbnail == null ? 0 : await thumbnail.length();
    final total = videoBytes + thumbBytes;

    try {
      final thumbnailUrl = thumbnail == null
          ? null
          : await _upload(thumbPath!, thumbnail, (sent) {
              onProgress?.call(sent / total);
            });
      final videoUrl = await _upload(videoPath, video, (sent) {
        onProgress?.call((thumbBytes + sent) / total);
      });
      await doc.set({
        ...draft.toMap(),
        'source': 'upload',
        'videoUrl': videoUrl,
        'storagePath': videoPath,
        'thumbnailUrl': ?thumbnailUrl,
        'thumbnailPath': ?thumbPath,
        'durationSeconds': ?durationSeconds,
        'createdBy': createdBy,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      await _deleteFiles([videoPath, ?thumbPath]);
      rethrow;
    }
  }

  Future<void> update(String id, VideoDraft draft) => _videos.doc(id).update({
    ...draft.toMap(),
    'updatedAt': FieldValue.serverTimestamp(),
  });

  // A new file name each time, so cached copies of the old cover aren't reused.
  Future<void> replaceThumbnail(Video video, File file) async {
    final path = _thumbnailPath(video.id, file);
    final url = await _upload(path, file, (_) {});
    try {
      await _videos.doc(video.id).update({
        'thumbnailUrl': url,
        'thumbnailPath': path,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      await _deleteFiles([path]);
      rethrow;
    }
    await _deleteFiles([?video.thumbnailPath]);
  }

  Future<void> removeThumbnail(Video video) async {
    await _videos.doc(video.id).update({
      'thumbnailUrl': FieldValue.delete(),
      'thumbnailPath': FieldValue.delete(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await _deleteFiles([?video.thumbnailPath]);
  }

  Future<void> delete(Video video) async {
    await _videos.doc(video.id).delete();
    await _deleteFiles([video.storagePath, ?video.thumbnailPath]);
  }

  Future<String> _upload(
    String path,
    File file,
    void Function(int sent) onSent,
  ) async {
    final ref = _storage.ref(path);
    final task = ref.putFile(
      file,
      SettableMetadata(contentType: _contentType(path)),
    );
    final progress = task.snapshotEvents.listen(
      (s) => onSent(s.bytesTransferred),
    );
    try {
      await task;
    } finally {
      await progress.cancel();
    }
    return ref.getDownloadURL();
  }

  Future<void> _deleteFiles(List<String> paths) async {
    for (final path in paths) {
      try {
        await _storage.ref(path).delete();
      } catch (e) {
        debugPrint('Could not delete $path: $e');
      }
    }
  }

  static String _thumbnailPath(String id, File file) =>
      'videos/$id/thumbnail_${DateTime.now().millisecondsSinceEpoch}'
      '.${_extension(file.path, 'jpg')}';

  static String _extension(String path, String fallback) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return fallback;
    return path.substring(dot + 1).toLowerCase();
  }

  static String _contentType(String path) => switch (_extension(path, '')) {
    'mov' => 'video/quicktime',
    'm4v' => 'video/x-m4v',
    'webm' => 'video/webm',
    'mp4' => 'video/mp4',
    'png' => 'image/png',
    'webp' => 'image/webp',
    _ => path.contains('thumbnail') ? 'image/jpeg' : 'video/mp4',
  };
}
