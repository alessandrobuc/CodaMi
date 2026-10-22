import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/emergency.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_widgets.dart';
import 'emergency_screen.dart';

class AdminEmergenciesScreen extends ConsumerStatefulWidget {
  const AdminEmergenciesScreen({super.key});

  @override
  ConsumerState<AdminEmergenciesScreen> createState() =>
      _AdminEmergenciesScreenState();
}

class _AdminEmergenciesScreenState
    extends ConsumerState<AdminEmergenciesScreen> {
  bool _activeOnly = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(allEmergenciesProvider);
    final all = state.value ?? const <Emergency>[];
    final items = [
      for (final e in all)
        if (!_activeOnly || e.status.isActive) e,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.emergencies),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
        children: [
          Row(
            children: [
              for (final active in [true, false]) ...[
                ChoiceChip(
                  label: Text(
                    active ? l10n.emergenciesActive : l10n.emergenciesAll,
                  ),
                  selected: _activeOnly == active,
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  side: BorderSide(
                    color: _activeOnly == active
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _activeOnly == active
                        ? Colors.white
                        : AppColors.text,
                  ),
                  onSelected: (_) => setState(() => _activeOnly = active),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 14),
          if (state.isLoading && !state.hasValue)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: EmptyState(
                icon: const Icon(Icons.health_and_safety_rounded),
                title: l10n.noActiveEmergencies,
                message: l10n.noEmergenciesMessage,
              ),
            )
          else
            for (final e in items) ...[
              EmergencyTile(
                emergency: e,
                subtitle: [
                  e.placeLabel ?? e.city ?? '',
                  e.ownerName,
                  if (e.createdAt != null) timeAgo(l10n, e.createdAt!),
                  if (e.falseReports > 0)
                    l10n.emergencyFalseReports(e.falseReports),
                ].where((s) => s.isNotEmpty).join(' · '),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EmergencyScreen(emergencyId: e.id),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}
