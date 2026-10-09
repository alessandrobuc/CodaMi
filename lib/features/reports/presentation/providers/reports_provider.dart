import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/reports_remote_data_source.dart';
import '../../data/repositories/reports_repository_impl.dart';
import '../../domain/entities/reports_entity.dart';
import '../../domain/repositories/reports_repository.dart';
import '../../domain/usecases/get_reports_usecase.dart';

const reportsPageSize = 20;
const mapPinLimit = 300;
const resolvedLimit = 20;
const myReportsLimit = 100;

final reportsRepositoryProvider = Provider<ReportsRepository>(
  (ref) => ReportsRepositoryImpl(ReportsRemoteDataSource()),
);

class ReportsLimit extends Notifier<int> {
  ReportsLimit(this.type);

  final ReportType type;

  @override
  int build() => reportsPageSize;

  void loadMore({required int loaded}) {
    if (loaded > state) state += reportsPageSize;
  }
}

final reportsLimitProvider =
    NotifierProvider.family<ReportsLimit, int, ReportType>(ReportsLimit.new);

final openReportsProvider = StreamProvider.family<List<Report>, ReportType>((
  ref,
  type,
) {
  final limit = ref.watch(reportsLimitProvider(type));
  return GetReportsUseCase(ref.watch(reportsRepositoryProvider))(
    type,
    limit: limit + 1,
  );
});

final hasMoreReportsProvider = Provider.family<bool, ReportType>(
  (ref, type) =>
      (ref.watch(openReportsProvider(type)).value?.length ?? 0) >
      ref.watch(reportsLimitProvider(type)),
);

final mapReportsProvider = StreamProvider.family<List<Report>, ReportType>(
  (ref, type) => GetReportsUseCase(ref.watch(reportsRepositoryProvider))(
    type,
    limit: mapPinLimit + 1,
  ),
);

final resolvedReportsProvider = StreamProvider<List<Report>>(
  (ref) => ref
      .watch(reportsRepositoryProvider)
      .watchResolvedReports(limit: resolvedLimit),
);

final reportProvider = StreamProvider.family<Report?, String>(
  (ref, id) => ref.watch(reportsRepositoryProvider).watchReport(id),
);

final myReportsProvider = StreamProvider<List<Report>>((ref) {
  final uid = ref.watch(authStateProvider.select((s) => s.value?.uid));
  if (uid == null) return Stream.value(const []);
  return ref
      .watch(reportsRepositoryProvider)
      .watchMyReports(uid, limit: myReportsLimit);
});
