import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../map/presentation/providers/map_provider.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../reports/domain/entities/reports_entity.dart';
import '../../../reports/presentation/screens/create_report_screen.dart';
import '../../../reports/presentation/screens/reports_screen.dart';
import '../../../shell/presentation/providers/shell_provider.dart';

enum _HomeSegment { map, lost, found }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  _HomeSegment _segment = _HomeSegment.map;

  @override
  Widget build(BuildContext context) {
    ref.listen(mapFocusProvider, (_, report) {
      if (report != null) setState(() => _segment = _HomeSegment.map);
    });
    final info = ref.watch(currentUserInfoProvider);
    final radius = ref.watch(areaRadiusProvider);
    final firstName = info.firstName;
    final textTheme = Theme.of(context).textTheme;
    final navBarHeight =
        MediaQuery.paddingOf(context).bottom -
        MediaQuery.viewPaddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: navBarHeight.clamp(0, double.infinity),
        ),
        child:
            _ReportButton(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const CreateReportScreen(),
                ),
              ),
            ).animate().scale(
              delay: 300.ms,
              duration: 500.ms,
              curve: Curves.easeOutBack,
            ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, $firstName!',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        _AreaChip(
                          city: info.city,
                          radius: radius,
                          onTap: info.city == null ? null : _pickRadius,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _BellButton(
                    unread: ref.watch(unreadNotificationsProvider),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SegmentTabs(
                selected: _segment,
                onChanged: (segment) => setState(() => _segment = segment),
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    for (final segment in _HomeSegment.values)
                      _SegmentPage(
                        active: segment == _segment,
                        child: _buildSegment(segment),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegment(_HomeSegment segment) {
    return switch (segment) {
      _HomeSegment.map => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 12),
        child: const ReportsMapView(),
      ),
      _HomeSegment.lost => const ReportsListView(type: ReportType.lost),
      _HomeSegment.found => const ReportsListView(type: ReportType.found),
    };
  }

  Future<void> _pickRadius() async {
    final current = ref.read(areaRadiusProvider);
    final city = ref.read(currentUserInfoProvider).city ?? '';
    final picked = await showModalBottomSheet<(int?,)>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Show pets within',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Distance from $city',
                style: const TextStyle(color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final km in [...areaRadiusOptions, null])
                    ChoiceChip(
                      label: Text(km == null ? 'Everywhere' : '$km km'),
                      selected: km == current,
                      showCheckmark: false,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: km == current ? Colors.white : AppColors.text,
                      ),
                      onSelected: (_) => Navigator.pop(context, (km,)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) ref.read(areaRadiusProvider.notifier).set(picked.$1);
  }
}

class _AreaChip extends StatelessWidget {
  final String? city;
  final int? radius;
  final VoidCallback? onTap;

  const _AreaChip({
    required this.city,
    required this.radius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = city == null
        ? 'Area not set yet'
        : radius == null
        ? '$city · Everywhere'
        : '$city · within $radius km';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.expand_more_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentPage extends StatelessWidget {
  final bool active;
  final Widget child;

  const _SegmentPage({required this.active, required this.child});

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !active,
      child: TickerMode(
        enabled: active,
        child: AnimatedOpacity(
          opacity: active ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: AnimatedSlide(
            offset: Offset(0, active ? 0 : 0.02),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _ReportButton extends StatefulWidget {
  final VoidCallback onTap;

  const _ReportButton({required this.onTap});

  @override
  State<_ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<_ReportButton> {
  bool _pressed = false;

  void _press(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Report a lost or found pet',
      child: GestureDetector(
        onTapDown: (_) => _press(true),
        onTapCancel: () => _press(false),
        onTapUp: (_) => _press(false),
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        child: AnimatedScale(
          scale: _pressed ? 0.94 : 1,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            height: 56,
            padding: const EdgeInsets.fromLTRB(8, 8, 22, 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF7B276), Color(0xFFE9803A)],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFFE9803A,
                  ).withValues(alpha: _pressed ? 0.25 : 0.42),
                  blurRadius: _pressed ? 10 : 22,
                  offset: Offset(0, _pressed ? 4 : 10),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Report a pet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BellButton extends StatelessWidget {
  final int unread;
  final VoidCallback onTap;

  const _BellButton({required this.unread, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Icon(
                unread > 0
                    ? Icons.notifications_rounded
                    : Icons.notifications_none_rounded,
                color: AppColors.text,
              ),
              if (unread > 0)
                Positioned(
                  top: 6,
                  right: 4,
                  child:
                      Container(
                            constraints: const BoxConstraints(minWidth: 19),
                            height: 19,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.lostPin,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.surface,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              unread > 9 ? '9+' : '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                          .animate(key: ValueKey(unread))
                          .scale(duration: 400.ms, curve: Curves.elasticOut),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentTabs extends StatelessWidget {
  final _HomeSegment selected;
  final ValueChanged<_HomeSegment> onChanged;

  const _SegmentTabs({required this.selected, required this.onChanged});

  static const _labels = {
    _HomeSegment.map: 'Map',
    _HomeSegment.lost: 'Lost',
    _HomeSegment.found: 'Found',
  };

  @override
  Widget build(BuildContext context) {
    final index = _HomeSegment.values.indexOf(selected);

    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(-1 + index * 1.0, 0),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            child: FractionallySizedBox(
              widthFactor: 1 / 3,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (final segment in _HomeSegment.values)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(segment),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          fontFamily: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: segment == selected
                              ? Colors.white
                              : AppColors.textMuted,
                        ),
                        child: Text(_labels[segment]!),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
