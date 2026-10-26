import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/petition.dart';
import '../widgets/petition_widgets.dart';
import 'petitions_screen.dart';

class PetitionDetailScreen extends StatelessWidget {
  final Petition petition;

  const PetitionDetailScreen({super.key, required this.petition});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final host = Uri.tryParse(petition.url)?.host ?? '';
    final started = petition.draft.startedOn;
    final unavailable = petition.status == PetitionStatus.unavailable;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.petition),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!petition.canSign)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  unavailable
                      ? l10n.petitionUnavailableNote
                      : l10n.petitionEndedNote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: unavailable
                    ? null
                    : () => openPetition(context, petition),
                style: FilledButton.styleFrom(
                  backgroundColor: petitionColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.open_in_new_rounded),
                label: Text(
                  petition.canSign
                      ? l10n.petitionSignOnSite
                      : l10n.petitionView,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          PetitionImage(
            petition: petition,
            height: 200,
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PetitionBadge(
                label: petition.status.label(l10n),
                color: petition.status.color,
              ),
              PetitionBadge(
                label: petition.topic.label(l10n),
                color: petitionColor,
              ),
              if (petition.country.isNotEmpty)
                PetitionBadge(
                  label: petition.country,
                  color: AppColors.textMuted,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            petition.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.text,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            petition.summary,
            style: const TextStyle(
              fontSize: 15,
              height: 1.45,
              color: AppColors.textMuted,
            ),
          ),
          _Block(
            icon: Icons.report_problem_rounded,
            title: l10n.petitionIssue,
            text: petition.issue,
          ),
          _Block(
            icon: Icons.flag_rounded,
            title: l10n.petitionAction,
            text: petition.action,
          ),
          _Block(
            icon: Icons.favorite_rounded,
            title: l10n.petitionWhy,
            text: petition.why,
          ),
          _Block(
            icon: Icons.link_rounded,
            title: l10n.petitionWhere,
            text: [
              petition.source,
              if (host.isNotEmpty) host,
              if (started != null)
                l10n.petitionStartedOn(shortDate(l10n, started)),
            ].join('\n'),
          ),
          const SizedBox(height: 14),
          Text(
            l10n.petitionDisclaimer,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _Block({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: petitionColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.45,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
