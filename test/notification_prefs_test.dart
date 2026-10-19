import 'package:CodaMi/features/notifications/domain/entities/notification_prefs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('missing preferences mean on with the phone default sound', () {
    final prefs = NotificationPrefs.fromMap(null);
    for (final type in AlertType.values) {
      expect(prefs[type].enabled, isTrue);
      expect(prefs[type].sound, AlertSound.deviceDefault);
      expect(prefs[type].channel, isNull);
    }
  });

  test('reads each type with its sound and channel', () {
    final prefs = NotificationPrefs.fromMap({
      'lost': {
        'enabled': true,
        'sound': 'bundled',
        'soundValue': 'bell',
        'channel': 'lost_1',
      },
      'found': {'enabled': false},
      'resolved': {
        'sound': 'file',
        'soundValue': 'content://media/9',
        'soundTitle': 'My song',
      },
    });
    expect(prefs[AlertType.lost].sound, const AlertSound.bundled('bell'));
    expect(prefs[AlertType.lost].channel, 'lost_1');
    expect(prefs[AlertType.found].enabled, isFalse);
    expect(prefs[AlertType.resolved].sound.kind, SoundKind.file);
    expect(prefs[AlertType.resolved].sound.title, 'My song');
    expect(prefs[AlertType.resolved].sound.nativeKind, 'uri');
  });

  test('a custom sound without a value falls back to the default', () {
    final prefs = NotificationPrefs.fromMap({
      'lost': {'sound': 'system'},
    });
    expect(prefs[AlertType.lost].sound, AlertSound.deviceDefault);
  });

  test('round-trips through the stored map', () {
    const original = AlertPrefs(
      enabled: false,
      sound: AlertSound(SoundKind.system, value: 'content://x', title: 'Tone'),
      channel: 'found_2',
    );
    final copy = AlertPrefs.fromMap(original.toMap());
    expect(copy.enabled, isFalse);
    expect(copy.sound, original.sound);
    expect(copy.sound.title, 'Tone');
    expect(copy.channel, 'found_2');
  });
}
