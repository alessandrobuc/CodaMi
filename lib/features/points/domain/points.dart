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
}

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
