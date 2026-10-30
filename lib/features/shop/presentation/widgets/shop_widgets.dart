import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/form_fields.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/shop.dart';

const shopColor = Color(0xFF4F46E5);

String formatPrice(int cents) => NumberFormat.currency(
  locale: currentAppLanguage.code,
  symbol: '€',
  decimalDigits: 2,
).format(cents / 100);

extension SalesModelLabel on SalesModel {
  String label(AppLocalizations l10n) => switch (this) {
    SalesModel.ownStock => l10n.shopModelOwnStock,
    SalesModel.brandPartner => l10n.shopModelBrand,
    SalesModel.dropship => l10n.shopModelDropship,
    SalesModel.affiliate => l10n.shopModelAffiliate,
  };

  String help(AppLocalizations l10n) => switch (this) {
    SalesModel.ownStock => l10n.shopModelOwnStockHelp,
    SalesModel.brandPartner => l10n.shopModelBrandHelp,
    SalesModel.dropship => l10n.shopModelDropshipHelp,
    SalesModel.affiliate => l10n.shopModelAffiliateHelp,
  };

  IconData get icon => switch (this) {
    SalesModel.ownStock => Icons.inventory_2_rounded,
    SalesModel.brandPartner => Icons.handshake_rounded,
    SalesModel.dropship => Icons.local_shipping_rounded,
    SalesModel.affiliate => Icons.link_rounded,
  };
}

extension AvailabilityLabel on Availability {
  String label(AppLocalizations l10n) => switch (this) {
    Availability.inStock => l10n.shopInStock,
    Availability.lowStock => l10n.shopLowStock,
    Availability.outOfStock => l10n.shopOutOfStock,
    Availability.comingSoon => l10n.shopComingSoon,
  };

  Color get color => switch (this) {
    Availability.inStock => AppColors.primary,
    Availability.lowStock => AppColors.rewardText,
    Availability.outOfStock => AppColors.danger,
    Availability.comingSoon => const Color(0xFF2563EB),
  };
}

extension OrderMethodLabel on OrderMethod {
  String label(AppLocalizations l10n) => switch (this) {
    OrderMethod.manual => l10n.shopOrderManual,
    OrderMethod.email => l10n.shopOrderEmail,
  };

  String help(AppLocalizations l10n) => switch (this) {
    OrderMethod.manual => l10n.shopOrderManualHelp,
    OrderMethod.email => l10n.shopOrderEmailHelp,
  };
}

extension CategoryIconData on CategoryIcon {
  IconData get data => switch (this) {
    CategoryIcon.food => Icons.restaurant_rounded,
    CategoryIcon.accessories => Icons.checkroom_rounded,
    CategoryIcon.care => Icons.spa_rounded,
    CategoryIcon.toys => Icons.sports_baseball_rounded,
    CategoryIcon.beds => Icons.bed_rounded,
    CategoryIcon.carriers => Icons.luggage_rounded,
    CategoryIcon.tech => Icons.devices_other_rounded,
    CategoryIcon.other => Icons.category_rounded,
  };

  String defaultName(AppLocalizations l10n) => switch (this) {
    CategoryIcon.food => l10n.shopCatFood,
    CategoryIcon.accessories => l10n.shopCatAccessories,
    CategoryIcon.care => l10n.shopCatCare,
    CategoryIcon.toys => l10n.shopCatToys,
    CategoryIcon.beds => l10n.shopCatBeds,
    CategoryIcon.carriers => l10n.shopCatCarriers,
    CategoryIcon.tech => l10n.shopCatTech,
    CategoryIcon.other => l10n.shopCatOther,
  };
}

Future<void> openShopLink(BuildContext context, String url) async {
  final failure = context.l10n.shopOpenFailed;
  final uri = Uri.tryParse(url);
  if (uri == null || !isShopLink(url)) {
    SnackbarUtils.showError(context, failure);
    return;
  }
  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) SnackbarUtils.showError(context, failure);
  } catch (_) {
    if (context.mounted) SnackbarUtils.showError(context, failure);
  }
}

class ShopNetworkImage extends StatelessWidget {
  final String? url;
  final double? height;
  final BorderRadius borderRadius;
  final IconData placeholder;

