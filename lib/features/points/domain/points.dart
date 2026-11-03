import 'package:cloud_firestore/cloud_firestore.dart';

enum DailyTask {
  checkin,
  active;

  static DailyTask? fromValue(Object? value) =>
      values.where((t) => t.name == value).firstOrNull;
}

// Values match the server (`functions/src/points.ts`).
enum AmbassadorLevel {
  supporter('supporter'),
  ambassador('ambassador'),
  superAmbassador('super_ambassador'),
  champion('champion');

  const AmbassadorLevel(this.value);

  final String value;

  static AmbassadorLevel? fromValue(Object? value) =>
      values.where((l) => l.value == value).firstOrNull;
}

class LevelRule {
  final AmbassadorLevel level;
  final int minFriends;
  final int bonus;

  const LevelRule(this.level, this.minFriends, this.bonus);
}

// The app's copy of `config/points`, for showing values. The server decides.
class PointsConfig {
  final int dailyCheckin;
  final int dailyActive;
  final int activeMinutes;
  final int streakDays;
  final int streakBonus;
  final int referralQualified;
  final int referralWelcome;
  final int qualifyDays;
  final int qualifyWithinDays;
  final int codeEntryDays;
  final int maxQualifiedPerDay;
  final int feedbackPoints;
  final int feedbackAfterDays;
  final int reviewAfterDays;
  final int reviewMinActiveDays;
  final int reviewEveryDays;
  final int stillUsingDays;
  final List<LevelRule> levels;

  const PointsConfig({
    this.dailyCheckin = 5,
    this.dailyActive = 10,
    this.activeMinutes = 3,
    this.streakDays = 7,
    this.streakBonus = 25,
    this.referralQualified = 50,
    this.referralWelcome = 0,
    this.qualifyDays = 3,
    this.qualifyWithinDays = 14,
    this.codeEntryDays = 7,
    this.maxQualifiedPerDay = 10,
    this.feedbackPoints = 20,
    this.feedbackAfterDays = 5,
    this.reviewAfterDays = 10,
    this.reviewMinActiveDays = 5,
    this.reviewEveryDays = 120,
    this.stillUsingDays = 30,
    this.levels = const [
      LevelRule(AmbassadorLevel.supporter, 1, 10),
      LevelRule(AmbassadorLevel.ambassador, 5, 50),
      LevelRule(AmbassadorLevel.superAmbassador, 15, 150),
      LevelRule(AmbassadorLevel.champion, 30, 300),
    ],
  });

  factory PointsConfig.fromMap(Map<String, dynamic>? map) {
    const d = PointsConfig();
    int read(String key, int fallback) =>
        (map?[key] as num?)?.toInt() ?? fallback;
    final levels = map?['levels'];
    return PointsConfig(
      dailyCheckin: read('dailyCheckin', d.dailyCheckin),
      dailyActive: read('dailyActive', d.dailyActive),
      activeMinutes: read('activeMinutes', d.activeMinutes),
      streakDays: read('streakDays', d.streakDays),
      streakBonus: read('streakBonus', d.streakBonus),
      referralQualified: read('referralQualified', d.referralQualified),
      referralWelcome: read('referralWelcome', d.referralWelcome),
      qualifyDays: read('qualifyDays', d.qualifyDays),
      qualifyWithinDays: read('qualifyWithinDays', d.qualifyWithinDays),
      codeEntryDays: read('codeEntryDays', d.codeEntryDays),
      maxQualifiedPerDay: read('maxQualifiedPerDay', d.maxQualifiedPerDay),
      feedbackPoints: read('feedbackPoints', d.feedbackPoints),
      feedbackAfterDays: read('feedbackAfterDays', d.feedbackAfterDays),
      reviewAfterDays: read('reviewAfterDays', d.reviewAfterDays),
      reviewMinActiveDays: read('reviewMinActiveDays', d.reviewMinActiveDays),
      reviewEveryDays: read('reviewEveryDays', d.reviewEveryDays),
      stillUsingDays: read('stillUsingDays', d.stillUsingDays),
      levels: [
        for (final rule in d.levels)
          if (levels is Map && levels[rule.level.value] is Map)
            LevelRule(
              rule.level,
              (levels[rule.level.value]['minFriends'] as num?)?.toInt() ??
                  rule.minFriends,
              (levels[rule.level.value]['bonus'] as num?)?.toInt() ??
                  rule.bonus,
            )
          else
            rule,
      ]..sort((a, b) => a.minFriends.compareTo(b.minFriends)),
    );
  }

