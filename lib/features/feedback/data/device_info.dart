import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _channel = MethodChannel('codami/device');

// For example "samsung SM-S911B · Android 14" or "iPhone15,2 · iOS 17.2".
Future<String> describeDevice() async {
  if (kIsWeb) return 'web';
  try {
    final info = await _channel.invokeMapMethod<String, String>('describe');
    final model = info?['model'] ?? '';
    final system = info?['system'] ?? '';
    final parts = [model, system].where((p) => p.trim().isNotEmpty);
    if (parts.isNotEmpty) return parts.join(' · ');
  } catch (e) {
    debugPrint('Device info not available: $e');
  }
  return Platform.operatingSystem;
}
