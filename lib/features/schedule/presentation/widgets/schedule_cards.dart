import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../providers/schedule_provider.dart';
import '../screens/schedule_form_screen.dart';
import '../screens/schedule_screen.dart';
import 'schedule_widgets.dart';

// Top of the Pets tab: the next event, or what the schedule is for.
class SchedulePromoCard extends ConsumerWidget {
  const SchedulePromoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final next = ref.watch(upcomingOccurrencesProvider(null)).firstOrNull;
    final text = next == null
        ? l10n.schPromo
        : l10n.schNext(
            eventTitle(l10n, next.event),
            whenText(l10n, next, DateTime.now()),
          );
    return ScheduleCard(
      tint: scheduleColor,
      padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const ScheduleScreen())),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 21,
            backgroundColor: scheduleColor,
            child: Icon(
              Icons.event_note_rounded,
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
                  l10n.schTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: scheduleColor),
        ],
      ),
    );
  }
}

// On a pet's page: its next few events.
class PetScheduleCard extends ConsumerWidget {
  final Pet pet;

  const PetScheduleCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final next = ref.watch(upcomingOccurrencesProvider(pet.id)).take(3);
    final now = DateTime.now();
    void openAll() => Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => ScheduleScreen(petId: pet.id)));
    return ScheduleCard(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.event_note_rounded,
                color: scheduleColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.schTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
              ),
              TextButton(onPressed: openAll, child: Text(l10n.schSeeAll)),
            ],
          ),
          if (next.isEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 4),
              child: Text(
                l10n.schPetEmpty(pet.name),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          for (final o in next)
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => showOccurrenceSheet(context, ref, o),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    ScheduleTypeIcon(o.event.type, size: 34),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventTitle(l10n, o.event),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                          Text(
                            whenText(l10n, o, now),
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 4),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => ScheduleFormScreen(petId: pet.id),
              ),
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(l10n.schAddEvent),
          ),
        ],
      ),
    );
  }
}
