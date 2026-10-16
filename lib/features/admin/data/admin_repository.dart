import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/models/user_model.dart';
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

  Future<StaffMember?> findUserByEmail(String email) async {
    final typed = email.trim();
    final snap = await _users
        .where('email', whereIn: {typed, typed.toLowerCase()}.toList())
        .limit(1)
        .get();
    return snap.docs.isEmpty ? null : StaffMember.fromDoc(snap.docs.first);
  }

  Future<void> setRole(String uid, UserRole role) => _users.doc(uid).update({
    'role': role.name,
    'updatedAt': FieldValue.serverTimestamp(),
  });

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
