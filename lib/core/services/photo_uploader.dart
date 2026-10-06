import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../features/pets/domain/entities/pets_entity.dart';

class PhotoUploader {
  final FirebaseStorage _storage;

  PhotoUploader({FirebaseStorage? storage})
    : _storage = storage ?? FirebaseStorage.instance;

  Future<List<String>> upload({
    required String folder,
    required List<PetPhoto> photos,
    void Function(double progress)? onProgress,
  }) async {
    final sizes = <String, int>{
      for (final p in photos.where((p) => p.isLocal))
        p.localPath!: await File(p.localPath!).length(),
    };
    final totalBytes = sizes.values.fold<int>(0, (total, size) => total + size);
    var uploadedBytes = 0;
    final urls = <String>[];

    for (final (index, photo) in photos.indexed) {
      if (!photo.isLocal) {
        urls.add(photo.url!);
        continue;
      }
      final path = photo.localPath!;
      final isPng = path.toLowerCase().endsWith('.png');
      final ref = _storage.ref(
        '$folder/${DateTime.now().millisecondsSinceEpoch}_$index'
        '${isPng ? '.png' : '.jpg'}',
      );
      final task = ref.putFile(
        File(path),
        SettableMetadata(contentType: isPng ? 'image/png' : 'image/jpeg'),
      );
      final progress = task.snapshotEvents.listen((s) {
        if (totalBytes > 0) {
          onProgress?.call((uploadedBytes + s.bytesTransferred) / totalBytes);
        }
      });
      try {
        await task;
      } finally {
        await progress.cancel();
      }
      uploadedBytes += sizes[path]!;
      urls.add(await ref.getDownloadURL());
    }

    onProgress?.call(1);
    return urls;
  }

  Future<void> delete(Iterable<String> urls) async {
    for (final url in urls) {
      try {
        await _storage.refFromURL(url).delete();
      } catch (e) {
        debugPrint('Could not delete photo: $e');
      }
    }
  }
}
