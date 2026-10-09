import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../features/pets/domain/entities/pets_entity.dart';

class PhotoUploader {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;

  PhotoUploader({FirebaseStorage? storage, FirebaseFirestore? firestore})
    : _storage = storage ?? FirebaseStorage.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

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

  // Lost reports reuse their pet's photos, so a photo is only deleted once
  // none of the owner's pets or reports point to it.
  Future<void> deleteUnused({
    required String ownerId,
    required Iterable<String> urls,
  }) async {
    final candidates = urls.toSet();
    if (candidates.isEmpty) return;
    try {
      final owned = await Future.wait([
        for (final name in ['pets', 'reports'])
          _firestore
              .collection(name)
              .where('ownerId', isEqualTo: ownerId)
              .get(),
      ]);
      for (final doc in owned.expand((snap) => snap.docs)) {
        final used = doc.data()['photoUrls'];
        if (used is List) candidates.removeAll(used);
      }
    } catch (e) {
      debugPrint('Could not check photo usage: $e');
      return;
    }
    await _delete(candidates);
  }

  Future<void> _delete(Iterable<String> urls) async {
    for (final url in urls) {
      try {
        await _storage.refFromURL(url).delete();
      } catch (e) {
        debugPrint('Could not delete photo: $e');
      }
    }
  }
}
