import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

// Shows a spinner while saving and keeps its colour, so it's clear the work runs.
class DialogSaveButton extends StatelessWidget {
  final String label;
  final bool saving;
  final VoidCallback? onPressed;

  const DialogSaveButton({
    super.key,
    required this.label,
    required this.saving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: saving ? null : onPressed,
      style: saving
          ? FilledButton.styleFrom(
              disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.8),
              disabledForegroundColor: Colors.white,
            )
          : null,
      child: saving
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(label),
    );
  }
}

// A short red line inside a dialog, for input or saving errors.
class DialogError extends StatelessWidget {
  final String? text;

  const DialogError(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final message = text;
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        message,
        style: const TextStyle(fontSize: 13, color: AppColors.danger),
      ),
    );
  }
}
