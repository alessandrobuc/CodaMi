import '../../../notifications/domain/entities/notification_prefs.dart';
import '../../../points/domain/points.dart';

enum UserRole {
  user,
  support,
  admin;

  bool get isStaff => this != user;

  static UserRole fromValue(Object? value) =>
      values.where((r) => r.name == value).firstOrNull ?? user;
}

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final bool isPremium;
  final DateTime createdAt;
  final String? city;
  final String? cityKey;
  final String? country;
  final double? homeLat;
  final double? homeLng;
  final String? phone;
  final UserRole role;
  final bool disabled;
  final Map<String, String> blockedUsers;
  final NotificationPrefs notificationPrefs;
  final int points;
  final DailyState daily;
  final String? inviteCode;
  final String? referredBy;
  final int referralCount;
  final AmbassadorLevel? ambassadorLevel;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.isPremium = false,
    required this.createdAt,
    this.city,
    this.cityKey,
    this.country,
    this.homeLat,
    this.homeLng,
    this.phone,
    this.role = UserRole.user,
    this.disabled = false,
    this.blockedUsers = const {},
    this.notificationPrefs = const NotificationPrefs(),
    this.points = 0,
    this.daily = const DailyState(),
    this.inviteCode,
    this.referredBy,
    this.referralCount = 0,
    this.ambassadorLevel,
  });

  bool get hasCity => (cityKey ?? '').isNotEmpty;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'isPremium': isPremium,
      'role': role.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      isPremium: map['isPremium'] ?? false,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      city: map['city'],
      cityKey: map['cityKey'],
      country: map['country'],
      homeLat: (map['homeLat'] as num?)?.toDouble(),
      homeLng: (map['homeLng'] as num?)?.toDouble(),
      phone: map['phone'] as String?,
      role: UserRole.fromValue(map['role']),
      disabled: map['disabled'] == true,
      blockedUsers: {
        for (final e in (map['blockedUsers'] as Map? ?? const {}).entries)
          '${e.key}': '${e.value ?? ''}',
      },
      notificationPrefs: NotificationPrefs.fromMap(map['notificationPrefs']),
      points: (map['points'] as num?)?.toInt() ?? 0,
      daily: DailyState.fromMap(map['daily']),
      inviteCode: map['inviteCode'] as String?,
      referredBy: map['referredBy'] as String?,
      referralCount: (map['referralCount'] as num?)?.toInt() ?? 0,
      ambassadorLevel: AmbassadorLevel.fromValue(map['ambassadorLevel']),
    );
  }
}
