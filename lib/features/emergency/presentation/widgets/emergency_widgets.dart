import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/emergency.dart';

const emergencyColor = AppColors.danger;

extension EmergencyTypeLabel on EmergencyType {
  String label(AppLocalizations l10n) => switch (this) {
    EmergencyType.injured => l10n.emergencyTypeInjured,
    EmergencyType.danger => l10n.emergencyTypeDanger,
    EmergencyType.abandoned => l10n.emergencyTypeAbandoned,
    EmergencyType.urgentFound => l10n.emergencyTypeUrgentFound,
    EmergencyType.intervention => l10n.emergencyTypeIntervention,
    EmergencyType.other => l10n.emergencyTypeOther,
  };

  IconData get icon => switch (this) {
    EmergencyType.injured => Icons.healing_rounded,
    EmergencyType.danger => Icons.warning_amber_rounded,
    EmergencyType.abandoned => Icons.heart_broken_rounded,
    EmergencyType.urgentFound => Icons.pets_rounded,
    EmergencyType.intervention => Icons.front_hand_rounded,
    EmergencyType.other => Icons.emergency_rounded,
  };
}

extension EmergencyStatusLabel on EmergencyStatus {
  String label(AppLocalizations l10n) => switch (this) {
    EmergencyStatus.open => l10n.emergencyStatusOpen,
    EmergencyStatus.helping => l10n.emergencyStatusHelping,
    EmergencyStatus.resolved => l10n.emergencyStatusResolved,
    EmergencyStatus.closed => l10n.emergencyStatusClosed,
    EmergencyStatus.falseAlarm => l10n.emergencyStatusFalseAlarm,
  };

  Color get color => switch (this) {
    EmergencyStatus.open => emergencyColor,
    EmergencyStatus.helping => AppColors.accent,
    EmergencyStatus.resolved => AppColors.primary,
    EmergencyStatus.closed || EmergencyStatus.falseAlarm => AppColors.textMuted,
  };
}

extension ContactKindLabel on ContactKind {
  String label(AppLocalizations l10n) => switch (this) {
    ContactKind.vet => l10n.contactKindVet,
    ContactKind.association => l10n.contactKindAssociation,
    ContactKind.publicService => l10n.contactKindPublicService,
    ContactKind.other => l10n.contactKindOther,
  };

  IconData get icon => switch (this) {
    ContactKind.vet => Icons.local_hospital_rounded,
    ContactKind.association => Icons.volunteer_activism_rounded,
    ContactKind.publicService => Icons.account_balance_rounded,
    ContactKind.other => Icons.contact_phone_rounded,
  };
}

Future<void> openLink(BuildContext context, Uri uri, String failure) async {
  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) SnackbarUtils.showError(context, failure);
  } catch (_) {
    if (context.mounted) SnackbarUtils.showError(context, failure);
  }
}

// Always shown where emergencies are reported or listed.
class EmergencyDisclaimer extends StatelessWidget {
  const EmergencyDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: emergencyColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: emergencyColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_rounded, color: emergencyColor, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.emergencyDisclaimer,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: () => openLink(
              context,
              Uri(scheme: 'tel', path: '112'),
              l10n.callFailed,
            ),
            style: FilledButton.styleFrom(backgroundColor: emergencyColor),
            icon: const Icon(Icons.call_rounded, size: 18),
            label: Text(l10n.call112),
          ),
        ],
      ),
    );
  }
}

class EmergencyStatusChip extends StatelessWidget {
  final EmergencyStatus status;

  const EmergencyStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label(context.l10n),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: status.color,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const _Badge({required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final EmergencyContact contact;
  final double? distanceKm;
  final VoidCallback? onEdit;

  const ContactCard({
    super.key,
    required this.contact,
    this.distanceKm,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = contact;
    final km = distanceKm ?? c.distanceKm;
    final details = [
      c.kind.label(l10n),
      if (km != null) l10n.kmAway(km.toStringAsFixed(km < 10 ? 1 : 0)),
      if (c.open24h) l10n.open24h else ?c.hours,
    ];

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: c.isTest
              ? AppColors.accent.withValues(alpha: 0.6)
              : AppColors.border,
        ),
      ),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: emergencyColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(c.kind.icon, color: emergencyColor, size: 21),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.name,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          details.join(' · '),
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onEdit != null)
                    const Icon(
                      Icons.edit_rounded,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                ],
              ),
              if (c.isTest || c.verified || c.recommended || !c.active) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    if (c.isTest)
                      _Badge(
                        label: l10n.testContactBadge,
                        color: AppColors.rewardText,
                        icon: Icons.science_rounded,
                      ),
                    if (c.verified)
                      _Badge(
                        label: l10n.verifiedContact,
                        color: AppColors.primary,
                        icon: Icons.verified_rounded,
                      ),
                    if (c.recommended)
                      _Badge(
                        label: l10n.recommendedContact,
                        color: AppColors.primaryDark,
                        icon: Icons.star_rounded,
                      ),
                    if (!c.active)
                      _Badge(
                        label: l10n.contactInactive,
                        color: AppColors.textMuted,
                      ),
                  ],
                ),
              ],
              if (c.address != null) ...[
                const SizedBox(height: 8),
                Text(
                  c.address!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final phone in c.phones)
                    _ActionChip(
                      icon: Icons.call_rounded,
                      label: phone,
                      onTap: () => openLink(
                        context,
                        Uri(scheme: 'tel', path: phone.replaceAll(' ', '')),
                        l10n.callFailed,
                      ),
                    ),
                  if (c.email != null)
                    _ActionChip(
                      icon: Icons.mail_rounded,
                      label: l10n.email,
                      onTap: () => openLink(
                        context,
                        Uri(scheme: 'mailto', path: c.email),
                        l10n.emailFailed,
                      ),
                    ),
                  _ActionChip(
                    icon: Icons.directions_rounded,
                    label: l10n.directions,
                    onTap: () => openLink(
                      context,
                      Uri.parse(
                        'https://www.google.com/maps/dir/?api=1&destination=${c.lat},${c.lng}',
                      ),
                      l10n.openMapFailed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyTile extends StatelessWidget {
  final Emergency emergency;
  final VoidCallback onTap;
  final String? subtitle;

  const EmergencyTile({
    super.key,
    required this.emergency,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final e = emergency;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: e.status.isActive
              ? emergencyColor.withValues(alpha: 0.35)
              : AppColors.border,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: e.status.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(e.type.icon, color: e.status.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.type.label(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle ?? e.placeLabel ?? e.city ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              EmergencyStatusChip(status: e.status),
            ],
          ),
        ),
      ),
    );
  }
}
