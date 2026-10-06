import '../../../pets/domain/entities/pets_entity.dart';

enum ReportType {
  lost('Lost'),
  found('Found');

  final String label;

  const ReportType(this.label);

  static ReportType fromValue(String? value) =>
      value == 'found' ? ReportType.found : ReportType.lost;
}

enum ReportStatus {
  open,
  resolved,
  closed;

  static ReportStatus fromValue(String? value) => ReportStatus.values
      .firstWhere((s) => s.name == value, orElse: () => ReportStatus.open);
}

class ReportPlace {
  final String city;
  final String cityKey;
  final String country;
  final double lat;
  final double lng;
  final String label;

  const ReportPlace({
    required this.city,
    required this.cityKey,
    required this.country,
    required this.lat,
    required this.lng,
    required this.label,
  });
}

class Report {
  final String id;
  final String ownerId;
  final String ownerName;
  final ReportType type;
  final String? petId;
  final String petName;
  final PetSpecies species;
  final String description;
  final List<String> photoUrls;
  final String country;
  final String city;
  final String cityKey;
  final String? placeDetail;
  final double lat;
  final double lng;
  final DateTime eventAt;
  final ReportStatus status;
  final String? contactPhone;
  final String? contactEmail;
  final bool whatsapp;
  final DateTime? createdAt;
  final DateTime? resolvedAt;

  const Report({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.type,
    required this.petName,
    required this.species,
    required this.description,
    required this.photoUrls,
    required this.country,
    required this.city,
    required this.cityKey,
    required this.lat,
    required this.lng,
    required this.eventAt,
    required this.status,
    this.petId,
    this.placeDetail,
    this.contactPhone,
    this.contactEmail,
    this.whatsapp = false,
    this.createdAt,
    this.resolvedAt,
  });

  bool get isOpen => status == ReportStatus.open;

  String? get coverUrl => photoUrls.isEmpty ? null : photoUrls.first;

  String get ownerContact => contactPhone ?? contactEmail ?? '';

  String get placeLabel => placeDetail == null ? city : '$placeDetail, $city';
}

class ReportDraft {
  final ReportType type;
  final String ownerName;
  final String? petId;
  final String petName;
  final PetSpecies species;
  final String description;
  final List<PetPhoto> photos;
  final ReportPlace place;
  final String? placeDetail;
  final DateTime eventAt;
  final String? contactPhone;
  final String? contactEmail;
  final bool whatsapp;

  const ReportDraft({
    required this.type,
    required this.ownerName,
    required this.petName,
    required this.species,
    required this.description,
    required this.photos,
    required this.place,
    required this.eventAt,
    this.petId,
    this.placeDetail,
    this.contactPhone,
    this.contactEmail,
    this.whatsapp = false,
  });
}
