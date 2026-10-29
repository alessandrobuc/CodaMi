import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/form_fields.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../domain/shop.dart';
import '../../domain/shop_repository.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';

class AdminProductFormScreen extends ConsumerStatefulWidget {
  final Product? product;

  const AdminProductFormScreen({super.key, this.product});

  @override
  ConsumerState<AdminProductFormScreen> createState() =>
      _AdminProductFormScreenState();
}

class _AdminProductFormScreenState
    extends ConsumerState<AdminProductFormScreen> {
  late final ProductDraft? _old = widget.product?.draft;
  late final _name = TextEditingController(text: _old?.name);
  late final _description = TextEditingController(text: _old?.description);
  late final _price = TextEditingController(text: priceInput(_old?.priceCents));
  late final _compareAt = TextEditingController(
    text: priceInput(_old?.compareAtCents),
  );
  late final _affiliateUrl = TextEditingController(text: _old?.affiliateUrl);
  late final _partner = TextEditingController(text: _old?.partnerName);
  late String _categoryId = _old?.categoryId ?? '';
  late String _brandId = _old?.brandId ?? '';
  late String _supplierId = _old?.supplierId ?? '';
  late SalesModel _model = _old?.salesModel ?? SalesModel.ownStock;
  late final Set<PetSpecies> _animals = {...?_old?.animals};
  late Availability _availability = _old?.availability ?? Availability.inStock;
  late bool _active = _old?.active ?? false;
  late final List<ImageSlot> _images = [
    for (final i in widget.product?.images ?? const <ShopImage>[])
      SavedImage(i),
  ];
  bool _showErrors = false;
  bool _saving = false;

  List<TextEditingController> get _controllers => [
    _name,
    _description,
    _price,
    _compareAt,
    _affiliateUrl,
    _partner,
  ];

  void _onText() {
    if (_showErrors) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (final c in _controllers) {
      c.addListener(_onText);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  // A typed but unreadable price counts as wrong, not as empty.
  int? _cents(TextEditingController c) =>
      c.text.trim().isEmpty ? null : parsePriceCents(c.text) ?? -1;

  ProductDraft get _draft => ProductDraft(
    name: _name.text,
    description: _description.text,
    categoryId: _categoryId,
    brandId: _brandId,
    supplierId: _supplierId,
    salesModel: _model,
    animals: _animals,
    priceCents: _cents(_price),
    compareAtCents: _cents(_compareAt),
    availability: _availability,
    affiliateUrl: _affiliateUrl.text,
    partnerName: _partner.text,
    active: _active,
  );

  Set<ProductProblem> get _problems =>
      _showErrors ? productProblems(_draft) : const {};

  Future<void> _pickImages() async {
    final l10n = context.l10n;
    final room = ShopLimits.images - _images.length;
    if (room <= 0) return;
    final picked = await ImagePicker().pickMultiImage(
      maxWidth: 1600,
      imageQuality: 82,
      limit: room > 1 ? room : null,
    );
    if (picked.isEmpty || !mounted) return;
    var tooBig = false;
    final files = <File>[];
    for (final x in picked.take(room)) {
      final file = File(x.path);
      if (await file.length() >= ShopLimits.imageBytes) {
        tooBig = true;
      } else {
        files.add(file);
      }
    }
    if (!mounted) return;
    if (tooBig) SnackbarUtils.showError(context, l10n.shopImageTooBig);
    setState(() => _images.addAll(files.map(PickedImage.new)));
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    if (productProblems(_draft).isNotEmpty) {
      setState(() => _showErrors = true);
      SnackbarUtils.showError(context, l10n.shopFixFields);
      return;
    }
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(shopRepositoryProvider)
          .saveProduct(
            existing: widget.product,
            draft: _draft,
            images: _images,
            adminId: adminId,
          );
      if (!mounted) return;
      SnackbarUtils.showSuccess(context, l10n.settingsSaved);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Product not saved: $e');
      if (!mounted) return;
      setState(() => _saving = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await confirmShopDelete(
      context,
      title: l10n.shopDeleteProductTitle,
      body: l10n.shopDeleteProductBody,
    );
    if (!confirmed || !mounted) return;
    setState(() => _saving = true);
    try {
      await ref.read(shopRepositoryProvider).deleteProduct(widget.product!);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final problems = _problems;
    final categories = ref.watch(allShopCategoriesProvider).value ?? const [];
    final brands = ref.watch(allBrandsProvider).value ?? const <Brand>[];
    final suppliers = ref.watch(suppliersProvider).value ?? const <Supplier>[];
    final byId = {for (final c in categories) c.id: c};
    final affiliate = _model == SalesModel.affiliate;
    final price = parsePriceCents(_price.text);
    final compare = parsePriceCents(_compareAt.text);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.product == null ? l10n.shopAddProduct : l10n.shopEditProduct,
        ),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (widget.product != null)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.danger,
              onPressed: _saving ? null : _delete,
            ),
        ],
      ),
      body: AbsorbPointer(
        absorbing: _saving,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: settingsListPadding(context),
          children: [
            SettingsSection(
              title: l10n.shopPhotos,
              icon: Icons.photo_library_rounded,
              color: shopColor,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShopHelpText(l10n.shopPhotosHelp),
                    SizedBox(
                      height: 96,
                      child: ReorderableListView(
                        scrollDirection: Axis.horizontal,
                        buildDefaultDragHandles: false,
                        onReorderItem: (from, to) => setState(
                          () => _images.insert(to, _images.removeAt(from)),
                        ),
                        footer: _images.length < ShopLimits.images
                            ? _AddPhoto(onTap: _pickImages)
                            : null,
                        children: [
                          for (final (i, slot) in _images.indexed)
                            ReorderableDelayedDragStartListener(
                              key: ObjectKey(slot),
                              index: i,
                              child: _Thumb(
                                slot: slot,
                                cover: i == 0,
                                onRemove: () =>
                                    setState(() => _images.removeAt(i)),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ],
            ),
            SettingsSection(
              title: l10n.shopDetails,
              icon: Icons.edit_note_rounded,
              color: shopColor,
              children: [
                ShopTextField(
                  controller: _name,
                  label: l10n.shopName,
                  maxLength: ShopLimits.name,
                  error: problems.contains(ProductProblem.name)
                      ? l10n.requiredField
                      : null,
                ),
                ShopTextField(
                  controller: _description,
                  label: l10n.shopDescription,
                  lines: 5,
                  maxLength: ShopLimits.description,
                ),
                LabeledField(
                  label: l10n.shopCategory,
                  hasError: problems.contains(ProductProblem.category),
                  child: DropdownButtonFormField<String>(
                    initialValue: byId.containsKey(_categoryId)
                        ? _categoryId
                        : null,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(14),
                    hint: Text(l10n.shopPickCategory),
                    decoration: fieldDecoration(
                      error: problems.contains(ProductProblem.category)
                          ? l10n.shopPickCategory
                          : null,
                      focusColor: shopColor,
                    ),
                    items: [
                      for (final top in categories.where((c) => c.isTop)) ...[
                        DropdownMenuItem(value: top.id, child: Text(top.name)),
                        for (final sub in subCategories(categories, top.id))
                          DropdownMenuItem(
                            value: sub.id,
                            child: Text('${top.name} › ${sub.name}'),
                          ),
                      ],
                    ],
                    onChanged: (id) => setState(() => _categoryId = id ?? ''),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      l10n.shopAnimals,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final a in PetSpecies.values)
                          FilterChip(
                            label: Text(a.label(l10n)),
                            selected: _animals.contains(a),
                            selectedColor: shopColor.withValues(alpha: 0.15),
                            checkmarkColor: shopColor,
                            shape: const StadiumBorder(),
                            onSelected: (on) => setState(
                              () => on ? _animals.add(a) : _animals.remove(a),
                            ),
                          ),
                      ],
                    ),
                    ShopHelpText(l10n.shopAnimalsHelp),
                  ],
                ),
              ],
            ),
            SettingsSection(
              title: l10n.shopSalesModel,
              icon: Icons.handshake_rounded,
              color: shopColor,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final m in SalesModel.values)
                            ShopChoice(
                              label: m.label(l10n),
                              icon: m.icon,
                              selected: _model == m,
                              onTap: () => setState(() => _model = m),
                            ),
                        ],
                      ),
                    ),
                    ShopHelpText(_model.help(l10n)),
                  ],
                ),
                if (affiliate) ...[
                  ShopTextField(
                    controller: _partner,
                    label: l10n.shopPartnerName,
                    hint: 'Amazon, Zooplus…',
                    maxLength: ShopLimits.shortText,
                    error: problems.contains(ProductProblem.partner)
                        ? l10n.requiredField
                        : null,
                  ),
                  ShopTextField(
                    controller: _affiliateUrl,
                    label: l10n.shopAffiliateUrl,
                    hint: 'https://',
                    keyboard: TextInputType.url,
                    maxLength: ShopLimits.url,
                    error: problems.contains(ProductProblem.affiliateUrl)
                        ? l10n.shopLinkInvalid
                        : null,
                  ),
                ],
                _Picker(
                  label: l10n.shopBrand,
                  none: l10n.shopNoBrand,
                  value: _brandId,
                  items: {for (final b in brands) b.id: b.name},
                  onChanged: (id) => setState(() => _brandId = id),
                ),
                if (!affiliate)
                  _Picker(
                    label: l10n.shopSupplier,
                    none: l10n.shopNoSupplier,
                    value: _supplierId,
                    items: {for (final s in suppliers) s.id: s.name},
                    onChanged: (id) => setState(() => _supplierId = id),
                  ),
              ],
            ),
            SettingsSection(
              title: l10n.shopPriceSection,
              icon: Icons.euro_rounded,
              color: shopColor,
              children: [
                ShopTextField(
                  controller: _price,
                  label: l10n.shopPrice,
                  hint: '12.90',
                  help: affiliate ? l10n.shopPriceAffiliateHelp : null,
                  keyboard: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  error: problems.contains(ProductProblem.price)
                      ? l10n.shopPriceInvalid
                      : null,
                ),
                ShopTextField(
                  controller: _compareAt,
                  label: l10n.shopCompareAt,
                  help: price != null && compare != null && compare > price
                      ? '-${((1 - price / compare) * 100).round()}%'
                      : l10n.shopCompareAtHelp,
                  keyboard: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  error: problems.contains(ProductProblem.compareAt)
                      ? l10n.shopCompareAtInvalid
                      : null,
                ),
              ],
            ),
            if (!affiliate)
              SettingsSection(
                title: l10n.shopAvailability,
                icon: Icons.inventory_2_rounded,
                color: shopColor,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final a in Availability.values)
                          ShopChoice(
                            label: a.label(l10n),
                            color: a.color,
                            selected: _availability == a,
                            onTap: () => setState(() => _availability = a),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            SettingsSection(
              title: l10n.shopVisible,
              icon: Icons.visibility_rounded,
              color: _active ? AppColors.primary : AppColors.textMuted,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _active,
                  onChanged: (v) => setState(() => _active = v),
                  title: Text(
                    l10n.shopVisibleHelp,
                    style: const TextStyle(fontSize: 14, color: AppColors.text),
                  ),
                ),
              ],
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
}

