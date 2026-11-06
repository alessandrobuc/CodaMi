import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../location/data/datasources/places_service.dart';
import '../domain/titles.dart';

class Donation {
  final String id;
  final int cents;
  final String note;
  final DateTime? createdAt;

  const Donation({
    required this.id,
    required this.cents,
    this.note = '',
    this.createdAt,
  });
}

class TitlesRepository {
  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;

  TitlesRepository({FirebaseFirestore? db, FirebaseFunctions? functions})
    : _db = db ?? FirebaseFirestore.instance,
      _functions =
          functions ??
          FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion);

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('titles');

  Stream<TitlesConfig> watchConfig() =>
      _config.snapshots().map((d) => TitlesConfig.fromMap(d.data()));

  Future<void> saveConfig(TitlesConfig c, {required String adminId}) =>
      _config.set({
        ...c.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Stream<Achievements> watchAchievements(String uid) => _db
      .collection('achievements')
      .doc(uid)
      .snapshots()
      .map((d) => Achievements.fromMap(d.data()));

  Stream<PublicTitles> watchPublic(String uid) => _db
      .collection('publicProfiles')
      .doc(uid)
      .snapshots()
      .map((d) => PublicTitles.fromMap(d.data()));

  Future<Object?> _call(String name, Map<String, Object?> data) async =>
      (await _functions.httpsCallable(name).call(data)).data;

  Future<void> refresh() => _call('refreshMyTitles', const {});

  // [main] null picks the best title automatically.
  Future<void> setPrefs({TitleId? main, required bool hideDonor}) =>
      _call('setTitlePrefs', {'main': main?.name, 'hideDonor': hideDonor});

  // [level] 0 takes the title away; null allows it again.
  Future<void> adminSetTitle(String uid, TitleId id, int? level) =>
      _call('adminSetTitle', {'uid': uid, 'id': id.name, 'level': level});

  Future<void> recordDonation(String uid, int cents, String note) =>
      _call('adminRecordDonation', {'uid': uid, 'cents': cents, 'note': note});

  Future<void> deleteDonation(String id) =>
      _call('adminDeleteDonation', {'id': id});

  Stream<List<Donation>> watchDonations(String uid) => _db
      .collection('donations')
      .where('uid', isEqualTo: uid)
      .limit(100)
      .snapshots()
      .map(
        (s) =>
            [
              for (final d in s.docs)
                Donation(
                  id: d.id,
                  cents: (d.data()['cents'] as num?)?.toInt() ?? 0,
                  note: d.data()['note'] as String? ?? '',
                  createdAt: (d.data()['createdAt'] as Timestamp?)?.toDate(),
                ),
            ]..sort(
              (a, b) => (b.createdAt ?? DateTime(2100)).compareTo(
                a.createdAt ?? DateTime(2100),
              ),
            ),
      );

  // How many users show a title right now.
  Future<int> holders(TitleId id) async {
    final snap = await _db
        .collection('achievements')
        .where('levels.${id.name}', isGreaterThanOrEqualTo: 1)
        .count()
        .get();
    return snap.count ?? 0;
  }
}

final titlesRepositoryProvider = Provider((ref) => TitlesRepository());
