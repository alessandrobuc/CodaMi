import 'package:CodaMi/features/points/domain/invite_code.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('typed codes are cleaned up', () {
    expect(extractInviteCode('ABC234'), 'ABC234');
    expect(extractInviteCode('  abc234 '), 'ABC234');
    expect(extractInviteCode('abc-234'), 'ABC234');
    expect(extractInviteCode('ABC 234'), 'ABC234');
  });

  test('codes with letters that are never used are rejected', () {
    expect(extractInviteCode('ABC123'), isNull); // 1
    expect(extractInviteCode('OBC234'), isNull); // O
    expect(extractInviteCode('IBC234'), isNull); // I
    expect(extractInviteCode('ABC23'), isNull);
    expect(extractInviteCode('ABC2345'), isNull);
    expect(extractInviteCode(''), isNull);
  });

  test('the code is found in the shared message and link', () {
    const message =
        'I use CodaMi to help lost pets get back home. Join me with my invite '
        'code QWE789: https://play.google.com/store/apps/details?id=com.codami.app&referrer=QWE789';
    expect(extractInviteCode(message), 'QWE789');
    expect(
      extractInviteCode(
        'https://play.google.com/store/apps/details?id=com.codami.app&referrer=qwe789',
      ),
      'QWE789',
    );
    expect(extractInviteCode('Mein Code: QWE789'), 'QWE789');
  });

  test('unclear text gives no code instead of a guess', () {
    expect(extractInviteCode('QWE789 or ZXC456'), isNull);
    expect(extractInviteCode('hello there'), isNull);
  });
}
