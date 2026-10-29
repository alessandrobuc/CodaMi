import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';

String? _adminId(WidgetRef ref) => ref.read(authStateProvider).value?.uid;

Future<bool> _run(
  BuildContext context,
  Future<void> Function() action, {
  bool pop = true,
}) async {
  final l10n = context.l10n;
  try {
    await action();
    if (!context.mounted) return true;
    SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    if (pop) Navigator.of(context).pop();
    return true;
  } catch (e) {
    debugPrint('Shop change failed: $e');
    if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    return false;
  }
}

class _ListScaffold extends StatelessWidget {
  final String title;
  final String addLabel;
  final VoidCallback onAdd;
  final AsyncValue<List<Object>> state;
  final VoidCallback onRetry;
  final List<Widget> children;

  const _ListScaffold({
    required this.title,
    required this.addLabel,
    required this.onAdd,
    required this.state,
    required this.onRetry,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          onPressed: onAdd,
          backgroundColor: shopColor,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: Text(addLabel),
        ),
      ),
      body: switch (state) {
        AsyncValue(hasValue: false, hasError: true) => Center(
          child: OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(context.l10n.videoRetry),
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
          children: children,
        ),
      },
    );
  }
}

class _Row extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final bool active;
  final bool indent;
  final VoidCallback onTap;

  const _Row({
    required this.leading,
    required this.title,
    required this.active,
    required this.onTap,
    this.subtitle = '',
    this.indent = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsetsDirectional.only(start: indent ? 28 : 0, bottom: 10),
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: leading,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: active ? AppColors.text : AppColors.textMuted,
            ),
          ),
          subtitle: subtitle.isEmpty
              ? null
              : Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                  ),
                ),
          trailing: ShopBadge(
            label: active ? l10n.shopActive : l10n.shopHidden,
            color: active ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;

  const _IconBox(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: shopColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: shopColor, size: 21),
    );
  }
}

class _ActiveSwitch extends StatelessWidget {
  final bool value;
  final String help;
  final ValueChanged<bool> onChanged;

  const _ActiveSwitch({
    required this.value,
    required this.help,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: context.l10n.shopVisible,
      icon: Icons.visibility_rounded,
      color: value ? AppColors.primary : AppColors.textMuted,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: value,
          onChanged: onChanged,
          title: Text(
            help,
            style: const TextStyle(fontSize: 14, color: AppColors.text),
          ),
        ),
      ],
    );
  }
}

class _FormScaffold extends StatelessWidget {
  final String title;
  final bool saving;
  final VoidCallback? onDelete;
  final VoidCallback onSave;
  final List<Widget> children;

  const _FormScaffold({
    required this.title,
    required this.saving,
    required this.onSave,
    required this.children,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (onDelete != null)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.danger,
              onPressed: saving ? null : onDelete,
            ),
        ],
      ),
      body: AbsorbPointer(
        absorbing: saving,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: settingsListPadding(context),
          children: [
            ...children,
            const SizedBox(height: 24),
            SettingsSaveButton(
              label: l10n.save,
              saving: saving,
              onPressed: onSave,
            ),
          ],
        ),
      ),
    );
  }
}

void _openForm(BuildContext context, Widget form) => Navigator.of(
  context,
).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => form));

class AdminCategoriesScreen extends ConsumerStatefulWidget {
  const AdminCategoriesScreen({super.key});

