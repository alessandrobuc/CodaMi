import 'package:cloud_firestore/cloud_firestore.dart';

import '../../reports/domain/entities/reports_entity.dart';
import '../domain/entities/notification_entity.dart';

class NotificationsRepository {
  final FirebaseFirestore _firestore;

  NotificationsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _items(String uid) =>
      _firestore.collection('users').doc(uid).collection('notifications');

  Stream<List<AppNotification>> watch(String uid) {
    return _items(uid)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snap) => snap.docs.map((d) => fromMap(d.id, d.data())).toList());
  }

  Future<void> markRead(String uid, String id) =>
      _items(uid).doc(id).update({'read': true});

  Future<void> markAllRead(String uid, Iterable<String> ids) async {
    final batch = _firestore.batch();
    for (final id in ids) {
      batch.update(_items(uid).doc(id), {'read': true});
    }
    await batch.commit();
  }

  Future<void> delete(String uid, String id) => _items(uid).doc(id).delete();

  static AppNotification fromMap(String id, Map<String, dynamic> map) {
    final created = map['createdAt'];
    return AppNotification(
      id: id,
      kind: NotificationKind.fromValue(map['kind'] as String?),
      title: map['title'] as String? ?? '',
      body: map['body'] as String? ?? '',
      reportId: map['reportId'] as String?,
      reportType: ReportType.fromValue(map['reportType'] as String?),
      photoUrl: map['photoUrl'] as String?,
      read: map['read'] as bool? ?? false,
      createdAt: created is Timestamp ? created.toDate() : null,
    );
  }
}
