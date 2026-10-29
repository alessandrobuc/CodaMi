import 'dart:io';

import 'shop.dart';

sealed class ImageSlot {
  const ImageSlot();
}

class SavedImage extends ImageSlot {
  final ShopImage image;

  const SavedImage(this.image);
}

class PickedImage extends ImageSlot {
  final File file;

  const PickedImage(this.file);
}

// The only way the app reads or writes the shop. Firebase is one
// implementation; another backend only needs a new class.
abstract interface class ShopRepository {
  Stream<ShopConfig> watchConfig();

  Future<void> saveConfig(ShopConfig config, {required String adminId});

  // [all] is for admins; users only get active items.
  Stream<List<ShopCategory>> watchCategories({bool all = false});

  Stream<List<Brand>> watchBrands({bool all = false});

  Stream<List<Product>> watchProducts({bool all = false});

  Stream<List<Supplier>> watchSuppliers();

  Future<void> saveCategory(ShopCategory category, {required String adminId});

  Future<void> addStartingCategories(
    List<ShopCategory> categories, {
    required String adminId,
  });

  Future<void> deleteCategory(String id);

  // A [brand] without a logo removes the one [existing] had.
  Future<void> saveBrand(
    Brand brand, {
    required String adminId,
    Brand? existing,
    File? newLogo,
  });

  Future<void> deleteBrand(Brand brand);

  Future<void> saveSupplier(
    Supplier supplier, {
    required String adminId,
    required ShopConfig config,
  });

  Future<void> deleteSupplier(
    String id, {
    required String adminId,
    required ShopConfig config,
  });

  // Creates the product when [existing] is null. Returns its id.
  Future<String> saveProduct({
    Product? existing,
    required ProductDraft draft,
    required List<ImageSlot> images,
    required String adminId,
  });

  Future<void> deleteProduct(Product product);
}
