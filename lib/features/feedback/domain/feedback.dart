import 'package:cloud_firestore/cloud_firestore.dart';

// Names must match FEEDBACK_TYPES, FEEDBACK_AREAS and FEEDBACK_STATUSES in functions/src/feedback.ts.
enum FeedbackType {
  suggestion,
  bug,
  problem,
  improvement,
  general;

  static const choices = [suggestion, bug, problem, improvement];

  static FeedbackType of(Object? value) =>
      values.where((t) => t.name == value).firstOrNull ?? general;
}

enum FeedbackArea {
  general,
  reports,
  map,
  walks,
  sitting,
  schedule,
  heat,
  scanner,
  shop,
  sharing;

  static FeedbackArea of(Object? value) =>
      values.where((a) => a.name == value).firstOrNull ?? general;
}

enum FeedbackStatus {
  open('new'),
  progress('in_progress'),
  done('done');

  final String value;

  const FeedbackStatus(this.value);

  static FeedbackStatus of(Object? value) =>
      values.where((s) => s.value == value).firstOrNull ?? open;
}

const feedbackCommentMax = 1000;
const feedbackNoteMax = 500;
// New accounts are left alone for a few days.
const feedbackNewAccountDays = 3;
// The general question: only for regular users, and only on some app starts.
const feedbackGeneralActiveDays = 10;
const feedbackGeneralChance = 0.25;

bool feedbackReady(int rating, String comment) =>
    rating > 0 || comment.trim().length >= 3;

class FeedbackAskConfig {
  final bool enabled;
  final int usesMin;
  final int usesMax;
  final int pauseDays;
  final int maxAsks;

  const FeedbackAskConfig({
    this.enabled = true,
    this.usesMin = 10,
    this.usesMax = 20,
    this.pauseDays = 14,
    this.maxAsks = 4,
  });

  static bool validUsesMin(int v) => v >= 1 && v <= 100;
  static bool validUsesMax(int v, int min) => v >= min && v <= 200;
  static bool validPause(int v) => v >= 3 && v <= 90;
  static bool validMax(int v) => v >= 1 && v <= 20;

  factory FeedbackAskConfig.fromMap(Map<String, dynamic>? map) {
    const d = FeedbackAskConfig();
    int read(String key, bool Function(int) valid, int fallback) =>
        switch (map?[key]) {
          final int v when valid(v) => v,
          _ => fallback,
        };
    final min = read('usesMin', validUsesMin, d.usesMin);
    return FeedbackAskConfig(
      enabled: map?['enabled'] != false,
      usesMin: min,
      usesMax: read(
        'usesMax',
        (v) => validUsesMax(v, min),
        d.usesMax < min ? min : d.usesMax,
      ),
      pauseDays: read('pauseDays', validPause, d.pauseDays),
      maxAsks: read('maxAsks', validMax, d.maxAsks),
    );
  }

  Map<String, Object> toMap() => {
    'enabled': enabled,
    'usesMin': usesMin,
    'usesMax': usesMax,
    'pauseDays': pauseDays,
    'maxAsks': maxAsks,
  };

  FeedbackAskConfig copyWith({
    bool? enabled,
    int? usesMin,
    int? usesMax,
    int? pauseDays,
    int? maxAsks,
  }) => FeedbackAskConfig(
    enabled: enabled ?? this.enabled,
    usesMin: usesMin ?? this.usesMin,
    usesMax: usesMax ?? this.usesMax,
    pauseDays: pauseDays ?? this.pauseDays,
    maxAsks: maxAsks ?? this.maxAsks,
  );
}

// Saved on the user's account, so it holds on every phone.
class FeedbackAskState {
  final DateTime? lastAt;
  final int count;
  final Set<FeedbackArea> asked;
  final bool optOut;

  const FeedbackAskState({
    this.lastAt,
    this.count = 0,
    this.asked = const {},
    this.optOut = false,
  });

  factory FeedbackAskState.fromMap(Object? value) {
    final map = value is Map ? value : const {};
    return FeedbackAskState(
      lastAt: switch (map['lastAt']) {
        final Timestamp t => t.toDate(),
        _ => null,
      },
      count: (map['count'] as num?)?.toInt() ?? 0,
      asked: {
        for (final a in map['asked'] as List? ?? const [])
          if (FeedbackArea.values.any((v) => v.name == a)) FeedbackArea.of(a),
      },
      optOut: map['optOut'] == true,
    );
  }
}

// The same number for a user and part of the app every time, inside the range.
int usesNeeded(String uid, FeedbackArea area, FeedbackAskConfig c) {
  var hash = 0x811c9dc5;
  for (final unit in '$uid/${area.name}'.codeUnits) {
    hash = ((hash ^ unit) * 0x01000193) & 0xffffffff;
  }
  return c.usesMin + hash % (c.usesMax - c.usesMin + 1);
}

