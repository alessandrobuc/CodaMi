import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
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
    final availability = product.draft.availability;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ShopNetworkImage(url: product.cover),
                  if (product.onSale)
                    PositionedDirectional(
                      top: 8,
                      start: 8,
                      child: ShopBadge(
                        label: '-${product.discountPercent}%',
                        color: AppColors.danger,
                        filled: true,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (brandName.isNotEmpty)
                    Text(
                      brandName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  PriceTag(product: product, size: 14.5),
                  if (!availability.canBuy) ...[
                    const SizedBox(height: 4),
                    ShopBadge(
                      label: availability.label(l10n),
                      color: availability.color,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
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
    final plain =
        keyboard == TextInputType.url || keyboard == TextInputType.emailAddress;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        minLines: lines,
        maxLines: lines == 1 ? 1 : lines + 4,
        maxLength: maxLength,
        keyboardType: keyboard ?? (lines > 1 ? TextInputType.multiline : null),
        autocorrect: !plain,
        textCapitalization: plain
            ? TextCapitalization.none
            : TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: help,
          helperMaxLines: 3,
          errorText: error,
          errorMaxLines: 2,
          alignLabelWithHint: lines > 1,
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
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
