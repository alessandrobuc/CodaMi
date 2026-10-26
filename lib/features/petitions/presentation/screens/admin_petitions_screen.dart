import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/petition.dart';
import '../providers/petitions_provider.dart';
import '../widgets/petition_widgets.dart';
import 'admin_petition_form_screen.dart';

class AdminPetitionsScreen extends ConsumerStatefulWidget {
  const AdminPetitionsScreen({super.key});

  @override
  ConsumerState<AdminPetitionsScreen> createState() =>
      _AdminPetitionsScreenState();
}

class _AdminPetitionsScreenState extends ConsumerState<AdminPetitionsScreen> {
  PetitionReview? _filter;

  void _open([Petition? petition]) => Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => AdminPetitionFormScreen(petition: petition),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(allPetitionsProvider);
    final all = state.value ?? const <Petition>[];
    final counts = {
      for (final r in PetitionReview.values)
        r: all.where((p) => p.review == r).length,
    };
    final shown = [
      for (final p in all)
        if (_filter == null || p.review == _filter) p,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.petitions),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          onPressed: _open,
          icon: const Icon(Icons.add_rounded),
          label: Text(l10n.petitionAdd),
        ),
      ),
      body: switch (state) {
        AsyncValue(hasValue: false, hasError: true) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.actionFailed),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => ref.invalidate(allPetitionsProvider),
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.videoRetry),
              ),
            ],
          ),
        ),
        AsyncValue(hasValue: false) => const Center(
          child: CircularProgressIndicator(),
        ),
        _ => ListView(
          padding: EdgeInsets.fromLTRB(
            16,
            4,
            16,
            MediaQuery.paddingOf(context).bottom + 96,
          ),
          children: [
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final review in [null, ...PetitionReview.values])
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: ChoiceChip(
                        label: Text(
                          review == null
                              ? '${l10n.all} (${all.length})'
                              : '${review.label(l10n)} (${counts[review]})',
                        ),
                        selected: _filter == review,
                        showCheckmark: false,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        shape: const StadiumBorder(),
                        side: BorderSide(
                          color: _filter == review
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _filter == review
                              ? Colors.white
                              : AppColors.text,
                        ),
                        onSelected: (_) => setState(() => _filter = review),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (shown.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: EmptyState(
                  icon: const Icon(
                    Icons.campaign_rounded,
                    size: 44,
                    color: petitionColor,
                  ),
                  color: petitionColor,
                  title: l10n.petitions,
                  message: l10n.petitionAdminEmpty,
                ),
              ),
            for (final petition in shown) ...[
              _PetitionTile(petition: petition, onTap: () => _open(petition)),
              const SizedBox(height: 10),
            ],
          ],
        ),
      },
    );
  }
}

class _PetitionTile extends StatelessWidget {
  final Petition petition;
  final VoidCallback onTap;

  const _PetitionTile({required this.petition, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final updated = petition.updatedAt;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: PetitionImage(
                  petition: petition,
                  height: 64,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petition.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      [
                        petition.source,
                        if (updated != null) shortDate(l10n, updated),
                      ].join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        PetitionBadge(
                          label: petition.review.label(l10n),
                          color: petition.review.color,
                        ),
                        PetitionBadge(
                          label: petition.status.label(l10n),
                          color: petition.status.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