class FeedbackAskFacts {
  final String uid;
  final DateTime joinedAt;
  final int activeDays;
  final FeedbackAskState state;
  final FeedbackAskConfig config;
  final DateTime? reviewAskedAt;

  const FeedbackAskFacts({
    required this.uid,
    required this.joinedAt,
    required this.activeDays,
    required this.state,
    required this.config,
    this.reviewAskedAt,
  });
}

bool _waited(DateTime? time, DateTime now, int days) =>
    time == null || now.difference(time).inDays >= days;

// The pause also follows the store rating window and the user's own feedback.
bool canAskFeedback(FeedbackAskFacts f, DateTime now) =>
    f.config.enabled &&
    !f.state.optOut &&
    f.state.count < f.config.maxAsks &&
    now.difference(f.joinedAt).inDays >= feedbackNewAccountDays &&
    _waited(f.state.lastAt, now, f.config.pauseDays) &&
    _waited(f.reviewAskedAt, now, f.config.pauseDays);

bool shouldAskAbout(
  FeedbackArea area,
  int uses,
  FeedbackAskFacts f,
  DateTime now,
) =>
    area != FeedbackArea.general &&
    !f.state.asked.contains(area) &&
    uses >= usesNeeded(f.uid, area, f.config) &&
    canAskFeedback(f, now);

// [roll] is a random number from 0 to 1.
bool shouldAskGeneral(FeedbackAskFacts f, DateTime now, double roll) =>
    !f.state.asked.contains(FeedbackArea.general) &&
    f.activeDays >= feedbackGeneralActiveDays &&
    roll < feedbackGeneralChance &&
    canAskFeedback(f, now);

class FeedbackEntry {
  final String id;
  final String uid;
  final String name;
  final String email;
  final FeedbackType type;
  final FeedbackArea area;
  // 0 when no stars were given.
  final int rating;
  final String comment;
  final bool asked;
  final String? screenshotPath;
  final FeedbackStatus status;
  final String note;
  final bool thanked;
  final String? appVersion;
  final String? platform;
  final String? device;
  final String? lang;
  final DateTime? createdAt;

  const FeedbackEntry({
    required this.id,
    required this.uid,
    this.name = '',
    this.email = '',
    this.type = FeedbackType.general,
    this.area = FeedbackArea.general,
    this.rating = 0,
    this.comment = '',
    this.asked = false,
    this.screenshotPath,
    this.status = FeedbackStatus.open,
    this.note = '',
    this.thanked = false,
    this.appVersion,
    this.platform,
    this.device,
    this.lang,
    this.createdAt,
  });

  factory FeedbackEntry.fromMap(String id, Map<String, dynamic> map) {
    String? text(String key) => switch (map[key]) {
      final String s when s.isNotEmpty => s,
      _ => null,
    };
    return FeedbackEntry(
      id: id,
      uid: map['uid'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      type: FeedbackType.of(map['type']),
      area: FeedbackArea.of(map['area']),
      rating: ((map['rating'] as num?)?.toInt() ?? 0).clamp(0, 5),
      comment: map['comment'] as String? ?? '',
      asked: map['asked'] == true,
      screenshotPath: text('screenshotPath'),
      status: FeedbackStatus.of(map['status']),
      note: map['note'] as String? ?? '',
      thanked: map['thankedAt'] != null,
      appVersion: text('appVersion'),
      platform: text('platform'),
      device: text('device'),
      lang: text('lang'),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

class AreaStars {
  final FeedbackArea area;
  final double average;
  final int count;

  const AreaStars(this.area, this.average, this.count);
}

class FeedbackOverview {
  final int total;
  final Map<FeedbackType, int> byType;
  // Lowest average first, so weak spots come first.
  final List<AreaStars> starsByArea;

  const FeedbackOverview({
    this.total = 0,
    this.byType = const {},
    this.starsByArea = const [],
  });
}

FeedbackOverview overviewOf(
  List<FeedbackEntry> entries,
  DateTime now, {
  int days = 30,
}) {
  final since = now.subtract(Duration(days: days));
  final recent = [
    for (final e in entries)
      if (e.createdAt != null && e.createdAt!.isAfter(since)) e,
  ];
  final byType = <FeedbackType, int>{};
  final stars = <FeedbackArea, List<int>>{};
  for (final e in recent) {
    byType[e.type] = (byType[e.type] ?? 0) + 1;
    if (e.rating > 0) (stars[e.area] ??= []).add(e.rating);
  }
  final areas = [
    for (final MapEntry(key: area, value: list) in stars.entries)
      AreaStars(area, list.reduce((a, b) => a + b) / list.length, list.length),
  ]..sort((a, b) => a.average.compareTo(b.average));
  return FeedbackOverview(
    total: recent.length,
    byType: byType,
    starsByArea: areas,
  );
}
