import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/locale_provider.dart';
import '../domain/donations.dart';

class DonationsRepository {
  final FirebaseFirestore _db;
  final SharedPreferences _prefs;

  static const _lastPromptKey = 'donation_prompt_last';

  DonationsRepository(this._prefs, {FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('donations');

  Stream<DonationsConfig> watchConfig() =>
      _config.snapshots().map((d) => DonationsConfig.fromMap(d.data()));

  // paymentsReady is set when the store products exist, not from the app.
  Future<void> saveConfig(DonationsConfig config, {required String adminId}) =>
      _config.set({
        ...config.toMap(),
        'updatedBy': adminId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  DateTime? get lastPrompt {
    final ms = _prefs.getInt(_lastPromptKey);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  Future<void> promptShown() =>
      _prefs.setInt(_lastPromptKey, DateTime.now().millisecondsSinceEpoch);
}

final donationsRepositoryProvider = Provider(
  (ref) => DonationsRepository(ref.read(sharedPreferencesProvider)),
);

final donationsConfigProvider = StreamProvider<DonationsConfig>(
  (ref) => ref.watch(donationsRepositoryProvider).watchConfig(),
);
