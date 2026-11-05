import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

import '../domain/sharing.dart';

// A report opened from its web page, waiting until the user is in the app.
final pendingReportLink = ValueNotifier<String?>(null);
StreamSubscription<Uri>? _links;

// Started in main() so the link that opened the app isn't missed.
void listenForReportLinks() {
  _links ??= AppLinks().uriLinkStream.listen((uri) {
    final id = reportIdOfLink(uri);
    if (id != null) pendingReportLink.value = id;
  }, onError: (Object e) => debugPrint('App link not read: $e'));
}
