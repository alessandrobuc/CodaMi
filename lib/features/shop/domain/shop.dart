import '../../pets/domain/entities/pets_entity.dart';

enum SalesModel {
  ownStock,
  brandPartner,
  dropship,
  affiliate;

  static SalesModel fromValue(Object? value) => SalesModel.values.firstWhere(
    (m) => m.name == value,
    orElse: () => SalesModel.ownStock,
  );
}

enum Availability {
  inStock,
  lowStock,
  outOfStock,
  comingSoon;

  bool get canBuy => this == inStock || this == lowStock;

  static Availability fromValue(Object? value) => Availability.values
      .firstWhere((a) => a.name == value, orElse: () => Availability.inStock);
}

enum OrderMethod {
  manual,
  email;

  static OrderMethod fromValue(Object? value) => OrderMethod.values.firstWhere(
    (m) => m.name == value,
    orElse: () => OrderMethod.manual,
  );
}

enum CategoryIcon {
  food,
  accessories,
  care,
  toys,
  beds,
  carriers,
  tech,
  other;

  static CategoryIcon fromValue(Object? value) => CategoryIcon.values
      .firstWhere((i) => i.name == value, orElse: () => CategoryIcon.other);
}

class ShopLimits {
  static const name = 120;
  static const description = 4000;
  static const shortText = 80;
  static const url = 500;
  static const notes = 1000;
  static const images = 6;
  static const imageBytes = 5 * 1024 * 1024;
  static const maxPriceCents = 1000000;
  static const listSize = 500;
}

// Off by default: nothing shows to users until an admin turns it on.
class ShopConfig {
  final bool enabled;
  final Set<String> disabledSuppliers;
  final Set<SalesModel> disabledModels;

  const ShopConfig({
    this.enabled = false,
    this.disabledSuppliers = const {},
    this.disabledModels = const {},
  });

  factory ShopConfig.fromMap(Map<String, dynamic>? map) => ShopConfig(
    enabled: map?['enabled'] == true,
    disabledSuppliers: {
      for (final id in map?['disabledSuppliers'] as List? ?? const [])
        if (id is String) id,
    },
    disabledModels: {
      for (final m in map?['disabledModels'] as List? ?? const [])
        if (SalesModel.values.any((v) => v.name == m)) SalesModel.fromValue(m),
    },
  );

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'disabledSuppliers': disabledSuppliers.toList()..sort(),
    'disabledModels': [for (final m in disabledModels) m.name]..sort(),
  };

  ShopConfig copyWith({
    bool? enabled,
    Set<String>? disabledSuppliers,
    Set<SalesModel>? disabledModels,
  }) => ShopConfig(
    enabled: enabled ?? this.enabled,
    disabledSuppliers: disabledSuppliers ?? this.disabledSuppliers,
    disabledModels: disabledModels ?? this.disabledModels,
  );
}

bool isShopLink(String text) {
  final value = text.trim();
  if (value.isEmpty ||
      value.length > ShopLimits.url ||
      RegExp(r'\s').hasMatch(value)) {
    return false;
  }
  final uri = Uri.tryParse(value);
  return uri != null &&
      uri.scheme == 'https' &&
      uri.host.contains('.') &&
      uri.userInfo.isEmpty;
}

// "12", "12.5" and "12,50" are accepted; more than two decimals are not.
int? parsePriceCents(String text) {
  final value = text.trim().replaceAll(',', '.');
  final match = RegExp(r'^(\d{1,6})(?:\.(\d{1,2}))?$').firstMatch(value);
  if (match == null) return null;
  final cents = (match.group(2) ?? '').padRight(2, '0');
  return int.parse(match.group(1)!) * 100 + int.parse(cents);
}

String priceInput(int? cents) {
  if (cents == null) return '';
  final euros = cents ~/ 100;
  final rest = cents % 100;
  return rest == 0 ? '$euros' : '$euros.${rest.toString().padLeft(2, '0')}';
}

class ShopCategory {
  final String id;
  final String name;
  final String parentId;
  final CategoryIcon icon;
  final int order;
  final bool active;