  @override
  ConsumerState<AdminCategoriesScreen> createState() =>
      _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends ConsumerState<AdminCategoriesScreen> {
  bool _seeding = false;

  Future<void> _addStarting() async {
    final adminId = _adminId(ref);
    if (adminId == null) return;
    final l10n = context.l10n;
    setState(() => _seeding = true);
    await _run(
      context,
      () => ref.read(shopRepositoryProvider).addStartingCategories([
        for (final (i, icon) in CategoryIcon.values.indexed)
          ShopCategory(
            id: '',
            name: icon.defaultName(l10n),
            icon: icon,
            order: (i + 1) * 10,
          ),
      ], adminId: adminId),
      pop: false,
    );
    if (mounted) setState(() => _seeding = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(allShopCategoriesProvider);
    final all = state.value ?? const <ShopCategory>[];

    return _ListScaffold(
      title: l10n.shopCategories,
      addLabel: l10n.shopAddCategory,
      onAdd: () => _openForm(context, const _CategoryForm()),
      state: state,
      onRetry: () => ref.invalidate(allShopCategoriesProvider),
      children: [
        if (all.isEmpty) ...[
          const SizedBox(height: 32),
          EmptyState(
            icon: const Icon(
              Icons.category_rounded,
              size: 44,
              color: shopColor,
            ),
            color: shopColor,
            title: l10n.shopCategories,
            message: l10n.shopStartingHelp,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _seeding ? null : _addStarting,
            style: FilledButton.styleFrom(backgroundColor: shopColor),
            icon: const Icon(Icons.auto_awesome_rounded),
            label: Text(l10n.shopAddStarting),
          ),
        ],
        for (final top in all.where((c) => c.isTop)) ...[
          _categoryRow(top),
          for (final sub in subCategories(all, top.id))
            _categoryRow(sub, indent: true),
        ],
        for (final orphan in all.where(
          (c) => !c.isTop && !all.any((p) => p.id == c.parentId),
        ))
          _categoryRow(orphan),
      ],
    );
  }

  Widget _categoryRow(ShopCategory c, {bool indent = false}) => _Row(
    leading: _IconBox(c.icon.data),
    title: c.name,
    active: c.active,
    indent: indent,
    onTap: () => _openForm(context, _CategoryForm(category: c)),
  );
}

class _CategoryForm extends ConsumerStatefulWidget {
  final ShopCategory? category;

  const _CategoryForm({this.category});

  @override
  ConsumerState<_CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends ConsumerState<_CategoryForm> {
  late final _name = TextEditingController(text: widget.category?.name);
  late final _order = TextEditingController(
    text: '${widget.category?.order ?? 0}',
  );
  late String _parentId = widget.category?.parentId ?? '';
  late CategoryIcon _icon = widget.category?.icon ?? CategoryIcon.other;
  late bool _active = widget.category?.active ?? true;
  bool _showErrors = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _order.dispose();
    super.dispose();
  }

  bool _inUse(String id) {
    final products = ref.read(allProductsProvider).value ?? const <Product>[];
    final categories =
        ref.read(allShopCategoriesProvider).value ?? const <ShopCategory>[];
    return products.any((p) => p.draft.categoryId == id) ||
        categories.any((c) => c.parentId == id);
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) {
      setState(() => _showErrors = true);
      return;
    }
    final adminId = _adminId(ref);
    if (adminId == null) return;
    setState(() => _saving = true);
    final ok = await _run(
      context,
      () => ref
          .read(shopRepositoryProvider)
          .saveCategory(
            ShopCategory(
              id: widget.category?.id ?? '',
              name: _name.text,
              parentId: _parentId,
              icon: _icon,
              order: (readInt(_order) ?? 0).clamp(0, 9999),
              active: _active,
            ),
            adminId: adminId,
          ),
    );
    if (!ok && mounted) setState(() => _saving = false);
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final c = widget.category!;
    if (_inUse(c.id)) {
      SnackbarUtils.showError(context, l10n.shopInUse);
      return;
    }
    if (!await confirmShopDelete(
          context,
          title: l10n.shopDeleteTitle(c.name),
          body: l10n.shopDeleteBody,
        ) ||
        !mounted) {
      return;
    }
    setState(() => _saving = true);
    final ok = await _run(
      context,
      () => ref.read(shopRepositoryProvider).deleteCategory(c.id),
    );
    if (!ok && mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final id = widget.category?.id;
    final all = ref.watch(allShopCategoriesProvider).value ?? const [];
    final hasChildren = id != null && all.any((c) => c.parentId == id);
    final parents = [
      for (final c in all)
        if (c.isTop && c.id != id) c,
    ];

    return _FormScaffold(
      title: widget.category == null
          ? l10n.shopAddCategory
          : l10n.shopEditCategory,
      saving: _saving,
      onSave: _save,
      onDelete: widget.category == null ? null : _delete,
      children: [
        SettingsSection(
          title: l10n.shopDetails,
          icon: Icons.category_rounded,
          color: shopColor,
          children: [
            const SizedBox(height: 12),
            ShopTextField(
              controller: _name,
              label: l10n.shopName,
              maxLength: ShopLimits.shortText,
              error: _showErrors && _name.text.trim().isEmpty
                  ? l10n.requiredField
                  : null,
            ),
            if (!hasChildren)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DropdownButtonFormField<String>(
                  initialValue: parents.any((p) => p.id == _parentId)
                      ? _parentId
                      : '',
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.shopParent,
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(value: '', child: Text(l10n.shopNoParent)),
                    for (final p in parents)
                      DropdownMenuItem(value: p.id, child: Text(p.name)),
                  ],
                  onChanged: (v) => setState(() => _parentId = v ?? ''),
                ),
              ),
            SettingsNumberTile(
              controller: _order,
              label: l10n.shopOrder,
              help: l10n.shopOrderHelp,
            ),
          ],
        ),
        SettingsSection(
          title: l10n.shopIcon,
          icon: Icons.interests_rounded,
          color: shopColor,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final icon in CategoryIcon.values)
                    InkWell(
                      onTap: () => setState(() => _icon = icon),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _icon == icon
                              ? shopColor
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _icon == icon ? shopColor : AppColors.border,
                          ),
                        ),
                        child: Icon(
                          icon.data,
                          color: _icon == icon ? Colors.white : shopColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        _ActiveSwitch(
          value: _active,
          help: l10n.shopCategoryVisibleHelp,
          onChanged: (v) => setState(() => _active = v),
        ),
      ],
    );
  }
}

