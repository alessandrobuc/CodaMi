import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/services/photo_uploader.dart';
import '../../domain/entities/reports_entity.dart';
import '../models/reports_model.dart';

class ReportsRemoteDataSource {
  final FirebaseFirestore _firestore;
  final PhotoUploader _photos;

  ReportsRemoteDataSource({FirebaseFirestore? firestore, PhotoUploader? photos})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _photos = photos ?? PhotoUploader();

  CollectionReference<Map<String, dynamic>> get _reports =>
      _firestore.collection('reports');

  Stream<List<Report>> watchOpenReports(ReportType type, {required int limit}) {
    return _reports
        .where('status', isEqualTo: ReportStatus.open.name)
        .where('type', isEqualTo: type.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => ReportModel.fromMap(d.id, d.data()))
              .toList(),
        );
  }

  Stream<List<Report>> watchResolvedReports({required int limit}) {
    return _reports
        .where('status', isEqualTo: ReportStatus.resolved.name)
        .orderBy('resolvedAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => ReportModel.fromMap(d.id, d.data()))
              .toList(),
        );
  }

  Stream<Report?> watchReport(String id) {
    return _reports
        .doc(id)
        .snapshots()
        .map((d) => d.exists ? ReportModel.fromMap(d.id, d.data()!) : null);
  }

  Future<String> createReport({
    required String ownerId,
    required ReportDraft draft,
    void Function(double progress)? onUploadProgress,
  }) async {
    final doc = _reports.doc();
    final photoUrls = await _photos.upload(
      folder: 'reports/$ownerId/${doc.id}',
      photos: draft.photos,
      onProgress: onUploadProgress,
    );
    await doc.set(
      ReportModel.toCreateMap(
        ownerId: ownerId,
        draft: draft,
        photoUrls: photoUrls,
      ),
    );
    final phone = draft.contactPhone?.trim() ?? '';
    if (phone.isNotEmpty) {
      await _firestore.collection('users').doc(ownerId).set({
        'phone': phone,
      }, SetOptions(merge: true));
    }
    return doc.id;
  }

  Future<void> markResolved(Report report) {
    return _reports.doc(report.id).update({
      'status': ReportStatus.resolved.name,
      'resolvedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
