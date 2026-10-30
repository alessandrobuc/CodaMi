import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/form_fields.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/checkout.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';

class _ZoneEdit {
  final String id;
  final TextEditingController name;
  bool active;

  _ZoneEdit(ShippingZone z)
    : id = z.id,
      name = TextEditingController(text: z.name),
      active = z.active;

  ShippingZone get value =>
      ShippingZone(id: id, name: name.text.trim(), active: active);
}

class _MethodEdit {
  final String id;
  final TextEditingController name;
  final TextEditingController time;
  final TextEditingController freeAbove;
  final Map<String, TextEditingController> prices;
  bool active;

  _MethodEdit(ShippingMethod m)
    : id = m.id,
      name = TextEditingController(text: m.name),
      time = TextEditingController(text: m.deliveryTime),
      freeAbove = TextEditingController(text: priceInput(m.freeAboveCents)),
      prices = {
        for (final e in m.prices.entries)
          e.key: TextEditingController(text: priceInput(e.value)),
      },
      active = m.active;

  TextEditingController price(String zoneId) =>
      prices.putIfAbsent(zoneId, TextEditingController.new);

  List<TextEditingController> get all => [
    name,
    time,
    freeAbove,
    ...prices.values,
  ];
}

// Shipping zones and methods, saved together in config/shipping.
class AdminShippingScreen extends ConsumerStatefulWidget {
  const AdminShippingScreen({super.key});

  @override
  ConsumerState<AdminShippingScreen> createState() =>
      _AdminShippingScreenState();
}

class _AdminShippingScreenState extends ConsumerState<AdminShippingScreen> {
  List<_ZoneEdit>? _zones;
  List<_MethodEdit>? _methods;
  bool _showErrors = false;
  bool _saving = false;

