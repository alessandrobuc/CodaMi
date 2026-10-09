import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_languages.dart';

const _prefsKey = 'app_language';

// Overridden in main() with the instance loaded before the first frame.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() => appLanguageFor(
    ref.read(sharedPreferencesProvider).getString(_prefsKey),
  )?.locale;

  // null means follow the phone's language.
  Future<void> select(AppLanguage? language) async {
    state = language?.locale;
    final prefs = ref.read(sharedPreferencesProvider);
    language == null
        ? await prefs.remove(_prefsKey)
        : await prefs.setString(_prefsKey, language.code);

    // Saved on the profile so server notifications can use it later.
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'language': language?.code ?? FieldValue.delete(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Saving language failed: $e');
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
