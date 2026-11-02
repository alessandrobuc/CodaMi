enum DonationTrigger { afterReport, afterFound }

// Off by default. Store payments (Google Play / App Store) are connected later;
// until then the amounts show "coming soon".
class DonationsConfig {
  final bool enabled;
  final bool showInProfile;
  final bool afterReport;
  final bool afterFound;
  final int daysBetweenPrompts;
  final List<int> amountsCents;
  final bool paymentsReady;

  const DonationsConfig({
    this.enabled = false,
    this.showInProfile = true,
    this.afterReport = true,
    this.afterFound = true,
    this.daysBetweenPrompts = 30,
    this.amountsCents = const [100, 300, 500, 1000, 2500],
    this.paymentsReady = false,
  });

  bool shows(DonationTrigger t) =>
      enabled &&
      switch (t) {
        DonationTrigger.afterReport => afterReport,
        DonationTrigger.afterFound => afterFound,
      };

  factory DonationsConfig.fromMap(Map<String, dynamic>? map) {
    const d = DonationsConfig();
    final days = map?['daysBetweenPrompts'];
    final amounts = [
      for (final a in map?['amountsCents'] as List? ?? const [])
        if (a is int && a > 0 && a <= 100000) a,
    ];
    return DonationsConfig(
      enabled: map?['enabled'] == true,
      showInProfile: map?['showInProfile'] != false,
      afterReport: map?['afterReport'] != false,
      afterFound: map?['afterFound'] != false,
      daysBetweenPrompts: days is int && days >= 1 && days <= 365
          ? days
          : d.daysBetweenPrompts,
      amountsCents: amounts.isEmpty ? d.amountsCents : amounts,
      paymentsReady: map?['paymentsReady'] == true,
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'showInProfile': showInProfile,
    'afterReport': afterReport,
    'afterFound': afterFound,
    'daysBetweenPrompts': daysBetweenPrompts,
    'amountsCents': amountsCents,
    'paymentsReady': paymentsReady,
  };

  DonationsConfig copyWith({
    bool? enabled,
    bool? showInProfile,
    bool? afterReport,
    bool? afterFound,
    int? daysBetweenPrompts,
    List<int>? amountsCents,
  }) => DonationsConfig(
    enabled: enabled ?? this.enabled,
    showInProfile: showInProfile ?? this.showInProfile,
    afterReport: afterReport ?? this.afterReport,
    afterFound: afterFound ?? this.afterFound,
    daysBetweenPrompts: daysBetweenPrompts ?? this.daysBetweenPrompts,
    amountsCents: amountsCents ?? this.amountsCents,
    paymentsReady: paymentsReady,
  );
}

// The prompt after a report or a found pet shows at most once in a while.
bool promptDue(DateTime? lastShown, DateTime now, int days) =>
    lastShown == null || now.difference(lastShown).inDays >= days;

// "1, 3, 5,10 , 25" → [100, 300, 500, 1000, 2500]; null when anything is wrong.
List<int>? parseAmounts(String text) {
  final parts = text.split(RegExp(r'[,;\s]+'))..removeWhere((p) => p.isEmpty);
  if (parts.isEmpty || parts.length > 6) return null;
  final cents = <int>[];
  for (final p in parts) {
    final m = RegExp(r'^(\d{1,3})(?:[.](\d{1,2}))?$').firstMatch(p);
    if (m == null) return null;
    final value =
        int.parse(m.group(1)!) * 100 +
        int.parse((m.group(2) ?? '').padRight(2, '0'));
    if (value <= 0) return null;
    cents.add(value);
  }
  return (cents.toSet().toList()..sort());
}

String amountsInput(List<int> cents) => cents
    .map((c) => c % 100 == 0 ? '${c ~/ 100}' : (c / 100).toStringAsFixed(2))
    .join(', ');
