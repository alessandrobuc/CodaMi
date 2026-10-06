import '../entities/pets_entity.dart';

abstract class PetsRepository {
  Stream<List<Pet>> watchPets(String ownerId);

  Future<void> savePet({
    required String ownerId,
    required PetDraft draft,
    Pet? existing,
    void Function(double progress)? onUploadProgress,
  });

  Future<void> deletePet(Pet pet);
}

class PetsException implements Exception {
  final String message;

  const PetsException(this.message);

  @override
  String toString() => message;
}
