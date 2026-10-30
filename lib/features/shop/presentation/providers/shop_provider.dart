import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/locale_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/firestore_shop_repository.dart';
import '../../domain/checkout.dart';
import '../../domain/shop.dart';
import '../../domain/shop_repository.dart';

final shopRepositoryProvider = Provider<ShopRepository>(
  (ref) => FirestoreShopRepository(),
);

final shopConfigProvider = StreamProvider<ShopConfig>(
  (ref) => ref.watch(shopRepositoryProvider).watchConfig(),
);

final shopEnabledProvider = Provider<bool>(
  (ref) => ref.watch(shopConfigProvider).value?.enabled ?? false,
);

// Users are refused while the shop is off, so these listen again when it opens.
final shopCategoriesProvider = StreamProvider<List<ShopCategory>>((ref) {
  ref.watch(shopEnabledProvider);
  return ref.watch(shopRepositoryProvider).watchCategories();
});

final shopBrandsProvider = StreamProvider<List<Brand>>((ref) {
  ref.watch(shopEnabledProvider);
  return ref.watch(shopRepositoryProvider).watchBrands();
});

final shopProductsProvider = StreamProvider<List<Product>>((ref) {
  ref.watch(shopEnabledProvider);
  return ref.watch(shopRepositoryProvider).watchProducts();
});

final allShopCategoriesProvider = StreamProvider<List<ShopCategory>>(
  (ref) => ref.watch(shopRepositoryProvider).watchCategories(all: true),
);

final allBrandsProvider = StreamProvider<List<Brand>>(
  (ref) => ref.watch(shopRepositoryProvider).watchBrands(all: true),
);

final allProductsProvider = StreamProvider<List<Product>>(
  (ref) => ref.watch(shopRepositoryProvider).watchProducts(all: true),
);

final suppliersProvider = StreamProvider<List<Supplier>>(
  (ref) => ref.watch(shopRepositoryProvider).watchSuppliers(),
);

final myPetSpeciesProvider = Provider<Set<PetSpecies>>(
  (ref) => {
    for (final pet in ref.watch(myPetsProvider).value ?? const <Pet>[])
      pet.species,
  },
);

class ShopCatalog {
  final List<ShopCategory> categories;
  final Map<String, Brand> brands;
  final List<Product> products;

  const ShopCatalog({
    required this.categories,
    required this.brands,
    required this.products,
  });

  String brandName(Product p) => brands[p.draft.brandId]?.name ?? '';
}

// What users see, already filtered and sorted with their own pets first.
final shopCatalogProvider = Provider<AsyncValue<ShopCatalog>>((ref) {
  final config = ref.watch(shopConfigProvider);
  final categories = ref.watch(shopCategoriesProvider);
  final brands = ref.watch(shopBrandsProvider);
  final products = ref.watch(shopProductsProvider);
  for (final state in <AsyncValue<Object>>[
    config,
    categories,
    brands,
    products,
  ]) {
    if (!state.hasValue) {
      return state.hasError
          ? AsyncValue.error(state.error!, state.stackTrace!)
          : const AsyncValue.loading();
    }
  }
  final byId = {for (final c in categories.value!) c.id: c};
  final brandIds = {for (final b in brands.value!) b.id};
  return AsyncValue.data(
    ShopCatalog(
      categories: categories.value!,
      brands: {for (final b in brands.value!) b.id: b},
      products: sortForUser(
        products.value!.where(
          (p) => visibleToUsers(p, config.value!, byId, brandIds),
        ),
        ref.watch(myPetSpeciesProvider),
      ),
    ),
  );
});

final shippingConfigProvider = StreamProvider<ShippingConfig>(
  (ref) => ref.watch(shopRepositoryProvider).watchShipping(),
);

final productCostsProvider = StreamProvider<Map<String, int>>(
  (ref) => ref.watch(shopRepositoryProvider).watchCosts(),
);

final affiliateClicksProvider = FutureProvider.family<int, String?>(
  (ref, productId) => ref
      .watch(shopRepositoryProvider)
      .countAffiliateClicks(productId: productId),
);

final affiliateClicks30DaysProvider = FutureProvider<int>(
  (ref) => ref
      .watch(shopRepositoryProvider)
      .countAffiliateClicks(
        since: DateTime.now().subtract(const Duration(days: 30)),
      ),
);

// Kept on the phone, one cart per account.
class CartNotifier extends Notifier<List<CartLine>> {
  String get _key => 'shop_cart_${ref.read(authStateProvider).value?.uid}';

  @override
  List<CartLine> build() {
    ref.watch(authStateProvider.select((a) => a.value?.uid));
    try {
      final raw = ref.read(sharedPreferencesProvider).getString(_key);
      if (raw == null) return const [];
      return [
        for (final item in jsonDecode(raw) as List)
          if (item is Map && item['p'] is String && item['q'] is int)
            CartLine(item['p'] as String, item['q'] as int),
      ];
    } catch (e) {
      debugPrint('Cart not read: $e');
      return const [];
    }
  }

  void _save(List<CartLine> lines) {
    state = lines;
    ref
        .read(sharedPreferencesProvider)
        .setString(
          _key,
          jsonEncode([
            for (final l in lines) {'p': l.productId, 'q': l.quantity},
          ]),
        );
  }

  int quantityOf(String productId) =>
      state.where((l) => l.productId == productId).firstOrNull?.quantity ?? 0;

  void add(String productId) =>
      setQuantity(productId, quantityOf(productId) + 1);

  void setQuantity(String productId, int quantity) {
    final q = quantity.clamp(0, CartLine.maxQuantity);
    final lines = [
      for (final l in state)
        if (l.productId != productId) l,
    ];
    final at = state.indexWhere((l) => l.productId == productId);
    if (q > 0) {
      lines.insert(at < 0 ? lines.length : at, CartLine(productId, q));
    }
    _save(lines);
  }

  void remove(String productId) => setQuantity(productId, 0);

  void clear() => _save(const []);
}

final cartProvider = NotifierProvider<CartNotifier, List<CartLine>>(
  CartNotifier.new,
);

final cartCountProvider = Provider<int>((ref) {
  final products = <String, Product>{
    for (final p in ref.watch(shopCatalogProvider).value?.products ?? const [])
      p.id: p,
  };
  return summarizeCart(ref.watch(cartProvider), products).count;
});
