import 'package:cloud_firestore/cloud_firestore.dart';

import '../../pets/domain/entities/pets_entity.dart';
import '../domain/heat.dart';

class HeatReminder {
  final int daysBefore;
  final String nextStart;
  final int cycleDays;

  const HeatReminder(this.daysBefore, this.nextStart, this.cycleDays);
}

class HeatRepository {
  final FirebaseFirestore _db;

  HeatRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('heat');
  CollectionReference<Map<String, dynamic>> get _cycles =>
      _db.collection('heatCycles');
  DocumentReference<Map<String, dynamic>> _reminder(String petId) =>
      _db.collection('heatReminders').doc(petId);

  Stream<HeatConfig> watchConfig() =>
      _config.snapshots().map((d) => HeatConfig.fromMap(d.data()));

  Future<void> saveConfig(HeatConfig config, {required String adminId}) =>
      _config.set({
        ...config.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Stream<List<HeatCycle>> watchCycles(String ownerId, String petId) => _cycles
      .where('ownerId', isEqualTo: ownerId)
      .where('petId', isEqualTo: petId)
      .snapshots()
      .map(
        (s) =>
            [for (final d in s.docs) ?HeatCycle.fromMap(d.id, d.data())]
              ..sort((a, b) => b.start.compareTo(a.start)),
      );

  Future<void> saveCycle({
    required String ownerId,
    required String petId,
    String? id,
    required DateTime start,
    DateTime? end,
    required String notes,
  }) {
    final fields = {
      'ownerId': ownerId,
      'petId': petId,
      'start': heatDayKey(start),
      'end': end == null ? null : heatDayKey(end),
      'notes': notes.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (id == null) {
      return _cycles.add({
        ...fields,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return _cycles.doc(id).update(fields);
  }

  Future<void> deleteCycle(String id) => _cycles.doc(id).delete();

  Stream<HeatReminder?> watchReminder(String petId) =>
      _reminder(petId).snapshots().map((d) {
        final data = d.data();
        final days = data?['daysBefore'];
        if (data == null || days is! int) return null;
        return HeatReminder(
          days,
          data['nextStart'] as String? ?? '',
          data['cycleDays'] as int? ?? 0,
        );
      });

  Future<void> saveReminder(
    Pet pet,
    HeatReminderPlan plan, {
    required int daysBefore,
  }) => _reminder(pet.id).set({
    'ownerId': pet.ownerId,
    'petId': pet.id,
    'petName': pet.name.length <= 60 ? pet.name : pet.name.substring(0, 60),
    'nextStart': heatDayKey(plan.nextStart),
    'remindOn': heatDayKey(plan.remindOn),
    'cycleDays': plan.cycleDays,
    'daysBefore': daysBefore,
    'updatedAt': FieldValue.serverTimestamp(),
  });

  Future<void> deleteReminder(String petId) => _reminder(petId).delete();

  Future<void> deleteForPet(String ownerId, String petId) async {
    final cycles = await _cycles
        .where('ownerId', isEqualTo: ownerId)
        .where('petId', isEqualTo: petId)
        .get();
    await Future.wait([
      for (final d in cycles.docs) d.reference.delete(),
      _reminder(petId).delete(),
    ]);
  }
}
