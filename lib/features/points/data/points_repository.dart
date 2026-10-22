import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../location/data/datasources/places_service.dart';
import '../domain/points.dart';

class PointsRepository {
  final FirebaseFirestore _db;

  PointsRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  static const _installIdKey = 'install_id';
  static const _visitDayKey = 'visit_day';

  // A random ID made on this phone, used only to spot invite abuse. It isn't
  // linked to the hardware or advertising ID, and the server keeps a hash.
  Future<String> installId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_installIdKey);
    if (existing != null) return existing;
    final random = Random.secure();
    final id = [
      for (var i = 0; i < 16; i++)
        random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ].join();
    await prefs.setString(_installIdKey, id);
    return id;
  }

  // Once a day is enough; the server counts each day only once anyway.
  Future<void> registerVisit() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = romeDayKey(DateTime.now());
      if (prefs.getString(_visitDayKey) == today) return;
      await _call('registerVisit', {'installId': await installId()});
      await prefs.setString(_visitDayKey, today);
    } catch (e) {
      debugPrint('Visit not registered: $e');
    }
  }

  Future<({int points, int bonus})> claim(DailyTask task) async {
    final result = await _call('claimDailyTask', {'task': task.name});
    final data = Map<String, dynamic>.from(result as Map);
    return (
      points: (data['points'] as num).toInt(),
      bonus: (data['bonus'] as num?)?.toInt() ?? 0,
    );
  }

  Future<String> inviteCode() async {
    final result = await _call('getInviteCode', const {});
    return (result as Map)['code'] as String;
  }

  // Returns the inviter's first name.
  Future<String> redeem(String code) async {
    final result = await _call('redeemInviteCode', {
      'code': code,
      'installId': await installId(),
    });
    return (result as Map)['inviterName'] as String? ?? '';
  }

  Stream<PointsConfig> watchConfig() => _db
      .collection('config')
      .doc('points')
      .snapshots()
      .map((d) => PointsConfig.fromMap(d.data()));

  Future<void> saveConfig(PointsConfig config) =>
      _db.collection('config').doc('points').set(config.toMap());

  Stream<List<PointsEntry>> watchLedger(String uid, {int limit = 100}) => _db
      .collection('users')
      .doc(uid)
      .collection('pointsLedger')
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (snap) => [
          for (final d in snap.docs) PointsEntry.fromMap(d.id, d.data()),
        ],
      );

  Stream<List<Referral>> watchInvitesBy(String uid) => _db
      .collection('referrals')
      .where('inviterId', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .limit(200)
      .snapshots()
      .map(_referrals);

  Stream<Referral?> watchMyReferral(String uid) => _db
      .collection('referrals')
      .doc(uid)
      .snapshots()
      .map((d) => d.exists ? Referral.fromMap(d.id, d.data()!) : null);

  Stream<List<Referral>> watchToReview() => _db
      .collection('referrals')
      .where('status', isEqualTo: ReferralStatus.review.name)
      .orderBy('createdAt')
      .limit(200)
      .snapshots()
      .map(_referrals);

  List<Referral> _referrals(QuerySnapshot<Map<String, dynamic>> snap) => [
    for (final d in snap.docs) Referral.fromMap(d.id, d.data()),
  ];

  Future<void> review(String inviteeId, {required bool approve}) => _call(
    'adminReviewReferral',
    {'inviteeId': inviteeId, 'approve': approve},
  );

  Future<void> adjust(String uid, int amount, String reason) => _call(
    'adminAdjustPoints',
    {'uid': uid, 'amount': amount, 'reason': reason},
  );

  Future<Object?> _call(String name, Map<String, Object> data) async =>
      (await FirebaseFunctions.instanceFor(
                region: PlacesService.functionsRegion,
              )
              .httpsCallable(
                name,
                options: HttpsCallableOptions(
                  timeout: const Duration(seconds: 30),
                ),
              )
              .call<Object?>(data))
          .data;
}

final pointsRepositoryProvider = Provider((ref) => PointsRepository());
