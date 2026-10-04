import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final userProfileProvider = StreamProvider<UserModel?>((ref) {
  final uid = ref.watch(authStateProvider.select((state) => state.value?.uid));
  if (uid == null) return Stream.value(null);

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((doc) => doc.exists ? UserModel.fromMap(doc.data()!) : null);
});

class CurrentUserInfo {
  final String name;
  final String email;
  final String? photoUrl;
  final String? city;

  const CurrentUserInfo({
    required this.name,
    required this.email,
    this.photoUrl,
    this.city,
  });

  String get firstName => name.split(' ').first;

  String get initials {
    final parts = name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    return parts.take(2).map((p) => p[0].toUpperCase()).join();
  }
}

final currentUserInfoProvider = Provider<CurrentUserInfo>((ref) {
  final authUser = ref.watch(authStateProvider).value;
  final profile = ref.watch(userProfileProvider).value;

  final email = _firstNonEmpty([profile?.email, authUser?.email]) ?? '';
  final name =
      _firstNonEmpty([profile?.name, authUser?.displayName]) ??
      _nameFromEmail(email);

  return CurrentUserInfo(
    name: name,
    email: email,
    photoUrl: _firstNonEmpty([profile?.photoUrl, authUser?.photoURL]),
    city: _firstNonEmpty([profile?.city]),
  );
});

String? _firstNonEmpty(List<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) return trimmed;
  }
  return null;
}

String _nameFromEmail(String email) {
  final local = email.split('@').first.split(RegExp(r'[._\-+]')).first;
  if (local.isEmpty) return 'there';
  return local[0].toUpperCase() + local.substring(1);
}
