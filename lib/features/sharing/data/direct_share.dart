import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../domain/sharing.dart';

const _channel = MethodChannel('codami/share');

// Android package names; the first one installed is used.
const sharePackages = {
  ShareTarget.whatsapp: ['com.whatsapp', 'com.whatsapp.w4b'],
  ShareTarget.facebook: ['com.facebook.katana', 'com.facebook.lite'],
  ShareTarget.instagram: ['com.instagram.android'],
  ShareTarget.tiktok: ['com.zhiliaoapp.musically', 'com.ss.android.ugc.trill'],
};

// Android only: opens the app straight away with the image and text.
// False when it isn't installed (or on iPhone), so the share menu is used.
Future<bool> shareToApp(ShareTarget target, Uint8List png, String text) async {
  final packages = sharePackages[target];
  if (packages == null || kIsWeb || !Platform.isAndroid) return false;
  try {
    return await _channel.invokeMethod<bool>('toApp', {
          'packages': packages,
          'png': png,
          'text': text,
        }) ??
        false;
  } catch (e) {
    debugPrint('Direct share failed: $e');
    return false;
  }
}
