import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../pets/presentation/screens/pets_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/animated_nav_bar.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  static const _items = [
    NavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    NavItem(
      label: 'Pets',
      icon: Icons.pets_outlined,
      activeIcon: Icons.pets_rounded,
    ),
    NavItem(
      label: 'Profile',
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
  void dispose() {
    _enter.dispose();
    super.dispose();
  }

  void _select(int index) {
    if (index == _index) return;
    setState(() {
      _direction = index > _index ? 1 : -1;
      _index = index;
    });
    _enter.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
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
          items: _items,
          currentIndex: _index,
          onTap: _select,
        ),
      ),
    );
  }
}
