import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';
import 'product_detail_screen.dart';

// The Shop tab. Admins also open it from the admin side to preview it.
class ShopScreen extends ConsumerStatefulWidget {
  final bool preview;

  const ShopScreen({super.key, this.preview = false});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  final _search = TextEditingController();
  PetSpecies? _animal;
  String? _category;
  String? _subCategory;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _retry() {
    ref
      ..invalidate(shopConfigProvider)
      ..invalidate(shopCategoriesProvider)
      ..invalidate(shopBrandsProvider)
      ..invalidate(shopProductsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(shopCatalogProvider);
    final closed = widget.preview && !ref.watch(shopEnabledProvider);
    final bottom = MediaQuery.paddingOf(context).bottom;

    final body = switch (state) {
      AsyncValue(hasValue: false, hasError: true) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.actionFailed),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _retry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.videoRetry),
            ),
          ],
        ),
      ),
      AsyncValue(:final value?) => _content(value, bottom),
      _ => const Center(child: CircularProgressIndicator()),
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.preview
          ? AppBar(
              title: Text(l10n.shop),
              backgroundColor: AppColors.background,
              surfaceTintColor: Colors.transparent,
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (closed)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  l10n.shopPreviewOff,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.rewardText,
                  ),
                ),
              ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }

  Widget _content(ShopCatalog catalog, double bottom) {
    final l10n = context.l10n;
    final tops = [
      for (final c in catalog.categories)
        if (c.isTop) c,
    ];
    final subs = _category == null
        ? const <ShopCategory>[]
        : subCategories(catalog.categories, _category!);
    final inCategory = _subCategory != null
        ? {_subCategory!}
        : _category != null
        ? categoryBranch(catalog.categories, _category!)
        : null;
    final products = [
      for (final p in catalog.products)
        if ((inCategory == null || inCategory.contains(p.draft.categoryId)) &&
            forAnimal(p, _animal) &&
            matchesSearch(p, _search.text, brandName: catalog.brandName(p)))
          p,
    ];

    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          sliver: SliverList.list(
            children: [
              if (!widget.preview) ...[
                Text(
                  l10n.shop,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  l10n.shopSubtitle,
                  style: const TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 14),
              ],
              TextField(
                controller: _search,
                onChanged: (_) => setState(() {}),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: l10n.shopSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _search.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => setState(_search.clear),
                        ),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final animal in [null, ...PetSpecies.values])
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: ShopChoice(
                          label: animal?.label(l10n) ?? l10n.all,
                          icon: animal == null ? null : Icons.pets_rounded,
                          selected: _animal == animal,
                          onTap: () => setState(() => _animal = animal),
                        ),
                      ),
                  ],
                ),
              ),
              if (tops.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 92,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: tops.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      final c = tops[i];
                      return _CategoryButton(
                        category: c,
                        selected: _category == c.id,
                        onTap: () => setState(() {
                          _category = _category == c.id ? null : c.id;
                          _subCategory = null;
                        }),
                      );
                    },
                  ),
                ),
              ],
              if (subs.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final s in [null, ...subs])
                      ShopChoice(
                        label: s?.name ?? l10n.all,
                        selected: _subCategory == s?.id,
                        onTap: () => setState(() => _subCategory = s?.id),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 14),
            ],
          ),
        ),
        if (products.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: EmptyState(
                icon: const Icon(
                  Icons.storefront_rounded,
                  size: 44,
                  color: shopColor,
                ),
                color: shopColor,
                title: l10n.shop,
                message: catalog.products.isEmpty
                    ? l10n.shopEmpty
                    : l10n.shopNoResults,
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, bottom + 120),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 240,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemCount: products.length,
              itemBuilder: (context, i) {
                final p = products[i];
                return ProductCard(
                  product: p,
                  brandName: catalog.brandName(p),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(productId: p.id),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final ShopCategory category;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: selected ? shopColor : AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selected ? shopColor : AppColors.border,
                ),
              ),
              child: Icon(
                category.icon.data,
                color: selected ? Colors.white : shopColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
