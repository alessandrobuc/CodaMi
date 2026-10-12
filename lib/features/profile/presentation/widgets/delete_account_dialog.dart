import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

const deleteConfirmWord = 'CONFIRM';

// Returns true once the user has proved it is really them.
Future<bool> confirmAccountDeletion(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => const _DeleteAccountDialog(),
  );
  return confirmed ?? false;
}

class _DeleteAccountDialog extends ConsumerStatefulWidget {
  const _DeleteAccountDialog();

  @override
  ConsumerState<_DeleteAccountDialog> createState() =>
      _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<_DeleteAccountDialog> {
  final _controller = TextEditingController();
  late final bool _usesPassword = ref.read(authRepositoryProvider).usesPassword;
  bool _obscure = true;
  bool _checking = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _ready => _usesPassword
      ? _controller.text.isNotEmpty
      : _controller.text.trim() == deleteConfirmWord;

  Future<void> _submit() async {
    if (!_ready || _checking) return;
    if (!_usesPassword) {
      Navigator.pop(context, true);
      return;
    }
    setState(() {
      _checking = true;
      _error = null;
    });
    try {
      await ref.read(authRepositoryProvider).reauthenticate(_controller.text);
      if (mounted) Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _checking = false;
        _error = switch (e.code) {
          'wrong-password' ||
          'invalid-credential' ||
          'INVALID_LOGIN_CREDENTIALS' => context.l10n.wrongPassword,
          _ => authErrorMessage(e),
        };
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _checking = false;
        _error = authErrorMessage(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: AppColors.danger,
        size: 32,
      ),
      title: Text(l10n.deleteAccountTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.deleteAccountMessage, textAlign: TextAlign.center),
            const SizedBox(height: 18),
            Text(
              _usesPassword
                  ? l10n.deleteAccountPasswordPrompt
                  : l10n.deleteAccountTypeConfirm(deleteConfirmWord),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              autofocus: true,
              enabled: !_checking,
              obscureText: _usesPassword && _obscure,
              autocorrect: false,
              enableSuggestions: false,
              textCapitalization: _usesPassword
                  ? TextCapitalization.none
                  : TextCapitalization.characters,
              textInputAction: TextInputAction.done,
              onChanged: (_) => setState(() => _error = null),
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: _usesPassword ? l10n.password : deleteConfirmWord,
                errorText: _error,
                errorMaxLines: 3,
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                suffixIcon: _usesPassword
                    ? IconButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: _checking ? null : () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _ready && !_checking ? _submit : null,
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          child: _checking
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(l10n.deleteAccount),
        ),
      ],
    );
  }
}
