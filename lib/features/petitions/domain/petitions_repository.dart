import 'dart:io';

import 'petition.dart';

sealed class PetitionImageChange {
  const PetitionImageChange();
}

class KeepImage extends PetitionImageChange {
  const KeepImage();
}

class NewImage extends PetitionImageChange {
  final File file;

  const NewImage(this.file);
}

class RemoveImage extends PetitionImageChange {
  const RemoveImage();
}

// The only way the app reads or writes petitions. Firebase is one
// implementation; another backend only needs a new class.
abstract interface class PetitionsRepository {
  // What users see: published petitions only.
  Stream<List<Petition>> watchPublished();

  // Every petition, for admins.
  Stream<List<Petition>> watchAll();

  // Creates the petition when [existing] is null. Returns its id.
  Future<String> save({
    Petition? existing,
    required PetitionDraft draft,
    required String adminId,
    PetitionImageChange image = const KeepImage(),
  });

  Future<void> delete(Petition petition);
}
