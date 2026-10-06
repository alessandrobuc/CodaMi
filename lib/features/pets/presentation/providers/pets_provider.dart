import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/pets_remote_data_source.dart';
import '../../data/repositories/pets_repository_impl.dart';
import '../../domain/entities/pets_entity.dart';
import '../../domain/repositories/pets_repository.dart';
import '../../domain/usecases/get_pets_usecase.dart';

final petsRepositoryProvider = Provider<PetsRepository>(
  (ref) => PetsRepositoryImpl(PetsRemoteDataSource()),
);

final myPetsProvider = StreamProvider<List<Pet>>((ref) {
  final uid = ref.watch(authStateProvider.select((state) => state.value?.uid));
  if (uid == null) return Stream.value(const []);
  return GetPetsUseCase(ref.watch(petsRepositoryProvider))(uid);
});

final petByIdProvider = Provider.family<Pet?, String>((ref, id) {
  for (final pet in ref.watch(myPetsProvider).value ?? const <Pet>[]) {
    if (pet.id == id) return pet;
  }
  return null;
});
