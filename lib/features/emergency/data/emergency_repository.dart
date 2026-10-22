import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/photo_uploader.dart';
import '../../location/data/datasources/places_service.dart';
import '../domain/emergency.dart';

class EmergencyRepository {
  final FirebaseFirestore _db;
  final PhotoUploader _photos;

  EmergencyRepository({FirebaseFirestore? db, PhotoUploader? photos})
    : _db = db ?? FirebaseFirestore.instance,
      _photos = photos ?? PhotoUploader();

  CollectionReference<Map<String, dynamic>> get _emergencies =>
      _db.collection('emergencies');

  CollectionReference<Map<String, dynamic>> get _contacts =>
      _db.collection('emergencyContacts');

  Future<String> create({
    required String ownerId,
    required String ownerName,
    required EmergencyDraft draft,
    void Function(double progress)? onUploadProgress,
  }) async {
    final doc = _emergencies.doc();
    final photoUrls = await _photos.upload(
      folder: 'emergencies/$ownerId/${doc.id}',
      photos: draft.photos,
      onProgress: onUploadProgress,
    );
    String? optional(String? value) {
      final text = value?.trim() ?? '';
      return text.isEmpty ? null : text;
    }

    await doc.set({
      'ownerId': ownerId,
      'ownerName': ownerName.length > 80
          ? ownerName.substring(0, 80)
          : ownerName,
      'type': draft.type.value,
      'species': draft.species.name,
      'description': draft.description.trim(),
      'photoUrls': photoUrls,
      'lat': draft.lat,
      'lng': draft.lng,
      'placeLabel': ?optional(draft.placeLabel),
      'city': ?optional(draft.city),
      'cityKey': ?optional(draft.cityKey),
      'contactPhone': ?optional(draft.contactPhone),
      'status': EmergencyStatus.open.value,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastActivityAt': FieldValue.serverTimestamp(),
    });
    return doc.id;
  }

  Stream<Emergency?> watch(String id) => _emergencies
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? Emergency.fromMap(d.id, d.data()!) : null);

  Stream<List<Emergency>> watchActive({required int limit}) => _emergencies
      .where(
        'status',
        whereIn: [EmergencyStatus.open.value, EmergencyStatus.helping.value],
      )
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(_list);

  Stream<List<Emergency>> watchMine(String uid) => _emergencies
      .where('ownerId', isEqualTo: uid)
      .snapshots()
      .map(
        (snap) => _list(snap)
          ..sort(
            (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
              a.createdAt ?? DateTime.now(),
            ),
          ),
      );

  Stream<List<Emergency>> watchAll({required int limit}) => _emergencies
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(_list);

  List<Emergency> _list(QuerySnapshot<Map<String, dynamic>> snap) => [
    for (final d in snap.docs) Emergency.fromMap(d.id, d.data()),
  ];

  Future<void> act(String id, EmergencyAction action) =>
      _call('updateEmergency', {'emergencyId': id, 'action': action.value});

  Stream<List<EmergencyContact>> watchActiveContacts() => _contacts
      .where('active', isEqualTo: true)
      .orderBy('name')
      .snapshots()
      .map(_contactList);

  Stream<List<EmergencyContact>> watchAllContacts() =>
      _contacts.orderBy('name').snapshots().map(_contactList);

  List<EmergencyContact> _contactList(
    QuerySnapshot<Map<String, dynamic>> snap,
  ) => [for (final d in snap.docs) EmergencyContact.fromMap(d.id, d.data())];

  Future<void> saveContact(EmergencyContact contact) {
    final data = {
      ...contact.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (contact.id.isEmpty) {
      return _contacts.add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return _contacts.doc(contact.id).set(data, SetOptions(merge: true));
  }

  Future<void> deleteContact(String id) => _contacts.doc(id).delete();

  Future<void> addTestContacts() => _call('seedTestContacts', const {});

  Future<Map<String, dynamic>> loadConfig() async =>
      (await _db.collection('config').doc('emergency').get()).data() ?? {};

  Future<void> saveConfig(Map<String, dynamic> config) =>
      _db.collection('config').doc('emergency').set(config);

  Future<void> _call(String name, Map<String, Object> data) =>
      FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion)
          .httpsCallable(
            name,
            options: HttpsCallableOptions(timeout: const Duration(seconds: 30)),
          )
          .call<Object?>(data);
}

final emergencyRepositoryProvider = Provider((ref) => EmergencyRepository());
