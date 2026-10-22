import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/points_repository.dart';
import '../../domain/invite_code.dart';

class InviteCodeException implements Exception {
  final String message;

  const InviteCodeException(this.message);
}

// Returns the inviter's first name, or throws [InviteCodeException] with a message for the user.
Future<String> redeemInviteCode(
  WidgetRef ref,
  AppLocalizations l10n,
  String input, {
  String? ownCode,
}) async {
  final code = extractInviteCode(input);
  if (code == null) throw InviteCodeException(l10n.inviteCodeFormat);
  if (code == ownCode) throw InviteCodeException(l10n.inviteCodeOwn);
  try {
    return await ref.read(pointsRepositoryProvider).redeem(code);
  } on FirebaseFunctionsException catch (e) {
    final details = e.details is Map ? e.details as Map : const {};
    throw InviteCodeException(switch (e.code) {
      'not-found' || 'invalid-argument' => l10n.inviteCodeNotFound,
      'already-exists' => l10n.inviteCodeAlreadyUsed,
      'resource-exhausted' => l10n.inviteCodeTooManyTries,
      'failed-precondition' => switch (details['reason']) {
        'own_code' => l10n.inviteCodeOwn,
        'too_late' => l10n.inviteCodeTooLate(
          (details['days'] as num?)?.toInt() ?? 7,
        ),
        _ => l10n.inviteCodeNotAllowed,
      },
      'unavailable' || 'deadline-exceeded' => l10n.checkConnection,
      _ => l10n.actionFailed,
    });
  } catch (_) {
    throw InviteCodeException(l10n.checkConnection);
  }
}

// Upper-cases what is typed and, when a whole message or link is pasted, keeps only the code.
class _InviteCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    if (text.length > inviteCodeLength) {
      text = extractInviteCode(text) ?? text;
    }
    text = text.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');
    if (text.length > inviteCodeLength) return oldValue;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class InviteCodeField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool large;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;

  const InviteCodeField({
    super.key,
    required this.controller,
    this.errorText,
    this.large = false,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.characters,
      textAlign: large ? TextAlign.center : TextAlign.start,
      textInputAction: TextInputAction.done,
      inputFormatters: [_InviteCodeFormatter()],
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
      style: TextStyle(
        fontSize: large ? 26 : 16,
        fontWeight: FontWeight.w800,
        letterSpacing: large ? 6 : 2,
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        hintText: 'ABC234',
        hintStyle: TextStyle(
          color: AppColors.textMuted.withValues(alpha: 0.4),
          letterSpacing: large ? 6 : 2,
        ),
        errorText: errorText,
        errorMaxLines: 3,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: large ? 18 : 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.6),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
