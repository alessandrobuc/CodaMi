import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';

class CommunityRadarIllustration extends StatefulWidget {
  final bool active;

  const CommunityRadarIllustration({super.key, required this.active});

  @override
  State<CommunityRadarIllustration> createState() =>
      _CommunityRadarIllustrationState();
}

class _CommunityRadarIllustrationState extends State<CommunityRadarIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, _) => CustomPaint(
              size: const Size(300, 300),
              painter: _RadarPainter(_pulse.value),
            ),
          ),
          Container(
                width: 190,
                height: 190,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Image.asset(AppAssets.logo),
              )
              .animate(target: widget.active ? 1 : 0)
              .scale(
                begin: const Offset(0.8, 0.8),
                duration: 700.ms,
                curve: Curves.elasticOut,
              ),
          _OrbitBubble(
            alignment: const Alignment(-0.92, -0.55),
            icon: FontAwesomeIcons.dog,
            color: AppColors.primary,
            delay: 0,
            active: widget.active,
          ),
          _OrbitBubble(
            alignment: const Alignment(0.95, -0.2),
            icon: FontAwesomeIcons.cat,
            color: AppColors.accent,
            delay: 150,
            active: widget.active,
          ),
          _OrbitBubble(
            alignment: const Alignment(-0.6, 0.95),
            icon: FontAwesomeIcons.solidHeart,
            color: AppColors.lostPin,
            delay: 300,
            active: widget.active,
          ),
          _OrbitBubble(
            alignment: const Alignment(0.7, 0.9),
            icon: FontAwesomeIcons.paw,
            color: AppColors.primaryDark,
            delay: 450,
            active: widget.active,
          ),
        ],
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final double t;

  _RadarPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.width / 2;
    const minRadius = 95.0;

    final guide = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.border;
    canvas.drawCircle(center, minRadius + 30, guide);
    canvas.drawCircle(center, maxRadius - 4, guide);

    for (var i = 0; i < 3; i++) {
      final p = (t + i / 3) % 1.0;
      final radius =
          minRadius + (maxRadius - minRadius) * Curves.easeOut.transform(p);
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = AppColors.primary.withValues(alpha: (1 - p) * 0.35),
      );
    }
  }

  @override
  bool shouldRepaint(_RadarPainter oldDelegate) => oldDelegate.t != t;
}

class _OrbitBubble extends StatelessWidget {
  final Alignment alignment;
  final FaIconData icon;
  final Color color;
  final int delay;
  final bool active;

  const _OrbitBubble({
    required this.alignment,
    required this.icon,
    required this.color,
    required this.delay,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child:
          Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.text.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(child: FaIcon(icon, size: 20, color: color)),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -5,
                end: 5,
                duration: (1600 + delay).ms,
                curve: Curves.easeInOut,
              )
              .animate(target: active ? 1 : 0)
              .fadeIn(delay: (300 + delay).ms, duration: 400.ms)
              .scale(begin: const Offset(0.4, 0.4), curve: Curves.easeOutBack),
    );
  }
}

class ReportCardIllustration extends StatelessWidget {
  final bool active;

  const ReportCardIllustration({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 320,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Transform.translate(
                offset: const Offset(34, -18),
                child: Transform.rotate(
                  angle: 0.12,
                  child: _CardShell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.cat,
                              size: 48,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _Badge(label: 'FOUND', color: AppColors.foundPin),
                      ],
                    ),
                  ),
                ),
              )
              .animate(target: active ? 1 : 0)
              .fadeIn(duration: 400.ms)
              .rotate(begin: -0.02),

          Transform.rotate(
                angle: -0.04,
                child: _CardShell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              AppAssets.dummyPet,
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              cacheWidth: 600,
                            ),
                          ),
                          const Positioned(
                            top: 10,
                            left: 10,
                            child: _Badge(
                              label: 'LOST',
                              color: AppColors.lostPin,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Milo',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                      ),
                      Text(
                        'Golden Retriever · 3 yrs',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: AppColors.lostPin,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Milano · 2h ago',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textMuted),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .animate(target: active ? 1 : 0)
              .fadeIn(duration: 400.ms)
              .moveY(
                begin: 40,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOutCubic,
              ),

          Positioned(
            right: -6,
            bottom: 22,
            child:
                Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Published',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: -4,
                      end: 4,
                      duration: 1500.ms,
                      curve: Curves.easeInOut,
                    )
                    .animate(target: active ? 1 : 0)
                    .fadeIn(delay: 500.ms)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      curve: Curves.easeOutBack,
                    ),
          ),

          Positioned(
            left: 0,
            top: 34,
            child:
                Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.photo_camera_rounded,
                        color: Colors.white,
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: 4,
                      end: -4,
                      duration: 1800.ms,
                      curve: Curves.easeInOut,
                    )
                    .animate(target: active ? 1 : 0)
                    .fadeIn(delay: 350.ms)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      curve: Curves.easeOutBack,
                    ),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;

  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.10),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class NearbyMapIllustration extends StatefulWidget {
  final bool active;

  const NearbyMapIllustration({super.key, required this.active});

  @override
  State<NearbyMapIllustration> createState() => _NearbyMapIllustrationState();
}

