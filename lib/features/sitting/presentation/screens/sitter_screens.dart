import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../moderation/presentation/widgets/flag_actions.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../domain/sitting.dart';
import '../providers/sitting_provider.dart';
import '../widgets/sitting_widgets.dart';
import 'chat_screens.dart';
import 'request_screens.dart';

class SitterFormScreen extends ConsumerStatefulWidget {
  final SitterProfile? existing;

  const SitterFormScreen({super.key, this.existing});

  @override
  ConsumerState<SitterFormScreen> createState() => _SitterFormScreenState();
}

class _SitterFormScreenState extends ConsumerState<SitterFormScreen> {
  late final _about = TextEditingController(text: widget.existing?.about);
  late final _experience = TextEditingController(
    text: widget.existing?.experience,
  );
  late final _availability = TextEditingController(
    text: widget.existing?.availability,
  );
  late final Set<PetSpecies> _species = {...?widget.existing?.species};
  late final Set<SittingService> _services = {...?widget.existing?.services};
  late int _area = widget.existing?.areaKm ?? 10;
  late bool _active = widget.existing?.active ?? true;
  bool _busy = false;

  @override
  void dispose() {
    _about.dispose();
    _experience.dispose();
    _availability.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final profile = ref.read(userProfileProvider).value;
    final uid = ref.read(authStateProvider).value?.uid;
    if (profile == null || uid == null) return;
    if (_about.text.trim().length < 10) {
      SnackbarUtils.showError(context, l10n.sitAboutTooShort);
      return;
    }
    if (_species.isEmpty || _services.isEmpty) {
      SnackbarUtils.showError(context, l10n.sitChooseSpeciesServices);
      return;
    }
    setState(() => _busy = true);
    await runSitting(context, () async {
      await ref
          .read(sittingRepositoryProvider)
          .saveSitter(
            SitterProfile(
              uid: uid,
              name: profile.name,
              photoUrl: profile.photoUrl,
              about: _about.text,
              experience: _experience.text,
              species: [
                for (final s in PetSpecies.values)
                  if (_species.contains(s)) s,
              ],
              services: [
                for (final s in SittingService.values)
                  if (_services.contains(s)) s,
              ],
              availability: _availability.text,
              city: profile.city!,
              lat: roundPlace(profile.homeLat!),
              lng: roundPlace(profile.homeLng!),
              areaKm: _area,
              active: _active,
            ),
            isNew: widget.existing == null,
          );
      if (mounted) Navigator.of(context).pop();
    }, success: l10n.settingsSaved);
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile = ref.watch(userProfileProvider).value;
    final hasPlace =
        profile?.city != null &&
        profile?.homeLat != null &&
        profile?.homeLng != null;
    InputDecoration field(String label, [String? hint]) => InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.existing == null
              ? l10n.sitBecomeSitter
              : l10n.sitMySitterProfile,
        ),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: AbsorbPointer(
        absorbing: _busy,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            16,
            8,
            16,
            MediaQuery.paddingOf(context).bottom + 80,
          ),
          children: [
            if (!hasPlace) ...[
              SittingCard(
                tint: AppColors.danger,
                child: Text(l10n.sitNeedCity),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: _about,
              maxLength: 800,
              maxLines: 5,
              minLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: field(l10n.sitAbout, l10n.sitAboutHint),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _experience,
              maxLength: 500,
              maxLines: 4,
              minLines: 2,
              textCapitalization: TextCapitalization.sentences,
              decoration: field(l10n.sitExperience, l10n.sitExperienceHint),
            ),
            const SizedBox(height: 8),
            SittingTitle(l10n.sitAnimals),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in PetSpecies.values)
                  FilterChip(
                    avatar: FaIcon(speciesIcon(s), size: 14),
                    label: Text(s.label(l10n)),
                    selected: _species.contains(s),
                    onSelected: (on) => setState(
                      () => on ? _species.add(s) : _species.remove(s),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SittingTitle(l10n.sitServices),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in SittingService.values)
                  FilterChip(
                    avatar: Icon(s.icon, size: 16),
                    label: Text(s.label(l10n)),
                    selected: _services.contains(s),
                    onSelected: (on) => setState(
                      () => on ? _services.add(s) : _services.remove(s),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _availability,
              maxLength: 300,
              maxLines: 3,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: field(l10n.sitAvailability, l10n.sitAvailabilityHint),
            ),
            const SizedBox(height: 8),
            SittingTitle(l10n.sitArea),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final km in sittingAreasKm)
                  ChoiceChip(
                    label: Text('$km km'),
                    selected: _area == km,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => _area = km),
                  ),
              ],
            ),
            if (hasPlace)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  l10n.sitShownArea(profile!.city!),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _active,
              onChanged: (v) => setState(() => _active = v),
              title: Text(l10n.sitShowMyProfile),
              subtitle: Text(
                _active ? l10n.sitProfileVisible : l10n.sitProfilePaused,
              ),
            ),
            const SizedBox(height: 8),
            const SafetyNote(),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: sittingColor,
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: hasPlace ? _save : null,
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}

