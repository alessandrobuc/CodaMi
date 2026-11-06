import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../notifications/presentation/providers/notification_settings_provider.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';
import '../../../notifications/presentation/widgets/push_banner.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../pets/presentation/screens/pets_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../support/presentation/screens/support_case_screen.dart';
import '../../../videos/presentation/screens/videos_screen.dart';
import '../providers/shell_provider.dart';
import '../widgets/animated_nav_bar.dart';
import '../../../emergency/presentation/screens/emergency_screen.dart';
import '../../../feedback/presentation/feedback_asks.dart';
import '../../../feedback/presentation/providers/feedback_provider.dart';
import '../../../feedback/presentation/startup_prompts.dart';
import '../../../points/data/points_repository.dart';
import '../../../points/presentation/providers/points_provider.dart';
import '../../../shop/presentation/providers/shop_provider.dart';
import '../../../shop/presentation/screens/shop_screen.dart';
import '../../../schedule/presentation/providers/schedule_provider.dart';
import '../../../schedule/presentation/screens/schedule_screen.dart';
import '../../../sharing/presentation/deep_links.dart';
import '../../../sharing/presentation/screens/share_app_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell>
    with SingleTickerProviderStateMixin {
  static const _shopIndex = 3;

  static List<NavItem> _items(BuildContext context, {required bool shop}) => [
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
      label: context.l10n.navVideos,
      icon: Icons.smart_display_outlined,
      activeIcon: Icons.smart_display_rounded,
    ),
    if (shop)
      NavItem(
        label: context.l10n.navShop,
        icon: Icons.storefront_outlined,
        activeIcon: Icons.storefront_rounded,
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
    pendingReportLink.addListener(_openReportLink);
    WidgetsBinding.instance.addPostFrameCallback((_) => _openReportLink());
  }

  void _openReportLink() {
    final id = pendingReportLink.value;
    if (id == null || !mounted) return;
    pendingReportLink.value = null;
    appNavigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => ReportByIdScreen(reportId: id)),
    );
  }

  void _startPush() {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null || !mounted) return;
    ref.read(localeProvider.notifier).saveToProfile(uid);
    ref
        .read(pushServiceProvider)
        .start(
          uid: uid,
          onOpenReport: (id) => appNavigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => ReportByIdScreen(reportId: id)),
          ),
          onForeground: showPushBanner,
          onOpenCase: (id) => appNavigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => SupportCaseScreen(caseId: id)),
          ),
          onOpenEmergency: (id) => appNavigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => EmergencyScreen(emergencyId: id)),
          ),
          onOpenSchedule: (id) => appNavigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => ScheduleScreen(openEventId: id)),
          ),
          onOpenShareReminder: () => appNavigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => const ShareAppScreen(fromReminder: true),
            ),
          ),
        );
    syncScheduleReminders(
      ref.read(scheduleRepositoryProvider),
      context.l10n,
      uid,
    );
    ref.read(notificationSettingsProvider).restoreChannels();
    ref.read(pointsRepositoryProvider).registerVisit();
    ref.read(activeTimeProvider);
    runStartupPrompts(context, ref, isIdle: _isIdle);
  }

  // On Home, with nothing opened on top and the app on screen.
  bool _isIdle() => _index == 0 && _isFree();

  // On any tab, with nothing opened on top and the app on screen.
  bool _isFree() =>
      mounted &&
      (ModalRoute.of(context)?.isCurrent ?? false) &&
      WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;

  @override
  void dispose() {
    pendingReportLink.removeListener(_openReportLink);
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
    ref.listen(pendingFeedbackAskProvider, (_, area) {
      if (area == null) return;
      ref.read(pendingFeedbackAskProvider.notifier).clear();
      askFeedbackWhenIdle(context, ref, area, isIdle: _isFree);
    });
    // Keeps the same tab selected when the Shop tab appears or disappears.
    ref.listen(shopEnabledProvider, (was, now) {
      if (was == now || _index < _shopIndex) return;
      setState(() {
        _index = now
            ? _index + 1
            : _index == _shopIndex
            ? 0
            : _index - 1;
      });
    });
    final shop = ref.watch(shopEnabledProvider);

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
              const HomeScreen(key: ValueKey('home')),
              const PetsScreen(key: ValueKey('pets')),
              const VideosScreen(key: ValueKey('videos')),
              if (shop) const ShopScreen(key: ValueKey('shop')),
              ProfileScreen(
                key: const ValueKey('profile'),
                onOpenPets: () => _select(1),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AnimatedNavBar(
          items: _items(context, shop: shop),
          currentIndex: _index,
          onTap: _select,
        ),
      ),
    );
  }
}
