import 'package:CodaMi/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('role defaults to user when missing or unknown', () {
    UserRole role(Object? value) =>
        UserModel.fromMap({'uid': 'u1', 'role': value}).role;
    expect(role(null), UserRole.user);
    expect(role('superuser'), UserRole.user);
    expect(role('support'), UserRole.support);
    expect(role('admin'), UserRole.admin);
    expect(UserRole.user.isStaff, isFalse);
    expect(UserRole.support.isStaff, isTrue);
  });

  test('new profiles are saved with the user role', () {
    final user = UserModel(
      uid: 'u1',
      name: 'Ammar',
      email: 'a@x.com',
      createdAt: DateTime(2026),
    );
    expect(user.toMap()['role'], 'user');
  });
}
