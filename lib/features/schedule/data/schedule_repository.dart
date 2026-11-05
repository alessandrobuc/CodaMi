import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../domain/schedule.dart';

class ScheduleRepository {
  final FirebaseFirestore _db;

  ScheduleRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('schedule');
  CollectionReference<Map<String, dynamic>> get _events =>
      _db.collection('scheduleEvents');

  Stream<ScheduleConfig> watchConfig() =>
      _config.snapshots().map((d) => ScheduleConfig.fromMap(d.data()));

  Future<void> saveConfig(ScheduleConfig config, {required String adminId}) =>
      _config.set({
        ...config.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  static ScheduleEvent? _read(String id, Map<String, dynamic> data) {
    final reminders = [
      for (final r in data['reminders'] as List? ?? const [])
        if (r is Map && r['at'] is Timestamp)
          {...r, 'at': (r['at'] as Timestamp).toDate()},
    ];
    return ScheduleEvent.fromMap(id, {...data, 'reminders': reminders});
  }

  Stream<List<ScheduleEvent>> watchEvents(String ownerId) => _events
      .where('ownerId', isEqualTo: ownerId)
      .snapshots()
      .map((s) => [for (final d in s.docs) ?_read(d.id, d.data())]);

  Future<List<ScheduleEvent>> events(String ownerId) async {
    final s = await _events.where('ownerId', isEqualTo: ownerId).get();
    return [for (final d in s.docs) ?_read(d.id, d.data())];
  }

  Map<String, Object?> _reminderFields(List<PlannedReminder> reminders) => {
    'reminders': [
      for (final r in reminders)
        {'at': Timestamp.fromDate(r.at), 'title': r.title, 'body': r.body},
    ],
    'nextRemindAt': reminders.isEmpty
        ? null
        : Timestamp.fromDate(reminders.first.at),
  };

  // Returns the event's id.
  Future<String> save(ScheduleEvent e, List<PlannedReminder> reminders) async {
    final fields = {
      ...e.toMap(),
      ..._reminderFields(reminders),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (e.id.isEmpty) {
      final doc = await _events.add({
        ...fields,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return doc.id;
    }
    fields.remove('ownerId');
    await _events.doc(e.id).update(fields);
    return e.id;
  }

  Future<void> saveReminders(String id, List<PlannedReminder> reminders) =>
      _events.doc(id).update({
        ..._reminderFields(reminders),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<void> delete(String id) => _events.doc(id).delete();

  // Events only for this pet go; shared ones just lose the pet.
  Future<void> removePet(
    String ownerId,
    String petId, {
    required bool delete,
  }) async {
    for (final e in await events(ownerId)) {
      final i = e.petIds.indexOf(petId);
      if (i < 0) continue;
      try {
        if (delete && e.petIds.length == 1) {
          await _events.doc(e.id).delete();
          continue;
        }
        final ids = [...e.petIds]..removeAt(i);
        final names = [...e.petNames];
        if (i < names.length) names.removeAt(i);
        await _events.doc(e.id).update({
          'petIds': ids,
          'petNames': names,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } catch (err) {
        debugPrint('Schedule event ${e.id} not updated: $err');
      }
    }
  }
}
