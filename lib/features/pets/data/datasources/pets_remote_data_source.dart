import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/pets_entity.dart';
import '../models/pets_model.dart';

class PetsRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  PetsRemoteDataSource({FirebaseFirestore? firestore, FirebaseStorage? storage})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _storage = storage ?? FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get _pets =>
      _firestore.collection('pets');

  Stream<List<Pet>> watchPets(String ownerId) {
    return _pets.where('ownerId', isEqualTo: ownerId).snapshots().map((snap) {
      final now = DateTime.now();
      return snap.docs.map((d) => PetModel.fromMap(d.id, d.data())).toList()
        ..sort((a, b) => (b.createdAt ?? now).compareTo(a.createdAt ?? now));
    });
  }

  Future<void> savePet({
    required String ownerId,
    required PetDraft draft,
    Pet? existing,
    void Function(double progress)? onUploadProgress,
  }) async {
    final doc = existing == null ? _pets.doc() : _pets.doc(existing.id);
    final photoUrls = await _uploadPhotos(
      ownerId: ownerId,
      petId: doc.id,
      photos: draft.photos,
      onProgress: onUploadProgress,
    );
    final fields = PetModel.toFields(
      ownerId: ownerId,
      draft: draft,
      photoUrls: photoUrls,
    );

    if (existing == null) {
      await doc.set({
        for (final e in fields.entries)
          if (e.value != null) e.key: e.value,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return;
    }

    await doc.update({
      for (final e in fields.entries) e.key: e.value ?? FieldValue.delete(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await _deletePhotos(
      existing.photoUrls.where((url) => !photoUrls.contains(url)),
    );
  }

  Future<void> deletePet(Pet pet) async {
    await _pets.doc(pet.id).delete();
    await _deletePhotos(pet.photoUrls);
  }

  Future<List<String>> _uploadPhotos({
    required String ownerId,
    required String petId,
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
        'pets/$ownerId/$petId/${DateTime.now().millisecondsSinceEpoch}_$index'
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

  Future<void> _deletePhotos(Iterable<String> urls) async {
    for (final url in urls) {
      try {
        await _storage.refFromURL(url).delete();
      } catch (e) {
        debugPrint('Could not delete pet photo: $e');
      }
    }
  }
}
