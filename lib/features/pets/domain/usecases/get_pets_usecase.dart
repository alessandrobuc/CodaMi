import '../entities/pets_entity.dart';
import '../repositories/pets_repository.dart';

class GetPetsUseCase {
  final PetsRepository _repository;

  const GetPetsUseCase(this._repository);

  Stream<List<Pet>> call(String ownerId) => _repository.watchPets(ownerId);
}
