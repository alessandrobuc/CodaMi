import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/shop.dart';
import '../providers/shop_provider.dart';
import '../widgets/shop_widgets.dart';
import 'admin_catalog_screens.dart';
import 'admin_products_screen.dart';
import 'admin_shipping_screen.dart';
import 'shop_screen.dart';

class AdminShopScreen extends ConsumerStatefulWidget {
  const AdminShopScreen({super.key});

  @override
  ConsumerState<AdminShopScreen> createState() => _AdminShopScreenState();
}

class _AdminShopScreenState extends ConsumerState<AdminShopScreen> {
  bool _saving = false;

  Future<void> _save(ShopConfig config) async {
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(shopRepositoryProvider)
          .saveConfig(config, adminId: adminId);
      if (mounted) {
        SnackbarUtils.showSuccess(context, context.l10n.settingsSaved);
      }
    } catch (e) {
      debugPrint('Shop settings not saved: $e');
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _toggleShop(ShopConfig config, bool on) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(on ? l10n.shopTurnOnTitle : l10n.shopTurnOffTitle),
        content: Text(on ? l10n.shopTurnOnBody : l10n.shopTurnOffBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: on ? AppColors.primary : AppColors.danger,
            ),
            child: Text(on ? l10n.shopTurnOn : l10n.shopTurnOff),
          ),
        ],
      ),
    );
    if (confirmed == true) await _save(config.copyWith(enabled: on));
  }

  void _push(Widget screen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(shopConfigProvider);
    final config = state.value;
    final products = ref.watch(allProductsProvider).value;
    final categories = ref.watch(allShopCategoriesProvider).value;
    final brands = ref.watch(allBrandsProvider).value;
    final suppliers = ref.watch(suppliersProvider).value;
    final busy = _saving || config == null;

    String count(List<Object>? items) => items == null ? '' : '${items.length}';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.shop),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: settingsListPadding(context),
        children: [
          SettingsHeader(
            icon: Icons.storefront_rounded,
            color: shopColor,
            title: l10n.shop,
            text: l10n.shopAdminIntro,
          ),
          if (state.hasError && config == null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                l10n.actionFailed,
                style: const TextStyle(color: AppColors.danger),
              ),
            ),
          SettingsSection(
            title: l10n.shopOpenSwitch,
            icon: config?.enabled == true
                ? Icons.toggle_on_rounded
                : Icons.toggle_off_rounded,
            color: config?.enabled == true
                ? AppColors.primary
                : AppColors.textMuted,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: config?.enabled ?? false,
                onChanged: busy ? null : (on) => _toggleShop(config, on),
                title: Text(
                  config?.enabled == true ? l10n.shopOnHelp : l10n.shopOffHelp,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          SettingsSection(
            title: l10n.shopSalesModels,
            icon: Icons.tune_rounded,
            color: shopColor,
            children: [
              ShopHelpText(l10n.shopSalesModelsHelp),
              for (final model in SalesModel.values)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: Icon(model.icon, color: shopColor),
                  value: !(config?.disabledModels.contains(model) ?? false),
                  onChanged: busy
                      ? null
                      : (on) => _save(
                          config.copyWith(
                            disabledModels: on
                                ? ({...config.disabledModels}..remove(model))
                                : {...config.disabledModels, model},
                          ),
                        ),
                  title: Text(
                    model.label(l10n),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  subtitle: Text(
                    model.help(l10n),
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
            ],
          ),
          SettingsSection(
            title: l10n.shopCatalog,
            icon: Icons.inventory_rounded,
            color: shopColor,
            children: [
              _Link(
                icon: Icons.shopping_bag_rounded,
                title: l10n.shopProducts,
                trailing: products == null
                    ? ''
                    : l10n.shopProductsCount(
                        products.where((p) => p.draft.active).length,
                        products.length,
                      ),
                onTap: () => _push(const AdminProductsScreen()),
              ),
              _Link(
                icon: Icons.category_rounded,
                title: l10n.shopCategories,
                trailing: count(categories),
                onTap: () => _push(const AdminCategoriesScreen()),
              ),
              _Link(
                icon: Icons.verified_rounded,
                title: l10n.shopBrands,
                trailing: count(brands),
                onTap: () => _push(const AdminBrandsScreen()),
              ),
              _Link(
                icon: Icons.local_shipping_rounded,
                title: l10n.shopSuppliers,
                trailing: count(suppliers),
                onTap: () => _push(const AdminSuppliersScreen()),
              ),
              _Link(
                icon: Icons.local_shipping_outlined,
                title: l10n.shopShipping,
                onTap: () => _push(const AdminShippingScreen()),
              ),
              _Link(
                icon: Icons.ads_click_rounded,
                title: l10n.shopAffiliateClicks,
                subtitle: l10n.shopLast30Days,
                trailing:
                    ref
                        .watch(affiliateClicks30DaysProvider)
                        .value
                        ?.toString() ??
                    '',
                onTap: () => ref.invalidate(affiliateClicks30DaysProvider),
              ),
              _Link(
                icon: Icons.visibility_rounded,
                title: l10n.shopPreview,
                subtitle: l10n.shopPreviewSubtitle,
                onTap: () => _push(const ShopScreen(preview: true)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Link extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String trailing;
  final VoidCallback onTap;

  const _Link({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing = '',
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(icon, color: shopColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 12.5,
                color: AppColors.textMuted,
              ),
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing.isNotEmpty)
            Text(
              trailing,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
