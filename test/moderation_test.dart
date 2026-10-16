import 'package:CodaMi/features/moderation/data/moderation_repository.dart';
import 'package:CodaMi/features/moderation/presentation/providers/moderation_provider.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/reports/domain/entities/reports_entity.dart';
import 'package:flutter_test/flutter_test.dart';

Report _report(String id, String ownerId, {ReportStatus? status}) => Report(
  id: id,
  ownerId: ownerId,
  ownerName: 'Owner',
  type: ReportType.lost,
  petName: 'Luna',
  species: PetSpecies.dog,
  description: 'A small brown dog',
  photoUrls: const [],
  country: 'IT',
  city: 'Milano',
  cityKey: 'milano',
  lat: 0,
  lng: 0,
  eventAt: DateTime(2026),
  status: status ?? ReportStatus.open,
);

ReportFlag _flag(String reportId, FlagReason reason, int minute) => ReportFlag(
  id: 'u${minute}_$reportId',
  reportId: reportId,
  reportOwnerId: 'owner',
  reporterId: 'u$minute',
  reason: reason,
  createdAt: DateTime(2026, 1, 1, 0, minute),
);

void main() {
  test('blocked owners are removed from lists', () {
    final reports = [_report('r1', 'a'), _report('r2', 'b')];
    expect(withoutBlocked(reports, const {}), reports);
    expect(withoutBlocked(reports, const {'a': 'Anna'}).map((r) => r.id), [
      'r2',
    ]);
  });

  test('flags are grouped per report, keeping the newest first', () {
    final grouped = FlaggedReport.group([
      _flag('r1', FlagReason.spam, 30),
      _flag('r2', FlagReason.scam, 20),
      _flag('r1', FlagReason.scam, 10),
      _flag('r1', FlagReason.spam, 5),
    ]);
    expect(grouped.map((g) => g.reportId), ['r1', 'r2']);
    expect(grouped.first.flags.length, 3);
    expect(grouped.first.latest, DateTime(2026, 1, 1, 0, 30));
    expect(grouped.first.reasons, {FlagReason.spam, FlagReason.scam});
  });

  test('unknown flag reasons fall back to other', () {
    expect(FlagReason.fromValue('wrongInfo'), FlagReason.wrongInfo);
    expect(FlagReason.fromValue('nonsense'), FlagReason.other);
  });

  test('hidden reports are neither open nor resolved', () {
    final hidden = _report('r1', 'a', status: ReportStatus.fromValue('hidden'));
    expect(hidden.isHidden, isTrue);
    expect(hidden.isOpen, isFalse);
    expect(hidden.activeReward, isNull);
  });
}
