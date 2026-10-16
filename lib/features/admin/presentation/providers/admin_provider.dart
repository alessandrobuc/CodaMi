import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/admin_repository.dart';

final supportStaffProvider = StreamProvider<List<StaffMember>>(
  (ref) => ref.watch(adminRepositoryProvider).watchSupportStaff(),
);

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) {
  final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
  return ref.watch(adminRepositoryProvider).stats(includeUsers: isAdmin);
});