class AdminBrandsScreen extends ConsumerWidget {
  const AdminBrandsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(allBrandsProvider);
    final all = state.value ?? const <Brand>[];

    return _ListScaffold(
      title: l10n.shopBrands,
      addLabel: l10n.shopAddBrand,
      onAdd: () => _openForm(context, const _BrandForm()),
      state: state,
      onRetry: () => ref.invalidate(allBrandsProvider),
      children: [
        if (all.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: EmptyState(
              icon: const Icon(
                Icons.verified_rounded,
                size: 44,
                color: shopColor,
              ),
              color: shopColor,
              title: l10n.shopBrands,
              message: l10n.shopBrandsEmpty,
            ),
          ),
        for (final b in all)
          _Row(
            leading: SizedBox(
              width: 40,
              height: 40,
              child: b.logoUrl == null
                  ? const _IconBox(Icons.verified_rounded)
                  : ShopNetworkImage(
                      url: b.logoUrl,
                      height: 40,
                      borderRadius: BorderRadius.circular(12),
                    ),
            ),
            title: b.name,
            subtitle: b.website,
            active: b.active,
            onTap: () => _openForm(context, _BrandForm(brand: b)),
          ),
      ],
    );
  }
}

class _BrandForm extends ConsumerStatefulWidget {
  final Brand? brand;

  const _BrandForm({this.brand});

  @override
  ConsumerState<_BrandForm> createState() => _BrandFormState();
}

