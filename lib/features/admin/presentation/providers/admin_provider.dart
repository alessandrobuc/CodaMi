import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../data/admin_repository.dart';

final supportStaffProvider = StreamProvider<List<StaffMember>>(
  (ref) => ref.watch(adminRepositoryProvider).watchSupportStaff(),
);

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) {
  final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
  return ref.watch(adminRepositoryProvider).stats(includeUsers: isAdmin);
});

const adminPageSize = 30;

class AdminLimit extends Notifier<int> {
  AdminLimit(this.key);

  final Object key;

  @override
  int build() => adminPageSize;

  void loadMore({required int loaded}) {
    if (loaded > state) state += adminPageSize;
  }
}

final adminLimitProvider = NotifierProvider.family<AdminLimit, int, Object>(
  AdminLimit.new,
);

final adminReportsProvider = StreamProvider.family<List<Report>, ReportStatus>((
  ref,
  status,
) {
  final limit = ref.watch(adminLimitProvider(status));
  return ref
      .watch(adminRepositoryProvider)
      .watchReports(status, limit: limit + 1);
});

const usersListKey = 'users';

final adminUsersProvider = StreamProvider<List<UserModel>>((ref) {
  final limit = ref.watch(adminLimitProvider(usersListKey));
  return ref.watch(adminRepositoryProvider).watchUsers(limit: limit + 1);
});

final adminUserProvider = StreamProvider.family<UserModel?, String>(
  (ref, uid) => ref.watch(adminRepositoryProvider).watchUser(uid),
);

final userReportCountProvider = FutureProvider.family<int, String>(
  (ref, uid) => ref.watch(adminRepositoryProvider).reportCount(uid),
);
