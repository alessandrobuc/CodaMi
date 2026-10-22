import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/emergency.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_widgets.dart';
import 'create_emergency_screen.dart';
import 'emergency_contacts_screen.dart';
import 'emergency_screen.dart';

// Emergencies near the user's city and the ones they reported.
class EmergenciesScreen extends ConsumerStatefulWidget {
  const EmergenciesScreen({super.key});

  @override
  ConsumerState<EmergenciesScreen> createState() => _EmergenciesScreenState();
}

class _EmergenciesScreenState extends ConsumerState<EmergenciesScreen> {
  bool _mine = false;

  void _open(Emergency e) => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => EmergencyScreen(emergencyId: e.id)));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final nearby = ref.watch(nearbyEmergenciesProvider);
    final mine = ref.watch(myEmergenciesProvider).value ?? const [];
    final items = _mine ? mine : nearby;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.emergencies),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: l10n.emergencyContacts,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const EmergencyContactsScreen(),
              ),
            ),
            icon: const Icon(Icons.contact_phone_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: emergencyColor,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => const CreateEmergencyScreen(),
          ),
        ),
        icon: const Icon(Icons.emergency_rounded),
        label: Text(l10n.reportEmergency),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
        children: [
          Row(
            children: [
              for (final mineTab in [false, true]) ...[
                ChoiceChip(
                  label: Text(
                    mineTab ? l10n.myEmergencies : l10n.emergenciesNearYou,
                  ),
                  selected: _mine == mineTab,
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  side: BorderSide(
                    color: _mine == mineTab
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _mine == mineTab ? Colors.white : AppColors.text,
                  ),
                  onSelected: (_) => setState(() => _mine = mineTab),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 14),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: EmptyState(
                icon: const Icon(Icons.health_and_safety_rounded),
                title: _mine ? l10n.noMyEmergencies : l10n.noEmergenciesNearby,
                message: l10n.noEmergenciesMessage,
              ),
            )
          else
            for (final e in items) ...[
              EmergencyTile(
                emergency: e,
                subtitle: [
                  e.placeLabel ?? e.city ?? '',
                  if (e.createdAt != null) timeAgo(l10n, e.createdAt!),
                ].where((s) => s.isNotEmpty).join(' · '),
                onTap: () => _open(e),
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}
