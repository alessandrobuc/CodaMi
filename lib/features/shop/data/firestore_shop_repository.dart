import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../pets/domain/entities/pets_entity.dart';
import '../domain/checkout.dart';
import '../domain/shop.dart';
import '../domain/shop_repository.dart';

// Images live under `shop/products/{id}/` and `shop/brands/{id}/`; only admins write there.
class FirestoreShopRepository implements ShopRepository {
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  FirestoreShopRepository({FirebaseFirestore? db, FirebaseStorage? storage})
    : _db = db ?? FirebaseFirestore.instance,
      _storage = storage ?? FirebaseStorage.instance;

  DocumentReference<Map<String, dynamic>> get _config =>
      _db.collection('config').doc('shop');
  CollectionReference<Map<String, dynamic>> get _categories =>
      _db.collection('shopCategories');
  CollectionReference<Map<String, dynamic>> get _brands =>
      _db.collection('brands');
  CollectionReference<Map<String, dynamic>> get _suppliers =>
      _db.collection('suppliers');
  CollectionReference<Map<String, dynamic>> get _products =>
      _db.collection('products');
  CollectionReference<Map<String, dynamic>> get _costs =>
      _db.collection('productCosts');
  CollectionReference<Map<String, dynamic>> get _clicks =>
      _db.collection('affiliateClicks');
  DocumentReference<Map<String, dynamic>> get _shipping =>
      _db.collection('config').doc('shipping');

  Query<Map<String, dynamic>> _visible(
    CollectionReference<Map<String, dynamic>> c,
    bool all,
  ) =>
      (all ? c : c.where('active', isEqualTo: true)).limit(ShopLimits.listSize);

  Map<String, Object> _stamp(String adminId) => {
    'updatedBy': adminId,
    'updatedAt': FieldValue.serverTimestamp(),
  };

  @override
  Stream<ShopConfig> watchConfig() =>
      _config.snapshots().map((d) => ShopConfig.fromMap(d.data()));

  @override
  Future<void> saveConfig(ShopConfig config, {required String adminId}) =>
      _config.set({...config.toMap(), ..._stamp(adminId)});

  @override
  Stream<List<ShopCategory>> watchCategories({bool all = false}) =>
      _visible(_categories, all).snapshots().map(
        (s) => sortCategories([
          for (final d in s.docs) categoryFromMap(d.id, d.data()),
        ]),
      );

