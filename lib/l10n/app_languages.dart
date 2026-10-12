import 'package:flutter/widgets.dart';

class AppLanguage {
  final String code;
  final String flag;
  final String nativeName;
  final String englishName;

  const AppLanguage(this.code, this.flag, this.nativeName, this.englishName);

  Locale get locale => Locale(code);
}

const appLanguages = [
  AppLanguage('en', '🇬🇧', 'English', 'English'),
  AppLanguage('it', '🇮🇹', 'Italiano', 'Italian'),
  AppLanguage('es', '🇪🇸', 'Español', 'Spanish'),
  AppLanguage('fr', '🇫🇷', 'Français', 'French'),
  AppLanguage('de', '🇩🇪', 'Deutsch', 'German'),
  AppLanguage('pt', '🇵🇹', 'Português', 'Portuguese'),
  AppLanguage('ru', '🇷🇺', 'Русский', 'Russian'),
  AppLanguage('ar', '🇸🇦', 'العربية', 'Arabic'),
  AppLanguage('zh', '🇨🇳', '中文', 'Chinese'),
  AppLanguage('hi', '🇮🇳', 'हिन्दी', 'Hindi'),
];

const defaultAppLanguage = AppLanguage('en', '🇬🇧', 'English', 'English');

// Kept in sync by LocaleNotifier.
AppLanguage currentAppLanguage = defaultAppLanguage;

final supportedAppLocales = [for (final l in appLanguages) l.locale];

AppLanguage? appLanguageFor(String? code) {
  for (final language in appLanguages) {
    if (language.code == code) return language;
  }
  return null;
}
