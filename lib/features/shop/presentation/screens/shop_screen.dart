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

const _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 220,
  mainAxisSpacing: 12,
  crossAxisSpacing: 12,
  childAspectRatio: 0.76,
);

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

  bool get _filtered =>
      _animal != null || _category != null || _search.text.trim().isNotEmpty;

  void _retry() {
    ref
      ..invalidate(shopConfigProvider)
      ..invalidate(shopCategoriesProvider)
      ..invalidate(shopBrandsProvider)
      ..invalidate(shopProductsProvider);
  }

  void _open(Product p) => Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: p.id)),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(shopCatalogProvider);
    final closed = widget.preview && !ref.watch(shopEnabledProvider);

    final content = switch (state) {
      AsyncValue(hasValue: false, hasError: true) => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
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
      ),
      AsyncValue(:final value?) => SliverMainAxisGroup(
        slivers: _content(value),
      ),
      _ => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      ),
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
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: _Header(
                preview: widget.preview,
                closed: closed,
                search: _search,
                onSearch: () => setState(() {}),
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }

  List<Widget> _content(ShopCatalog catalog) {
    final l10n = context.l10n;
    final bottom = MediaQuery.paddingOf(context).bottom;
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
    final myPets = ref.watch(myPetSpeciesProvider);
    final forPets = _filtered || myPets.isEmpty
        ? const <Product>[]
        : [
            for (final p in catalog.products)
              if (p.draft.animals.any(myPets.contains)) p,
          ];
    final onSale = _filtered
        ? const <Product>[]
        : [
            for (final p in catalog.products)
              if (p.onSale) p,
          ];

    return [
      SliverToBoxAdapter(
        child: _Filters(
          animal: _animal,
          onAnimal: (a) => setState(() => _animal = a),
          categories: tops,
          category: _category,
          onCategory: (id) => setState(() {
            _category = id;
            _subCategory = null;
          }),
          subs: subs,
          subCategory: _subCategory,
          onSubCategory: (id) => setState(() => _subCategory = id),
        ),
      ),
      if (forPets.isNotEmpty)
        SliverToBoxAdapter(
          child: _Row(
            title: l10n.shopForYourPets,
            icon: Icons.favorite_rounded,
            products: forPets,
            catalog: catalog,
            onOpen: _open,
          ),
        ),
      if (onSale.isNotEmpty)
        SliverToBoxAdapter(
          child: _Row(
            title: l10n.shopOnSale,
            icon: Icons.local_offer_rounded,
            products: onSale,
            catalog: catalog,
            onOpen: _open,
          ),
        ),
      if (products.isEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 32, 24, bottom + 120),
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
      else ...[
        SliverToBoxAdapter(
          child: _SectionTitle(
            title: _filtered ? l10n.shopResults : l10n.shopAllProducts,
            trailing: l10n.shopProductCount(products.length),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, bottom + 120),
          sliver: SliverGrid.builder(
            gridDelegate: _gridDelegate,
            itemCount: products.length,
            itemBuilder: (context, i) => ProductCard(
              product: products[i],
              brandName: catalog.brandName(products[i]),
              onTap: () => _open(products[i]),
            ),
          ),
        ),
      ],
    ];
  }
}

class _Header extends StatelessWidget {
  final bool preview;
  final bool closed;
  final TextEditingController search;
  final VoidCallback onSearch;

  const _Header({
    required this.preview,
    required this.closed,
    required this.search,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.border),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (closed)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
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
          if (!preview) ...[
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
            controller: search,
            onChanged: (_) => onSearch(),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.shopSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: search.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        search.clear();
                        onSearch();
                      },
                    ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: EdgeInsets.zero,
              border: border,
              enabledBorder: border,
            ),
          ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  final PetSpecies? animal;
  final ValueChanged<PetSpecies?> onAnimal;
  final List<ShopCategory> categories;
  final String? category;
  final ValueChanged<String?> onCategory;
  final List<ShopCategory> subs;
  final String? subCategory;
  final ValueChanged<String?> onSubCategory;

  const _Filters({
    required this.animal,
    required this.onAnimal,
    required this.categories,
    required this.category,
    required this.onCategory,
    required this.subs,
    required this.subCategory,
    required this.onSubCategory,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final a in [null, ...PetSpecies.values])
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: ShopChoice(
                      label: a?.label(l10n) ?? l10n.all,
                      icon: a == null ? null : Icons.pets_rounded,
                      selected: animal == a,
                      onTap: () => onAnimal(a),
                    ),
                  ),
              ],
            ),
          ),
          if (categories.isNotEmpty) ...[
            const SizedBox(height: 14),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CategoryButton(
                    name: l10n.all,
                    icon: Icons.apps_rounded,
                    selected: category == null,
                    onTap: () => onCategory(null),
                  ),
                  for (final c in categories)
                    _CategoryButton(
                      name: c.name,
                      icon: c.icon.data,
                      selected: category == c.id,
                      onTap: () => onCategory(category == c.id ? null : c.id),
                    ),
                ],
              ),
            ),
          ],
          if (subs.isNotEmpty)
            SizedBox(
              height: 46,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                children: [
                  for (final s in [null, ...subs])
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: ShopChoice(
                        label: s?.name ?? l10n.all,
                        selected: subCategory == s?.id,
                        onTap: () => onSubCategory(s?.id),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.name,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: ShapeDecoration(
          color: selected ? shopColor : AppColors.surface,
          shape: StadiumBorder(
            side: BorderSide(color: selected ? shopColor : AppColors.border),
          ),
          shadows: selected
              ? [
                  BoxShadow(
                    color: shopColor.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            customBorder: const StadiumBorder(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(6, 6, 14, 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white.withValues(alpha: 0.2)
                          : shopColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 17,
                      color: selected ? Colors.white : shopColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String trailing;

  const _SectionTitle({required this.title, this.icon, this.trailing = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: shopColor),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
          ),
          if (trailing.isNotEmpty)
            Text(
              trailing,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Product> products;
  final ShopCatalog catalog;
  final ValueChanged<Product> onOpen;

  const _Row({
    required this.title,
    required this.icon,
    required this.products,
    required this.catalog,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(title: title, icon: icon),
        SizedBox(
          height: 222,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            clipBehavior: Clip.none,
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, i) => SizedBox(
              width: 148,
              child: ProductCard(
                product: products[i],
                brandName: catalog.brandName(products[i]),
                onTap: () => onOpen(products[i]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