  @override
  Stream<List<Brand>> watchBrands({bool all = false}) =>
      _visible(_brands, all).snapshots().map(
        (s) => [
          for (final d in s.docs) brandFromMap(d.id, d.data()),
        ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())),
      );

  @override
  Stream<List<Supplier>> watchSuppliers() => _suppliers
      .limit(ShopLimits.listSize)
      .snapshots()
      .map(
        (s) => [
          for (final d in s.docs) supplierFromMap(d.id, d.data()),
        ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())),
      );

  @override
  Stream<List<Product>> watchProducts({bool all = false}) =>
      _visible(_products, all).snapshots().map(
        (s) => [for (final d in s.docs) productFromMap(d.id, d.data())],
      );

  Map<String, Object> _categoryMap(ShopCategory c, String adminId) => {
    'name': c.name.trim(),
    'parentId': c.parentId,
    'icon': c.icon.name,
    'order': c.order,
    'active': c.active,
    ..._stamp(adminId),
  };

  @override
  Future<void> saveCategory(ShopCategory category, {required String adminId}) {
    final doc = category.id.isEmpty
        ? _categories.doc()
        : _categories.doc(category.id);
    return doc.set(_categoryMap(category, adminId));
  }

  @override
  Future<void> addStartingCategories(
    List<ShopCategory> categories, {
    required String adminId,
  }) {
    final batch = _db.batch();
    for (final c in categories) {
      batch.set(_categories.doc(), _categoryMap(c, adminId));
    }
    return batch.commit();
  }

  @override
  Future<void> deleteCategory(String id) => _categories.doc(id).delete();

  @override
  Future<void> saveBrand(
    Brand brand, {
    required String adminId,
    Brand? existing,
    File? newLogo,
  }) async {
    final doc = brand.id.isEmpty ? _brands.doc() : _brands.doc(brand.id);
    String? path = brand.logoPath;
    String? url = brand.logoUrl;
    if (newLogo != null) {
      path = _imagePath('shop/brands/${doc.id}', 'logo', newLogo);
      url = await _upload(path, newLogo);
    }
    try {
      await doc.set({
        'name': brand.name.trim(),
        'description': brand.description.trim(),
        'website': brand.website.trim(),
        'active': brand.active,
        if (url != null && path != null) ...{'logoUrl': url, 'logoPath': path},
        ..._stamp(adminId),
      });
    } catch (_) {
      if (newLogo != null && path != null) await _deleteFile(path);
      rethrow;
    }
    final oldPath = existing?.logoPath;
    if (oldPath != null && oldPath != path) await _deleteFile(oldPath);
  }

  @override
  Future<void> deleteBrand(Brand brand) async {
    await _brands.doc(brand.id).delete();
    if (brand.logoPath != null) await _deleteFile(brand.logoPath!);
  }

  // The supplier's on/off state is copied to config/shop, which users can read.
  @override
  Future<void> saveSupplier(
    Supplier supplier, {
    required String adminId,
    required ShopConfig config,
  }) async {
    final doc = supplier.id.isEmpty
        ? _suppliers.doc()
        : _suppliers.doc(supplier.id);
    final off = {...config.disabledSuppliers};
    supplier.active ? off.remove(doc.id) : off.add(doc.id);
    final batch = _db.batch()
      ..set(doc, {
        'name': supplier.name.trim(),
        'contactName': supplier.contactName.trim(),
        'email': supplier.email.trim(),
        'phone': supplier.phone.trim(),
        'website': supplier.website.trim(),
        'orderMethod': supplier.orderMethod.name,
        'notes': supplier.notes.trim(),
        'active': supplier.active,
        ..._stamp(adminId),
      });
    if (off.length != config.disabledSuppliers.length) {
      batch.set(_config, {
        ...config.copyWith(disabledSuppliers: off).toMap(),
        ..._stamp(adminId),
      });
    }
    await batch.commit();
  }

  @override
  Future<void> deleteSupplier(
    String id, {
    required String adminId,
    required ShopConfig config,
  }) async {
    final batch = _db.batch()..delete(_suppliers.doc(id));
    if (config.disabledSuppliers.contains(id)) {
      final off = {...config.disabledSuppliers}..remove(id);
      batch.set(_config, {
        ...config.copyWith(disabledSuppliers: off).toMap(),
        ..._stamp(adminId),
      });
    }
    await batch.commit();
  }

  @override
  Future<String> saveProduct({
    Product? existing,
    required ProductDraft draft,
    required List<ImageSlot> images,
    required String adminId,
    int? costCents,
  }) async {
    final doc = existing == null ? _products.doc() : _products.doc(existing.id);
    final d = draft.trimmed();

    final uploaded = <String>[];
    final kept = <ShopImage>[];
    try {
      for (final slot in images.take(ShopLimits.images)) {
        switch (slot) {
          case SavedImage(:final image):
            kept.add(image);
          case PickedImage(:final file):
            final path = _imagePath('shop/products/${doc.id}', 'image', file);
            kept.add(ShopImage(url: await _upload(path, file), path: path));
            uploaded.add(path);
        }
      }
      final data = <String, Object?>{
        'name': d.name,
        'description': d.description,
        'categoryId': d.categoryId,
        'brandId': d.brandId,
        'supplierId': d.supplierId,
        'salesModel': d.salesModel.name,
        'animals': [for (final a in d.animals) a.name]..sort(),
        'priceCents': d.priceCents,
        'compareAtCents': d.compareAtCents,
        'availability': d.availability.name,
        'affiliateUrl': d.affiliateUrl,
        'partnerName': d.partnerName,
        'active': d.active,
        'sponsored': d.sponsored,
        'sponsorStart': _day(d.sponsorStart),
        'sponsorEnd': _day(d.sponsorEnd),
        'images': [for (final i in kept) i.toMap()],
        ..._stamp(adminId),
      };
      final batch = _db.batch();
      if (existing == null) {
        batch.set(doc, {
          ...data,
          'createdBy': adminId,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        batch.update(doc, data);
      }
      final cost = _costs.doc(doc.id);
      if (costCents == null) {
        batch.delete(cost);
      } else {
        batch.set(cost, {'costCents': costCents, ..._stamp(adminId)});
      }
      await batch.commit();
    } catch (_) {
      for (final path in uploaded) {
        await _deleteFile(path);
      }
      rethrow;
    }
    final keptPaths = {for (final i in kept) i.path};
    for (final old in existing?.images ?? const <ShopImage>[]) {
      if (!keptPaths.contains(old.path)) await _deleteFile(old.path);
    }
    return doc.id;
  }

  @override
  Future<void> deleteProduct(Product product) async {
    await (_db.batch()
          ..delete(_products.doc(product.id))
          ..delete(_costs.doc(product.id)))
        .commit();
    for (final image in product.images) {
      await _deleteFile(image.path);
    }
  }

  @override
  Stream<Map<String, int>> watchCosts() => _costs.snapshots().map(
    (s) => {
      for (final d in s.docs)
        if (d.data()['costCents'] is num)
          d.id: (d.data()['costCents'] as num).toInt(),
    },
  );

  @override
  Stream<ShippingConfig> watchShipping() =>
      _shipping.snapshots().map((d) => ShippingConfig.fromMap(d.data()));

  @override
  Future<void> saveShipping(ShippingConfig config, {required String adminId}) =>
      _shipping.set({...config.toMap(), ..._stamp(adminId)});

  @override
  Future<void> recordAffiliateClick(Product product, {required String uid}) =>
      _clicks.add({
        'productId': product.id,
        'partner': product.draft.partnerName,
        'uid': uid,
        'at': FieldValue.serverTimestamp(),
      });

  @override
  Future<int> countAffiliateClicks({String? productId, DateTime? since}) async {
    Query<Map<String, dynamic>> q = _clicks;
    if (productId != null) q = q.where('productId', isEqualTo: productId);
    if (since != null) {
      q = q.where('at', isGreaterThanOrEqualTo: Timestamp.fromDate(since));
    }
    return (await q.count().get()).count ?? 0;
  }

  static Timestamp? _day(DateTime? d) =>
      d == null ? null : Timestamp.fromDate(DateTime(d.year, d.month, d.day));

  Future<String> _upload(String path, File file) async {
    final ref = _storage.ref(path);
    await ref.putFile(file, SettableMetadata(contentType: _contentType(path)));
    return ref.getDownloadURL();
  }

  Future<void> _deleteFile(String path) async {
    try {
      await _storage.ref(path).delete();
    } catch (e) {
      debugPrint('Could not delete $path: $e');
    }
  }

  // A new name each time, so cached copies of an old image aren't reused.
  static String _imagePath(String folder, String prefix, File file) {
    final dot = file.path.lastIndexOf('.');
    final ext = dot < 0 ? 'jpg' : file.path.substring(dot + 1).toLowerCase();
    final safe = const {'jpg', 'jpeg', 'png', 'webp'}.contains(ext)
        ? ext
        : 'jpg';
    final stamp = DateTime.now().microsecondsSinceEpoch;
    return '$folder/${prefix}_$stamp.$safe';
  }

  static String _contentType(String path) => switch (path.split('.').last) {
    'png' => 'image/png',
    'webp' => 'image/webp',
    _ => 'image/jpeg',
  };
}

String _text(Map<String, dynamic> map, String key) => map[key] as String? ?? '';

DateTime? _date(Map<String, dynamic> map, String key) =>
    (map[key] as Timestamp?)?.toDate();

ShopCategory categoryFromMap(String id, Map<String, dynamic> map) =>
    ShopCategory(
      id: id,
      name: _text(map, 'name'),
      parentId: _text(map, 'parentId'),
      icon: CategoryIcon.fromValue(map['icon']),
      order: (map['order'] as num?)?.toInt() ?? 0,
      active: map['active'] == true,
    );

Brand brandFromMap(String id, Map<String, dynamic> map) => Brand(
  id: id,
  name: _text(map, 'name'),
  description: _text(map, 'description'),
  website: _text(map, 'website'),
  logoUrl: map['logoUrl'] as String?,
  logoPath: map['logoPath'] as String?,
  active: map['active'] == true,
);

Supplier supplierFromMap(String id, Map<String, dynamic> map) => Supplier(
  id: id,
  name: _text(map, 'name'),
  contactName: _text(map, 'contactName'),
  email: _text(map, 'email'),
  phone: _text(map, 'phone'),
  website: _text(map, 'website'),
  orderMethod: OrderMethod.fromValue(map['orderMethod']),
  notes: _text(map, 'notes'),
  active: map['active'] == true,
);

Product productFromMap(String id, Map<String, dynamic> map) => Product(
  id: id,
  draft: ProductDraft(
    name: _text(map, 'name'),
    description: _text(map, 'description'),
    categoryId: _text(map, 'categoryId'),
    brandId: _text(map, 'brandId'),
    supplierId: _text(map, 'supplierId'),
    salesModel: SalesModel.fromValue(map['salesModel']),
    animals: {
      for (final a in map['animals'] as List? ?? const [])
        if (a is String) PetSpecies.fromValue(a),
    },
    priceCents: (map['priceCents'] as num?)?.toInt(),
    compareAtCents: (map['compareAtCents'] as num?)?.toInt(),
    availability: Availability.fromValue(map['availability']),
    affiliateUrl: _text(map, 'affiliateUrl'),
    partnerName: _text(map, 'partnerName'),
    active: map['active'] == true,
    sponsored: map['sponsored'] == true,
    sponsorStart: _date(map, 'sponsorStart'),
    sponsorEnd: _date(map, 'sponsorEnd'),
  ),
  images: [
    for (final i in map['images'] as List? ?? const [])
      if (i is Map && i['url'] is String && i['path'] is String)
        ShopImage(url: i['url'] as String, path: i['path'] as String),
  ],
  createdAt: _date(map, 'createdAt'),
  updatedAt: _date(map, 'updatedAt'),
);
