import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/city_place.dart';

class HomeCityRepository {
  final FirebaseFirestore _firestore;

  HomeCityRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveHomeCity(String uid, CityPlace place) {
    return _firestore.collection('users').doc(uid).set({
      ...place.toUserFields(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
