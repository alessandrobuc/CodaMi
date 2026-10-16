import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../shell/presentation/widgets/animated_nav_bar.dart';
import 'admin_dashboard_tab.dart';
import 'admin_more_tab.dart';
import 'admin_soon_tab.dart';

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

class _AdminShellState extends ConsumerState<AdminShell> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uid = ref.read(authStateProvider).value?.uid;
      if (uid != null && mounted) {
        ref.read(localeProvider.notifier).saveToProfile(uid);
      }
    });
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
          AdminSoonTab(icon: Icons.campaign_rounded, title: l10n.adminListings),
        ),
      _AdminTab(
        NavItem(
          label: l10n.adminReportedShort,
          icon: Icons.flag_outlined,
          activeIcon: Icons.flag_rounded,
        ),
        AdminSoonTab(
          icon: Icons.flag_rounded,
          title: l10n.adminReportedContent,
        ),
      ),
      _AdminTab(
        NavItem(
          label: l10n.adminTicketsShort,
          icon: Icons.confirmation_number_outlined,
          activeIcon: Icons.confirmation_number_rounded,
        ),
        AdminSoonTab(
          icon: Icons.confirmation_number_rounded,
          title: l10n.adminTickets,
        ),
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
