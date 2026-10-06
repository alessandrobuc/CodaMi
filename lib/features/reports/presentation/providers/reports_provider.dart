import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/reports_remote_data_source.dart';
import '../../data/repositories/reports_repository_impl.dart';
import '../../domain/entities/reports_entity.dart';
import '../../domain/repositories/reports_repository.dart';
import '../../domain/usecases/get_reports_usecase.dart';

final reportsRepositoryProvider = Provider<ReportsRepository>(
  (ref) => ReportsRepositoryImpl(ReportsRemoteDataSource()),
);

final openReportsProvider = StreamProvider.family<List<Report>, ReportType>(
  (ref, type) => GetReportsUseCase(ref.watch(reportsRepositoryProvider))(type),
);

final reportProvider = StreamProvider.family<Report?, String>(
  (ref, id) => ref.watch(reportsRepositoryProvider).watchReport(id),
);
