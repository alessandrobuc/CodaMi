import 'package:flutter_test/flutter_test.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/shop/domain/shop.dart';

void main() {
  Product product(
    String id, {
    String name = 'Dog food',
    String categoryId = 'food',
    String brandId = '',
    String supplierId = '',
    SalesModel model = SalesModel.ownStock,
    Set<PetSpecies> animals = const {},
    Availability availability = Availability.inStock,
    bool active = true,
    int? price = 1290,
    int? compareAt,
    DateTime? updatedAt,
  }) => Product(
    id: id,
    draft: ProductDraft(
      name: name,
      categoryId: categoryId,
      brandId: brandId,
      supplierId: supplierId,
      salesModel: model,
      animals: animals,
      availability: availability,
      active: active,
      priceCents: price,
      compareAtCents: compareAt,
    ),
    updatedAt: updatedAt,
  );

  test('prices are read in euros and cents', () {
    expect(parsePriceCents('12'), 1200);
    expect(parsePriceCents('12.5'), 1250);
    expect(parsePriceCents(' 12,90 '), 1290);
    expect(parsePriceCents('0.99'), 99);
    expect(parsePriceCents('12.999'), isNull);
    expect(parsePriceCents('-3'), isNull);
    expect(parsePriceCents('abc'), isNull);
    expect(parsePriceCents(''), isNull);
    expect(priceInput(1290), '12.90');
    expect(priceInput(1200), '12');
    expect(priceInput(null), '');
  });

  test('the shop is off until an admin turns it on', () {
    expect(ShopConfig.fromMap(null).enabled, isFalse);
    final config = ShopConfig.fromMap({
      'enabled': true,
      'disabledSuppliers': ['s1', 3],
      'disabledModels': ['affiliate', 'unknown'],
    });
    expect(config.enabled, isTrue);
    expect(config.disabledSuppliers, {'s1'});
    expect(config.disabledModels, {SalesModel.affiliate});
    expect(ShopConfig.fromMap(config.toMap()).disabledModels, {
      SalesModel.affiliate,
    });
  });

  test('product checks', () {
    expect(productProblems(product('a').draft), isEmpty);
    expect(productProblems(product('a', name: '  ', categoryId: '').draft), {
      ProductProblem.name,
      ProductProblem.category,
    });
    expect(productProblems(product('a', price: null).draft), {
      ProductProblem.price,
    });
    expect(productProblems(product('a', price: -1).draft), {
      ProductProblem.price,
    });
    expect(productProblems(product('a', compareAt: 1000).draft), {
      ProductProblem.compareAt,
    });
    expect(productProblems(product('a', compareAt: 1590).draft), isEmpty);
  });

  test('affiliate products need a link and a partner, not a price', () {
    const base = ProductDraft(
      name: 'Harness',
      categoryId: 'acc',
      salesModel: SalesModel.affiliate,
    );
    expect(productProblems(base), {
      ProductProblem.affiliateUrl,
      ProductProblem.partner,
    });
    const ok = ProductDraft(
      name: 'Harness',
      categoryId: 'acc',
      salesModel: SalesModel.affiliate,
      affiliateUrl: 'https://www.amazon.it/dp/B000?tag=codami-21',
      partnerName: 'Amazon',
      supplierId: 's1',
    );
    expect(productProblems(ok), isEmpty);
    expect(ok.trimmed().supplierId, isEmpty);
    expect(isShopLink('http://amazon.it/x'), isFalse);
    expect(isShopLink('https://user@evil.com/x'), isFalse);
  });

  test('discounts', () {
    final p = product('a', price: 750, compareAt: 1000);
    expect(p.onSale, isTrue);
    expect(p.discountPercent, 25);
    expect(product('b').onSale, isFalse);
  });

  test(
    'users only see products whose category, brand, supplier and model are on',
    () {
      final categories = {
        'food': const ShopCategory(id: 'food', name: 'Food'),
        'dry': const ShopCategory(id: 'dry', name: 'Dry', parentId: 'food'),
        'orphan': const ShopCategory(id: 'orphan', name: 'X', parentId: 'gone'),
      };
      const config = ShopConfig(
        enabled: true,
        disabledSuppliers: {'s-off'},
        disabledModels: {SalesModel.dropship},
      );
      bool visible(Product p) =>
          visibleToUsers(p, config, categories, {'brand-on'});

      expect(visible(product('a')), isTrue);
      expect(visible(product('b', categoryId: 'dry')), isTrue);
      expect(visible(product('c', active: false)), isFalse);
      expect(visible(product('d', categoryId: 'hidden')), isFalse);
      expect(visible(product('e', categoryId: 'orphan')), isFalse);
      expect(visible(product('f', brandId: 'brand-on')), isTrue);
      expect(visible(product('g', brandId: 'brand-off')), isFalse);
      expect(visible(product('h', supplierId: 's-off')), isFalse);
      expect(visible(product('i', model: SalesModel.dropship)), isFalse);
    },
  );

  test('search, animal filter and sub-categories', () {
    final p = product(
      'a',
      name: 'Grain-free Dry Food',
      animals: {PetSpecies.dog},
    );
    expect(matchesSearch(p, 'dry food'), isTrue);
    expect(matchesSearch(p, 'royal', brandName: 'Royal Canin'), isTrue);
    expect(matchesSearch(p, 'cat'), isFalse);
    expect(forAnimal(p, PetSpecies.dog), isTrue);
    expect(forAnimal(p, PetSpecies.cat), isFalse);
    expect(forAnimal(product('b'), PetSpecies.cat), isTrue);

    const all = [
      ShopCategory(id: 'food', name: 'Food'),
      ShopCategory(id: 'wet', name: 'Wet', parentId: 'food', order: 2),
      ShopCategory(id: 'dry', name: 'Dry', parentId: 'food', order: 1),
      ShopCategory(id: 'toys', name: 'Toys'),
    ];
    expect(categoryBranch(all, 'food'), {'food', 'wet', 'dry'});
    expect(subCategories(all, 'food').map((c) => c.id), ['dry', 'wet']);
  });

  test(
    "products for the user's pets come first, then ones in stock, then newest",
    () {
      final sorted = sortForUser(
        [
          product('old', updatedAt: DateTime(2026, 1, 1)),
          product('new', updatedAt: DateTime(2026, 6, 1)),
          product('cat', animals: {PetSpecies.cat}, updatedAt: DateTime(2025)),
          product(
            'cat-out',
            animals: {PetSpecies.cat},
            availability: Availability.outOfStock,
            updatedAt: DateTime(2026, 9, 1),
          ),
        ],
        {PetSpecies.cat},
      );
      expect(sorted.map((p) => p.id), ['cat', 'cat-out', 'new', 'old']);
    },
  );
}
