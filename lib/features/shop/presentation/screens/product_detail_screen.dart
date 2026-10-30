import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/checkout.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final _pages = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _goTo(int i) => _pages.animateToPage(
    i,
    duration: const Duration(milliseconds: 280),
    curve: Curves.easeOutCubic,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final catalog = ref.watch(shopCatalogProvider).value;
    final product = catalog?.products
        .where((p) => p.id == widget.productId)
        .firstOrNull;

    if (catalog == null || product == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.background),
        body: Center(
          child: catalog == null
              ? const CircularProgressIndicator()
              : Text(l10n.shopNoResults),
        ),
      );
    }

    final d = product.draft;
    final brand = catalog.brands[d.brandId];
    final size = MediaQuery.sizeOf(context);
    final imageHeight = (size.width * 0.95).clamp(260.0, 460.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: _BuyBar(product: product),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: imageHeight,
            backgroundColor: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            leading: const Padding(
              padding: EdgeInsets.all(6),
              child: _RoundButton(),
            ),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: CartButton(round: true),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ColoredBox(
                    color: shopColor.withValues(alpha: 0.05),
                    child: product.images.length <= 1
                        ? ShopNetworkImage(url: product.cover)
                        : PageView(
                            controller: _pages,
                            onPageChanged: (i) => setState(() => _page = i),
                            children: [
                              for (final image in product.images)
                                ShopNetworkImage(url: image.url),
                            ],
                          ),
                  ),
                  if (product.onSale)
                    PositionedDirectional(
                      end: 16,
                      bottom: 16,
                      child: ShopBadge(
                        label: '-${product.discountPercent}%',
                        color: AppColors.danger,
                        filled: true,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (product.images.length > 1)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 76,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  itemCount: product.images.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () => _goTo(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 64,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _page == i ? shopColor : AppColors.border,
                          width: _page == i ? 2 : 1,
                        ),
                      ),
                      child: ShopNetworkImage(
                        url: product.images[i].url,
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList.list(
              children: [
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (brand != null || d.sponsoredAt(DateTime.now())) ...[
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            if (brand != null)
                              ShopBadge(label: brand.name, color: shopColor),
                            if (d.sponsoredAt(DateTime.now()))
                              ShopBadge(
                                label: l10n.shopSponsored,
                                color: AppColors.textMuted,
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 21,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 12),
                      PriceTag(product: product, size: 24),
                      if (product.onSale) ...[
                        const SizedBox(height: 4),
                        Text(
                          l10n.shopYouSave(
                            formatPrice(d.compareAtCents! - d.priceCents!),
                          ),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (!d.isAffiliate) _Availability(d.availability),
                          _Pill(
                            icon: d.animals.length == 1
                                ? speciesIcon(d.animals.first)
                                : FontAwesomeIcons.paw,
                            label: d.animals.isEmpty
                                ? l10n.shopAllAnimals
                                : [
                                    for (final a in d.animals) a.label(l10n),
                                  ].join(' · '),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (d.description.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.shopDescription,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          d.description,
                          style: const TextStyle(
                            fontSize: 14.5,
                            height: 1.55,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (d.isAffiliate) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: shopColor.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: shopColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.shopAffiliateNote(d.partnerName),
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black26,
      child: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        color: AppColors.text,
        icon: const BackButtonIcon(),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Availability extends StatelessWidget {
  final Availability availability;

  const _Availability(this.availability);

  @override
  Widget build(BuildContext context) {
    final color = availability.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            availability.label(context.l10n),
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

class _Pill extends StatelessWidget {
  final FaIconData icon;
  final String label;

  const _Pill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 12, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuyBar extends ConsumerWidget {
  final Product product;

  const _BuyBar({required this.product});

  void _buyOnPartner(BuildContext context, WidgetRef ref) {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid != null) {
      ref
          .read(shopRepositoryProvider)
          .recordAffiliateClick(product, uid: uid)
          .catchError((Object e) => debugPrint('Click not saved: $e'));
    }
    openShopLink(context, product.draft.affiliateUrl);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final d = product.draft;
    final inCart = ref.watch(
      cartProvider.select(
        (lines) =>
            lines
                .where((l) => l.productId == product.id)
                .firstOrNull
                ?.quantity ??
            0,
      ),
    );
    final buyable = canAddToCart(product);
    final buttonStyle = FilledButton.styleFrom(
      backgroundColor: shopColor,
      minimumSize: const Size.fromHeight(54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: d.isAffiliate
          ? FilledButton.icon(
              onPressed: () => _buyOnPartner(context, ref),
              icon: const Icon(Icons.open_in_new_rounded),
              label: Text(l10n.shopBuyOn(d.partnerName)),
              style: buttonStyle,
            )
          : inCart > 0 && buyable
          ? Row(
              children: [
                QuantityStepper(
                  quantity: inCart,
                  onChanged: (q) => ref
                      .read(cartProvider.notifier)
                      .setQuantity(product.id, q),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    ),
                    icon: const Icon(Icons.shopping_cart_rounded),
                    label: Text(l10n.shopViewCart),
                    style: buttonStyle,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.icon(
                  onPressed: buyable
                      ? () => ref.read(cartProvider.notifier).add(product.id)
                      : null,
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  label: Text(l10n.shopAddToCart),
                  style: buttonStyle,
                ),
                if (!buyable) ...[
                  const SizedBox(height: 6),
                  Text(
                    d.availability.label(l10n),
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
