import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

// Phones don't show pushes while the app is open, so the app shows them itself.
typedef ForegroundPush =
    void Function(RemoteMessage message, void Function() open);

class PushService {
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;
  final _subscriptions = <StreamSubscription<Object?>>[];
  String? _uid;
  String? _token;

  PushService({FirebaseMessaging? messaging, FirebaseFirestore? firestore})
    : _messaging = messaging ?? FirebaseMessaging.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> start({
    required String uid,
    required void Function(String reportId) onOpenReport,
    void Function(String caseId)? onOpenCase,
    ForegroundPush? onForeground,
  }) async {
    if (_uid == uid) return;
    await stop();
    _uid = uid;

    void open(RemoteMessage message) {
      final reportId = message.data['reportId'];
      final caseId = message.data['caseId'];
      if (reportId is String && reportId.isNotEmpty) onOpenReport(reportId);
      if (caseId is String && caseId.isNotEmpty) onOpenCase?.call(caseId);
    }

    _subscriptions.add(FirebaseMessaging.onMessageOpenedApp.listen(open));
    if (onForeground != null) {
      _subscriptions.add(
        FirebaseMessaging.onMessage.listen(
          (m) => onForeground(m, () => open(m)),
        ),
      );
    }
    try {
      final initial = await _messaging.getInitialMessage();
      if (initial != null) open(initial);

      final settings = await _messaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.denied) return;

      final token = await _messaging.getToken();
      if (token != null) await _saveToken(token);
      _subscriptions.add(_messaging.onTokenRefresh.listen(_saveToken));
    } catch (e) {
      debugPrint('Push setup failed: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    final uid = _uid;
    if (uid == null) return;
    _token = token;
    await _firestore.collection('users').doc(uid).set({
      'fcmTokens': FieldValue.arrayUnion([token]),
    }, SetOptions(merge: true));
  }

  Future<void> stop() async {
    for (final s in _subscriptions) {
      await s.cancel();
    }
    _subscriptions.clear();
    final uid = _uid;
    final token = _token;
    _uid = null;
    _token = null;
    if (uid == null || token == null) return;
    try {
      await _firestore.collection('users').doc(uid).update({
        'fcmTokens': FieldValue.arrayRemove([token]),
      });
    } catch (e) {
      debugPrint('Removing push token failed: $e');
    }
  }
}