class _BrandFormState extends ConsumerState<_BrandForm> {
  late final _name = TextEditingController(text: widget.brand?.name);
  late final _description = TextEditingController(
    text: widget.brand?.description,
  );
  late final _website = TextEditingController(text: widget.brand?.website);
  late bool _active = widget.brand?.active ?? true;
  late String? _logoUrl = widget.brand?.logoUrl;
  File? _newLogo;
  bool _showErrors = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _website.dispose();
    super.dispose();
  }

  bool get _badWebsite =>
      _website.text.trim().isNotEmpty && !isShopLink(_website.text);

  Future<void> _pickLogo() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (picked == null || !mounted) return;
    final file = File(picked.path);
    if (await file.length() >= ShopLimits.imageBytes) {
      if (mounted) {
        SnackbarUtils.showError(context, context.l10n.shopImageTooBig);
      }
      return;
    }
    setState(() => _newLogo = file);
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty || _badWebsite) {
      setState(() => _showErrors = true);
      return;
    }
    final adminId = _adminId(ref);
    if (adminId == null) return;
    setState(() => _saving = true);
    final keep = _newLogo == null && _logoUrl != null;
    final ok = await _run(
      context,
      () => ref
          .read(shopRepositoryProvider)
          .saveBrand(
            Brand(
              id: widget.brand?.id ?? '',
              name: _name.text,
              description: _description.text,
              website: _website.text,
              logoUrl: keep ? widget.brand?.logoUrl : null,
              logoPath: keep ? widget.brand?.logoPath : null,
              active: _active,
            ),
            adminId: adminId,
            existing: widget.brand,
            newLogo: _newLogo,
          ),
    );
    if (!ok && mounted) setState(() => _saving = false);
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final b = widget.brand!;
    final products = ref.read(allProductsProvider).value ?? const <Product>[];
    if (products.any((p) => p.draft.brandId == b.id)) {
      SnackbarUtils.showError(context, l10n.shopInUse);
      return;
    }
    if (!await confirmShopDelete(
          context,
          title: l10n.shopDeleteTitle(b.name),
          body: l10n.shopDeleteBody,
        ) ||
        !mounted) {
      return;
    }
    setState(() => _saving = true);
    final ok = await _run(
      context,
      () => ref.read(shopRepositoryProvider).deleteBrand(b),
    );
    if (!ok && mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasLogo = _newLogo != null || _logoUrl != null;

    return _FormScaffold(
      title: widget.brand == null ? l10n.shopAddBrand : l10n.shopEditBrand,
      saving: _saving,
      onSave: _save,
      onDelete: widget.brand == null ? null : _delete,
      children: [
        SettingsSection(
          title: l10n.shopDetails,
          icon: Icons.verified_rounded,
          color: shopColor,
          children: [
            const SizedBox(height: 12),
            ShopTextField(
              controller: _name,
              label: l10n.shopName,
              maxLength: ShopLimits.shortText,
              error: _showErrors && _name.text.trim().isEmpty
                  ? l10n.requiredField
                  : null,
            ),
            ShopTextField(
              controller: _description,
              label: l10n.shopDescription,
              lines: 3,
              maxLength: ShopLimits.notes,
            ),
            ShopTextField(
              controller: _website,
              label: l10n.shopWebsite,
              hint: 'https://',
              keyboard: TextInputType.url,
              maxLength: ShopLimits.url,
              error: _showErrors && _badWebsite ? l10n.shopLinkInvalid : null,
            ),
          ],
        ),
        SettingsSection(
          title: l10n.shopLogo,
          icon: Icons.image_rounded,
          color: shopColor,
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: _newLogo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(_newLogo!, fit: BoxFit.cover),
                        )
                      : ShopNetworkImage(
                          url: _logoUrl,
                          height: 72,
                          borderRadius: BorderRadius.circular(16),
                          placeholder: Icons.verified_rounded,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _pickLogo,
                        icon: const Icon(Icons.photo_library_rounded),
                        label: Text(l10n.shopAddLogo),
                      ),
                      if (hasLogo)
                        OutlinedButton.icon(
                          onPressed: () => setState(() {
                            _newLogo = null;
                            _logoUrl = null;
                          }),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.danger,
                          ),
                          icon: const Icon(Icons.delete_outline_rounded),
                          label: Text(l10n.remove),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
        _ActiveSwitch(
          value: _active,
          help: l10n.shopBrandVisibleHelp,
          onChanged: (v) => setState(() => _active = v),
        ),
      ],
    );
  }
}

class AdminSuppliersScreen extends ConsumerWidget {
  const AdminSuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(suppliersProvider);
    final all = state.value ?? const <Supplier>[];

    return _ListScaffold(
      title: l10n.shopSuppliers,
      addLabel: l10n.shopAddSupplier,
      onAdd: () => _openForm(context, const _SupplierForm()),
      state: state,
      onRetry: () => ref.invalidate(suppliersProvider),
      children: [
        ShopHelpText(l10n.shopSuppliersHelp),
        if (all.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: EmptyState(
              icon: const Icon(
                Icons.local_shipping_rounded,
                size: 44,
                color: shopColor,
              ),
              color: shopColor,
              title: l10n.shopSuppliers,
              message: l10n.shopSuppliersEmpty,
            ),
          ),
        for (final s in all)
          _Row(
            leading: const _IconBox(Icons.local_shipping_rounded),
            title: s.name,
            subtitle: [
              s.orderMethod.label(l10n),
              if (s.email.isNotEmpty) s.email,
            ].join(' · '),
            active: s.active,
            onTap: () => _openForm(context, _SupplierForm(supplier: s)),
          ),
      ],
    );
  }
}

class _SupplierForm extends ConsumerStatefulWidget {
  final Supplier? supplier;

  const _SupplierForm({this.supplier});

  @override
  ConsumerState<_SupplierForm> createState() => _SupplierFormState();
}

class _SupplierFormState extends ConsumerState<_SupplierForm> {
  late final Supplier? _old = widget.supplier;
  late final _name = TextEditingController(text: _old?.name);
  late final _contact = TextEditingController(text: _old?.contactName);
  late final _email = TextEditingController(text: _old?.email);
  late final _phone = TextEditingController(text: _old?.phone);
  late final _website = TextEditingController(text: _old?.website);
  late final _notes = TextEditingController(text: _old?.notes);
  late OrderMethod _method = _old?.orderMethod ?? OrderMethod.manual;
  late bool _active = _old?.active ?? true;
  bool _showErrors = false;
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_name, _contact, _email, _phone, _website, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  // Automatic emails need an address to send to.
  bool get _badEmail =>
      (_email.text.trim().isNotEmpty || _method == OrderMethod.email) &&
      !isEmail(_email.text);

