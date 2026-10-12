import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/pets_entity.dart';
import '../../domain/repositories/pets_repository.dart';
import '../datasources/pets_remote_data_source.dart';
import '../../../../l10n/l10n.dart';

class PetsRepositoryImpl implements PetsRepository {
  final PetsRemoteDataSource _remote;

  const PetsRepositoryImpl(this._remote);

  @override
  Stream<List<Pet>> watchPets(String ownerId) => _remote.watchPets(ownerId);

  @override
  Future<void> savePet({
    required String ownerId,
    required PetDraft draft,
    Pet? existing,
    void Function(double progress)? onUploadProgress,
  }) => _guard(
    () => _remote.savePet(
      ownerId: ownerId,
      draft: draft,
      existing: existing,
      onUploadProgress: onUploadProgress,
    ),
    action: 'save',
  );

  @override
  Future<void> deletePet(Pet pet) =>
      _guard(() => _remote.deletePet(pet), action: 'delete');

  Future<void> _guard(
    Future<void> Function() run, {
    required String action,
  }) async {
    try {
      await run();
    } on FirebaseException catch (e) {
      debugPrint('Pet $action failed: ${e.plugin}/${e.code} ${e.message}');
      throw PetsException(_messageFor(e, action));
    } catch (e) {
      debugPrint('Pet $action failed: $e');
      throw PetsException(_failed(action));
    }
  }

  String _failed(String action) =>
      action == 'delete' ? appL10n.petDeleteFailed : appL10n.petSaveFailed;

  String _messageFor(FirebaseException e, String action) {
    return switch (e.code) {
      'permission-denied' ||
      'unauthorized' ||
      'unauthenticated' => appL10n.errorPermission,
      'unavailable' ||
      'retry-limit-exceeded' ||
      'network-request-failed' => appL10n.errorOffline,
      'bucket-not-found' || 'project-not-found' || 'object-not-found'
          when e.plugin == 'firebase_storage' =>
        appL10n.storageNotReady,
      'quota-exceeded' => appL10n.storageFull,
      _ => _failed(action),
    };
  }
}
