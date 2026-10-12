import 'package:flutter/widgets.dart';

import 'app_languages.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

// For code without a BuildContext (validators, repository errors).
AppLocalizations get appL10n =>
    lookupAppLocalizations(currentAppLanguage.locale);
