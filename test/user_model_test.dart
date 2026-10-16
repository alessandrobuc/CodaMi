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

  test('reads disabled flag and blocked users', () {
    final user = UserModel.fromMap({
      'uid': 'u1',
      'disabled': true,
      'blockedUsers': {'u2': 'Luca', 'u3': null},
    });
    expect(user.disabled, isTrue);
    expect(user.blockedUsers, {'u2': 'Luca', 'u3': ''});
    expect(UserModel.fromMap({'uid': 'u1'}).blockedUsers, isEmpty);
  });
}
