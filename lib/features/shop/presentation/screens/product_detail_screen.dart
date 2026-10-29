import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final _pages = PageController();

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

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
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: _BuyBar(product: product),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          SizedBox(
            height: width.clamp(240, 420),
            child: product.images.length <= 1
                ? ShopNetworkImage(url: product.cover)
                : PageView(
                    controller: _pages,
                    children: [
                      for (final image in product.images)
                        ShopNetworkImage(url: image.url),
                    ],
                  ),
          ),
          if (product.images.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pages,
                  count: product.images.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    activeDotColor: shopColor,
                    dotColor: AppColors.border,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (brand != null)
                  Text(
                    brand.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: shopColor,
                    ),
                  ),
                const SizedBox(height: 2),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 21,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: PriceTag(product: product, size: 20)),
                    if (product.onSale)
                      ShopBadge(
                        label: '-${product.discountPercent}%',
                        color: AppColors.danger,
                        filled: true,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (!d.isAffiliate)
                      ShopBadge(
                        label: d.availability.label(l10n),
                        color: d.availability.color,
                      ),
                    ShopBadge(
                      label: d.animals.isEmpty
                          ? l10n.shopAllAnimals
                          : [
                              for (final a in d.animals) a.label(l10n),
                            ].join(' · '),
                      color: AppColors.primary,
                    ),
                  ],
                ),
                if (d.description.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    l10n.shopDescription,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    d.description,
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
                      color: AppColors.text,
                    ),
                  ),
                ],
                if (d.isAffiliate) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: shopColor.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: shopColor,
                        ),
                        const SizedBox(width: 8),
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

class _BuyBar extends StatelessWidget {
  final Product product;

  const _BuyBar({required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final d = product.draft;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton.icon(
            onPressed: d.isAffiliate
                ? () => openShopLink(context, d.affiliateUrl)
                : null,
            icon: Icon(
              d.isAffiliate
                  ? Icons.open_in_new_rounded
                  : Icons.add_shopping_cart_rounded,
            ),
            label: Text(
              d.isAffiliate
                  ? l10n.shopBuyOn(d.partnerName)
                  : l10n.shopAddToCart,
            ),
            style: FilledButton.styleFrom(
              backgroundColor: shopColor,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          if (!d.isAffiliate) ...[
            const SizedBox(height: 6),
            Text(
              d.availability.canBuy
                  ? l10n.shopCheckoutSoon
                  : d.availability.label(l10n),
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
