import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';

class NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

class AnimatedNavBar extends StatefulWidget {
  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AnimatedNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<AnimatedNavBar> createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar>
    with TickerProviderStateMixin {
  static const _barHeight = 66.0;
  static const _rise = 30.0;
  static const _bubbleSize = 56.0;
  static const _notchGap = 7.0;
  static const _sidePadding = 14.0;
  static const _cornerRadius = 26.0;
  static const _spring = SpringDescription(
    mass: 1,
    stiffness: 170,
    damping: 17,
  );

  late final AnimationController _position = AnimationController.unbounded(
    vsync: this,
    value: widget.currentIndex.toDouble(),
  )..addListener(_checkLanding);

  late final AnimationController _burst = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  )..value = 1;

  bool _landed = true;

  double get _bubbleCenterY => _rise + 4;

  @override
  void didUpdateWidget(AnimatedNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _landed = false;
      _position.animateWith(
        SpringSimulation(
          _spring,
          _position.value,
          widget.currentIndex.toDouble(),
          _position.velocity,
        ),
      );
    }
  }

  void _checkLanding() {
    if (_landed) return;
    if ((_position.value - widget.currentIndex).abs() < 0.06) {
      _landed = true;
      _burst.forward(from: 0);
      HapticFeedback.lightImpact();
    }
  }

  void _handleTap(int index) {
    if (index == widget.currentIndex) return;
    HapticFeedback.selectionClick();
    widget.onTap(index);
  }

  @override
  void dispose() {
    _position.dispose();
    _burst.dispose();
    super.dispose();
  }

  Path _barPath(Rect bar, double cx) {
    final notched = const CircularNotchedRectangle().getOuterPath(
      bar,
      Rect.fromCircle(
        center: Offset(cx, _bubbleCenterY),
        radius: _bubbleSize / 2 + _notchGap,
      ),
    );
    final rounded = Path()
      ..addRRect(
        RRect.fromRectAndRadius(bar, const Radius.circular(_cornerRadius)),
      );
    return Path.combine(PathOperation.intersect, notched, rounded);
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.items.length;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    double visual(double position) => rtl ? count - 1 - position : position;

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: _rise + _barHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final slot = (width - _sidePadding * 2) / count;
              final bar = Rect.fromLTWH(0, _rise, width, _barHeight);

              return AnimatedBuilder(
                animation: Listenable.merge([_position, _burst]),
                builder: (context, _) {
                  final pos = _position.value.clamp(-0.1, count - 0.9);
                  final cx = _sidePadding + slot * (visual(pos) + 0.5);
                  final path = _barPath(bar, cx);
                  final hoverIndex = _position.value.round().clamp(
                    0,
                    count - 1,
                  );

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _BarShadowPainter(path),
                          foregroundPainter: _BarBorderPainter(path),
                          child: ClipPath(
                            clipper: _PathClipper(path),
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(
                                sigmaX: 18,
                                sigmaY: 18,
                              ),
                              child: ColoredBox(
                                color: AppColors.surface.withValues(
                                  alpha: 0.88,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      for (var i = 0; i < count; i++)
                        Positioned(
                          left: _sidePadding + slot * visual(i.toDouble()),
                          top: _rise,
                          width: slot,
                          height: _barHeight,
                          child: _NavSlot(
                            item: widget.items[i],
                            distance: (_position.value - i).abs(),
                            selected: i == widget.currentIndex,
                            onTap: () => _handleTap(i),
                          ),
                        ),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _BurstPainter(
                              center: Offset(cx, _bubbleCenterY),
                              radius: _bubbleSize / 2,
                              t: _burst.value,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: cx - _bubbleSize / 2,
                        top: _bubbleCenterY - _bubbleSize / 2,
                        child: IgnorePointer(
                          child: _Bubble(
                            size: _bubbleSize,
                            velocity: _position.velocity,
                            icon: widget.items[hoverIndex].activeIcon,
                            iconKey: hoverIndex,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  final NavItem item;
  final double distance;
  final bool selected;
  final VoidCallback onTap;

  const _NavSlot({
    required this.item,
    required this.distance,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final reveal = (distance / 0.6).clamp(0.0, 1.0);

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 12 + (1 - reveal) * 16,
              child: Opacity(
                opacity: reveal,
                child: Transform.scale(
                  scale: 0.6 + 0.4 * reveal,
                  child: Icon(item.icon, size: 24, color: AppColors.textMuted),
                ),
              ),
            ),
            Positioned(
              bottom: 9,
              child: Text(
                item.label,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily,
                  fontSize: 11.5,
                  height: 1,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: Color.lerp(
                    AppColors.primary,
                    AppColors.textMuted,
                    reveal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final double size;
  final double velocity;
  final IconData icon;
  final int iconKey;

  const _Bubble({
    required this.size,
    required this.velocity,
    required this.icon,
    required this.iconKey,
  });

  @override
  Widget build(BuildContext context) {
    final stretch = (velocity.abs() * 0.035).clamp(0.0, 0.22);
    final lean = (velocity * 0.012).clamp(-0.12, 0.12);

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(lean)
        ..multiply(Matrix4.diagonal3Values(1 + stretch, 1 - stretch * 0.6, 1)),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2A8A71),
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 420),
          switchInCurve: Curves.elasticOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: RotationTransition(
              turns: Tween(begin: -0.08, end: 0.0).animate(animation),
              child: child,
            ),
          ),
          child: Icon(
            icon,
            key: ValueKey(iconKey),
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }
}

class _PathClipper extends CustomClipper<Path> {
  final Path path;

  _PathClipper(this.path);

  @override
  Path getClip(Size size) => path;

  @override
  bool shouldReclip(_PathClipper oldClipper) => oldClipper.path != path;
}

class _BarShadowPainter extends CustomPainter {
  final Path path;

  _BarShadowPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      path.shift(const Offset(0, 10)),
      Paint()
        ..color = AppColors.primaryDark.withValues(alpha: 0.16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18),
    );
  }

  @override
  bool shouldRepaint(_BarShadowPainter oldDelegate) => oldDelegate.path != path;
}

class _BarBorderPainter extends CustomPainter {
  final Path path;

  _BarBorderPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = AppColors.border.withValues(alpha: 0.7),
    );
  }

  @override
  bool shouldRepaint(_BarBorderPainter oldDelegate) => oldDelegate.path != path;
}

class _BurstPainter extends CustomPainter {
  final Offset center;
  final double radius;
  final double t;

  _BurstPainter({required this.center, required this.radius, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    if (t >= 1) return;
    final eased = Curves.easeOutCubic.transform(t);
    final fade = 1 - t;

    canvas.drawCircle(
      center,
      radius + 20 * eased,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5 * fade
        ..color = AppColors.primary.withValues(alpha: 0.4 * fade),
    );

    for (var i = 0; i < 8; i++) {
      final angle = -math.pi / 2 + i * math.pi / 4;
      final distance = radius + 6 + 16 * eased;
      canvas.drawCircle(
        center + Offset(math.cos(angle), math.sin(angle)) * distance,
        3 * fade,
        Paint()
          ..color = (i.isEven ? AppColors.accent : AppColors.primary)
              .withValues(alpha: fade),
      );
    }
  }

  @override
  bool shouldRepaint(_BurstPainter oldDelegate) =>
      oldDelegate.t != t || oldDelegate.center != center;
}
