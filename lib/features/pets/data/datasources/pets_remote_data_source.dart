import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/services/photo_uploader.dart';
import '../../domain/entities/pets_entity.dart';
import '../models/pets_model.dart';

class PetsRemoteDataSource {
  final FirebaseFirestore _firestore;
  final PhotoUploader _photos;

  PetsRemoteDataSource({FirebaseFirestore? firestore, PhotoUploader? photos})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _photos = photos ?? PhotoUploader();

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
    final photoUrls = await _photos.upload(
      folder: 'pets/$ownerId/${doc.id}',
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
    await _photos.delete(
      existing.photoUrls.where((url) => !photoUrls.contains(url)),
    );
  }

  Future<void> deletePet(Pet pet) async {
    await _pets.doc(pet.id).delete();
    await _photos.delete(pet.photoUrls);
  }
}
