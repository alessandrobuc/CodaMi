import 'package:CodaMi/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('name', () {
    expect(Validators.name(''), isNotNull);
    expect(Validators.name('A'), isNotNull);
    expect(Validators.name('John3'), isNotNull);
    expect(Validators.name("Ammar Hameed"), isNull);
    expect(Validators.name("Anne-Marie O'Neil"), isNull);
    expect(Validators.name('José Ñúñez'), isNull);
  });

  test('email', () {
    expect(Validators.email('a@b'), isNotNull);
    expect(Validators.email('foo@bar.com'), isNull);
    expect(Validators.email(' first.last+tag@mail.co.uk '), isNull);
    expect(Validators.email('foo bar@x.com'), isNotNull);
  });

  test('password', () {
    expect(Validators.password('1234567'), isNotNull);
    expect(Validators.password('12345678'), isNull);
    final confirm = Validators.confirmPassword(() => 'secret123');
    expect(confirm('secret12'), isNotNull);
    expect(confirm('secret123'), isNull);
  });
}
