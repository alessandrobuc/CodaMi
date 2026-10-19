import 'package:flutter/services.dart';

// Going straight from immersive to edge-to-edge leaves the bars hidden on
// Android, so they are shown explicitly first.
Future<void> showSystemBars() async {
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
