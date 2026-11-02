import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../domain/walks.dart';
import '../providers/walks_provider.dart';

const walkColor = Color(0xFF2F855A);

extension WalkGroupLabel on WalkGroup {
  String label(AppLocalizations l10n) => switch (this) {
    WalkGroup.dogParks => l10n.walkDogParks,
    WalkGroup.parks => l10n.walkParks,
    WalkGroup.green => l10n.walkGreen,
    WalkGroup.trails => l10n.walkTrails,
  };

  IconData get icon => switch (this) {
    WalkGroup.dogParks => Icons.pets_rounded,
    WalkGroup.parks => Icons.park_rounded,
    WalkGroup.green => Icons.local_florist_rounded,
    WalkGroup.trails => Icons.hiking_rounded,
  };

  Color get color => switch (this) {
    WalkGroup.dogParks => const Color(0xFFD97706),
    WalkGroup.parks => walkColor,
    WalkGroup.green => const Color(0xFF65A30D),
    WalkGroup.trails => const Color(0xFF8B5E34),
  };

  double get markerHue => switch (this) {
    WalkGroup.dogParks => BitmapDescriptor.hueOrange,
    WalkGroup.parks => BitmapDescriptor.hueGreen,
    WalkGroup.green => BitmapDescriptor.hueYellow,
    WalkGroup.trails => BitmapDescriptor.hueRose,
  };
}

Future<void> _open(BuildContext context, Uri uri) async {
  final failure = context.l10n.walkOpenFailed;
  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) SnackbarUtils.showError(context, failure);
  } catch (_) {
    if (context.mounted) SnackbarUtils.showError(context, failure);
  }
}

class WalkPlaceTile extends StatelessWidget {
  final WalkPlace place;
  final double meters;
  final VoidCallback onTap;

  const WalkPlaceTile({
    super.key,
    required this.place,
    required this.meters,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = place.group.color;
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
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(place.group.icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      place.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${place.group.label(l10n)} · ${formatDistance(meters)}',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showWalkPlace(
  BuildContext context,
  WalkPlace place, {
  required double meters,
}) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: AppColors.surface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
  ),
  builder: (_) => _PlaceSheet(place: place, meters: meters),
);

class _PlaceSheet extends ConsumerWidget {
  final WalkPlace place;
  final double meters;

  const _PlaceSheet({required this.place, required this.meters});

  Future<void> _hide(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final config = ref.read(walksConfigProvider).value;
    final adminId = ref.read(authStateProvider).value?.uid;
    if (config == null || adminId == null) return;
    try {
      await ref
          .read(walksRepositoryProvider)
          .saveConfig(config.hide(place.id, place.name), adminId: adminId);
      if (context.mounted) {
        Navigator.of(context).pop();
        SnackbarUtils.showSuccess(context, l10n.walkHidden);
      }
    } catch (_) {
      if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(walkDetailsProvider(place.id));
    final d = state.value;
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final color = place.group.color;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.62,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (context, scroll) => ListView(
        controller: scroll,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (d?.photoUrl case final url?) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CachedNetworkImage(
                imageUrl: url,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
            if (d!.photoAuthor.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  l10n.walkPhotoBy(d.photoAuthor),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Icon(place.group.icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                '${place.group.label(l10n)} · ${formatDistance(meters)}',
                style: TextStyle(fontWeight: FontWeight.w700, color: color),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            place.name,
            style: const TextStyle(
              fontSize: 21,
              height: 1.2,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          if (place.address.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              place.address,
              style: const TextStyle(color: AppColors.textMuted),
            ),
          ],
          const SizedBox(height: 14),
          switch (state) {
            AsyncValue(hasValue: false, hasError: true) => Text(
              l10n.walkDetailsFailed,
              style: const TextStyle(color: AppColors.textMuted),
            ),
            AsyncValue(hasValue: false) => const Padding(
              padding: EdgeInsets.all(12),
              child: Center(child: CircularProgressIndicator()),
            ),
            _ => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (d!.rating case final rating?)
                  _Fact(
                    icon: Icons.star_rounded,
                    color: AppColors.accent,
                    text: d.ratingCount == null
                        ? rating.toStringAsFixed(1)
                        : '${rating.toStringAsFixed(1)} (${d.ratingCount})',
                  ),
                if (d.openNow case final open?)
                  _Fact(
                    icon: Icons.schedule_rounded,
                    color: open ? AppColors.primary : AppColors.danger,
                    text: open ? l10n.walkOpenNow : l10n.walkClosedNow,
                  ),
                if (d.allowsDogs case final dogs?)
                  _Fact(
                    icon: Icons.pets_rounded,
                    color: dogs ? AppColors.primary : AppColors.danger,
                    text: dogs ? l10n.walkDogsAllowed : l10n.walkDogsNotAllowed,
                  ),
              ],
            ),
          },
          if (d != null && d.hours.isNotEmpty)
            Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  l10n.walkOpeningHours,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                children: [
                  for (final line in d.hours)
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          line,
                          style: const TextStyle(color: AppColors.text),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _open(context, directionsUri(place)),
            style: FilledButton.styleFrom(
              backgroundColor: walkColor,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.directions_walk_rounded),
            label: Text(l10n.walkDirections),
          ),
          if (d != null && (d.phone.isNotEmpty || d.website.isNotEmpty)) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                if (d.phone.isNotEmpty)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _open(
                        context,
                        Uri(scheme: 'tel', path: d.phone.replaceAll(' ', '')),
                      ),
                      icon: const Icon(Icons.call_rounded),
                      label: Text(l10n.walkCall),
                    ),
                  ),
                if (d.phone.isNotEmpty && d.website.isNotEmpty)
                  const SizedBox(width: 10),
                if (Uri.tryParse(d.website) case final site?
                    when d.website.isNotEmpty)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _open(context, site),
                      icon: const Icon(Icons.language_rounded),
                      label: Text(l10n.walkWebsite),
                    ),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          const GoogleAttribution(),
          if (isAdmin) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _hide(context, ref),
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
              icon: const Icon(Icons.visibility_off_rounded),
              label: Text(l10n.walkHide),
            ),
          ],
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _Fact({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// Google requires its name next to Places data shown outside its map.
class GoogleAttribution extends StatelessWidget {
  const GoogleAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.walkDataFromGoogle,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted),
    );
  }
}
