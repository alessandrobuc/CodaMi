import 'shop.dart';

class ShippingZone {
  final String id;
  final String name;
  final bool active;

  const ShippingZone({
    required this.id,
    required this.name,
    this.active = true,
  });

  Map<String, Object> toMap() => {'id': id, 'name': name, 'active': active};

  factory ShippingZone.fromMap(Map map) => ShippingZone(
    id: map['id'] as String? ?? '',
    name: map['name'] as String? ?? '',
    active: map['active'] != false,
  );
}

class ShippingMethod {
  final String id;
  final String name;
  final String deliveryTime;
  // Zone id → price in cents. A zone that is missing isn't served.
  final Map<String, int> prices;
  final int? freeAboveCents;
  final bool active;

  const ShippingMethod({
    required this.id,
    required this.name,
    this.deliveryTime = '',
    this.prices = const {},
    this.freeAboveCents,
    this.active = true,
  });

  bool serves(String zoneId) => active && prices.containsKey(zoneId);

  int? costFor(String zoneId, int subtotalCents) {
    final price = prices[zoneId];
    if (!active || price == null) return null;
    final free = freeAboveCents;
    return free != null && subtotalCents >= free ? 0 : price;
  }

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'deliveryTime': deliveryTime,
    'prices': prices,
    'freeAboveCents': freeAboveCents,
    'active': active,
  };

  factory ShippingMethod.fromMap(Map map) => ShippingMethod(
    id: map['id'] as String? ?? '',
    name: map['name'] as String? ?? '',
    deliveryTime: map['deliveryTime'] as String? ?? '',
    prices: {
      for (final e in (map['prices'] as Map? ?? const {}).entries)
        if (e.key is String && e.value is num)
          e.key as String: (e.value as num).toInt(),
    },
    freeAboveCents: (map['freeAboveCents'] as num?)?.toInt(),
    active: map['active'] != false,
  );

  ShippingMethod copyWith({
    String? name,
    String? deliveryTime,
    Map<String, int>? prices,
    int? Function()? freeAboveCents,
    bool? active,
  }) => ShippingMethod(
    id: id,
    name: name ?? this.name,
    deliveryTime: deliveryTime ?? this.deliveryTime,
    prices: prices ?? this.prices,
    freeAboveCents: freeAboveCents == null
        ? this.freeAboveCents
        : freeAboveCents(),
    active: active ?? this.active,
  );
}

class ShippingLimits {
  static const zones = 20;
  static const methods = 10;
  static const name = 60;
  static const deliveryTime = 80;
}

class ShippingConfig {
  final List<ShippingZone> zones;
  final List<ShippingMethod> methods;

  const ShippingConfig({this.zones = const [], this.methods = const []});

  bool get isEmpty => zones.isEmpty && methods.isEmpty;

  List<ShippingZone> get activeZones => [
    for (final z in zones)
      if (z.active && methods.any((m) => m.serves(z.id))) z,
  ];

  List<ShippingMethod> methodsFor(String zoneId) => [
    for (final m in methods)
      if (m.serves(zoneId)) m,
  ];

  factory ShippingConfig.fromMap(Map<String, dynamic>? map) => ShippingConfig(
    zones: [
      for (final z in map?['zones'] as List? ?? const [])
        if (z is Map) ShippingZone.fromMap(z),
    ],
    methods: [
      for (final m in map?['methods'] as List? ?? const [])
        if (m is Map) ShippingMethod.fromMap(m),
    ],
  );

  Map<String, Object> toMap() => {
    'zones': [for (final z in zones) z.toMap()],
    'methods': [for (final m in methods) m.toMap()],
  };
}

// The starting setup an admin can add with one tap and then change.
ShippingConfig startingShipping({
  required String italy,
  required String islands,
  required String europe,
  required String standard,
  required String express,
  required String standardTime,
  required String expressTime,
}) => ShippingConfig(
  zones: [
    ShippingZone(id: 'it', name: italy),
    ShippingZone(id: 'islands', name: islands),
    ShippingZone(id: 'eu', name: europe, active: false),
  ],
  methods: [
    ShippingMethod(
      id: 'standard',
      name: standard,
      deliveryTime: standardTime,
      prices: const {'it': 590, 'islands': 990, 'eu': 1490},
      freeAboveCents: 4900,
    ),
    ShippingMethod(
      id: 'express',
      name: express,
      deliveryTime: expressTime,
      prices: const {'it': 990, 'islands': 1490},
    ),
  ],
);

class CartLine {
  final String productId;
  final int quantity;

  const CartLine(this.productId, this.quantity);

  static const maxQuantity = 20;
}

class CartItem {
  final Product product;
  final int quantity;

  const CartItem(this.product, this.quantity);

  int get totalCents => (product.draft.priceCents ?? 0) * quantity;
}

class CartSummary {
  final List<CartItem> items;
  final int unavailable;
  final int subtotalCents;
  final int? shippingCents;
  final int? freeShippingGapCents;

  const CartSummary({
    required this.items,
    required this.unavailable,
    required this.subtotalCents,
    this.shippingCents,
    this.freeShippingGapCents,
  });

  int get count => items.fold(0, (n, i) => n + i.quantity);
  int get totalCents => subtotalCents + (shippingCents ?? 0);
}

bool canAddToCart(Product p) =>
    !p.draft.isAffiliate &&
    p.draft.priceCents != null &&
    p.draft.availability.canBuy;

// Lines whose product is gone, hidden or no longer for sale are counted
// as unavailable and left out of the totals.
CartSummary summarizeCart(
  List<CartLine> lines,
  Map<String, Product> products, {
  ShippingMethod? method,
  String? zoneId,
}) {
  final items = <CartItem>[];
  var unavailable = 0;
  for (final line in lines) {
    final p = products[line.productId];
    if (p == null || !canAddToCart(p)) {
      unavailable++;
    } else {
      items.add(CartItem(p, line.quantity.clamp(1, CartLine.maxQuantity)));
    }
  }
  final subtotal = items.fold(0, (sum, i) => sum + i.totalCents);
  final shipping = method == null || zoneId == null || items.isEmpty
      ? null
      : method.costFor(zoneId, subtotal);
  final free = method?.freeAboveCents;
  return CartSummary(
    items: items,
    unavailable: unavailable,
    subtotalCents: subtotal,
    shippingCents: shipping,
    freeShippingGapCents:
        free != null && shipping != null && shipping > 0 && subtotal < free
        ? free - subtotal
        : null,
  );
}
