import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/firestore_shop_repository.dart';
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
