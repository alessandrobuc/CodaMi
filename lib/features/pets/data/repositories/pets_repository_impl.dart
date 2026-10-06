import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/pets_entity.dart';
import '../../domain/repositories/pets_repository.dart';
import '../datasources/pets_remote_data_source.dart';

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
      throw PetsException('Couldn\'t $action your pet. Please try again.');
    }
  }

  String _messageFor(FirebaseException e, String action) {
    return switch (e.code) {
      'permission-denied' ||
      'unauthorized' ||
      'unauthenticated' => 'You don\'t have permission to $action this pet.',
      'unavailable' || 'retry-limit-exceeded' || 'network-request-failed' =>
        'You\'re offline. Check your connection and try again.',
      'bucket-not-found' || 'project-not-found' || 'object-not-found'
          when e.plugin == 'firebase_storage' =>
        'Photo storage isn\'t set up yet. Please try again later.',
      'quota-exceeded' => 'Storage is full right now. Please try again later.',
      _ => 'Couldn\'t $action your pet. Please try again.',
    };
  }
}