  Map<String, dynamic> toMap() => {
    'dailyCheckin': dailyCheckin,
    'dailyActive': dailyActive,
    'activeMinutes': activeMinutes,
    'streakDays': streakDays,
    'streakBonus': streakBonus,
    'referralQualified': referralQualified,
    'referralWelcome': referralWelcome,
    'qualifyDays': qualifyDays,
    'qualifyWithinDays': qualifyWithinDays,
    'codeEntryDays': codeEntryDays,
    'maxQualifiedPerDay': maxQualifiedPerDay,
    'feedbackPoints': feedbackPoints,
    'feedbackAfterDays': feedbackAfterDays,
    'reviewAfterDays': reviewAfterDays,
    'reviewMinActiveDays': reviewMinActiveDays,
    'reviewEveryDays': reviewEveryDays,
    'stillUsingDays': stillUsingDays,
    'levels': {
      for (final rule in levels)
        rule.level.value: {'minFriends': rule.minFriends, 'bonus': rule.bonus},
    },
  };

  int pointsFor(DailyTask task) =>
      task == DailyTask.checkin ? dailyCheckin : dailyActive;

  LevelRule? nextLevel(int friends) =>
      levels.where((l) => l.minFriends > friends).firstOrNull;
}

// Days are calendar days in Italy, like on the server. Italy is UTC+1, and
// UTC+2 from the last Sunday of March to the last Sunday of October (01:00 UTC).
String romeDayKey(DateTime now) {
  final utc = now.toUtc();
  DateTime lastSunday(int month) {
    final last = DateTime.utc(utc.year, month + 1, 0, 1);
    return last.subtract(Duration(days: last.weekday % 7));
  }

  final summer = !utc.isBefore(lastSunday(3)) && utc.isBefore(lastSunday(10));
  final local = utc.add(Duration(hours: summer ? 2 : 1));
  String two(int n) => n.toString().padLeft(2, '0');
  return '${local.year}-${two(local.month)}-${two(local.day)}';
}

class DailyState {
  final String? day;
  final Set<DailyTask> claimed;
  final int streak;
  final String? streakDay;

  const DailyState({
    this.day,
    this.claimed = const {},
    this.streak = 0,
    this.streakDay,
  });

  factory DailyState.fromMap(Object? map) {
    if (map is! Map) return const DailyState();
    return DailyState(
      day: map['day'] as String?,
      claimed: {
        for (final t in map['claimed'] as List? ?? const [])
          ?DailyTask.fromValue(t),
      },
      streak: (map['streak'] as num?)?.toInt() ?? 0,
      streakDay: map['streakDay'] as String?,
    );
  }

  bool claimedToday(DailyTask task, String today) =>
      day == today && claimed.contains(task);

  // A streak only counts while it reaches today or yesterday.
  int currentStreak(String today, String yesterday) =>
      streakDay == today || streakDay == yesterday ? streak : 0;
}

class PointsEntry {
  final String id;
  final String action;
  final int points;
  final String? note;
  final DateTime? createdAt;

  const PointsEntry({
    required this.id,
    required this.action,
    required this.points,
    this.note,
    this.createdAt,
  });

  factory PointsEntry.fromMap(String id, Map<String, dynamic> map) =>
      PointsEntry(
        id: id,
        action: map['action'] as String? ?? '',
        points: (map['points'] as num?)?.toInt() ?? 0,
        note: map['note'] as String?,
        createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      );
}

enum ReferralStatus {
  pending,
  qualified,
  review,
  rejected,
  expired;

  static ReferralStatus fromValue(Object? value) =>
      values.where((s) => s.name == value).firstOrNull ?? pending;

  // Same grouping as the server (`inviteBucket` in functions/src/points.ts).
  InviteBucket get bucket => switch (this) {
    qualified => InviteBucket.active,
    rejected || expired => InviteBucket.inactive,
    pending || review => InviteBucket.waiting,
  };
}

enum InviteBucket { active, inactive, waiting }

class Referral {
  final String inviteeId;
  final String inviterId;
  final String inviteeName;
  final ReferralStatus status;
  final List<String> flags;
  final DateTime? createdAt;
  final DateTime? joinedAt;

  const Referral({
    required this.inviteeId,
    required this.inviterId,
    required this.inviteeName,
    required this.status,
    this.flags = const [],
    this.createdAt,
    this.joinedAt,
  });

  factory Referral.fromMap(String id, Map<String, dynamic> map) => Referral(
    inviteeId: id,
    inviterId: map['inviterId'] as String? ?? '',
    inviteeName: map['inviteeName'] as String? ?? '',
    status: ReferralStatus.fromValue(map['status']),
    flags: [
      for (final f in map['flags'] as List? ?? const [])
        if (f is String) f,
    ],
    createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    joinedAt: (map['joinedAt'] as Timestamp?)?.toDate(),
  );
}

int _int(Object? value) => (value as num?)?.toInt() ?? 0;

DateTime? _millis(Object? value) =>
    value is num ? DateTime.fromMillisecondsSinceEpoch(value.toInt()) : null;

