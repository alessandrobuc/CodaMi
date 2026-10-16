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

class LocaleNotifier extends Notifier<AppLanguage> {
  @override
  AppLanguage build() {
    final saved = ref.read(sharedPreferencesProvider).getString(_prefsKey);
    return currentAppLanguage = appLanguageFor(saved) ?? defaultAppLanguage;
  }

  Future<void> select(AppLanguage language) async {
    state = currentAppLanguage = language;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_prefsKey, language.code);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) await saveToProfile(uid);
  }

  // Server notifications are sent in the language stored on the profile.
  Future<void> saveToProfile(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'language': state.code,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Saving language failed: $e');
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, AppLanguage>(
  LocaleNotifier.new,
);

const _confirmedKey = 'app_language_confirmed';

// False only on first launch, until the user confirms a language.
class LanguageConfirmedNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(_confirmedKey) ?? prefs.containsKey(_prefsKey);
  }

  Future<void> confirm() async {
    final language = ref.read(localeProvider);
    await ref.read(localeProvider.notifier).select(language);
    await ref.read(sharedPreferencesProvider).setBool(_confirmedKey, true);
    state = true;
  }
}

final languageConfirmedProvider =
    NotifierProvider<LanguageConfirmedNotifier, bool>(
      LanguageConfirmedNotifier.new,
    );
