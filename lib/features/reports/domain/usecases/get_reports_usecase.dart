import '../entities/reports_entity.dart';
import '../repositories/reports_repository.dart';

class GetReportsUseCase {
  final ReportsRepository _repository;

  const GetReportsUseCase(this._repository);

  Stream<List<Report>> call(ReportType type) =>
      _repository.watchOpenReports(type);
}
