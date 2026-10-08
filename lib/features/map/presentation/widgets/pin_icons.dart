import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/number_format.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../../reports/presentation/widgets/reports_widget.dart';

class PinIcons {
  static const _width = 58.0;
  static const _height = 66.0;

  final _icons = <String, BitmapDescriptor>{};
  final _photos = <String, Future<ui.Image?>>{};

  BitmapDescriptor? cached(Report report, {required bool selected}) =>
      _icons[_key(report, selected)];

  Future<BitmapDescriptor> load(
    Report report, {
    required bool selected,
    required double pixelRatio,
  }) async {
    final key = _key(report, selected);
    final existing = _icons[key];
    if (existing != null) return existing;

    final url = report.coverUrl;
    final photo = url == null
        ? null
        : await _photos.putIfAbsent(url, () => _loadPhoto(url));
    final scale = selected ? 1.2 : 1.0;
    final bytes = await _draw(
      color: pinColor(report),
      home: !report.isOpen,
      photo: photo,
      scale: scale,
      pixelRatio: pixelRatio,
    );
    return _icons[key] = BitmapDescriptor.bytes(
      bytes,
      width: _width * scale,
      height: _height * scale,
    );
  }

  static double clusterSize(int count) => switch (count) {
    < 10 => 46,
    < 100 => 52,
    < 1000 => 58,
    _ => 64,
  };

  String _clusterKey(int count, int lost) =>
      'cluster|${compactCount(count)}|${(lost / count * 12).round()}';

  BitmapDescriptor? cachedCluster(int count, int lost) =>
      _icons[_clusterKey(count, lost)];

  Future<BitmapDescriptor> loadCluster(
    int count,
    int lost, {
    required double pixelRatio,
  }) async {
    final key = _clusterKey(count, lost);
    final existing = _icons[key];
    if (existing != null) return existing;

    final size = clusterSize(count);
    final factor = pixelRatio;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder)..scale(factor);
    final center = Offset(size / 2, size / 2);
    final radius = size / 2 - 5;

    canvas.drawCircle(
      center.translate(0, 2),
      radius,
      Paint()
        ..color = AppColors.primaryDark.withValues(alpha: 0.28)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);

    const stroke = 4.5;
    final arcRect = Rect.fromCircle(center: center, radius: radius - stroke);
    final lostSweep = 2 * 3.141592653589793 * lost / count;
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    const start = -3.141592653589793 / 2;
    if (lost < count) {
      canvas.drawArc(
        arcRect,
        start + lostSweep,
        2 * 3.141592653589793 - lostSweep,
        false,
        ring..color = AppColors.foundPin,
      );
    }
    if (lost > 0) {
      canvas.drawArc(
        arcRect,
        start,
        lostSweep,
        false,
        ring..color = AppColors.lostPin,
      );
    }

    final label = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: compactCount(count),
        style: TextStyle(
          fontSize: count < 1000 ? 15 : 14,
          fontWeight: FontWeight.w800,
          color: AppColors.primaryDark,
        ),
      ),
    )..layout();
    label.paint(canvas, center - Offset(label.width / 2, label.height / 2));

    final image = await recorder.endRecording().toImage(
      (size * factor).ceil(),
      (size * factor).ceil(),
    );
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return _icons[key] = BitmapDescriptor.bytes(
      data!.buffer.asUint8List(),
      width: size,
      height: size,
    );
  }

  String _key(Report r, bool selected) =>
      '${r.type.name}|${r.isOpen}|${r.coverUrl}|$selected';

  Future<ui.Image?> _loadPhoto(String url) {
    final completer = Completer<ui.Image?>();
    final stream = CachedNetworkImageProvider(
      url,
      maxWidth: 160,
    ).resolve(ImageConfiguration.empty);
    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, _) {
        if (!completer.isCompleted) completer.complete(info.image);
        stream.removeListener(listener);
      },
      onError: (_, _) {
        if (!completer.isCompleted) completer.complete(null);
        stream.removeListener(listener);
      },
    );
    stream.addListener(listener);
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () => null,
    );
  }

  static Future<Uint8List> _draw({
    required Color color,
    required bool home,
    required ui.Image? photo,
    required double scale,
    required double pixelRatio,
  }) async {
    final factor = scale * pixelRatio;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder)..scale(factor);

    const center = Offset(_width / 2, 27);
    const outer = 25.0;
    const ring = 3.0;
    const gap = 2.0;
    const inner = outer - ring - gap;

    canvas.drawCircle(
      center.translate(0, 3),
      outer,
      Paint()
        ..color = color.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    final tip = Path()
      ..moveTo(center.dx - 8, center.dy + outer - 3)
      ..lineTo(center.dx + 8, center.dy + outer - 3)
      ..lineTo(center.dx, center.dy + outer + 9)
      ..close();
    canvas.drawPath(tip, Paint()..color = color);
    canvas.drawCircle(center, outer, Paint()..color = color);
    canvas.drawCircle(center, outer - ring, Paint()..color = Colors.white);

    final photoRect = Rect.fromCircle(center: center, radius: inner);
    canvas.save();
    canvas.clipPath(Path()..addOval(photoRect));
    if (photo != null) {
      paintImage(
        canvas: canvas,
        rect: photoRect,
        image: photo,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
      );
    } else {
      canvas.drawRect(photoRect, Paint()..color = const Color(0xFFE8EFEC));
      final icon = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: String.fromCharCode(Icons.pets_rounded.codePoint),
          style: TextStyle(
            fontSize: 22,
            fontFamily: Icons.pets_rounded.fontFamily,
            package: Icons.pets_rounded.fontPackage,
            color: color.withValues(alpha: 0.75),
          ),
        ),
      )..layout();
      icon.paint(canvas, center - Offset(icon.width / 2, icon.height / 2));
    }
    canvas.restore();

    if (home) {
      final badge = center.translate(18, -17);
      canvas.drawCircle(badge, 9.5, Paint()..color = Colors.white);
      canvas.drawCircle(badge, 8, Paint()..color = color);
      final icon = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: String.fromCharCode(Icons.home_rounded.codePoint),
          style: TextStyle(
            fontSize: 11,
            fontFamily: Icons.home_rounded.fontFamily,
            package: Icons.home_rounded.fontPackage,
            color: Colors.white,
          ),
        ),
      )..layout();
      icon.paint(canvas, badge - Offset(icon.width / 2, icon.height / 2));
    }

    final image = await recorder.endRecording().toImage(
      (_width * factor).ceil(),
      (_height * factor).ceil(),
    );
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return data!.buffer.asUint8List();
  }
}