class _Picker extends StatelessWidget {
  final String label;
  final String none;
  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;

  const _Picker({
    required this.label,
    required this.none,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: label,
      child: DropdownButtonFormField<String>(
        initialValue: items.containsKey(value) ? value : '',
        isExpanded: true,
        borderRadius: BorderRadius.circular(14),
        decoration: fieldDecoration(focusColor: shopColor),
        items: [
          DropdownMenuItem(value: '', child: Text(none)),
          for (final e in items.entries)
            DropdownMenuItem(value: e.key, child: Text(e.value)),
        ],
        onChanged: (id) => onChanged(id ?? ''),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final ImageSlot slot;
  final bool cover;
  final VoidCallback onRemove;

  const _Thumb({
    required this.slot,
    required this.cover,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          fit: StackFit.expand,
          children: [
            switch (slot) {
              SavedImage(:final image) => ShopNetworkImage(
                url: image.url,
                borderRadius: radius,
              ),
              PickedImage(:final file) => ClipRRect(
                borderRadius: radius,
                child: Image.file(file, fit: BoxFit.cover),
              ),
            },
            if (cover)
              const PositionedDirectional(
                start: 6,
                bottom: 6,
                child: Icon(Icons.star_rounded, color: Colors.white, size: 20),
              ),
            PositionedDirectional(
              top: 2,
              end: 2,
              child: IconButton.filled(
                onPressed: onRemove,
                iconSize: 16,
                visualDensity: VisualDensity.compact,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddPhoto extends StatelessWidget {
  final VoidCallback onTap;

  const _AddPhoto({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          color: shopColor.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: shopColor.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_a_photo_rounded, color: shopColor),
            const SizedBox(height: 4),
            Text(
              context.l10n.shopAddPhoto,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: shopColor),
            ),
          ],
        ),
      ),
    );
  }
}
