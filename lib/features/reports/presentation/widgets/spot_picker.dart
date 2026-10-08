import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/geo.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../../../map/presentation/widgets/map_style.dart';
import '../../../map/presentation/widgets/map_widget.dart';

class SpotPicker extends StatefulWidget {
  final LatLng center;
  final LatLng? spot;
  final Color color;
  final ValueChanged<LatLng> onMoved;

  const SpotPicker({
    super.key,
    required this.center,
    required this.spot,
    required this.color,
    required this.onMoved,
  });

  @override
  State<SpotPicker> createState() => _SpotPickerState();
}

class _SpotPickerState extends State<SpotPicker> {
  static const _height = 280.0;
  static const _pinnedZoom = 16.5;

  GoogleMapController? _map;
  late final _camera = ValueNotifier(
    CameraPosition(
      target: widget.spot ?? widget.center,
      zoom: widget.spot == null ? 14 : _pinnedZoom,
    ),
  );
  final _moving = ValueNotifier(false);
  final _locating = ValueNotifier(false);
  bool _touched = false;
  LatLng? _reported;

  @override
  void didUpdateWidget(SpotPicker old) {
    super.didUpdateWidget(old);
    final spot = widget.spot;
    if (spot != null && spot != _reported && spot != old.spot) {
      _reported = spot;
      _map?.animateCamera(CameraUpdate.newLatLngZoom(spot, _pinnedZoom));
    } else if (spot == null && widget.center != old.center) {
      _map?.moveCamera(CameraUpdate.newLatLngZoom(widget.center, 14));
    }
  }

  @override
  void dispose() {
    _camera.dispose();
    _moving.dispose();
    _locating.dispose();
    _map?.dispose();
    super.dispose();
  }

  void _onIdle() {
    _moving.value = false;
    if (!_touched) return;
    _touched = false;
    final target = _camera.value.target;
    _reported = target;
    HapticFeedback.selectionClick();
    widget.onMoved(target);
  }

  Future<void> _useMyLocation() async {
    _locating.value = true;
    final point = await currentLocation(context);
    if (!mounted) return;
    _locating.value = false;
    if (point == null) return;
    _touched = true;
    await _map?.animateCamera(CameraUpdate.newLatLngZoom(point, _pinnedZoom));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Stack(
          children: [
            Positioned.fill(
              child: Listener(
                onPointerDown: (_) => _touched = true,
                child: GoogleMap(
                  initialCameraPosition: _camera.value,
                  style: codamiMapStyle,
                  onMapCreated: (c) => _map = c,
                  onCameraMoveStarted: () => _moving.value = true,
                  onCameraMove: (p) => _camera.value = p,
                  onCameraIdle: _onIdle,
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                      EagerGestureRecognizer.new,
                    ),
                  },
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  buildingsEnabled: false,
                ),
              ),
            ),
            IgnorePointer(
              child: ValueListenableBuilder<CameraPosition>(
                valueListenable: _camera,
                builder: (context, camera, _) {
                  final size =
                      2 *
                      publicAreaRadius /
                      metersPerLogicalPixel(
                        camera.target.latitude,
                        camera.zoom,
                      );
                  return Center(
                    child: Container(
                      width: size.clamp(0, 1000),
                      height: size.clamp(0, 1000),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withValues(alpha: 0.12),
                        border: Border.all(
                          color: widget.color.withValues(alpha: 0.55),
                          width: 1.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            IgnorePointer(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 56),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _moving,
                    builder: (context, moving, _) =>
                        CenterPin(lifted: moving, color: widget.color),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: MapGlass(
                borderRadius: BorderRadius.circular(18),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: _useMyLocation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: _locating,
                            builder: (context, busy, _) => busy
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.my_location_rounded,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            'Use my location',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
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
