import 'package:flutter/widgets.dart';

import '../../l10n/l10n.dart';

class Validators {
  static final _emailRegex = RegExp(
    r'^[\w.+-]+@[\w-]+(\.[\w-]+)*\.[a-zA-Z]{2,}$',
  );
  static final _nameRegex = RegExp(
    r"^[\p{L}]+(?:[ '\-.][\p{L}]+)*\.?$",
    unicode: true,
  );

  static String? name(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return appL10n.validationNameRequired;
    if (name.length < 2) return appL10n.validationNameTooShort;
    if (name.length > 50) return appL10n.validationNameTooLong;
    if (!_nameRegex.hasMatch(name)) {
      return appL10n.validationNameInvalid;
    }
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return appL10n.validationEmailRequired;
    if (!_emailRegex.hasMatch(email)) {
      return appL10n.validationEmailInvalid;
    }
    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return appL10n.validationPasswordRequired;
    if (password.length < 8) {
      return appL10n.validationPasswordTooShort;
    }
    return null;
  }

  static FormFieldValidator<String> confirmPassword(
    String Function() password,
  ) {
    return (value) {
      if ((value ?? '').isEmpty) return appL10n.validationConfirmRequired;
      if (value != password()) return appL10n.validationPasswordsDontMatch;
      return null;
    };
  }
}
