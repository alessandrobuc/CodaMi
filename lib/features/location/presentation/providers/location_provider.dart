import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/places_service.dart';
import '../../data/repositories/home_city_repository.dart';

final placesServiceProvider = Provider((ref) => PlacesService());

final homeCityRepositoryProvider = Provider((ref) => HomeCityRepository());
