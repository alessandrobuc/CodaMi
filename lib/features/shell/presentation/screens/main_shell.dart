import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../pets/presentation/screens/pets_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../providers/shell_provider.dart';
import '../widgets/animated_nav_bar.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell>
    with SingleTickerProviderStateMixin {
  static List<NavItem> _items(BuildContext context) => [
    NavItem(
      label: context.l10n.navHome,
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    NavItem(
      label: context.l10n.navPets,
      icon: Icons.pets_outlined,
      activeIcon: Icons.pets_rounded,
    ),
    NavItem(
      label: context.l10n.navProfile,
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  int _index = 0;
  int _direction = 1;

  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  )..value = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startPush());
  }

  void _startPush() {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null || !mounted) return;
    ref
        .read(pushServiceProvider)
        .start(
          uid: uid,
          onOpenReport: (id) => appNavigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => ReportByIdScreen(reportId: id)),
          ),
        );
  }

  @override
  void dispose() {
    _enter.dispose();
    super.dispose();
  }

  void _select(int index) {
    if (index == _index) return;
    ref.read(shellTabProvider.notifier).select(index);
    setState(() {
      _direction = index > _index ? 1 : -1;
      _index = index;
    });
    _enter.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(shellTabProvider, (_, index) => _select(index));

    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _select(0);
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: AnimatedBuilder(
          animation: _enter,
          builder: (context, child) {
            final t = Curves.easeOutCubic.transform(_enter.value);
            return Opacity(
              opacity: Curves.easeOut.transform(_enter.value),
              child: Transform.translate(
                offset: Offset(_direction * 36 * (1 - t), 0),
                child: Transform.scale(scale: 0.98 + 0.02 * t, child: child),
              ),
            );
          },
          child: IndexedStack(
            index: _index,
            children: [
              const HomeScreen(),
              const PetsScreen(),
              ProfileScreen(onOpenPets: () => _select(1)),
            ],
          ),
        ),
        bottomNavigationBar: AnimatedNavBar(
          items: _items(context),
          currentIndex: _index,
          onTap: _select,
        ),
      ),
    );
  }
}