class _NearbyMapIllustrationState extends State<NearbyMapIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  static const _pins = [
    (Alignment(-0.62, -0.55), AppColors.lostPin, FontAwesomeIcons.dog),
    (Alignment(0.58, -0.68), AppColors.foundPin, FontAwesomeIcons.cat),
    (Alignment(0.7, 0.42), AppColors.lostPin, FontAwesomeIcons.cat),
    (Alignment(-0.55, 0.6), AppColors.foundPin, FontAwesomeIcons.dog),
  ];

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 290,
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.text.withValues(alpha: 0.10),
                blurRadius: 30,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              const Positioned.fill(child: CustomPaint(painter: _MapPainter())),
              Center(
                child: AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, _) {
                    final t = _pulse.value;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 20 + 50 * t,
                          height: 20 + 50 * t,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryDark.withValues(
                              alpha: 0.25 * (1 - t),
                            ),
                          ),
                        ),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              for (var i = 0; i < _pins.length; i++)
                Align(
                  alignment: _pins[i].$1,
                  child: _MapPin(color: _pins[i].$2, icon: _pins[i].$3)
                      .animate(target: widget.active ? 1 : 0)
                      .fadeIn(delay: (200 + i * 180).ms, duration: 200.ms)
                      .moveY(
                        begin: -40,
                        end: 0,
                        delay: (200 + i * 180).ms,
                        duration: 600.ms,
                        curve: Curves.bounceOut,
                      ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LegendDot(color: AppColors.lostPin, label: 'Lost'),
            SizedBox(width: 20),
            _LegendDot(color: AppColors.foundPin, label: 'Found'),
            SizedBox(width: 20),
            _LegendDot(color: AppColors.primaryDark, label: 'You'),
          ],
        ).animate(target: widget.active ? 1 : 0).fadeIn(delay: 900.ms),
      ],
    );
  }
}

class _MapPin extends StatelessWidget {
  final Color color;
  final FaIconData icon;

  const _MapPin({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: FaIcon(icon, size: 15, color: Colors.white)),
        ),
        Transform.translate(
          offset: const Offset(0, -5),
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(width: 10, height: 10, color: color),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MapPainter extends CustomPainter {
  const _MapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFEAF2EE),
    );

    final park = Paint()..color = const Color(0xFFD3E9DC);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.08, h * 0.08, w * 0.3, h * 0.26),
        const Radius.circular(14),
      ),
      park,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.62, h * 0.64, w * 0.32, h * 0.28),
        const Radius.circular(14),
      ),
      park,
    );

    final river = Path()
      ..moveTo(-10, h * 0.78)
      ..cubicTo(w * 0.3, h * 0.62, w * 0.55, h * 1.0, w + 10, h * 0.82);
    canvas.drawPath(
      river,
      Paint()
        ..color = const Color(0xFFC6E0EA)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16,
    );

    final main = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    final side = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, h * 0.45), Offset(w, h * 0.5), main);
    canvas.drawLine(Offset(w * 0.45, 0), Offset(w * 0.52, h), main);
    canvas.drawLine(Offset(w * 0.2, h * 0.47), Offset(w * 0.12, h), side);
    canvas.drawLine(Offset(w * 0.75, 0), Offset(w * 0.8, h * 0.6), side);
    canvas.drawLine(Offset(0, h * 0.2), Offset(w * 0.46, h * 0.24), side);
    canvas.drawLine(Offset(w * 0.5, h * 0.3), Offset(w, h * 0.22), side);
  }

  @override
  bool shouldRepaint(_MapPainter oldDelegate) => false;
}