  @override
  void dispose() {
    for (final z in _zones ?? const <_ZoneEdit>[]) {
      z.name.dispose();
    }
    for (final m in _methods ?? const <_MethodEdit>[]) {
      for (final c in m.all) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _load(ShippingConfig config) {
    _zones = [for (final z in config.zones) _ZoneEdit(z)];
    _methods = [for (final m in config.methods) _MethodEdit(m)];
  }

  String _newId(String prefix) =>
      '${prefix}_${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';

  void _addStarting() {
    final l10n = context.l10n;
    setState(
      () => _load(
        startingShipping(
          italy: l10n.shopZoneItaly,
          islands: l10n.shopZoneIslands,
          europe: l10n.shopZoneEurope,
          standard: l10n.shopMethodStandard,
          express: l10n.shopMethodExpress,
          standardTime: l10n.shopMethodStandardTime,
          expressTime: l10n.shopMethodExpressTime,
        ),
      ),
    );
  }

  bool _badPrice(TextEditingController c) =>
      c.text.trim().isNotEmpty && parsePriceCents(c.text) == null;

  bool get _valid {
    final zones = _zones!, methods = _methods!;
    return zones.every((z) => z.name.text.trim().isNotEmpty) &&
        methods.every(
          (m) =>
              m.name.text.trim().isNotEmpty &&
              !_badPrice(m.freeAbove) &&
              zones.every((z) => !_badPrice(m.price(z.id))),
        );
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    if (!_valid) {
      setState(() => _showErrors = true);
      SnackbarUtils.showError(context, l10n.shopFixFields);
      return;
    }
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    final zoneIds = {for (final z in _zones!) z.id};
    final config = ShippingConfig(
      zones: [for (final z in _zones!) z.value],
      methods: [
        for (final m in _methods!)
          ShippingMethod(
            id: m.id,
            name: m.name.text.trim(),
            deliveryTime: m.time.text.trim(),
            prices: {
              for (final e in m.prices.entries)
                if (zoneIds.contains(e.key) &&
                    parsePriceCents(e.value.text) != null)
                  e.key: parsePriceCents(e.value.text)!,
            },
            freeAboveCents: parsePriceCents(m.freeAbove.text),
            active: m.active,
          ),
      ],
    );
    setState(() => _saving = true);
    try {
      await ref
          .read(shopRepositoryProvider)
          .saveShipping(config, adminId: adminId);
      if (!mounted) return;
      SnackbarUtils.showSuccess(context, l10n.settingsSaved);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Shipping not saved: $e');
      if (!mounted) return;
      setState(() => _saving = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(shippingConfigProvider);
    if (_zones == null && state.hasValue) _load(state.value!);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.shopShipping),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: _zones == null
          ? Center(
              child: state.hasError
                  ? OutlinedButton.icon(
                      onPressed: () => ref.invalidate(shippingConfigProvider),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(l10n.videoRetry),
                    )
                  : const CircularProgressIndicator(),
            )
          : AbsorbPointer(
              absorbing: _saving,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: settingsListPadding(context),
                children: [
                  SettingsHeader(
                    icon: Icons.local_shipping_rounded,
                    color: shopColor,
                    title: l10n.shopShipping,
                    text: l10n.shopShippingIntro,
                  ),
                  if (_zones!.isEmpty && _methods!.isEmpty) ...[
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _addStarting,
                      style: FilledButton.styleFrom(backgroundColor: shopColor),
                      icon: const Icon(Icons.auto_awesome_rounded),
                      label: Text(l10n.shopShippingStarting),
                    ),
                  ],
                  _zonesSection(l10n),
                  for (final m in _methods!) _methodSection(l10n, m),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => setState(
                      () => _methods!.add(
                        _MethodEdit(ShippingMethod(id: _newId('m'), name: '')),
                      ),
                    ),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(l10n.shopAddMethod),
                  ),
                  const SizedBox(height: 24),
                  SettingsSaveButton(
                    label: l10n.save,
                    saving: _saving,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _zonesSection(AppLocalizations l10n) {
    return SettingsSection(
      title: l10n.shopZones,
      icon: Icons.public_rounded,
      color: shopColor,
      children: [
        ShopHelpText(l10n.shopZonesHelp),
        for (final z in _zones!)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: z.name,
                    onChanged: (_) {
                      if (_showErrors) setState(() {});
                    },
                    decoration: fieldDecoration(
                      hint: l10n.shopZoneName,
                      error: _showErrors && z.name.text.trim().isEmpty
                          ? l10n.requiredField
                          : null,
                      focusColor: shopColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Switch(
                  value: z.active,
                  onChanged: (v) => setState(() => z.active = v),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: IconButton(
                  tooltip: l10n.delete,
                  color: AppColors.danger,
                  onPressed: () => setState(() => _zones!.remove(z)),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextButton.icon(
            onPressed: _zones!.length >= ShippingLimits.zones
                ? null
                : () => setState(
                    () => _zones!.add(
                      _ZoneEdit(ShippingZone(id: _newId('z'), name: '')),
                    ),
                  ),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.shopAddZone),
          ),
        ),
      ],
    );
  }

  Widget _methodSection(AppLocalizations l10n, _MethodEdit m) {
    void changed(_) {
      if (_showErrors) setState(() {});
    }

    return SettingsSection(
      title: m.name.text.trim().isEmpty ? l10n.shopMethod : m.name.text.trim(),
      icon: Icons.local_shipping_rounded,
      color: m.active ? shopColor : AppColors.textMuted,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: m.active,
              onChanged: (v) => setState(() => m.active = v),
              title: Text(
                l10n.shopMethodActive,
                style: const TextStyle(fontSize: 14, color: AppColors.text),
              ),
            ),
            LabeledField(
              label: l10n.shopName,
              hasError: _showErrors && m.name.text.trim().isEmpty,
              child: TextField(
                controller: m.name,
                maxLength: ShippingLimits.name,
                onChanged: (_) => setState(() {}),
                decoration: fieldDecoration(
                  hint: l10n.shopMethodStandard,
                  error: _showErrors && m.name.text.trim().isEmpty
                      ? l10n.requiredField
                      : null,
                  focusColor: shopColor,
                ),
              ),
            ),
            LabeledField(
              label: l10n.shopDeliveryTime,
              child: TextField(
                controller: m.time,
                maxLength: ShippingLimits.deliveryTime,
                decoration: fieldDecoration(
                  hint: l10n.shopMethodStandardTime,
                  focusColor: shopColor,
                ),
              ),
            ),
            Text(
              l10n.shopPricePerZone,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            ShopHelpText(l10n.shopPricePerZoneHelp),
            for (final z in _zones!)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        z.name.text.trim().isEmpty ? '…' : z.name.text.trim(),
                        style: const TextStyle(color: AppColors.text),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: m.price(z.id),
                        onChanged: changed,
                        textAlign: TextAlign.end,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: fieldDecoration(
                          hint: '–',
                          error: _showErrors && _badPrice(m.price(z.id))
                              ? ''
                              : null,
                          focusColor: shopColor,
                        ).copyWith(prefixText: '€ '),
                      ),
                    ),
                  ],
                ),
              ),
            LabeledField(
              label: l10n.shopFreeAboveLabel,
              hasError: _showErrors && _badPrice(m.freeAbove),
              child: TextField(
                controller: m.freeAbove,
                onChanged: changed,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: fieldDecoration(
                  hint: '49',
                  help: l10n.shopFreeAboveHelp,
                  error: _showErrors && _badPrice(m.freeAbove)
                      ? l10n.shopPriceInvalid
                      : null,
                  focusColor: shopColor,
                ).copyWith(prefixText: '€ '),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                onPressed: () => setState(() => _methods!.remove(m)),
                style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                icon: const Icon(Icons.delete_outline_rounded),
                label: Text(l10n.delete),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
