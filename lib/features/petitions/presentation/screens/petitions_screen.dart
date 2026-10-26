import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/petition.dart';
import '../providers/petitions_provider.dart';
import '../widgets/petition_widgets.dart';
import 'petition_detail_screen.dart';

// Signing always happens on the original site, in the browser.
Future<void> openPetition(BuildContext context, Petition petition) async {
  final failure = context.l10n.petitionOpenFailed;
  final uri = Uri.tryParse(petition.url);
  if (uri == null || !isPetitionUrl(petition.url)) {
    SnackbarUtils.showError(context, failure);
    return;
  }
  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) SnackbarUtils.showError(context, failure);
  } catch (_) {
    if (context.mounted) SnackbarUtils.showError(context, failure);
  }
}

class PetitionsScreen extends ConsumerStatefulWidget {
  const PetitionsScreen({super.key});

  @override
  ConsumerState<PetitionsScreen> createState() => _PetitionsScreenState();
}

class _PetitionsScreenState extends ConsumerState<PetitionsScreen> {
  PetitionTopic? _topic;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(publishedPetitionsProvider);
    final all = state.value ?? const <Petition>[];
    final topics = {for (final p in all) p.topic};
    final petitions = [
      for (final p in all)
        if (_topic == null || p.topic == _topic) p,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.petitions),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: switch (state) {
        AsyncValue(hasValue: false, hasError: true) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.actionFailed),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => ref.invalidate(publishedPetitionsProvider),
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.videoRetry),
              ),
            ],
          ),
        ),
        AsyncValue(hasValue: false) => const Center(
          child: CircularProgressIndicator(),
        ),
        _ when all.isEmpty => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: EmptyState(
              icon: const Icon(
                Icons.campaign_rounded,
                size: 44,
                color: petitionColor,
              ),
              color: petitionColor,
              title: l10n.petitions,
              message: l10n.petitionsEmpty,
            ),
          ),
        ),
        _ => ListView(
          padding: EdgeInsets.fromLTRB(
            16,
            4,
            16,
            MediaQuery.paddingOf(context).bottom + 24,
          ),
          children: [
            const _Intro(),
            if (topics.length > 1) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final topic in [
                      null,
                      ...PetitionTopic.values.where(topics.contains),
                    ])
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: ChoiceChip(
                          label: Text(topic?.label(l10n) ?? l10n.all),
                          selected: _topic == topic,
                          showCheckmark: false,
                          selectedColor: petitionColor,
                          backgroundColor: AppColors.surface,
                          shape: const StadiumBorder(),
                          side: BorderSide(
                            color: _topic == topic
                                ? petitionColor
                                : AppColors.border,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _topic == topic
                                ? Colors.white
                                : AppColors.text,
                          ),
                          onSelected: (_) => setState(() => _topic = topic),
                        ),
                      ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            for (final petition in petitions) ...[
              PetitionCard(
                petition: petition,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PetitionDetailScreen(petition: petition),
                  ),
                ),
                onView: () => openPetition(context, petition),
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      },
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: petitionColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_rounded, color: petitionColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.petitionsIntro,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
