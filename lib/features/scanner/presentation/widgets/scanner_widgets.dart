import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/breed_scan.dart';

const scannerColor = Color(0xFF6D4AB8);
const _warnColor = Color(0xFFB45309);

extension ScanConfidenceView on ScanConfidence {
  Color get color => switch (this) {
    ScanConfidence.high => AppColors.primary,
    ScanConfidence.medium => scannerColor,
    ScanConfidence.low => _warnColor,
  };

  String label(AppLocalizations l10n) => switch (this) {
    ScanConfidence.high => l10n.scannerConfidenceHigh,
    ScanConfidence.medium => l10n.scannerConfidenceMedium,
    ScanConfidence.low => l10n.scannerConfidenceLow,
  };
}

// Must match modelTier in functions/src/scanner.ts.
ModelTier modelTierOf(String id) => id.contains('lite')
    ? ModelTier.lite
    : id.contains('flash')
    ? ModelTier.flash
    : ModelTier.pro;

extension ModelTierView on ModelTier {
  String label(AppLocalizations l10n) => switch (this) {
    ModelTier.lite => l10n.scannerModelTierLite,
    ModelTier.flash => l10n.scannerModelTierFlash,
    ModelTier.pro => l10n.scannerModelTierPro,
  };
}

extension BreedFactView on BreedFact {
  IconData get icon => switch (this) {
    BreedFact.size => Icons.straighten_rounded,
    BreedFact.weight => Icons.monitor_weight_outlined,
    BreedFact.lifeSpan => Icons.cake_outlined,
    BreedFact.temperament => Icons.emoji_emotions_outlined,
    BreedFact.characteristics => Icons.auto_awesome_outlined,
    BreedFact.care => Icons.spa_outlined,
  };

  String label(AppLocalizations l10n) => switch (this) {
    BreedFact.size => l10n.breedFactSize,
    BreedFact.weight => l10n.breedFactWeight,
    BreedFact.lifeSpan => l10n.breedFactLifeSpan,
    BreedFact.temperament => l10n.breedFactTemperament,
    BreedFact.characteristics => l10n.breedFactCharacteristics,
    BreedFact.care => l10n.breedFactCare,
  };
}

class ScannerCard extends StatelessWidget {
  final Widget child;
  final Color? tint;

  const ScannerCard({super.key, required this.child, this.tint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tint?.withValues(alpha: 0.07) ?? AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: tint?.withValues(alpha: 0.25) ?? AppColors.border,
        ),
      ),
      child: child,
    );
  }
}

class ScannerSectionTitle extends StatelessWidget {
  final String text;

  const ScannerSectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: AppColors.text,
        ),
      ),
    );
  }
}

class ConfidenceBar extends StatelessWidget {
  final int percent;
  final double height;

  const ConfidenceBar({super.key, required this.percent, this.height = 8});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: percent / 100,
        minHeight: height,
        backgroundColor: AppColors.border.withValues(alpha: 0.6),
        color: ScanConfidence.of(percent).color,
      ),
    );
  }
}

class ScannerChip extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const ScannerChip({
    super.key,
    required this.text,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerNote extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const ScannerNote({
    super.key,
    required this.icon,
    required this.text,
    this.color = AppColors.textMuted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 17, color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, height: 1.4, color: color),
          ),
        ),
      ],
    );
  }
}

// Shortcut to the scanner at the top of the Pets tab.
class ScannerPromoCard extends StatelessWidget {
  final VoidCallback onTap;

  const ScannerPromoCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: scannerColor.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: scannerColor.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 21,
                backgroundColor: scannerColor,
                child: Icon(
                  Icons.document_scanner_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.scannerIntroTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.scannerSubtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: scannerColor),
            ],
          ),
        ),
      ),
    );
  }
}
