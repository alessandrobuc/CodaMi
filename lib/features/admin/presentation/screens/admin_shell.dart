import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';
import '../../../notifications/presentation/widgets/push_banner.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../shell/presentation/widgets/animated_nav_bar.dart';
import '../../../support/data/support_repository.dart';
import '../../../support/domain/support_case.dart';
import '../../../support/presentation/providers/presence_provider.dart';
import '../../../support/presentation/screens/admin_tickets_tab.dart';
import '../../../support/presentation/screens/support_case_screen.dart';
import 'admin_dashboard_tab.dart';
import 'admin_listings_tab.dart';
import 'admin_more_tab.dart';
import 'admin_reported_tab.dart';

class _AdminTab {
  final NavItem item;
  final Widget page;

  const _AdminTab(this.item, this.page);
}

class AdminShell extends ConsumerStatefulWidget {
  const AdminShell({super.key});

  @override
  ConsumerState<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends ConsumerState<AdminShell>
    with WidgetsBindingObserver {
  int _index = 0;
  Timer? _heartbeat;
  String? _uid;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uid = ref.read(authStateProvider).value?.uid;
      if (uid == null || !mounted) return;
      _uid = uid;
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
              MaterialPageRoute(
                builder: (_) => SupportCaseScreen(caseId: id, asStaff: true),
              ),
            ),
          );
      _startHeartbeat();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _heartbeat?.cancel();
    _sendPresence(PresenceState.offline);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startHeartbeat();
    } else if (state == AppLifecycleState.paused) {
      _heartbeat?.cancel();
      _sendPresence(PresenceState.offline);
    }
  }

  // The server treats staff as offline when the heartbeat stops.
  void _startHeartbeat() {
    _heartbeat?.cancel();
    _sendCurrentPresence();
    _heartbeat = Timer.periodic(
      presenceHeartbeat,
      (_) => _sendCurrentPresence(),
    );
  }

  void _sendCurrentPresence() => _sendPresence(
    ref.read(chatAvailabilityProvider)
        ? PresenceState.online
        : PresenceState.away,
  );

  void _sendPresence(PresenceState state) {
    final uid = _uid;
    if (uid == null) return;
    ref
        .read(supportRepositoryProvider)
        .setPresence(uid, state)
        .catchError((Object e) => debugPrint('Presence update failed: $e'));
  }

  List<_AdminTab> _tabs(BuildContext context, bool isAdmin) {
    final l10n = context.l10n;
    return [
      _AdminTab(
        NavItem(
          label: l10n.adminDashboard,
          icon: Icons.space_dashboard_outlined,
          activeIcon: Icons.space_dashboard_rounded,
        ),
        const AdminDashboardTab(),
      ),
      if (isAdmin)
        _AdminTab(
          NavItem(
            label: l10n.adminListings,
            icon: Icons.campaign_outlined,
            activeIcon: Icons.campaign_rounded,
          ),
          const AdminListingsTab(),
        ),
      _AdminTab(
        NavItem(
          label: l10n.adminReportedShort,
          icon: Icons.flag_outlined,
          activeIcon: Icons.flag_rounded,
        ),
        const AdminReportedTab(),
      ),
      _AdminTab(
        NavItem(
          label: l10n.adminTicketsShort,
          icon: Icons.confirmation_number_outlined,
          activeIcon: Icons.confirmation_number_rounded,
        ),
        const AdminTicketsTab(),
      ),
      _AdminTab(
        NavItem(
          label: l10n.adminMore,
          icon: Icons.menu_rounded,
          activeIcon: Icons.menu_open_rounded,
        ),
        const AdminMoreTab(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatAvailabilityProvider, (_, _) => _sendCurrentPresence());
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final tabs = _tabs(context, isAdmin);
    final index = _index.clamp(0, tabs.length - 1);

    return PopScope(
      canPop: index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _index = 0);
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: index,
          children: [for (final tab in tabs) tab.page],
        ),
        bottomNavigationBar: AnimatedNavBar(
          items: [for (final tab in tabs) tab.item],
          currentIndex: index,
          onTap: (i) => setState(() => _index = i),
        ),
      ),
    );
  }
}