  const ShopCategory({
    required this.id,
    required this.name,
    this.parentId = '',
    this.icon = CategoryIcon.other,
    this.order = 0,
    this.active = true,
  });

  bool get isTop => parentId.isEmpty;
}

class Brand {
  final String id;
  final String name;
  final String description;
  final String website;
  final String? logoUrl;
  final String? logoPath;
  final bool active;

  const Brand({
    required this.id,
    required this.name,
    this.description = '',
    this.website = '',
    this.logoUrl,
    this.logoPath,
    this.active = true,
  });
}

// Admin only: contact details never reach users.
class Supplier {
  final String id;
  final String name;
  final String contactName;
  final String email;
  final String phone;
  final String website;
  final OrderMethod orderMethod;
  final String notes;
  final bool active;

  const Supplier({
    required this.id,
    required this.name,
    this.contactName = '',
    this.email = '',
    this.phone = '',
    this.website = '',
    this.orderMethod = OrderMethod.manual,
    this.notes = '',
    this.active = true,
  });
}

bool isEmail(String text) =>
    RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(text.trim());

class ShopImage {
  final String url;
  final String path;

  const ShopImage({required this.url, required this.path});

  Map<String, String> toMap() => {'url': url, 'path': path};
}

class ProductDraft {
  final String name;
  final String description;
  final String categoryId;
  final String brandId;
  final String supplierId;
  final SalesModel salesModel;
  final Set<PetSpecies> animals;
  final int? priceCents;
  final int? compareAtCents;
  final Availability availability;
  final String affiliateUrl;
  final String partnerName;
  final bool active;
  final bool sponsored;
  final DateTime? sponsorStart;
  final DateTime? sponsorEnd;

  const ProductDraft({
    required this.name,
    this.description = '',
    required this.categoryId,
    this.brandId = '',
    this.supplierId = '',
    this.salesModel = SalesModel.ownStock,
    this.animals = const {},
    this.priceCents,
    this.compareAtCents,
    this.availability = Availability.inStock,
    this.affiliateUrl = '',
    this.partnerName = '',
    this.active = false,
    this.sponsored = false,
    this.sponsorStart,
    this.sponsorEnd,
  });

  bool get isAffiliate => salesModel == SalesModel.affiliate;

  // Dates are whole days: the campaign runs to the end of [sponsorEnd].
  bool sponsoredAt(DateTime now) =>
      sponsored &&
      (sponsorStart == null || !now.isBefore(sponsorStart!)) &&
      (sponsorEnd == null ||
          now.isBefore(sponsorEnd!.add(const Duration(days: 1))));

  ProductDraft trimmed() => ProductDraft(
    name: name.trim(),
    description: description.trim(),
    categoryId: categoryId,
    brandId: brandId,
    supplierId: isAffiliate ? '' : supplierId,
    salesModel: salesModel,
    animals: animals,
    priceCents: priceCents,
    compareAtCents: compareAtCents,
    availability: availability,
    affiliateUrl: isAffiliate ? affiliateUrl.trim() : '',
    partnerName: isAffiliate ? partnerName.trim() : '',
    active: active,
    sponsored: sponsored,
    sponsorStart: sponsored ? sponsorStart : null,
    sponsorEnd: sponsored ? sponsorEnd : null,
  );
}

enum ProductProblem {
  name,
  category,
  price,
  compareAt,
  affiliateUrl,
  partner,
  sponsorDates,
}

// Affiliate prices change on the partner's site, so they are optional.
Set<ProductProblem> productProblems(ProductDraft draft) {
  final d = draft.trimmed();
  final price = d.priceCents;
  final compare = d.compareAtCents;
  return {
    if (d.name.isEmpty || d.name.length > ShopLimits.name) ProductProblem.name,
    if (d.categoryId.isEmpty) ProductProblem.category,
    if ((price == null && !d.isAffiliate) ||
        (price != null && (price <= 0 || price > ShopLimits.maxPriceCents)))
      ProductProblem.price,
    if (compare != null && (price == null || compare <= price))
      ProductProblem.compareAt,
    if (d.isAffiliate && !isShopLink(d.affiliateUrl))
      ProductProblem.affiliateUrl,
    if (d.isAffiliate &&
        (d.partnerName.isEmpty || d.partnerName.length > ShopLimits.shortText))
      ProductProblem.partner,
    if (d.sponsorStart != null &&
        d.sponsorEnd != null &&
        d.sponsorEnd!.isBefore(d.sponsorStart!))
      ProductProblem.sponsorDates,
  };
}

