import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';

List<TextInputFormatter> _numberFormatters(bool decimal) => [
  FilteringTextInputFormatter.allow(
    decimal ? RegExp(r'[0-9.,]') : RegExp(r'[0-9]'),
  ),
];

// A labelled number field for admin settings. Out-of-range values are
// ignored by the server, which then uses its default.
class SettingsNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? help;
  final bool decimal;

  const SettingsNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.help,
    this.decimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
        inputFormatters: _numberFormatters(decimal),
        decoration: InputDecoration(
          labelText: label,
          helperText: help,
          helperMaxLines: 3,
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

class SettingsNumberBox extends StatelessWidget {
  final TextEditingController controller;
  final bool decimal;
  final double width;

  const SettingsNumberBox({
    super.key,
    required this.controller,
    this.decimal = false,
    this.width = 84,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
        inputFormatters: _numberFormatters(decimal),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.background,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
          ),
        ),
      ),
    );
  }
}

// One setting as a row: label and help on the left, a small number box on the right.
class SettingsNumberTile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? help;
  final bool decimal;
  final double boxWidth;

  const SettingsNumberTile({
    super.key,
    required this.controller,
    required this.label,
    this.help,
    this.decimal = false,
    this.boxWidth = 84,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                if (help != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    help!,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.3,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 14),
          SettingsNumberBox(
            controller: controller,
            decimal: decimal,
            width: boxWidth,
          ),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String text;

  const SettingsHeader({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, Colors.black, 0.25)!],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Colors.white.withValues(alpha: 0.88),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.icon,
    this.color = AppColors.primary,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // A Material, not a coloured box, so list tiles inside show their ripples.
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(icon, size: 19, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              for (final (i, child) in children.indexed) ...[
                if (i > 0) const Divider(height: 1, color: AppColors.border),
                child,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSaveButton extends StatelessWidget {
  final String label;
  final bool saving;
  final VoidCallback onPressed;

  const SettingsSaveButton({
    super.key,
    required this.label,
    required this.saving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: saving ? null : onPressed,
      icon: saving
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.check_rounded),
      label: Text(label),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}

// Leaves room below the last item so it never sits under the phone's buttons.
EdgeInsets settingsListPadding(BuildContext context) => EdgeInsets.fromLTRB(
  16,
  4,
  16,
  120 + MediaQuery.viewPaddingOf(context).bottom,
);

int? readInt(TextEditingController c) => int.tryParse(c.text.trim());

double? readDouble(TextEditingController c) =>
    double.tryParse(c.text.trim().replaceAll(',', '.'));
