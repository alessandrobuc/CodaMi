import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';
import 'admin_product_form_screen.dart';

class AdminProductsScreen extends ConsumerStatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  ConsumerState<AdminProductsScreen> createState() =>
      _AdminProductsScreenState();
}

class _AdminProductsScreenState extends ConsumerState<AdminProductsScreen> {
  final _search = TextEditingController();
  bool? _active;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _open([Product? product]) {
    final categories = ref.read(allShopCategoriesProvider).value ?? const [];
    if (product == null && categories.isEmpty) {
      SnackbarUtils.showError(context, context.l10n.shopNeedCategory);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AdminProductFormScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(allProductsProvider);
    final categories = {
      for (final c in ref.watch(allShopCategoriesProvider).value ?? const [])
        c.id: c,
    };
    final brands = {
      for (final b in ref.watch(allBrandsProvider).value ?? const <Brand>[])
        b.id: b.name,
    };
    final all = [...?state.value]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    final shown = [
      for (final p in all)
        if ((_active == null || p.draft.active == _active) &&
            matchesSearch(
              p,
              _search.text,
              brandName: brands[p.draft.brandId] ?? '',
            ))
          p,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.shopProducts),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          onPressed: _open,
          backgroundColor: shopColor,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: Text(l10n.shopAddProduct),
        ),
      ),
      body: switch (state) {
        AsyncValue(hasValue: false, hasError: true) => Center(
          child: OutlinedButton.icon(
            onPressed: () => ref.invalidate(allProductsProvider),
            icon: const Icon(Icons.refresh_rounded),
            label: Text(l10n.videoRetry),
          ),
        ),
        AsyncValue(hasValue: false) => const Center(
          child: CircularProgressIndicator(),
        ),
        _ => ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            16,
            4,
            16,
            MediaQuery.paddingOf(context).bottom + 96,
          ),
          children: [
            TextField(
              controller: _search,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: l10n.shopSearchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                for (final (value, label) in [
                  (null, '${l10n.all} (${all.length})'),
                  (
                    true,
                    '${l10n.shopActive} (${all.where((p) => p.draft.active).length})',
                  ),
                  (
                    false,
                    '${l10n.shopHidden} (${all.where((p) => !p.draft.active).length})',
                  ),
                ])
                  ShopChoice(
                    label: label,
                    selected: _active == value,
                    onTap: () => setState(() => _active = value),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (shown.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: EmptyState(
                  icon: const Icon(
                    Icons.shopping_bag_rounded,
                    size: 44,
                    color: shopColor,
                  ),
                  color: shopColor,
                  title: l10n.shopProducts,
                  message: all.isEmpty
                      ? l10n.shopProductsEmpty
                      : l10n.shopNoResults,
                ),
              ),
            for (final p in shown) ...[
              _ProductTile(
                product: p,
                category: categories[p.draft.categoryId]?.name ?? '',
                brand: brands[p.draft.brandId] ?? '',
                onTap: () => _open(p),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      },
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;
  final String category;
  final String brand;
  final VoidCallback onTap;

  const _ProductTile({
    required this.product,
    required this.category,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final d = product.draft;

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
                child: ShopNetworkImage(
                  url: product.cover,
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
                      product.name,
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
                      [brand, category].where((s) => s.isNotEmpty).join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    PriceTag(product: product, size: 14),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        ShopBadge(
                          label: d.active ? l10n.shopActive : l10n.shopHidden,
                          color: d.active
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                        ShopBadge(
                          label: d.salesModel.label(l10n),
                          color: shopColor,
                        ),
                        if (!d.isAffiliate && !d.availability.canBuy)
                          ShopBadge(
                            label: d.availability.label(l10n),
                            color: d.availability.color,
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