  bool get _badWebsite =>
      _website.text.trim().isNotEmpty && !isShopLink(_website.text);

  Future<void> _save() async {
    final config = ref.read(shopConfigProvider).value;
    if (_name.text.trim().isEmpty || _badEmail || _badWebsite) {
      setState(() => _showErrors = true);
      return;
    }
    final adminId = _adminId(ref);
    if (adminId == null || config == null) return;
    setState(() => _saving = true);
    final ok = await _run(
      context,
      () => ref
          .read(shopRepositoryProvider)
          .saveSupplier(
            Supplier(
              id: _old?.id ?? '',
              name: _name.text,
              contactName: _contact.text,
              email: _email.text,
              phone: _phone.text,
              website: _website.text,
              orderMethod: _method,
              notes: _notes.text,
              active: _active,
            ),
            adminId: adminId,
            config: config,
          ),
    );
    if (!ok && mounted) setState(() => _saving = false);
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final s = widget.supplier!;
    final config = ref.read(shopConfigProvider).value;
    final adminId = _adminId(ref);
    final products = ref.read(allProductsProvider).value ?? const <Product>[];
    if (products.any((p) => p.draft.supplierId == s.id)) {
      SnackbarUtils.showError(context, l10n.shopInUse);
      return;
    }
    if (config == null || adminId == null) return;
    if (!await confirmShopDelete(
          context,
          title: l10n.shopDeleteTitle(s.name),
          body: l10n.shopDeleteBody,
        ) ||
        !mounted) {
      return;
    }
    setState(() => _saving = true);
    final ok = await _run(
      context,
      () => ref
          .read(shopRepositoryProvider)
          .deleteSupplier(s.id, adminId: adminId, config: config),
    );
    if (!ok && mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _FormScaffold(
      title: _old == null ? l10n.shopAddSupplier : l10n.shopEditSupplier,
      saving: _saving,
      onSave: _save,
      onDelete: _old == null ? null : _delete,
      children: [
        SettingsSection(
          title: l10n.shopDetails,
          icon: Icons.local_shipping_rounded,
          color: shopColor,
          children: [
            const SizedBox(height: 12),
            ShopTextField(
              controller: _name,
              label: l10n.shopName,
              maxLength: ShopLimits.shortText,
              error: _showErrors && _name.text.trim().isEmpty
                  ? l10n.requiredField
                  : null,
            ),
            ShopTextField(
              controller: _contact,
              label: l10n.shopContactName,
              maxLength: ShopLimits.shortText,
            ),
            ShopTextField(
              controller: _email,
              label: l10n.shopEmail,
              keyboard: TextInputType.emailAddress,
              maxLength: ShopLimits.shortText,
              error: _showErrors && _badEmail ? l10n.shopEmailInvalid : null,
            ),
            ShopTextField(
              controller: _phone,
              label: l10n.shopPhone,
              keyboard: TextInputType.phone,
              maxLength: 30,
            ),
            ShopTextField(
              controller: _website,
              label: l10n.shopWebsite,
              hint: 'https://',
              keyboard: TextInputType.url,
              maxLength: ShopLimits.url,
              error: _showErrors && _badWebsite ? l10n.shopLinkInvalid : null,
            ),
          ],
        ),
        SettingsSection(
          title: l10n.shopOrderMethod,
          icon: Icons.outgoing_mail,
          color: shopColor,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final m in OrderMethod.values)
                    ShopChoice(
                      label: m.label(l10n),
                      selected: _method == m,
                      onTap: () => setState(() => _method = m),
                    ),
                ],
              ),
            ),
            ShopHelpText(_method.help(l10n)),
          ],
        ),
        SettingsSection(
          title: l10n.shopNotes,
          icon: Icons.sticky_note_2_rounded,
          color: shopColor,
          children: [
            const SizedBox(height: 12),
            ShopTextField(
              controller: _notes,
              label: l10n.shopNotes,
              lines: 4,
              maxLength: ShopLimits.notes,
            ),
          ],
        ),
        _ActiveSwitch(
          value: _active,
          help: l10n.shopSupplierActiveHelp,
          onChanged: (v) => setState(() => _active = v),
        ),
      ],
    );
  }
}
