import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../domain/entities/notification_prefs.dart';

class SoundCapabilities {
  final bool channels;
  final bool systemSounds;
  final bool files;

  const SoundCapabilities({
    this.channels = false,
    this.systemSounds = false,
    this.files = false,
  });
}

// Talks to MainActivity.kt (Android) and AppDelegate.swift (iOS).
class NotificationSounds {
  static const _channel = MethodChannel('codami/notification_sounds');

  Future<SoundCapabilities> capabilities() async {
    try {
      final map = await _channel.invokeMapMethod<String, bool>('capabilities');
      return SoundCapabilities(
        channels: map?['channels'] ?? false,
        systemSounds: map?['systemSounds'] ?? false,
        files: map?['files'] ?? false,
      );
    } on MissingPluginException {
      return const SoundCapabilities();
    }
  }

  Future<void> createChannel({
    required String id,
    required String name,
    required AlertSound sound,
  }) => _channel.invokeMethod('createChannel', {
    'id': id,
    'name': name,
    'kind': sound.nativeKind,
    'value': sound.value,
  });

  Future<void> deleteChannel(String id) =>
      _channel.invokeMethod('deleteChannel', {'id': id});

  Future<AlertSound?> pickSystemSound({AlertSound? current}) => _pick(
    'pickSystemSound',
    SoundKind.system,
    {if (current?.kind == SoundKind.system) 'current': current!.value},
  );

  Future<AlertSound?> pickAudioFile() => _pick('pickAudioFile', SoundKind.file);

  Future<AlertSound?> _pick(
    String method,
    SoundKind kind, [
    Map<String, Object?>? args,
  ]) async {
    final map = await _channel.invokeMapMethod<String, String>(method, args);
    final uri = map?['uri'];
    if (uri == null) return null;
    return AlertSound(kind, value: uri, title: map?['title']);
  }

  Future<void> deleteFile(String uri) =>
      _channel.invokeMethod('deleteFile', {'uri': uri});

  Future<void> play(AlertSound sound) async {
    try {
      await _channel.invokeMethod('play', {
        'kind': sound.nativeKind,
        'value': sound.value,
      });
    } catch (e) {
      debugPrint('Sound preview failed: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _channel.invokeMethod('stop');
    } catch (_) {}
  }
}