Map<String, dynamic> _map(Object? value) =>
    value is Map ? Map<String, dynamic>.from(value) : const {};

class InviteCounts {
  final int qrOpens;
  final int linkOpens;
  final int joined;
  final int active;
  final int inactive;
  final int waiting;
  final int stillUsing;

  const InviteCounts({
    this.qrOpens = 0,
    this.linkOpens = 0,
    this.joined = 0,
    this.active = 0,
    this.inactive = 0,
    this.waiting = 0,
    this.stillUsing = 0,
  });

  factory InviteCounts.fromMap(Object? value) {
    final map = _map(value);
    return InviteCounts(
      qrOpens: _int(map['qrOpens']),
      linkOpens: _int(map['linkOpens']),
      joined: _int(map['joined']),
      active: _int(map['active']),
      inactive: _int(map['inactive']),
      waiting: _int(map['waiting']),
      stillUsing: _int(map['stillUsing']),
    );
  }

  factory InviteCounts.ofReferrals(Iterable<Referral> referrals) {
    int count(InviteBucket b) =>
        referrals.where((r) => r.status.bucket == b).length;
    return InviteCounts(
      joined: referrals.length,
      active: count(InviteBucket.active),
      inactive: count(InviteBucket.inactive),
      waiting: count(InviteBucket.waiting),
    );
  }
}

class InvitedFriend {
  final String inviteeId;
  final String name;
  final ReferralStatus status;
  final DateTime? createdAt;
  final DateTime? qualifiedAt;
  final DateTime? lastActiveDay;
  final bool stillUsing;

  const InvitedFriend({
    required this.inviteeId,
    required this.name,
    required this.status,
    this.createdAt,
    this.qualifiedAt,
    this.lastActiveDay,
    this.stillUsing = false,
  });

  factory InvitedFriend.fromMap(Map<String, dynamic> map) => InvitedFriend(
    inviteeId: map['inviteeId'] as String? ?? '',
    name: map['name'] as String? ?? '',
    status: ReferralStatus.fromValue(map['status']),
    createdAt: _millis(map['createdAt']),
    qualifiedAt: _millis(map['qualifiedAt']),
    lastActiveDay: DateTime.tryParse(map['lastActiveDay'] as String? ?? ''),
    stillUsing: map['stillUsing'] == true,
  );
}

// One user's invites, from `adminInviteStats`.
class InviteStats {
  final String? code;
  final int stillUsingDays;
  final InviteCounts counts;
  final List<InvitedFriend> friends;

  const InviteStats({
    this.code,
    this.stillUsingDays = 30,
    this.counts = const InviteCounts(),
    this.friends = const [],
  });

  factory InviteStats.fromMap(Object? value) {
    final map = _map(value);
    return InviteStats(
      code: map['code'] as String?,
      stillUsingDays: _int(map['stillUsingDays']),
      counts: InviteCounts.fromMap(map['counts']),
      friends: [
        for (final f in map['friends'] as List? ?? const [])
          InvitedFriend.fromMap(_map(f)),
      ],
    );
  }
}

enum InviteSort { active, joined }

// Days as yyyy-MM-dd; both null means all time.
typedef InvitePeriod = ({String? from, String? to});

String dayKeyOf(DateTime day) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${day.year}-${two(day.month)}-${two(day.day)}';
}

class InviteRankingRow {
  final String uid;
  final String name;
  final String email;
  final String? code;
  final InviteCounts counts;

  const InviteRankingRow({
    required this.uid,
    required this.name,
    required this.email,
    this.code,
    this.counts = const InviteCounts(),
  });

  factory InviteRankingRow.fromMap(Map<String, dynamic> map) =>
      InviteRankingRow(
        uid: map['uid'] as String? ?? '',
        name: map['name'] as String? ?? '',
        email: map['email'] as String? ?? '',
        code: map['code'] as String?,
        counts: InviteCounts.fromMap(map),
      );
}

// From `adminInviteRanking`: totals for the period and the top inviters.
class InviteRanking {
  final InviteCounts totals;
  final int inviters;
  final int stillUsingDays;
  final List<InviteRankingRow> rows;

  const InviteRanking({
    this.totals = const InviteCounts(),
    this.inviters = 0,
    this.stillUsingDays = 30,
    this.rows = const [],
  });

  factory InviteRanking.fromMap(Object? value) {
    final map = _map(value);
    return InviteRanking(
      totals: InviteCounts.fromMap(map['totals']),
      inviters: _int(map['inviters']),
      stillUsingDays: _int(map['stillUsingDays']),
      rows: [
        for (final r in map['rows'] as List? ?? const [])
          InviteRankingRow.fromMap(_map(r)),
      ],
    );
  }
}
