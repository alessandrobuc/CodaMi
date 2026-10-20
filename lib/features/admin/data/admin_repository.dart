import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/models/user_model.dart';
import '../../location/data/datasources/places_service.dart';
import '../../reports/data/models/reports_model.dart';
import '../../reports/domain/entities/reports_entity.dart';

class StaffMember {
  final String uid;
  final String name;
  final String email;
  final UserRole role;

  const StaffMember({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
  });

  factory StaffMember.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      StaffMember(
        uid: doc.id,
        name: doc.data()?['name'] as String? ?? '',
        email: doc.data()?['email'] as String? ?? '',
        role: UserRole.fromValue(doc.data()?['role']),
      );
}

class DashboardStats {
  final int users;
  final int openLost;
  final int openFound;
  final int backHome;

  const DashboardStats({
    required this.users,
    required this.openLost,
    required this.openFound,
    required this.backHome,
  });
}

// The rules only let an admin switch other users between `user` and `support`.
class AdminRepository {
  final FirebaseFirestore _db;

  AdminRepository([FirebaseFirestore? db])
    : _db = db ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  Stream<List<StaffMember>> watchSupportStaff() => _users
      .where('role', isEqualTo: UserRole.support.name)
      .snapshots()
      .map(
        (snap) => snap.docs.map(StaffMember.fromDoc).toList()
          ..sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
          ),
      );

  Future<void> setRole(String uid, UserRole role) => _users.doc(uid).update({
    'role': role.name,
    'updatedAt': FieldValue.serverTimestamp(),
  });

  Stream<List<Report>> watchReports(
    ReportStatus status, {
    required int limit,
  }) => _db
      .collection('reports')
      .where('status', isEqualTo: status.name)
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (snap) =>
            snap.docs.map((d) => ReportModel.fromMap(d.id, d.data())).toList(),
      );

  // `createdAt` is an ISO string, so it sorts by date.
  Stream<List<UserModel>> watchUsers({required int limit}) => _users
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (snap) => snap.docs
            .map((d) => UserModel.fromMap({...d.data(), 'uid': d.id}))
            .toList(),
      );

  Stream<UserModel?> watchUser(String uid) => _users
      .doc(uid)
      .snapshots()
      .map(
        (d) => d.exists ? UserModel.fromMap({...d.data()!, 'uid': d.id}) : null,
      );

  // Matches the start of a name or email. `searchName` / `searchEmail` are
  // kept by a Cloud Function; the exact `email` match covers older profiles.
  Future<List<UserModel>> searchUsers(String text) async {
    final typed = text.trim();
    final lower = typed.toLowerCase();
    Query<Map<String, dynamic>> prefix(String field) => _users
        .where(field, isGreaterThanOrEqualTo: lower)
        .where(field, isLessThan: '$lower\uf8ff')
        .limit(20);

    final results = await Future.wait([
      prefix('searchName').get(),
      prefix('searchEmail').get(),
      _users.where('email', whereIn: {typed, lower}.toList()).limit(5).get(),
    ]);
    final byId = {
      for (final snap in results)
        for (final d in snap.docs) d.id: d,
    };
    return byId.values
        .map((d) => UserModel.fromMap({...d.data(), 'uid': d.id}))
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  Future<int> reportCount(String uid) async =>
      (await _db
              .collection('reports')
              .where('ownerId', isEqualTo: uid)
              .count()
              .get())
          .count ??
      0;

  Future<void> setDisabled(String uid, {required bool disabled}) =>
      _call('adminSetUserDisabled', {'uid': uid, 'disabled': disabled});

  Future<void> deleteUser(String uid) => _call('adminDeleteUser', {'uid': uid});

  Future<void> _call(String name, Map<String, Object> data) =>
      FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion)
          .httpsCallable(
            name,
            options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
          )
          .call<Object?>(data);

  Future<DashboardStats> stats({required bool includeUsers}) async {
    final reports = _db.collection('reports');
    Future<int> count(Query<Map<String, dynamic>> q) async =>
        (await q.count().get()).count ?? 0;
    final open = reports.where('status', isEqualTo: ReportStatus.open.name);

    final (users, openLost, openFound, backHome) = await (
      includeUsers ? count(_users) : Future.value(0),
      count(open.where('type', isEqualTo: ReportType.lost.name)),
      count(open.where('type', isEqualTo: ReportType.found.name)),
      count(reports.where('status', isEqualTo: ReportStatus.resolved.name)),
    ).wait;
    return DashboardStats(
      users: users,
      openLost: openLost,
      openFound: openFound,
      backHome: backHome,
    );
  }
}

final adminRepositoryProvider = Provider((ref) => AdminRepository());
