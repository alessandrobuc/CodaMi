import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../location/presentation/providers/location_provider.dart';
import '../../../pets/presentation/widgets/pet_form_widgets.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../reports/presentation/widgets/spot_picker.dart';
import '../../data/emergency_repository.dart';
import '../../domain/emergency.dart';
import '../widgets/emergency_widgets.dart';

class ContactFormScreen extends ConsumerStatefulWidget {
  final EmergencyContact? contact;

  const ContactFormScreen({super.key, this.contact});

  @override
  ConsumerState<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends ConsumerState<ContactFormScreen> {
  late final EmergencyContact? _c = widget.contact;
  late final _name = TextEditingController(text: _c?.name ?? '');
  late final _phones = TextEditingController(text: _c?.phones.join(', ') ?? '');
  late final _email = TextEditingController(text: _c?.email ?? '');
  late final _address = TextEditingController(text: _c?.address ?? '');
  late final _city = TextEditingController(text: _c?.city ?? '');
  late final _hours = TextEditingController(text: _c?.hours ?? '');
  late final _area = TextEditingController(
    text: _c?.areaKm == null ? '' : _c!.areaKm!.toStringAsFixed(0),
  );
  late ContactKind _kind = _c?.kind ?? ContactKind.vet;
  late Set<EmergencyType> _types = {...?_c?.types};
  late bool _open24h = _c?.open24h ?? false;
  late bool _verified = _c?.verified ?? false;
  late bool _recommended = _c?.recommended ?? false;
  late bool _active = _c?.active ?? true;
  late bool _isTest = _c?.isTest ?? false;
  late LatLng? _spot = _c == null ? null : LatLng(_c.lat, _c.lng);
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_name, _phones, _email, _address, _city, _hours, _area]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _onSpotMoved(LatLng spot) async {
    setState(() => _spot = spot);
    final result = await ref
        .read(placesServiceProvider)
        .reverseGeocode(spot.latitude, spot.longitude);
    if (!mounted) return;
    setState(() {
      if (_address.text.trim().isEmpty && result.label != null) {
        _address.text = result.label!;
      }
      if (_city.text.trim().isEmpty && result.city != null) {
        _city.text = result.city!;
      }
    });
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final name = _name.text.trim();
    if (name.isEmpty || _spot == null) {
      SnackbarUtils.showError(context, l10n.contactMissingFields);
      return;
    }
    String? optional(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();
    setState(() => _saving = true);
    try {
      await ref
          .read(emergencyRepositoryProvider)
          .saveContact(
            EmergencyContact(
              id: _c?.id ?? '',
              name: name,
              kind: _kind,
              phones: [
                for (final p in _phones.text.split(','))
                  if (p.trim().isNotEmpty) p.trim(),
              ].take(5).toList(),
              email: optional(_email),
              address: optional(_address),
              city: optional(_city),
              lat: _spot!.latitude,
              lng: _spot!.longitude,
              areaKm: readDouble(_area),
              types: _types,
              open24h: _open24h,
              hours: _open24h ? null : optional(_hours),
              // Placeholders can never be marked verified.
              verified: _verified && !_isTest,
              recommended: _recommended,
              active: _active,
              isTest: _isTest,
            ),
          );
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteContactTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(emergencyRepositoryProvider).deleteContact(_c!.id);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  Widget _switch(
    String title,
    bool value,
    ValueChanged<bool> onChanged, {
    String? subtitle,
  }) => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: subtitle == null ? null : Text(subtitle),
    value: value,
    onChanged: onChanged,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile = ref.watch(userProfileProvider).value;
    final center =
        _spot ??
        (profile?.homeLat != null && profile?.homeLng != null
            ? LatLng(profile!.homeLat!, profile.homeLng!)
            : const LatLng(41.9028, 12.4964));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_c == null ? l10n.addContact : l10n.editContact),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (_c != null)
            IconButton(
              onPressed: _saving ? null : _delete,
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
        children: [
          SectionLabel(l10n.contactName),
          const SizedBox(height: 8),
          AppFormField(
            controller: _name,
            hint: l10n.contactNameHint,
            icon: Icons.badge_rounded,
            maxLength: 120,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 8),
          SectionLabel(l10n.contactType),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final kind in ContactKind.values)
                ChoiceChip(
                  label: Text(kind.label(l10n)),
                  selected: kind == _kind,
                  onSelected: (_) => setState(() => _kind = kind),
                ),
            ],
          ),
          const SizedBox(height: 18),
          SectionLabel(l10n.contactPhones),
          const SizedBox(height: 8),
          AppFormField(
            controller: _phones,
            hint: l10n.contactPhonesHint,
            icon: Icons.call_rounded,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 8),
          SectionLabel(l10n.email, optional: true),
          const SizedBox(height: 8),
          AppFormField(
            controller: _email,
            hint: 'name@example.com',
            icon: Icons.mail_rounded,
            keyboardType: TextInputType.emailAddress,
            maxLength: 120,
          ),
          const SizedBox(height: 8),
          SectionLabel(l10n.contactPlace),
          const SizedBox(height: 8),
          SpotPicker(
            center: center,
            spot: _spot,
            color: emergencyColor,
            onMoved: _onSpotMoved,
            showPublicArea: false,
          ),
          const SizedBox(height: 12),
          AppFormField(
            controller: _address,
            hint: l10n.contactAddress,
            icon: Icons.place_rounded,
            maxLength: 200,
          ),
          const SizedBox(height: 8),
          AppFormField(
            controller: _city,
            hint: l10n.contactCity,
            icon: Icons.location_city_rounded,
            maxLength: 80,
          ),
          const SizedBox(height: 8),
          SettingsNumberField(
            controller: _area,
            label: l10n.contactAreaKm,
            help: l10n.contactAreaKmHelp,
            decimal: true,
          ),
          SectionLabel(l10n.contactHandles),
          const SizedBox(height: 4),
          Text(
            l10n.contactHandlesHelp,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final type in EmergencyType.values)
                FilterChip(
                  label: Text(type.label(l10n)),
                  selected: _types.contains(type),
                  onSelected: (on) => setState(
                    () => _types = on
                        ? {..._types, type}
                        : ({..._types}..remove(type)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          _switch(l10n.open24h, _open24h, (v) => setState(() => _open24h = v)),
          if (!_open24h)
            AppFormField(
              controller: _hours,
              hint: l10n.contactHoursHint,
              icon: Icons.schedule_rounded,
              maxLength: 200,
            ),
          const Divider(height: 28),
          _switch(
            l10n.verifiedContact,
            _verified && !_isTest,
            _isTest ? (_) {} : (v) => setState(() => _verified = v),
            subtitle: l10n.contactVerifiedHelp,
          ),
          _switch(
            l10n.recommendedContact,
            _recommended,
            (v) => setState(() => _recommended = v),
            subtitle: l10n.contactRecommendedHelp,
          ),
          _switch(
            l10n.contactActive,
            _active,
            (v) => setState(() => _active = v),
            subtitle: l10n.contactActiveHelp,
          ),
          _switch(
            l10n.testContactBadge,
            _isTest,
            (v) => setState(() => _isTest = v),
            subtitle: l10n.contactTestHelp,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _saving ? null : _save,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
            ),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
