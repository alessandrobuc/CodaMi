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
