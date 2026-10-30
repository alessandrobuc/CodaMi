import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/checkout.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';
import 'product_detail_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  String? _zoneId;
  String? _methodId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final catalog = ref.watch(shopCatalogProvider).value;
    final shipping =
        ref.watch(shippingConfigProvider).value ?? const ShippingConfig();
    final lines = ref.watch(cartProvider);
    final products = <String, Product>{
      for (final p in catalog?.products ?? const <Product>[]) p.id: p,
    };

    final zones = shipping.activeZones;
    final zone =
        zones.where((z) => z.id == _zoneId).firstOrNull ?? zones.firstOrNull;
    final methods = zone == null
        ? const <ShippingMethod>[]
        : shipping.methodsFor(zone.id);
    final method =
        methods.where((m) => m.id == _methodId).firstOrNull ??
        methods.firstOrNull;
    final summary = summarizeCart(
      lines,
      products,
      method: method,
      zoneId: zone?.id,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.shopCart),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (lines.isNotEmpty)
            TextButton(
              onPressed: () => ref.read(cartProvider.notifier).clear(),
              child: Text(l10n.shopCartClear),
            ),
        ],
      ),
      bottomNavigationBar: summary.items.isEmpty
          ? null
          : _CheckoutBar(summary: summary),
      body: catalog == null
          ? const Center(child: CircularProgressIndicator())
          : summary.items.isEmpty && summary.unavailable == 0
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: EmptyState(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 44,
                    color: shopColor,
                  ),
                  color: shopColor,
                  title: l10n.shopCart,
                  message: l10n.shopCartEmpty,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              children: [
                for (final item in summary.items) ...[
                  _CartRow(item: item),
                  const SizedBox(height: 10),
                ],
                if (summary.unavailable > 0)
                  _Notice(
                    icon: Icons.info_outline_rounded,
                    color: AppColors.rewardText,
                    text: l10n.shopCartUnavailable(summary.unavailable),
                    action: l10n.remove,
                    onAction: () {
                      final cart = ref.read(cartProvider.notifier);
                      for (final l in lines) {
                        final p = products[l.productId];
                        if (p == null || !canAddToCart(p)) {
                          cart.remove(l.productId);
                        }
                      }
                    },
                  ),
                if (summary.items.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _Box(
                    title: l10n.shopShipping,
                    icon: Icons.local_shipping_rounded,
                    child: zones.isEmpty
                        ? Text(
                            l10n.shopShippingNotSet,
                            style: const TextStyle(color: AppColors.textMuted),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                l10n.shopShipTo,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final z in zones)
                                    ShopChoice(
                                      label: z.name,
                                      selected: z.id == zone?.id,
                                      onTap: () =>
                                          setState(() => _zoneId = z.id),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              for (final m in methods)
                                _MethodTile(
                                  method: m,
                                  cost: m.costFor(
                                    zone!.id,
                                    summary.subtotalCents,
                                  ),
                                  selected: m.id == method?.id,
                                  onTap: () => setState(() => _methodId = m.id),
                                ),
                              if (summary.freeShippingGapCents case final gap?)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    l10n.shopFreeShippingGap(formatPrice(gap)),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 12),
                  _Box(
                    title: l10n.shopSummary,
                    icon: Icons.receipt_long_rounded,
                    child: Column(
                      children: [
                        _Line(
                          l10n.shopSubtotal,
                          formatPrice(summary.subtotalCents),
                        ),
                        _Line(
                          l10n.shopShipping,
                          switch (summary.shippingCents) {
                            null => '–',
                            0 => l10n.shopFree,
                            final c => formatPrice(c),
                          },
                        ),
                        const Divider(height: 20, color: AppColors.border),
                        _Line(
                          l10n.shopTotal,
                          formatPrice(summary.totalCents),
                          bold: true,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            l10n.shopVatIncluded,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

class _CartRow extends ConsumerWidget {
  final CartItem item;

  const _CartRow({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = item.product;
    final cart = ref.read(cartProvider.notifier);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(productId: p.id),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: ShopNetworkImage(
                  url: p.cover,
                  height: 72,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatPrice(item.totalCents),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    QuantityStepper(
                      quantity: item.quantity,
                      onChanged: (q) => cart.setQuantity(p.id, q),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: context.l10n.remove,
                onPressed: () => cart.remove(p.id),
                color: AppColors.textMuted,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Widget button(IconData icon, int? next) => SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        color: shopColor,
        disabledColor: AppColors.border,
        onPressed: next == null ? null : () => onChanged(next),
        icon: Icon(icon),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          button(Icons.remove_rounded, quantity > 1 ? quantity - 1 : null),
          SizedBox(
            width: 28,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
          button(
            Icons.add_rounded,
            quantity < CartLine.maxQuantity ? quantity + 1 : null,
          ),
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final ShippingMethod method;
  final int? cost;
  final bool selected;
  final VoidCallback onTap;

  const _MethodTile({
    required this.method,
    required this.cost,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected
            ? shopColor.withValues(alpha: 0.06)
            : AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: selected ? shopColor : AppColors.border),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  color: selected ? shopColor : AppColors.textMuted,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        method.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                      if (method.deliveryTime.isNotEmpty)
                        Text(
                          method.deliveryTime,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      if (method.freeAboveCents case final free?)
                        Text(
                          l10n.shopFreeAbove(formatPrice(free)),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  switch (cost) {
                    null => '–',
                    0 => l10n.shopFree,
                    final c => formatPrice(c),
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: cost == 0 ? AppColors.primary : AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _Box({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 19, color: shopColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _Line(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 17 : 14.5,
      fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
      color: AppColors.text,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String action;
  final VoidCallback onAction;

  const _Notice({
    required this.icon,
    required this.color,
    required this.text,
    required this.action,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 6, 6),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 13, color: color)),
          ),
          TextButton(onPressed: onAction, child: Text(action)),
        ],
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  final CartSummary summary;

  const _CheckoutBar({required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
            onPressed: null,
            icon: const Icon(Icons.lock_rounded),
            label: Text(
              '${l10n.shopCheckout} · ${formatPrice(summary.totalCents)}',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: shopColor,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.shopPaymentSoon,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

// Cart icon with the number of items, for the shop and product screens.
class CartButton extends ConsumerWidget {
  final bool round;

  const CartButton({super.key, this.round = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(cartCountProvider);
    final button = IconButton(
      tooltip: context.l10n.shopCart,
      color: AppColors.text,
      onPressed: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const CartScreen())),
      icon: Badge(
        isLabelVisible: count > 0,
        backgroundColor: AppColors.danger,
        label: Text('$count'),
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
    if (!round) return button;
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black26,
      child: button,
    );
  }
}
