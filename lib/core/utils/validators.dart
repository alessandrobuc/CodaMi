import 'package:flutter/widgets.dart';

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
    if (name.isEmpty) return 'Please enter your name';
    if (name.length < 2) return 'Name must be at least 2 characters';
    if (name.length > 50) return 'Name must be under 50 characters';
    if (!_nameRegex.hasMatch(name)) {
      return 'Name can only contain letters, spaces, hyphens and apostrophes';
    }
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter your email';
    if (!_emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Please enter your password';
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static FormFieldValidator<String> confirmPassword(
    String Function() password,
  ) {
    return (value) {
      if ((value ?? '').isEmpty) return 'Please confirm your password';
      if (value != password()) return 'Passwords do not match';
      return null;
    };
  }
}
