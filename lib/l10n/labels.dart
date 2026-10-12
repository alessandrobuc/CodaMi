import '../features/pets/domain/entities/pets_entity.dart';
import '../features/reports/domain/entities/reports_entity.dart';
import 'app_localizations.dart';

extension ReportTypeLabel on ReportType {
  String label(AppLocalizations l10n) => switch (this) {
    ReportType.lost => l10n.lost,
    ReportType.found => l10n.found,
  };
}

extension PetSpeciesLabel on PetSpecies {
  String label(AppLocalizations l10n) => switch (this) {
    PetSpecies.dog => l10n.speciesDog,
    PetSpecies.cat => l10n.speciesCat,
    PetSpecies.other => l10n.speciesOther,
  };
}

extension PetSexLabel on PetSex {
  String label(AppLocalizations l10n) => switch (this) {
    PetSex.male => l10n.sexMale,
    PetSex.female => l10n.sexFemale,
    PetSex.unknown => l10n.sexUnknown,
  };
}

extension ReportLabels on Report {
  String placeLabel(AppLocalizations l10n) {
    final detail = placeDetail;
    if (detail == null) return city;
    return areaRadius == null ? '$detail, $city' : l10n.nearPlace(detail, city);
  }

  String resolvedLabel(AppLocalizations l10n) =>
      type == ReportType.lost ? l10n.backHome : l10n.reunited;
}

extension PetLabels on Pet {
  String subtitle(AppLocalizations l10n) {
    final parts = [breed, age].whereType<String>().where((p) => p.isNotEmpty);
    return parts.isEmpty ? species.label(l10n) : parts.join(' · ');
  }
}
