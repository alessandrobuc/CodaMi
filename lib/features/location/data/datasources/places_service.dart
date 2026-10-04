import 'dart:convert';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

import '../models/city_place.dart';

class PlacesException implements Exception {
  final String message;

  const PlacesException(this.message);

  @override
  String toString() => message;
}

typedef FunctionInvoker =
    Future<Map<String, dynamic>> Function(
      String name,
      Map<String, dynamic> data,
    );

class PlacesService {
  static const functionsRegion = 'europe-west1';

  final FunctionInvoker _invoke;
  String? _sessionToken;

  PlacesService({FunctionInvoker? invoke})
    : _invoke = invoke ?? _invokeCloudFunction;

  String get _session => _sessionToken ??= _newSessionToken();

  Future<List<PlaceSuggestion>> searchCities(String input) async {
    final query = input.trim();
    if (query.length < 2) return const [];

    final result = await _call('searchCities', {
      'input': query,
      'sessionToken': _session,
    });
    return (result['suggestions'] as List? ?? [])
        .map((s) => PlaceSuggestion.fromMap(s as Map<String, dynamic>))
        .where((s) => s.placeId.isNotEmpty)
        .toList();
  }

  Future<CityPlace> cityDetails(PlaceSuggestion suggestion) async {
    final result = await _call('getCityDetails', {
      'placeId': suggestion.placeId,
      'sessionToken': _session,
    });
    _sessionToken = null;
    try {
      return CityPlace.fromMap(result, suggestion: suggestion);
    } catch (e) {
      debugPrint('getCityDetails returned unexpected data: $e');
      throw const PlacesException('City search failed. Please try again.');
    }
  }

  Future<Map<String, dynamic>> _call(
    String name,
    Map<String, dynamic> data,
  ) async {
    try {
      return await _invoke(name, data);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('$name failed: ${e.code} ${e.message}');
      throw PlacesException(switch (e.code) {
        'unauthenticated' => 'Your session expired. Please sign in again.',
        'not-found' =>
          e.message ?? 'We couldn\'t find that city. Please pick another one.',
        'unavailable' || 'deadline-exceeded' =>
          'Couldn\'t reach city search. Check your connection and try again.',
        _ => 'City search failed. Please try again.',
      });
    } catch (e) {
      debugPrint('$name failed: $e');
      throw const PlacesException('City search failed. Please try again.');
    }
  }

  static Future<Map<String, dynamic>> _invokeCloudFunction(
    String name,
    Map<String, dynamic> data,
  ) async {
    final callable = FirebaseFunctions.instanceFor(region: functionsRegion)
        .httpsCallable(
          name,
          options: HttpsCallableOptions(timeout: const Duration(seconds: 15)),
        );
    final result = await callable.call<Object?>(data);
    return jsonDecode(jsonEncode(result.data)) as Map<String, dynamic>;
  }

  static String _newSessionToken() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }
}
