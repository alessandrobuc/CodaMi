import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../domain/petition.dart';
import '../domain/petitions_repository.dart';

// Images live under `petitions/{id}/`; only admins can write there.
class FirestorePetitionsRepository implements PetitionsRepository {
  static const publishedLimit = 100;

  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  FirestorePetitionsRepository({
    FirebaseFirestore? db,
    FirebaseStorage? storage,
  }) : _db = db ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get _petitions =>
      _db.collection('petitions');

  List<Petition> _parse(QuerySnapshot<Map<String, dynamic>> snap) => [
    for (final d in snap.docs) petitionFromMap(d.id, d.data()),
  ];

  @override
  Stream<List<Petition>> watchPublished() => _petitions
      .where('review', isEqualTo: PetitionReview.published.name)
      .orderBy('publishedAt', descending: true)
      .limit(publishedLimit)
      .snapshots()
      .map(_parse);

  @override
  Stream<List<Petition>> watchAll() =>
      _petitions.orderBy('updatedAt', descending: true).snapshots().map(_parse);

  @override
  Future<String> save({
    Petition? existing,
    required PetitionDraft draft,
    required String adminId,
    PetitionImageChange image = const KeepImage(),
  }) async {
    final doc = existing == null
        ? _petitions.doc()
        : _petitions.doc(existing.id);
    final d = draft.trimmed();

    String? newPath;
    String? newUrl;
    if (image is NewImage) {
      newPath = _imagePath(doc.id, image.file);
      newUrl = await _upload(newPath, image.file);
    }
    final dropOld = image is! KeepImage;

    final publishedNow =
        d.review == PetitionReview.published &&
        (existing == null || existing.publishedAt == null);
    final data = <String, Object?>{
      'url': d.url,
      'title': d.title,
      'source': d.source,
      'topic': d.topic.name,
      'summary': d.summary,
      'issue': d.issue,
      'action': d.action,
      'why': d.why,
      'imagePermission': d.imagePermission,
      'review': d.review.name,
      'status': d.status.name,
      'checks': d.checks.toMap(),
      'updatedBy': adminId,
      'updatedAt': FieldValue.serverTimestamp(),
      if (publishedNow) 'publishedAt': FieldValue.serverTimestamp(),
    };
    final remove = existing == null ? null : FieldValue.delete();
    void optional(String key, Object? value) {
      if (value != null) {
        data[key] = value;
      } else if (remove != null) {
        data[key] = remove;
      }
    }

    optional('country', d.country.isEmpty ? null : d.country);
    optional(
      'startedOn',
      d.startedOn == null ? null : Timestamp.fromDate(d.startedOn!),
    );
    optional('rejectReason', d.rejectReason.isEmpty ? null : d.rejectReason);
    if (newUrl != null) {
      data['imageUrl'] = newUrl;
      data['imagePath'] = newPath;
    } else if (image is RemoveImage) {
      optional('imageUrl', null);
      optional('imagePath', null);
    }

    try {
      if (existing == null) {
        await doc.set({
          ...data,
          'createdBy': adminId,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        await doc.update(data);
      }
    } catch (_) {
      if (newPath != null) await _deleteFile(newPath);
      rethrow;
    }
    if (dropOld && existing?.imagePath != null) {
      await _deleteFile(existing!.imagePath!);
    }
    return doc.id;
  }

  @override
  Future<void> delete(Petition petition) async {
    await _petitions.doc(petition.id).delete();
    if (petition.imagePath != null) await _deleteFile(petition.imagePath!);
  }

  Future<String> _upload(String path, File file) async {
    final ref = _storage.ref(path);
    await ref.putFile(file, SettableMetadata(contentType: _contentType(path)));
    return ref.getDownloadURL();
  }

  Future<void> _deleteFile(String path) async {
    try {
      await _storage.ref(path).delete();
    } catch (e) {
      debugPrint('Could not delete $path: $e');
    }
  }

  // A new name each time, so cached copies of an old image aren't reused.
  static String _imagePath(String id, File file) {
    final dot = file.path.lastIndexOf('.');
    final ext = dot < 0 ? 'jpg' : file.path.substring(dot + 1).toLowerCase();
    final safe = const {'jpg', 'jpeg', 'png', 'webp'}.contains(ext)
        ? ext
        : 'jpg';
    return 'petitions/$id/image_${DateTime.now().millisecondsSinceEpoch}.$safe';
  }

  static String _contentType(String path) => switch (path.split('.').last) {
    'png' => 'image/png',
    'webp' => 'image/webp',
    _ => 'image/jpeg',
  };
}

Petition petitionFromMap(String id, Map<String, dynamic> map) {
  DateTime? date(String key) => (map[key] as Timestamp?)?.toDate();
  String text(String key) => map[key] as String? ?? '';
  return Petition(
    id: id,
    draft: PetitionDraft(
      url: text('url'),
      title: text('title'),
      source: text('source'),
      topic: PetitionTopic.fromValue(map['topic']),
      country: text('country'),
      startedOn: date('startedOn'),
      summary: text('summary'),
      issue: text('issue'),
      action: text('action'),
      why: text('why'),
      imagePermission: map['imagePermission'] == true,
      review: PetitionReview.fromValue(map['review']),
      status: PetitionStatus.fromValue(map['status']),
      checks: PetitionChecks.fromMap(map['checks']),
      rejectReason: text('rejectReason'),
    ),
    imageUrl: map['imageUrl'] as String?,
    imagePath: map['imagePath'] as String?,
    createdBy: text('createdBy'),
    updatedBy: text('updatedBy'),
    createdAt: date('createdAt'),
    updatedAt: date('updatedAt'),
    publishedAt: date('publishedAt'),
  );
}
