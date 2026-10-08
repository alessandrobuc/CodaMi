import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../../reports/presentation/screens/report_detail_screen.dart';
import '../../../reports/presentation/widgets/reports_widget.dart';
import '../../../shell/presentation/providers/shell_provider.dart';
import '../../domain/clustering.dart';
import '../providers/map_provider.dart';
import '../widgets/map_style.dart';
import '../widgets/map_widget.dart';
import '../widgets/pin_icons.dart';

const _italy = LatLng(42.5, 12.5);
const _italyZoom = 5.3;
const _cityZoom = 13.0;
const _reportZoom = 15.5;
const _areaZoom = 14.5;

LatLng _point(Report r) => LatLng(r.lat, r.lng);

Future<LatLng?> currentLocation(BuildContext context) async {
  void fail(String message) {
    if (context.mounted) SnackbarUtils.showError(context, message);
  }

  try {
    if (!await Geolocator.isLocationServiceEnabled()) {
      fail('Turn on location services to use your location.');
      return null;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      fail('Allow location access in Settings to use your location.');
      return null;
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 12),
      ),
    );
    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    debugPrint('Location failed: $e');
    fail('Couldn\'t get your location. Please try again.');
    return null;
  }
}

class ReportsMapView extends ConsumerStatefulWidget {
  final bool fullscreen;
  final ReportType? initialType;

  const ReportsMapView({super.key, this.fullscreen = false, this.initialType});

  @override
  ConsumerState<ReportsMapView> createState() => _ReportsMapViewState();
}

class _ReportsMapViewState extends ConsumerState<ReportsMapView> {
  final _icons = PinIcons();
  final _locating = ValueNotifier(false);
  GoogleMapController? _map;
  late ReportType? _type = widget.initialType;
  Report? _selected;
  bool _showMyLocation = false;
  bool _centeredOnHome = false;
  bool _showAreas = false;
  int _zoomLevel = _cityZoom.floor();

  int _iconsVersion = 0;
  final _loadingIcons = <String>{};
  Object? _markersKey;
  Set<Marker> _markers = const {};
  Object? _circlesKey;
  Set<Circle> _circles = const {};

  @override
  void dispose() {
    _locating.dispose();
    _map?.dispose();
    super.dispose();
  }

  void _onCreated(GoogleMapController controller) {
    _map = controller;
    final focus = ref.read(mapFocusProvider);
    if (focus != null && !widget.fullscreen) {
      _consumeFocus(focus);
    } else {
      _centerOnHome(animate: false);
    }
  }

  void _centerOnHome({bool animate = true}) {
    final home = ref.read(homeCenterProvider);
    if (home == null) return;
    _centeredOnHome = true;
    final km = ref.read(areaRadiusProvider);
    _moveTo(
      home,
      km == null ? _cityZoom : _zoomForRadius(km),
      animate: animate,
    );
  }

  void _consumeFocus(Report? report) {
    if (report == null || _map == null || widget.fullscreen) return;
    _centeredOnHome = true;
    setState(() {
      _type = null;
      _selected = report;
    });
    _moveTo(_point(report), _reportZoom);
    Future.microtask(() => ref.read(mapFocusProvider.notifier).clear());
  }

  Future<void> _moveTo(LatLng target, double zoom, {bool animate = true}) {
    final map = _map;
    if (map == null) return Future.value();
    final update = CameraUpdate.newLatLngZoom(target, zoom);
    return animate ? map.animateCamera(update) : map.moveCamera(update);
  }

  Future<void> _select(Report report) async {
    HapticFeedback.selectionClick();
    setState(() => _selected = report);
    final zoom = await _map?.getZoomLevel() ?? _cityZoom;
    _moveTo(_point(report), zoom < 14 ? 14 : zoom);
  }

  void _goHome() {
    if (ref.read(homeCenterProvider) == null) {
      _moveTo(_italy, _italyZoom);
    } else {
      _centerOnHome();
    }
  }

