import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

import '../../location/data/datasources/places_service.dart';
import '../domain/breed_scan.dart';

enum ScanError { limit, off, badPhoto, unavailable }

class ScanException implements Exception {
  final ScanError error;

  const ScanException(this.error);
}

// The photo goes to the server, which asks the AI; nothing is stored.
class ScannerRepository {
  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;

  ScannerRepository({FirebaseFirestore? db, FirebaseFunctions? functions})
    : _db = db ?? FirebaseFirestore.instance,
      _functions =
          functions ??
          FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion);

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('scanner');

  Stream<ScannerConfig> watchConfig() =>
      _config.snapshots().map((d) => ScannerConfig.fromMap(d.data()));

  Future<void> saveConfig(ScannerConfig config, {required String adminId}) =>
      _config.set({
        ...config.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<ScannerModels> models() async {
    final result = await _functions.httpsCallable('scannerModels').call();
    return ScannerModels.fromMap(result.data as Map);
  }

  Future<BreedScan> scan(Uint8List photo, {required String language}) async {
    try {
      final result = await _functions
          .httpsCallable(
            'scanBreed',
            options: HttpsCallableOptions(timeout: const Duration(seconds: 90)),
          )
          .call({'image': base64Encode(photo), 'language': language});
      return BreedScan.fromMap(result.data as Map);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('scanBreed failed: ${e.code} ${e.message}');
      throw ScanException(switch (e.code) {
        'resource-exhausted' => ScanError.limit,
        'failed-precondition' => ScanError.off,
        'invalid-argument' => ScanError.badPhoto,
        _ => ScanError.unavailable,
      });
    } catch (e) {
      debugPrint('scanBreed failed: $e');
      throw const ScanException(ScanError.unavailable);
    }
  }
}
