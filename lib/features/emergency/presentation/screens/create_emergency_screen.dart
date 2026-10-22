import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../location/presentation/providers/location_provider.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/widgets/pet_form_widgets.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../reports/presentation/widgets/spot_picker.dart';
import '../../data/emergency_repository.dart';
import '../../domain/emergency.dart';
import '../widgets/emergency_widgets.dart';
import 'emergency_screen.dart';

// Rome, used only when the user has no home city yet.
const _fallbackCenter = LatLng(41.9028, 12.4964);

class CreateEmergencyScreen extends ConsumerStatefulWidget {
  const CreateEmergencyScreen({super.key});

  @override
  ConsumerState<CreateEmergencyScreen> createState() =>
      _CreateEmergencyScreenState();
}

class _CreateEmergencyScreenState extends ConsumerState<CreateEmergencyScreen> {
  EmergencyType? _type;
  PetSpecies? _species;
  List<PetPhoto> _photos = const [];
  final _description = TextEditingController();
  late final _phone = TextEditingController(
    text: ref.read(userProfileProvider).value?.phone ?? '',
  );
  LatLng? _spot;
  String? _placeLabel;
  String? _placeCity;
  int _geocodeId = 0;
  bool _showErrors = false;
  bool _sending = false;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    // The animal is usually right where the user is, so start there.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final here = await currentLocation(context);
      if (here != null && mounted && _spot == null) _onSpotMoved(here);
    });
  }

  @override
  void dispose() {
    _description.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _onSpotMoved(LatLng spot) async {
    setState(() => _spot = spot);
    final id = ++_geocodeId;
    final result = await ref
        .read(placesServiceProvider)
        .reverseGeocode(spot.latitude, spot.longitude);
    if (!mounted || id != _geocodeId) return;
    setState(() {
      _placeLabel = result.label;
      _placeCity = result.city;
    });
  }

  bool get _valid =>
      _type != null &&
      _species != null &&
      _spot != null &&
      _description.text.trim().isNotEmpty;

  Future<void> _send() async {
    final l10n = context.l10n;
    if (!_valid) {
      HapticFeedback.heavyImpact();
      setState(() => _showErrors = true);
      SnackbarUtils.showError(context, l10n.emergencyMissingFields);
      return;
    }
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    final profile = ref.read(userProfileProvider).value;
    final info = ref.read(currentUserInfoProvider);
    setState(() => _sending = true);
    try {
      final id = await ref
          .read(emergencyRepositoryProvider)
          .create(
            ownerId: uid,
            ownerName: info.name,
            draft: EmergencyDraft(
              type: _type!,
              species: _species!,
              description: _description.text,
              photos: _photos,
              lat: _spot!.latitude,
              lng: _spot!.longitude,
              placeLabel: _placeLabel,
              city: _placeCity ?? profile?.city,
              cityKey: _placeCity == null ? profile?.cityKey : null,
              contactPhone: _phone.text,
            ),
            onUploadProgress: (p) {
              if (mounted) setState(() => _progress = p);
            },
          );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => EmergencyScreen(emergencyId: id, justSent: true),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _sending = false);
      SnackbarUtils.showError(context, l10n.emergencySendFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile = ref.watch(userProfileProvider).value;
    final center = profile?.homeLat != null && profile?.homeLng != null
        ? LatLng(profile!.homeLat!, profile.homeLng!)
        : _fallbackCenter;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.reportEmergency),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: AbsorbPointer(
        absorbing: _sending,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            4,
            20,
            MediaQuery.paddingOf(context).bottom + 120,
          ),
          children: [
            const EmergencyDisclaimer(),
            const SizedBox(height: 22),
            SectionLabel(l10n.emergencyWhatHappened),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.6,
              children: [
                for (final type in EmergencyType.values)
                  _TypeChoice(
                    type: type,
                    selected: type == _type,
                    error: _showErrors && _type == null,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _type = type);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 22),
            SectionLabel(l10n.whatKindOfAnimal),
            const SizedBox(height: 10),
            SpeciesSelector(
              selected: _species,
              showError: _showErrors && _species == null,
              onChanged: (s) => setState(() => _species = s),
            ),
            const SizedBox(height: 22),
            SectionLabel(l10n.emergencyDetails),
            const SizedBox(height: 8),
            AppFormField(
              controller: _description,
              hint: l10n.emergencyDetailsHint,
              icon: Icons.notes_rounded,
              maxLines: 4,
              maxLength: 1000,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) {
                if (_showErrors) setState(() {});
              },
            ),
            if (_showErrors && _description.text.trim().isEmpty)
              Text(
                l10n.emergencyDetailsRequired,
                style: const TextStyle(fontSize: 12.5, color: AppColors.danger),
              ),
            const SizedBox(height: 14),
            SectionLabel(l10n.photos, optional: true),
            const SizedBox(height: 10),
            PhotoPickerField(
              photos: _photos,
              showError: false,
              enabled: !_sending,
              emptyTitle: l10n.emergencyAddPhotos,
              emptySubtitle: l10n.emergencyAddPhotosHint,
              onAdd: () async {
                if (_photos.length >= 4) return;
                final path = await pickPhoto(context);
                if (path != null && mounted) {
                  setState(() => _photos = [..._photos, PetPhoto.local(path)]);
                }
              },
              onRemove: (i) =>
                  setState(() => _photos = [..._photos]..removeAt(i)),
              onMakeCover: (i) => setState(() {
                final photo = _photos[i];
                _photos = [photo, ..._photos.where((p) => p != photo)];
              }),
            ),
            const SizedBox(height: 22),
            SectionLabel(l10n.emergencyWhere),
            const SizedBox(height: 4),
            Text(
              l10n.emergencyWhereHint,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(height: 10),
            SpotPicker(
              center: center,
              spot: _spot,
              color: emergencyColor,
              onMoved: _onSpotMoved,
              showPublicArea: false,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  _spot == null
                      ? Icons.touch_app_rounded
                      : Icons.location_on_rounded,
                  size: 16,
                  color: _showErrors && _spot == null
                      ? AppColors.danger
                      : AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _spot == null
                        ? l10n.emergencyPinHint
                        : _placeLabel ?? l10n.emergencyPinned,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: _showErrors && _spot == null
                          ? AppColors.danger
                          : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            SectionLabel(l10n.emergencyYourPhone, optional: true),
            const SizedBox(height: 8),
            AppFormField(
              controller: _phone,
              hint: l10n.phoneHint,
              icon: Icons.phone_rounded,
              keyboardType: TextInputType.phone,
              maxLength: 20,
            ),
            Text(
              l10n.emergencyPhoneHint,
              style: const TextStyle(
                fontSize: 12.5,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: FilledButton.icon(
            onPressed: _sending ? null : _send,
            style: FilledButton.styleFrom(
              backgroundColor: emergencyColor,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            icon: _sending
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                      value: _photos.isEmpty || _progress == 0
                          ? null
                          : _progress,
                    ),
                  )
                : const Icon(Icons.campaign_rounded),
            label: Text(
              _sending ? l10n.emergencySending : l10n.emergencySend,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeChoice extends StatelessWidget {
  final EmergencyType type;
  final bool selected;
  final bool error;
  final VoidCallback onTap;

  const _TypeChoice({
    required this.type,
    required this.selected,
    required this.error,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? emergencyColor : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: selected
              ? emergencyColor
              : error
              ? AppColors.danger
              : AppColors.border,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(
                type.icon,
                size: 20,
                color: selected ? Colors.white : emergencyColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  type.label(context.l10n),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : AppColors.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
