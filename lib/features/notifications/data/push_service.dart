import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

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
  }) async {
    if (_uid == uid) return;
    await stop();
    _uid = uid;

    void open(RemoteMessage message) {
      final id = message.data['reportId'];
      if (id is String && id.isNotEmpty) onOpenReport(id);
    }

    _subscriptions.add(FirebaseMessaging.onMessageOpenedApp.listen(open));
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
