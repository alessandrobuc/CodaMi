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
  });

  bool get hasCity => (cityKey ?? '').isNotEmpty;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'isPremium': isPremium,
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
    );
  }
}