class SitterProfileScreen extends ConsumerWidget {
  final String uid;

  const SitterProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final me = ref.watch(authStateProvider).value?.uid;
    final state = ref.watch(sitterProfileProvider(uid));
    final s = state.value;
    final reviews =
        ref.watch(sitterReviewsProvider(uid)).value ?? const <SittingReview>[];
    final repo = ref.read(sittingRepositoryProvider);
    final isMe = me == uid;

    Widget info(String title, String text) => text.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: const TextStyle(height: 1.4, color: AppColors.text),
                ),
              ],
            ),
          );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.sitSitterProfile),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (s != null && me != null && !isMe)
            PopupMenuButton<String>(
              onSelected: (v) async {
                if (v == 'report') {
                  await flagWith(
                    context,
                    (reason, note) => repo.flag(
                      reporterId: me,
                      kind: SittingFlagKind.sitter,
                      targetId: s.uid,
                      targetOwnerId: s.uid,
                      reason: reason,
                      note: note,
                    ),
                  );
                } else if (v == 'block' && context.mounted) {
                  final blocked = await blockUser(
                    context,
                    ref,
                    userId: s.uid,
                    name: s.name,
                  );
                  if (blocked && context.mounted) Navigator.of(context).pop();
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(value: 'report', child: Text(l10n.sitReport)),
                PopupMenuItem(
                  value: 'block',
                  child: Text(l10n.blockUser(s.name)),
                ),
              ],
            ),
        ],
      ),
      body: s == null
          ? Center(
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : Text(l10n.sitNotFound),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 86,
                        decoration: const BoxDecoration(
                          gradient: sittingGradient,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.pets_rounded,
                              size: 54,
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 46, bottom: 14),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.surface,
                                shape: BoxShape.circle,
                              ),
                              child: SittingAvatar(
                                name: s.name,
                                photoUrl: s.photoUrl,
                                radius: 38,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    s.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                                if (s.completedCount > 0) ...[
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.verified_rounded,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.sitCityArea(s.city, s.areaKm),
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (s.rating != null)
                              StarRow(value: s.rating!, size: 22),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                StatGrid(
                  perRow: 3,
                  tiles: [
                    StatTile(
                      icon: Icons.star_rounded,
                      value: s.rating == null
                          ? '–'
                          : NumberFormat(
                              '0.0',
                              l10n.localeName,
                            ).format(s.rating),
                      label: l10n.sitStatRating,
                      color: const Color(0xFFB7791F),
                    ),
                    StatTile(
                      icon: Icons.reviews_outlined,
                      value: '${s.reviewCount}',
                      label: l10n.sitAdminReviews,
                    ),
                    StatTile(
                      icon: Icons.task_alt_rounded,
                      value: '${s.completedCount}',
                      label: l10n.sitStatusDone,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SittingCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SittingTitle(l10n.sitServices),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final sv in s.services)
                            InfoPill(
                              icon: sv.icon,
                              text: sv.label(l10n),
                              color: sittingColor,
                            ),
                          for (final sp in s.species)
                            InfoPill(
                              icon: Icons.pets_rounded,
                              text: sp.label(l10n),
                              color: AppColors.primaryDark,
                            ),
                        ],
                      ),
                      info(l10n.sitAbout, s.about),
                      info(l10n.sitExperience, s.experience),
                      info(l10n.sitAvailability, s.availability),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                if (isMe)
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SitterFormScreen(existing: s),
                      ),
                    ),
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(l10n.sitEdit),
                  )
                else
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: sittingColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () => openChatWith(context, ref, s.uid, s.name),
                    icon: const Icon(Icons.chat_bubble_outline_rounded),
                    label: Text(l10n.sitChatWith(s.name)),
                  ),
                const SizedBox(height: 20),
                SittingTitle(l10n.sitReviewsTitle(reviews.length)),
                if (reviews.isEmpty)
                  Text(
                    l10n.sitNoReviewsYet,
                    style: const TextStyle(color: AppColors.textMuted),
                  ),
                for (final r in reviews)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SittingCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              StarRow(value: r.stars.toDouble()),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  [
                                    r.reviewerName,
                                    if (r.createdAt != null)
                                      DateFormat.yMMMd(
                                        l10n.localeName,
                                      ).format(r.createdAt!),
                                  ].join(' · '),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                              if (me != null && !isMe)
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: l10n.sitReport,
                                  icon: const Icon(
                                    Icons.flag_outlined,
                                    size: 18,
                                  ),
                                  onPressed: () => flagWith(
                                    context,
                                    (reason, note) => repo.flag(
                                      reporterId: me,
                                      kind: SittingFlagKind.review,
                                      targetId: r.id,
                                      targetOwnerId: s.uid,
                                      reason: reason,
                                      note: note,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          SittingChip(
                            l10n.sitVerifiedService,
                            color: AppColors.primary,
                            icon: Icons.verified_rounded,
                          ),
                          if (r.text.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              r.text,
                              style: const TextStyle(color: AppColors.text),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
