import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../domain/invite_code.dart';

const _channel = MethodChannel('codami/install_referrer');

// The invite code from the Play Store link this app was installed from (Android only).
Future<String?> installInviteCode() async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return null;
  try {
    final raw = await _channel
        .invokeMethod<String>('get')
        .timeout(const Duration(seconds: 5));
    return inviteCodeFromReferrer(raw);
  } catch (e) {
    debugPrint('Install referrer failed: $e');
    return null;
  }
}
