// Stored on `users/{uid}.notificationPrefs`; Cloud Functions read the same keys.
enum AlertType { lost, found, resolved, support, emergency }

enum SoundKind {
  deviceDefault('default'),
  silent('silent'),
  bundled('bundled'),
  system('system'),
  file('file');

  const SoundKind(this.value);

  final String value;

  static SoundKind fromValue(Object? value) =>
      values.where((k) => k.value == value).firstOrNull ?? deviceDefault;
}

const bundledSounds = ['chime', 'bell', 'bright', 'soft'];

class AlertSound {
  final SoundKind kind;

  // Bundled sound name, or the Android content URI of a system or file sound.
  final String? value;
  final String? title;

  const AlertSound(this.kind, {this.value, this.title});

  const AlertSound.bundled(String name) : this(SoundKind.bundled, value: name);

  static const deviceDefault = AlertSound(SoundKind.deviceDefault);
  static const silent = AlertSound(SoundKind.silent);

  // The native side only knows default, silent, bundled and plain URIs.
  String get nativeKind => switch (kind) {
    SoundKind.system || SoundKind.file => 'uri',
    _ => kind.value,
  };

  factory AlertSound.fromMap(Map<Object?, Object?> map) {
    final kind = SoundKind.fromValue(map['sound']);
    final value = map['soundValue'] as String?;
    if (kind != SoundKind.deviceDefault &&
        kind != SoundKind.silent &&
        (value == null || value.isEmpty)) {
      return deviceDefault;
    }
    return AlertSound(kind, value: value, title: map['soundTitle'] as String?);
  }

  Map<String, Object?> toMap() => {
    'sound': kind.value,
    'soundValue': value,
    'soundTitle': title,
  };

  @override
  bool operator ==(Object other) =>
      other is AlertSound && other.kind == kind && other.value == value;

  @override
  int get hashCode => Object.hash(kind, value);
}

class AlertPrefs {
  final bool enabled;
  final AlertSound sound;

  // Android channel this type posts to; the server falls back to the default one.
  final String? channel;

  const AlertPrefs({
    this.enabled = true,
    this.sound = AlertSound.deviceDefault,
    this.channel,
  });

  factory AlertPrefs.fromMap(Object? data) {
    if (data is! Map) return const AlertPrefs();
    return AlertPrefs(
      enabled: data['enabled'] != false,
      sound: AlertSound.fromMap(data),
      channel: data['channel'] as String?,
    );
  }

  Map<String, Object?> toMap() => {
    'enabled': enabled,
    ...sound.toMap(),
    'channel': channel,
  };

  AlertPrefs copyWith({bool? enabled, AlertSound? sound, String? channel}) =>
      AlertPrefs(
        enabled: enabled ?? this.enabled,
        sound: sound ?? this.sound,
        channel: channel ?? this.channel,
      );
}

class NotificationPrefs {
  final Map<AlertType, AlertPrefs> _types;

  const NotificationPrefs([this._types = const {}]);

  factory NotificationPrefs.fromMap(Object? data) => NotificationPrefs({
    if (data is Map)
      for (final type in AlertType.values)
        type: AlertPrefs.fromMap(data[type.name]),
  });

  AlertPrefs operator [](AlertType type) => _types[type] ?? const AlertPrefs();
}
