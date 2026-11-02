import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

import '../../location/data/datasources/places_service.dart';
import '../domain/walks.dart';

enum WalksError { limit, off, unavailable }

class WalksException implements Exception {
  final WalksError error;

  const WalksException(this.error);
}

// Google searches run on the server, so the API key never reaches the app.
class WalksRepository {
  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;

  WalksRepository({FirebaseFirestore? db, FirebaseFunctions? functions})
    : _db = db ?? FirebaseFirestore.instance,
      _functions =
          functions ??
          FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion);

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('walks');

  Stream<WalksConfig> watchConfig() =>
      _config.snapshots().map((d) => WalksConfig.fromMap(d.data()));

  Future<void> saveConfig(WalksConfig config, {required String adminId}) =>
      _config.set({
        ...config.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<T> _call<T>(
    String name,
    Map<String, Object> data,
    T Function(Map result) parse,
  ) async {
    try {
      final result = await _functions.httpsCallable(name).call(data);
      return parse(result.data as Map);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('$name failed: ${e.code} ${e.message}');
      throw WalksException(switch (e.code) {
        'resource-exhausted' => WalksError.limit,
        'failed-precondition' => WalksError.off,
        _ => WalksError.unavailable,
      });
    } catch (e) {
      debugPrint('$name failed: $e');
      throw const WalksException(WalksError.unavailable);
    }
  }

  Future<List<WalkPlace>> findPlaces({
    required double lat,
    required double lng,
    required int radiusKm,
    required String language,
  }) => _call(
    'findWalkPlaces',
    {'lat': lat, 'lng': lng, 'radiusKm': radiusKm, 'language': language},
    (r) => [
      for (final p in r['places'] as List? ?? const [])
        if (p is Map) WalkPlace.fromMap(p),
    ],
  );

  Future<WalkDetails> details(String placeId, {required String language}) =>
      _call('walkPlaceDetails', {
        'placeId': placeId,
        'language': language,
      }, WalkDetails.fromMap);
}