  double _zoomForRadius(int km) => switch (km) {
    <= 1 => 14.3,
    <= 5 => 12,
    <= 10 => 11,
    <= 25 => 9.7,
    _ => 8.7,
  };

  Future<void> _locateMe() async {
    _locating.value = true;
    final point = await currentLocation(context);
    if (!mounted) return;
    _locating.value = false;
    if (point == null) return;
    if (!_showMyLocation) setState(() => _showMyLocation = true);
    _moveTo(point, 15);
  }

  void _openDetail(Report report) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ReportDetailScreen(report: report)),
    );
  }

  void _openFullscreen() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (_, _, _) => FullMapScreen(initialType: _type),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        ),
      ),
    );
  }

  void _ensureIcons(List<ReportCluster> clusters, String? selectedId) {
    final ratio = MediaQuery.devicePixelRatioOf(context);
    final jobs = <Future<void>>[];
    final keys = <String>[];
    for (final c in clusters) {
      if (c.isSingle) {
        final r = c.reports.first;
        final selected = r.id == selectedId;
        final key = 'pin|${r.id}|$selected';
        if (_icons.cached(r, selected: selected) != null ||
            !_loadingIcons.add(key)) {
          continue;
        }
        keys.add(key);
        jobs.add(_icons.load(r, selected: selected, pixelRatio: ratio));
      } else {
        final count = c.reports.length;
        final lost = c.lostCount;
        final key = 'cluster|$count|$lost';
        if (_icons.cachedCluster(count, lost) != null ||
            !_loadingIcons.add(key)) {
          continue;
        }
        keys.add(key);
        jobs.add(_icons.loadCluster(count, lost, pixelRatio: ratio));
      }
    }
    if (jobs.isEmpty) return;
    Future.wait(jobs).whenComplete(() {
      _loadingIcons.removeAll(keys);
      if (mounted) setState(() => _iconsVersion++);
    });
  }

  void _openCluster(ReportCluster cluster) {
    HapticFeedback.selectionClick();
    final lats = cluster.reports.map((r) => r.lat);
    final lngs = cluster.reports.map((r) => r.lng);
    final south = lats.reduce(min);
    final north = lats.reduce(max);
    final west = lngs.reduce(min);
    final east = lngs.reduce(max);
    if (north - south < 0.0003 && east - west < 0.0003) {
      _moveTo(
        LatLng(cluster.lat, cluster.lng),
        (_zoomLevel + 2).toDouble().clamp(0, 19),
      );
      return;
    }
    _map?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(south, west),
          northeast: LatLng(north, east),
        ),
        72,
      ),
    );
  }

  Set<Marker> _buildMarkers(List<Report> pins, String? selectedId) {
    final key = (
      [
        for (final r in pins)
          '${r.id}${r.coverUrl}${r.lat}${r.lng}${r.type}${r.status}',
      ],
      selectedId,
      _iconsVersion,
      _zoomLevel,
    );
    if (_markersKey is (List<String>, String?, int, int)) {
      final old = _markersKey as (List<String>, String?, int, int);
      if (listEquals(old.$1, key.$1) &&
          old.$2 == key.$2 &&
          old.$3 == key.$3 &&
          old.$4 == key.$4) {
        return _markers;
      }
    }
    _markersKey = key;

    Report? selected;
    final others = <Report>[];
    for (final r in pins) {
      r.id == selectedId ? selected = r : others.add(r);
    }
    final clusters = [
      ...clusterReports(others, _zoomLevel.toDouble()),
      if (selected != null)
        ReportCluster([selected], selected.lat, selected.lng),
    ];
    _ensureIcons(clusters, selectedId);

    return _markers = {
      for (final c in clusters)
        if (c.isSingle)
          if (_icons.cached(c.reports.first, selected: c.id == selectedId) ??
                  _icons.cached(c.reports.first, selected: false)
              case final icon?)
            Marker(
              markerId: MarkerId(c.id),
              position: LatLng(c.lat, c.lng),
              icon: icon,
              anchor: const Offset(0.5, 1),
              zIndexInt: c.id == selectedId ? 3 : 1,
              consumeTapEvents: true,
              onTap: () => _select(c.reports.first),
            )
          else
            ...[]
        else if (_icons.cachedCluster(c.reports.length, c.lostCount)
            case final icon?)
          Marker(
            markerId: MarkerId(c.id),
            position: LatLng(c.lat, c.lng),
            icon: icon,
            anchor: const Offset(0.5, 0.5),
            zIndexInt: 2,
            consumeTapEvents: true,
            onTap: () => _openCluster(c),
          ),
    };
  }

  Future<void> _onCameraIdle() async {
    final zoom = await _map?.getZoomLevel();
    if (zoom == null || !mounted) return;
    final level = zoom.floor();
    final show = zoom >= _areaZoom;
    if (level != _zoomLevel || show != _showAreas) {
      setState(() {
        _zoomLevel = level;
        _showAreas = show;
      });
    }
  }

  Set<Circle> _buildCircles(List<Report> pins, LatLng? home, int? km) {
    final key = (
      [
        if (_showAreas)
          for (final r in pins)
            '${r.id}${r.lat}${r.lng}${r.areaRadius}${r.status}',
      ],
      home,
      km,
    );
    if (_circlesKey is (List<String>, LatLng?, int?)) {
      final old = _circlesKey as (List<String>, LatLng?, int?);
      if (listEquals(old.$1, key.$1) && old.$2 == key.$2 && old.$3 == key.$3) {
        return _circles;
      }
    }
    _circlesKey = key;
    return _circles = {
      if (home != null && km != null)
        Circle(
          circleId: const CircleId('radius'),
          center: home,
          radius: km * 1000.0,
          fillColor: AppColors.primary.withValues(alpha: 0.04),
          strokeColor: AppColors.primary.withValues(alpha: 0.45),
          strokeWidth: 2,
        ),
      if (_showAreas)
        for (final r in pins)
          if (r.areaRadius != null)
            Circle(
              circleId: CircleId('area-${r.id}'),
              center: _point(r),
              radius: r.areaRadius!.toDouble(),
              fillColor: pinColor(r).withValues(alpha: 0.14),
              strokeColor: pinColor(r).withValues(alpha: 0.55),
              strokeWidth: 2,
            ),
    };
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mapFocusProvider, (_, report) => _consumeFocus(report));
    ref.listen(areaRadiusProvider, (_, _) => _goHome());
    ref.listen(homeCenterProvider, (previous, home) {
      if (previous == null && home != null && !_centeredOnHome) {
        _centerOnHome();
      }
    });

    final lostState = ref.watch(mapAreaReportsProvider(ReportType.lost));
    final foundState = ref.watch(mapAreaReportsProvider(ReportType.found));
    final lost = lostState.value ?? const <Report>[];
    final open = foundState.value ?? const <Report>[];
    final resolved =
        ref.watch(areaResolvedReportsProvider).value ?? const <Report>[];
    final found = [...open, ...resolved];
    final loading = !lostState.hasValue || !foundState.hasValue;
    final failed =
        (lostState.hasError && !lostState.hasValue) ||
        (foundState.hasError && !foundState.hasValue);

    final home = ref.watch(homeCenterProvider);
    final km = ref.watch(areaRadiusProvider);

    final visible = switch (_type) {
      ReportType.lost => lost,
      ReportType.found => found,
      null => [...found, ...lost],
    };
    final selected = _selected == null
        ? null
        : [
            ...lost,
            ...found,
          ].firstWhere((r) => r.id == _selected!.id, orElse: () => _selected!);
    final pins = [
      for (final r in visible)
        if (r.id != selected?.id) r,
      ?selected,
    ];

    final padding = MediaQuery.paddingOf(context);
    final top = widget.fullscreen ? padding.top + 12 : 12.0;
    final bottom = widget.fullscreen ? padding.bottom + 20 : 84.0;
    const cardHeight = 128.0;

    final map = GoogleMap(
      initialCameraPosition: CameraPosition(
        target: home ?? _italy,
        zoom: home == null ? _italyZoom : _cityZoom,
      ),
      style: codamiMapStyle,
      markers: _buildMarkers(pins, selected?.id),
      circles: _buildCircles(pins, home, km),
      onMapCreated: _onCreated,
      onCameraIdle: _onCameraIdle,
      onTap: (_) {
        if (_selected != null) setState(() => _selected = null);
      },
      myLocationEnabled: _showMyLocation,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      buildingsEnabled: false,
      indoorViewEnabled: false,
      trafficEnabled: false,
      padding: EdgeInsets.only(
        top: top,
        bottom: widget.fullscreen ? padding.bottom : 0,
      ),
    );

    final content = Stack(
      children: [
        Positioned.fill(child: map),
        if (widget.fullscreen)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: padding.top + 28,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.background,
                      AppColors.background.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          top: top,
          left: widget.fullscreen ? 72 : 12,
          right: 68,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: MapTypeChips(
                selected: _type,
                lostCount: lost.length,
                foundCount: found.length,
                lostMore: ref.watch(mapHasMoreProvider(ReportType.lost)),
                foundMore: ref.watch(mapHasMoreProvider(ReportType.found)),
                onChanged: (type) => setState(() {
                  _type = type;
                  if (type != null && selected?.type != type) {
                    _selected = null;
                  }
                }),
              ),
            ),
          ),
        ),
        Positioned(
          top: top,
          left: widget.fullscreen ? 12 : null,
          right: widget.fullscreen ? null : 12,
          child: widget.fullscreen
              ? MapIconButton(
                  icon: Icons.arrow_back_rounded,
                  tooltip: 'Back',
                  onTap: () => Navigator.of(context).pop(),
                )
              : MapIconButton(
                  icon: Icons.open_in_full_rounded,
                  tooltip: 'Full screen',
                  onTap: _openFullscreen,
                ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          right: 12,
          bottom: selected == null ? bottom : bottom + cardHeight + 12,
          child: MapControlPill(
            locating: _locating,
            onZoomIn: () => _map?.animateCamera(CameraUpdate.zoomIn()),
            onZoomOut: () => _map?.animateCamera(CameraUpdate.zoomOut()),
            onLocate: _locateMe,
            onHome: _goHome,
          ),
        ),
        if (loading || failed || (visible.isEmpty && selected == null))
          Positioned(
            top: top + 56,
            left: 0,
            right: 0,
            child: Center(
              child: MapPill(
                icon: loading
                    ? Icons.hourglass_top_rounded
                    : failed
                    ? Icons.cloud_off_rounded
                    : Icons.pets_rounded,
                text: loading
                    ? 'Loading pets…'
                    : failed
                    ? 'Couldn\'t load reports. Check your connection.'
                    : switch (_type) {
                        ReportType.lost => 'No lost pets in this area',
                        ReportType.found => 'No found pets in this area',
                        null => 'No lost or found pets in this area',
                      },
              ).animate().fadeIn(duration: 250.ms),
            ),
          ),
        Positioned(
          left: 12,
          right: 12,
          bottom: bottom,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: selected == null
                ? const SizedBox.shrink()
                : ReportCard(
                    key: ValueKey(selected.id),
                    report: selected,
                    onTap: () => _openDetail(selected),
                  ),
          ),
        ),
      ],
    );

    if (widget.fullscreen) return content;
    return ClipRRect(borderRadius: BorderRadius.circular(26), child: content);
  }
}

class FullMapScreen extends StatelessWidget {
  final ReportType? initialType;

  const FullMapScreen({super.key, this.initialType});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: ReportsMapView(fullscreen: true, initialType: initialType),
      ),
    );
  }
}
