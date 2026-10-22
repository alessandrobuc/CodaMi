import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/geo.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../domain/emergency.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_widgets.dart';

class EmergencyContactsScreen extends ConsumerStatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  ConsumerState<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState
    extends ConsumerState<EmergencyContactsScreen> {
  ContactKind? _kind;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(activeContactsProvider);
    final profile = ref.watch(userProfileProvider).value;
    final lat = profile?.homeLat;
    final lng = profile?.homeLng;
    final contacts = sortedForBrowsing(
      [
        for (final c in state.value ?? const <EmergencyContact>[])
          if (_kind == null || c.kind == _kind) c,
      ],
      lat: lat,
      lng: lng,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.emergencyContacts),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          4,
          20,
          MediaQuery.paddingOf(context).bottom + 32,
        ),
        children: [
          const EmergencyDisclaimer(),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final kind in [null, ...ContactKind.values]) ...[
                  ChoiceChip(
                    label: Text(kind?.label(l10n) ?? l10n.allContacts),
                    selected: kind == _kind,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                      color: kind == _kind
                          ? AppColors.primary
                          : AppColors.border,
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kind == _kind ? Colors.white : AppColors.text,
                    ),
                    onSelected: (_) => setState(() => _kind = kind),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (state.isLoading && !state.hasValue)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (contacts.isEmpty)
            EmptyState(
              icon: const Icon(Icons.contact_phone_rounded),
              title: l10n.noEmergencyContacts,
              message: l10n.noEmergencyContactsMessage,
            )
          else
            for (final c in contacts) ...[
              ContactCard(
                contact: c,
                distanceKm: lat == null || lng == null
                    ? null
                    : metersBetween(lat, lng, c.lat, c.lng) / 1000,
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}
