import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

// Label sits above the box, so the outline never opens a gap for it.
InputDecoration fieldDecoration({
  String? hint,
  String? help,
  String? error,
  Widget? suffix,
  Color focusColor = AppColors.primary,
}) {
  OutlineInputBorder border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: AppColors.textMuted.withValues(alpha: 0.7)),
    helperText: help,
    helperMaxLines: 3,
    helperStyle: const TextStyle(fontSize: 12, color: AppColors.textMuted),
    errorText: error,
    errorMaxLines: 2,
    counterStyle: const TextStyle(fontSize: 11, color: AppColors.textMuted),
    suffixIcon: suffix,
    isDense: true,
    filled: true,
    fillColor: AppColors.background,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: border(AppColors.border),
    enabledBorder: border(AppColors.border),
    focusedBorder: border(focusColor, 1.6),
    errorBorder: border(AppColors.danger),
    focusedErrorBorder: border(AppColors.danger, 1.6),
  );
}

class LabeledField extends StatelessWidget {
  final String label;
  final bool hasError;
  final Widget child;

  const LabeledField({
    super.key,
    required this.label,
    required this.child,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 2, bottom: 6),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: hasError ? AppColors.danger : AppColors.text,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? help;
  final String? error;
  final int lines;
  final int? maxLength;
  final TextInputType? keyboard;
  final Widget? suffix;
  final Color focusColor;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.help,
    this.error,
    this.lines = 1,
    this.maxLength,
    this.keyboard,
    this.suffix,
    this.focusColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final plain =
        keyboard == TextInputType.url || keyboard == TextInputType.emailAddress;
    return LabeledField(
      label: label,
      hasError: error != null,
      child: TextField(
        controller: controller,
        minLines: lines,
        maxLines: lines == 1 ? 1 : lines + 4,
        maxLength: maxLength,
        keyboardType: keyboard ?? (lines > 1 ? TextInputType.multiline : null),
        autocorrect: !plain,
        textCapitalization: plain
            ? TextCapitalization.none
            : TextCapitalization.sentences,
        cursorColor: focusColor,
        style: const TextStyle(fontSize: 15, color: AppColors.text),
        decoration: fieldDecoration(
          hint: hint,
          help: help,
          error: error,
          suffix: suffix,
          focusColor: focusColor,
        ),
      ),
    );
  }
}
