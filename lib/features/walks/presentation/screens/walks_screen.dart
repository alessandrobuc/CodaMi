import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/geo.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../../../map/presentation/widgets/map_style.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/walks_repository.dart';
import '../../domain/walks.dart';
import '../providers/walks_provider.dart';
import '../widgets/walk_widgets.dart';
import '../../../../core/utils/screen_space.dart';
import '../../../feedback/domain/feedback.dart';
import '../../../feedback/presentation/providers/feedback_provider.dart';

double _zoomFor(int km) => switch (km) {
  1 => 15,
  3 => 13.5,
  5 => 12.8,
  10 => 11.8,
  _ => 10.5,
};

class WalksScreen extends ConsumerStatefulWidget {
  const WalksScreen({super.key});

  @override
  ConsumerState<WalksScreen> createState() => _WalksScreenState();
}

class _WalksScreenState extends ConsumerState<WalksScreen> {
  GoogleMapController? _map;
  LatLng? _origin;
  bool _originIsMe = false;
  LatLng? _cameraCenter;
  int? _radiusKm;
  WalkGroup? _group;
  bool _showList = false;
  bool _loading = false;
  WalksError? _error;
  List<WalkPlace> _places = const [];

  @override
  void initState() {
    super.initState();
    ref.read(feedbackTrackerProvider).used(FeedbackArea.walks);
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  int get _radius =>
      _radiusKm ?? ref.read(walksConfigProvider).value?.defaultRadiusKm ?? 5;

  LatLng? get _homeCity {
    final user = ref.read(userProfileProvider).value;
    final lat = user?.homeLat, lng = user?.homeLng;
    return lat == null || lng == null ? null : LatLng(lat, lng);
  }

  // The phone's position first; the user's city when it isn't available.
  Future<void> _start() async {
    final here = await currentLocation(context);
    if (!mounted) return;
    if (here != null) {
      _originIsMe = true;
      _moveTo(here);
    } else if (_homeCity case final home?) {
      _moveTo(home);
    } else {
      setState(() {});
    }
  }

  Future<void> _useMyLocation() async {
    final here = await currentLocation(context);
    if (here == null || !mounted) return;
    _originIsMe = true;
    _moveTo(here);
  }

  void _moveTo(LatLng point) {
    setState(() => _origin = point);
    _map?.animateCamera(CameraUpdate.newLatLngZoom(point, _zoomFor(_radius)));
    _search();
  }

  Future<void> _search() async {
    final origin = _origin;
    if (origin == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final places = await ref
          .read(walksRepositoryProvider)
          .findPlaces(
            lat: origin.latitude,
            lng: origin.longitude,
            radiusKm: _radius,
            language: currentAppLanguage.code,
          );
      if (!mounted || origin != _origin) return;
      setState(() => _places = places);
    } on WalksException catch (e) {
      if (mounted) setState(() => _error = e.error);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _setRadius(int km) {
    setState(() => _radiusKm = km);
    if (_origin case final o?) {
      _map?.animateCamera(CameraUpdate.newLatLngZoom(o, _zoomFor(km)));
    }
    _search();
  }

  bool get _movedAway {
    final o = _origin, c = _cameraCenter;
    if (o == null || c == null) return false;
    return metersBetween(o.latitude, o.longitude, c.latitude, c.longitude) >
        _radius * 400;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final config = ref.watch(walksConfigProvider).value ?? const WalksConfig();
    final groups = config.activeGroups;
    final origin = _origin;
    final shown = origin == null
        ? const <WalkPlace>[]
        : placesNear(
            _places,
            origin.latitude,
            origin.longitude,
            radiusKm: _radius,
            group: groups.contains(_group) ? _group : null,
          );
    final city = ref.watch(userProfileProvider).value?.city;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.walksTitle),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: _showList ? l10n.walkShowMap : l10n.walkShowList,
            onPressed: () => setState(() => _showList = !_showList),
            icon: Icon(_showList ? Icons.map_rounded : Icons.view_list_rounded),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final g in [null, ...groups])
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: _Chip(
                      label: g?.label(l10n) ?? l10n.all,
                      icon: g?.icon,
                      color: g?.color ?? walkColor,
                      selected: _group == g,
                      onTap: () => setState(() => _group = g),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final km in walkRadiusOptionsKm)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: _Chip(
                      label: '$km km',
                      color: AppColors.text,
                      selected: _radius == km,
                      onTap: () => _setRadius(km),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 8, 4),
            child: Row(
              children: [
                Icon(
                  _originIsMe
                      ? Icons.my_location_rounded
                      : Icons.location_city_rounded,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    origin == null
                        ? ''
                        : _originIsMe
                        ? l10n.walkNearYou(shown.length)
                        : l10n.walkNearCity(shown.length, city ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                if (!_originIsMe)
                  TextButton.icon(
                    onPressed: _useMyLocation,
                    icon: const Icon(Icons.my_location_rounded, size: 16),
                    label: Text(l10n.walkUseMyLocation),
                  ),
              ],
            ),
          ),
          Expanded(
            child: origin == null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EmptyState(
                            icon: const Icon(
                              Icons.park_rounded,
                              size: 44,
                              color: walkColor,
                            ),
                            color: walkColor,
                            title: l10n.walksTitle,
                            message: l10n.walkNeedLocation,
                          ),
                          const SizedBox(height: 12),
                          FilledButton.icon(
                            onPressed: _useMyLocation,
                            style: FilledButton.styleFrom(
                              backgroundColor: walkColor,
                            ),
                            icon: const Icon(Icons.my_location_rounded),
                            label: Text(l10n.walkUseMyLocation),
                          ),
                        ],
                      ),
                    ),
                  )
                : _showList
                ? _list(shown, origin)
                : _mapView(shown, origin),
          ),
        ],
      ),
    );
  }

  Widget _status(BuildContext context, int count) {
    final l10n = context.l10n;
    final text = _loading
        ? l10n.walkSearching
        : switch (_error) {
            WalksError.limit => l10n.walkLimitReached,
            WalksError.off => l10n.walkTurnedOff,
            WalksError.unavailable => l10n.walkUnavailable,
            null => count == 0 ? l10n.walkNoPlaces : null,
          };
    if (text == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.12),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_loading)
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          if (_loading) const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapView(List<WalkPlace> shown, LatLng origin) {
    final l10n = context.l10n;
    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: origin,
              zoom: _zoomFor(_radius),
            ),
            style: codamiMapStyle,
            myLocationEnabled: _originIsMe,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (c) => _map = c,
            onCameraMove: (p) => _cameraCenter = p.target,
            onCameraIdle: () => setState(() {}),
            circles: {
              Circle(
                circleId: const CircleId('radius'),
                center: origin,
                radius: _radius * 1000.0,
                fillColor: walkColor.withValues(alpha: 0.06),
                strokeColor: walkColor.withValues(alpha: 0.5),
                strokeWidth: 1,
              ),
            },
            markers: {
              for (final p in shown)
                Marker(
                  markerId: MarkerId(p.id),
                  position: LatLng(p.lat, p.lng),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    p.group.markerHue,
                  ),
                  infoWindow: InfoWindow(title: p.name),
                  onTap: () => showWalkPlace(
                    context,
                    p,
                    meters: p.metersFrom(origin.latitude, origin.longitude),
                  ),
                ),
            },
          ),
        ),
        Positioned(
          top: 12,
          left: 16,
          right: 16,
          child: Center(
            child: _movedAway && !_loading
                ? FilledButton.icon(
                    onPressed: () {
                      _originIsMe = false;
                      _moveTo(_cameraCenter!);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.text,
                      elevation: 3,
                    ),
                    icon: const Icon(Icons.search_rounded),
                    label: Text(l10n.walkSearchHere),
                  )
                : _status(context, shown.length),
          ),
        ),
      ],
    );
  }

  Widget _list(List<WalkPlace> shown, LatLng origin) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 4, 16, endSpace(context)),
      children: [
        if (_loading || _error != null || shown.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(child: _status(context, shown.length)),
          ),
        for (final p in shown) ...[
          WalkPlaceTile(
            place: p,
            meters: p.metersFrom(origin.latitude, origin.longitude),
            onTap: () => showWalkPlace(
              context,
              p,
              meters: p.metersFrom(origin.latitude, origin.longitude),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (shown.isNotEmpty) const GoogleAttribution(),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: icon == null
          ? null
          : Icon(icon, size: 17, color: selected ? Colors.white : color),
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      selectedColor: color,
      backgroundColor: AppColors.surface,
      shape: const StadiumBorder(),
      side: BorderSide(color: selected ? color : AppColors.border),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: selected ? Colors.white : AppColors.text,
      ),
      onSelected: (_) => onTap(),
    );
  }
}
