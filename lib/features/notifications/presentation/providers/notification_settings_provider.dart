import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/notification_sounds.dart';
import '../../domain/entities/notification_prefs.dart';

final notificationSoundsProvider = Provider((ref) => NotificationSounds());

final soundCapabilitiesProvider = FutureProvider<SoundCapabilities>(
  (ref) => ref.watch(notificationSoundsProvider).capabilities(),
);

final notificationPrefsProvider = Provider<NotificationPrefs>(
  (ref) =>
      ref.watch(userProfileProvider).value?.notificationPrefs ??
      const NotificationPrefs(),
);

final notificationSettingsProvider = Provider(
  (ref) => NotificationSettingsController(ref),
);

extension AlertTypeLabels on AlertType {
  String title(AppLocalizations l10n) => switch (this) {
    AlertType.lost => l10n.alertLostTitle,
    AlertType.found => l10n.alertFoundTitle,
    AlertType.resolved => l10n.alertResolvedTitle,
    AlertType.support => l10n.alertSupportTitle,
  };

  String description(AppLocalizations l10n) => switch (this) {
    AlertType.lost => l10n.alertLostDescription,
    AlertType.found => l10n.alertFoundDescription,
    AlertType.resolved => l10n.alertResolvedDescription,
    AlertType.support => l10n.alertSupportDescription,
  };
}

extension AlertSoundLabel on AlertSound {
  String label(AppLocalizations l10n) => switch (kind) {
    SoundKind.deviceDefault => l10n.soundDefault,
    SoundKind.silent => l10n.soundSilent,
    SoundKind.bundled => switch (value) {
      'bell' => l10n.soundBell,
      'bright' => l10n.soundBright,
      'soft' => l10n.soundSoft,
      _ => l10n.soundChime,
    },
    SoundKind.system ||
    SoundKind.file => (title ?? '').isEmpty ? l10n.soundCustom : title!,
  };
}

// Android channels can't change their sound once created, so every new sound
// gets a fresh channel id and the old channel is deleted.
class NotificationSettingsController {
  final Ref _ref;

  NotificationSettingsController(this._ref);

  NotificationSounds get _sounds => _ref.read(notificationSoundsProvider);

  Future<void> setEnabled(AlertType type, bool enabled) =>
      _save(type, {'enabled': enabled});

  Future<void> setSound(AlertType type, AlertSound sound) async {
    final prefs = _ref.read(notificationPrefsProvider);
    final previous = prefs[type];
    final caps = await _ref.read(soundCapabilitiesProvider.future);

    String? channel = previous.channel;
    if (caps.channels) {
      channel = '${type.name}_${DateTime.now().millisecondsSinceEpoch}';
      await _sounds.createChannel(
        id: channel,
        name: type.title(appL10n),
        sound: sound,
      );
    }
    await _save(type, {...sound.toMap(), 'channel': channel});

    final oldChannel = previous.channel;
    if (oldChannel != null && oldChannel != channel) {
      await _sounds.deleteChannel(oldChannel);
    }
    final oldSound = previous.sound;
    final stillUsed = AlertType.values.any(
      (t) => t != type && prefs[t].sound == oldSound,
    );
    if (oldSound.kind == SoundKind.file && oldSound != sound && !stillUsed) {
      await _sounds.deleteFile(oldSound.value!);
    }
  }

  // Channels live on the device, so a new install or a second phone needs them again.
  Future<void> restoreChannels() async {
    try {
      final caps = await _ref.read(soundCapabilitiesProvider.future);
      if (!caps.channels) return;
      final prefs =
          (await _ref.read(userProfileProvider.future))?.notificationPrefs ??
          const NotificationPrefs();
      for (final type in AlertType.values) {
        final channel = prefs[type].channel;
        if (channel == null) continue;
        await _sounds.createChannel(
          id: channel,
          name: type.title(appL10n),
          sound: prefs[type].sound,
        );
      }
    } catch (e) {
      debugPrint('Restoring notification channels failed: $e');
    }
  }

  Future<void> _save(AlertType type, Map<String, Object?> fields) {
    final uid = _ref.read(authStateProvider).value?.uid;
    if (uid == null) return Future.value();
    return FirebaseFirestore.instance.collection('users').doc(uid).set({
      'notificationPrefs': {type.name: fields},
    }, SetOptions(merge: true));
  }
}