class Product {
  final String id;
  final ProductDraft draft;
  final List<ShopImage> images;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.draft,
    this.images = const [],
    this.createdAt,
    this.updatedAt,
  });

  String get name => draft.name;
  String? get cover => images.isEmpty ? null : images.first.url;

  bool get onSale =>
      draft.priceCents != null &&
      draft.compareAtCents != null &&
      draft.compareAtCents! > draft.priceCents!;

  int get discountPercent => onSale
      ? ((1 - draft.priceCents! / draft.compareAtCents!) * 100).round()
      : 0;
}

List<ShopCategory> sortCategories(Iterable<ShopCategory> categories) =>
    categories.toList()..sort(
      (a, b) => a.order != b.order
          ? a.order.compareTo(b.order)
          : a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );

List<ShopCategory> subCategories(List<ShopCategory> all, String parentId) =>
    sortCategories(all.where((c) => c.parentId == parentId));

// A category together with its sub-categories.
Set<String> categoryBranch(List<ShopCategory> all, String id) => {
  id,
  for (final c in all)
    if (c.parentId == id) c.id,
};

// Users only receive active categories and brands, so a product whose
// category, parent category or brand is missing is hidden too.
bool visibleToUsers(
  Product p,
  ShopConfig config,
  Map<String, ShopCategory> categories,
  Set<String> brandIds,
) {
  final d = p.draft;
  final category = categories[d.categoryId];
  return d.active &&
      category != null &&
      (category.isTop || categories.containsKey(category.parentId)) &&
      (d.brandId.isEmpty || brandIds.contains(d.brandId)) &&
      !config.disabledModels.contains(d.salesModel) &&
      (d.supplierId.isEmpty ||
          !config.disabledSuppliers.contains(d.supplierId));
}

bool matchesSearch(Product p, String query, {String brandName = ''}) {
  final words = query.toLowerCase().split(RegExp(r'\s+'))
    ..removeWhere((w) => w.isEmpty);
  if (words.isEmpty) return true;
  final text = '${p.name} $brandName ${p.draft.partnerName}'.toLowerCase();
  return words.every(text.contains);
}

// A product with no animals set is for every animal.
bool forAnimal(Product p, PetSpecies? species) =>
    species == null ||
    p.draft.animals.isEmpty ||
    p.draft.animals.contains(species);

// Sponsored first, then products for the user's own pets, then ones that can
// be bought, then newest.
List<Product> sortForUser(
  Iterable<Product> products,
  Set<PetSpecies> myPets, {
  DateTime? now,
}) {
  final at = now ?? DateTime.now();
  int sponsorRank(Product p) => p.draft.sponsoredAt(at) ? 0 : 1;
  int petRank(Product p) =>
      myPets.isNotEmpty && p.draft.animals.any(myPets.contains) ? 0 : 1;
  int stockRank(Product p) => p.draft.availability.canBuy ? 0 : 1;
  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  return products.toList()..sort((a, b) {
    final sponsor = sponsorRank(a).compareTo(sponsorRank(b));
    if (sponsor != 0) return sponsor;
    final pet = petRank(a).compareTo(petRank(b));
    if (pet != 0) return pet;
    final stock = stockRank(a).compareTo(stockRank(b));
    if (stock != 0) return stock;
    return (b.updatedAt ?? epoch).compareTo(a.updatedAt ?? epoch);
  });
}

class Margin {
  final int cents;
  final int percent;

  const Margin(this.cents, this.percent);
}

// Percent of the selling price that CodaMi keeps.
Margin? marginOf(int? priceCents, int? costCents) {
  if (priceCents == null || priceCents <= 0 || costCents == null) return null;
  final cents = priceCents - costCents;
  return Margin(cents, (cents * 100 / priceCents).round());
}
