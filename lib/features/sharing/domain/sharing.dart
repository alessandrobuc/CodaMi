// The public report page (functions/src/sharingFunctions.ts, /r/** in firebase.json).
const reportPageBase = 'https://codami-cd91e.web.app/r/';

// Must match SHARE_TARGETS in functions/src/sharing.ts.
enum ShareTarget { whatsapp, facebook, instagram, tiktok, more, save, copy, qr }

enum ShareKind { announce, reunited }

// [source] tells the page which app the visitor came from.
String reportLink(String id, {String? lang, ShareTarget? source}) {
  final query = {'l': ?lang, 's': ?source?.name};
  return Uri.parse(
    '$reportPageBase$id',
  ).replace(queryParameters: query.isEmpty ? null : query).toString();
}

// The report id in codami://report/<id> or https://…/r/<id>.
String? reportIdOfLink(Uri uri) {
  final id = switch (uri) {
    Uri(scheme: 'codami', host: 'report') => uri.pathSegments.firstOrNull,
    Uri(scheme: 'https', pathSegments: ['r', final id, ...]) => id,
    _ => null,
  };
  return id != null && RegExp(r'^[A-Za-z0-9_-]{1,128}$').hasMatch(id)
      ? id
      : null;
}

String cityTag(String city) => city
    .replaceAll(RegExp(r"[\s'’\-.]+"), '')
    .replaceAll(RegExp(r'[^\p{L}\p{N}]', unicode: true), '');

class SharingConfig {
  // The pop-up after publishing or resolving; share buttons are always there.
  final bool popup;

  const SharingConfig({this.popup = false});

  factory SharingConfig.fromMap(Map<String, dynamic>? map) =>
      SharingConfig(popup: map?['popup'] == true);
}

class ShareStats {
  final int shares;
  final int views;
  final Map<String, int> byTarget;
  final Map<String, int> viewsBy;

  const ShareStats({
    this.shares = 0,
    this.views = 0,
    this.byTarget = const {},
    this.viewsBy = const {},
  });

  static Map<String, int> _counts(Object? v) => {
    if (v is Map)
      for (final e in v.entries)
        if (e.key is String && e.value is num)
          e.key as String: (e.value as num).toInt(),
  };

  factory ShareStats.fromMap(Map<String, dynamic>? map) => ShareStats(
    shares: (map?['shares'] as num?)?.toInt() ?? 0,
    views: (map?['views'] as num?)?.toInt() ?? 0,
    byTarget: _counts(map?['byTarget']),
    viewsBy: _counts(map?['viewsBy']),
  );

  ShareStats operator +(ShareStats o) {
    Map<String, int> add(Map<String, int> a, Map<String, int> b) => {
      for (final k in {...a.keys, ...b.keys}) k: (a[k] ?? 0) + (b[k] ?? 0),
    };
    return ShareStats(
      shares: shares + o.shares,
      views: views + o.views,
      byTarget: add(byTarget, o.byTarget),
      viewsBy: add(viewsBy, o.viewsBy),
    );
  }
}

// Weekly push asking users to share CodaMi (functions/src/shareReminders.ts).
class ShareReminderConfig {
  final bool enabled;
  final int firstDays;
  final int everyDays;
  final int maxCount;

  const ShareReminderConfig({
    this.enabled = false,
    this.firstDays = 3,
    this.everyDays = 7,
    this.maxCount = 8,
  });

  static bool validFirst(int v) => v >= 1 && v <= 60;
  static bool validEvery(int v) => v >= 3 && v <= 60;
  static bool validMax(int v) => v >= 1 && v <= 52;

  factory ShareReminderConfig.fromMap(Map<String, dynamic>? map) {
    int read(String key, bool Function(int) valid, int fallback) =>
        switch (map?[key]) {
          final int v when valid(v) => v,
          _ => fallback,
        };
    return ShareReminderConfig(
      enabled: map?['enabled'] == true,
      firstDays: read('firstDays', validFirst, 3),
      everyDays: read('everyDays', validEvery, 7),
      maxCount: read('maxCount', validMax, 8),
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'firstDays': firstDays,
    'everyDays': everyDays,
    'maxCount': maxCount,
  };

  ShareReminderConfig copyWith({
    bool? enabled,
    int? firstDays,
    int? everyDays,
    int? maxCount,
  }) => ShareReminderConfig(
    enabled: enabled ?? this.enabled,
    firstDays: firstDays ?? this.firstDays,
    everyDays: everyDays ?? this.everyDays,
    maxCount: maxCount ?? this.maxCount,
  );
}

class ShareReminderStats {
  final int sent;
  final int opened;
  final int shares;

  const ShareReminderStats({this.sent = 0, this.opened = 0, this.shares = 0});

  factory ShareReminderStats.fromMap(Map<String, dynamic>? map) =>
      ShareReminderStats(
        sent: (map?['sent'] as num?)?.toInt() ?? 0,
        opened: (map?['opened'] as num?)?.toInt() ?? 0,
        shares: (map?['shares'] as num?)?.toInt() ?? 0,
      );

  ShareReminderStats operator +(ShareReminderStats o) => ShareReminderStats(
    sent: sent + o.sent,
    opened: opened + o.opened,
    shares: shares + o.shares,
  );

  // Percent of sent reminders that were opened.
  int get openRate => sent == 0 ? 0 : (opened * 100 / sent).round();
}

// Set when the app opens from a share reminder, so no other prompt shows that day.
DateTime? shareReminderOpenedAt;

bool openedShareReminderToday(DateTime now) {
  final at = shareReminderOpenedAt;
  return at != null &&
      at.year == now.year &&
      at.month == now.month &&
      at.day == now.day;
}
