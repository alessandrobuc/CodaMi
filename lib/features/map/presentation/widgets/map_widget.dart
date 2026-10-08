import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/number_format.dart';
import '../../../reports/domain/entities/reports_entity.dart';

class MapGlass extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;

  const MapGlass({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.14),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(borderRadius: borderRadius, child: child),
    );
  }
}

class MapIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  const MapIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MapGlass(
      borderRadius: BorderRadius.circular(16),
      child: _ControlButton(icon: icon, tooltip: tooltip, onTap: onTap),
    );
  }
}

class MapControlPill extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onLocate;
  final VoidCallback onHome;
  final ValueNotifier<bool> locating;

  const MapControlPill({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onLocate,
    required this.onHome,
    required this.locating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MapGlass(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ControlButton(
                icon: Icons.add_rounded,
                tooltip: 'Zoom in',
                onTap: onZoomIn,
              ),
              const SizedBox(
                width: 28,
                child: Divider(height: 1, color: AppColors.border),
              ),
              _ControlButton(
                icon: Icons.remove_rounded,
                tooltip: 'Zoom out',
                onTap: onZoomOut,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        MapGlass(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: locating,
                builder: (context, busy, _) => _ControlButton(
                  icon: Icons.my_location_rounded,
                  tooltip: 'My location',
                  onTap: busy ? null : onLocate,
                  busy: busy,
                ),
              ),
              const SizedBox(
                width: 28,
                child: Divider(height: 1, color: AppColors.border),
              ),
              _ControlButton(
                icon: Icons.home_work_outlined,
                tooltip: 'My city',
                onTap: onHome,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final bool busy;

  const _ControlButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2.2),
                    )
                  : Icon(icon, size: 21, color: AppColors.primaryDark),
            ),
          ),
        ),
      ),
    );
  }
}

class MapTypeChips extends StatelessWidget {
  final ReportType? selected;
  final int lostCount;
  final int foundCount;
  final bool lostMore;
  final bool foundMore;
  final ValueChanged<ReportType?> onChanged;

  const MapTypeChips({
    super.key,
    required this.selected,
    required this.lostCount,
    required this.foundCount,
    required this.onChanged,
    this.lostMore = false,
    this.foundMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return MapGlass(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _chip(
              null,
              'All',
              compactCount(lostCount + foundCount, more: lostMore || foundMore),
              AppColors.primary,
            ),
            _chip(
              ReportType.lost,
              'Lost',
              compactCount(lostCount, more: lostMore),
              AppColors.lostPin,
            ),
            _chip(
              ReportType.found,
              'Found',
              compactCount(foundCount, more: foundMore),
              AppColors.foundPin,
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(ReportType? type, String label, String count, Color color) {
    final active = selected == type;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (type != null) ...[
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active ? Colors.white : color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: active ? Colors.white : AppColors.text,
              ),
            ),
            const SizedBox(width: 5),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: active
                    ? Colors.white.withValues(alpha: 0.25)
                    : color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: active ? Colors.white : color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPill extends StatelessWidget {
  final String text;
  final IconData icon;

  const MapPill({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.primaryDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.white),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CenterPin extends StatelessWidget {
  final bool lifted;
  final Color color;

  const CenterPin({super.key, required this.lifted, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSlide(
          offset: Offset(0, lifted ? -0.18 : 0),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: Column(
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
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.pets_rounded,
                  size: 17,
                  color: Colors.white,
                ),
              ),
              Container(width: 3, height: 14, color: color),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: lifted ? 14 : 8,
          height: lifted ? 5 : 3,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: lifted ? 0.18 : 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
