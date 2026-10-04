import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

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
    final info = ref.watch(currentUserInfoProvider);
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
            FloatingActionButton.extended(
              onPressed: () => SnackbarUtils.showInfo(
                context,
                'Creating reports is coming soon.',
              ),
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              elevation: 4,
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'New report',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ).animate().scale(
              delay: 300.ms,
              duration: 500.ms,
              curve: Curves.easeOutBack,
            ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.logo, width: 34, height: 34),
                  const SizedBox(width: 8),
                  Text(
                    'CodaMi',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const Spacer(),
                  _BellButton(
                    onTap: () => SnackbarUtils.showInfo(
                      context,
                      'Notifications are coming soon.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Hi, $firstName!',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Area: ${info.city ?? 'not set yet'}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _SegmentTabs(
                selected: _segment,
                onChanged: (segment) => setState(() => _segment = segment),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 16, bottom: 80),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: KeyedSubtree(
                        key: ValueKey(_segment),
                        child: _buildEmptyState(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return switch (_segment) {
      _HomeSegment.map => const EmptyState(
        icon: Icon(Icons.map_rounded),
        title: 'Map is on its way',
        message:
            'Soon you\'ll see lost and found pets around you, pinned on a live map.',
      ),
      _HomeSegment.lost => const EmptyState(
        icon: Icon(Icons.search_rounded),
        color: AppColors.lostPin,
        title: 'No lost pets nearby',
        message: 'Good news! Nobody has reported a lost pet in your area yet.',
      ),
      _HomeSegment.found => const EmptyState(
        icon: Icon(Icons.volunteer_activism_rounded),
        color: AppColors.foundPin,
        title: 'No found pets yet',
        message: 'Pets found by your neighbours will show up here.',
      ),
    };
  }
}

class _BellButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BellButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 46,
          height: 46,
          child: Icon(Icons.notifications_none_rounded, color: AppColors.text),
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