  const ShopNetworkImage({
    super.key,
    required this.url,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.placeholder = Icons.shopping_bag_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final empty = Container(
      height: height,
      color: shopColor.withValues(alpha: 0.07),
      alignment: Alignment.center,
      child: Icon(placeholder, color: shopColor.withValues(alpha: 0.5)),
    );
    return ClipRRect(
      borderRadius: borderRadius,
      child: url == null
          ? empty
          : CachedNetworkImage(
              imageUrl: url!,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, _) => empty,
              errorWidget: (_, _, _) => empty,
            ),
    );
  }
}

class ShopBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool filled;

  const ShopBadge({
    super.key,
    required this.label,
    required this.color,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: filled ? color : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: filled ? Colors.white : color,
        ),
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  final Product product;
  final double size;

  const PriceTag({super.key, required this.product, this.size = 15});

  @override
  Widget build(BuildContext context) {
    final price = product.draft.priceCents;
    if (price == null) {
      return Text(
        context.l10n.shopPriceOnPartner(product.draft.partnerName),
        style: TextStyle(
          fontSize: size - 2,
          fontWeight: FontWeight.w600,
          color: shopColor,
        ),
      );
    }
    return Wrap(
      spacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          formatPrice(price),
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w800,
            color: product.onSale ? AppColors.danger : AppColors.text,
          ),
        ),
        if (product.onSale)
          Text(
            formatPrice(product.draft.compareAtCents!),
            style: TextStyle(
              fontSize: size - 3,
              color: AppColors.textMuted,
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final String brandName;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.brandName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final d = product.draft;
    final soldOut = !d.isAffiliate && !d.availability.canBuy;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Opacity(
                        opacity: soldOut ? 0.55 : 1,
                        child: ShopNetworkImage(
                          url: product.cover,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      if (product.onSale)
                        PositionedDirectional(
                          top: 6,
                          start: 6,
                          child: ShopBadge(
                            label: '-${product.discountPercent}%',
                            color: AppColors.danger,
                            filled: true,
                          ),
                        ),
                      if (d.isAffiliate)
                        PositionedDirectional(
                          top: 6,
                          end: 6,
                          child: _PartnerTag(name: d.partnerName),
                        ),
                      if (soldOut || d.availability == Availability.lowStock)
                        PositionedDirectional(
                          bottom: 6,
                          start: 6,
                          child: ShopBadge(
                            label: d.availability.label(l10n),
                            color: d.availability.color,
                            filled: true,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (d.sponsoredAt(DateTime.now()))
                      Text(
                        l10n.shopSponsored,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                    if (brandName.isNotEmpty)
                      Text(
                        brandName.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.5,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.w700,
                          color: shopColor,
                        ),
                      ),
                    const SizedBox(height: 2),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    PriceTag(product: product, size: 14),
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

class _PartnerTag extends StatelessWidget {
  final String name;

  const _PartnerTag({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 110),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.open_in_new_rounded, size: 11, color: shopColor),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: shopColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? help;
  final String? error;
  final int lines;
  final int? maxLength;
  final TextInputType? keyboard;

  const ShopTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLength,
    this.hint,
    this.help,
    this.error,
    this.lines = 1,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      help: help,
      error: error,
      lines: lines,
      maxLength: maxLength,
      keyboard: keyboard,
      focusColor: shopColor,
    );
  }
}

class ShopChoice extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const ShopChoice({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.color = shopColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: icon == null
          ? null
          : Icon(icon, size: 18, color: selected ? Colors.white : color),
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      selectedColor: color,
      backgroundColor: AppColors.surface,
      shape: const StadiumBorder(),
      side: BorderSide(color: selected ? color : AppColors.border),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: selected ? Colors.white : AppColors.text,
      ),
      onSelected: (_) => onTap(),
    );
  }
}

class ShopHelpText extends StatelessWidget {
  final String text;

  const ShopHelpText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          height: 1.35,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

Future<bool> confirmShopDelete(
  BuildContext context, {
  required String title,
  required String body,
}) async {
  final l10n = context.l10n;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          child: Text(l10n.delete),
        ),
      ],
    ),
  );
  return confirmed == true;
}
