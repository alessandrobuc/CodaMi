import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/firestore_petitions_repository.dart';
import '../../domain/petition.dart';
import '../../domain/petitions_repository.dart';

final petitionsRepositoryProvider = Provider<PetitionsRepository>(
  (ref) => FirestorePetitionsRepository(),
);

final publishedPetitionsProvider = StreamProvider<List<Petition>>(
  (ref) =>
      ref.watch(petitionsRepositoryProvider).watchPublished().map(sortForUsers),
);

final allPetitionsProvider = StreamProvider<List<Petition>>(
  (ref) => ref.watch(petitionsRepositoryProvider).watchAll(),
);

final activePetitionCountProvider = Provider<int>(
  (ref) =>
      ref
          .watch(publishedPetitionsProvider)
          .value
          ?.where((p) => p.canSign)
          .length ??
      0,
);
