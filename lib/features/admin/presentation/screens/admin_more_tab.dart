import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/language_picker.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../support/data/support_repository.dart';
import '../../../support/domain/support_case.dart';
import '../../../support/presentation/screens/operators_screen.dart';
import 'admin_users_screen.dart';
import 'admin_videos_screen.dart';
import 'support_staff_screen.dart';
import '../../../emergency/presentation/screens/admin_contacts_screen.dart';
import '../../../emergency/presentation/screens/admin_emergencies_screen.dart';
import '../../../emergency/presentation/screens/admin_emergency_settings_screen.dart';
import '../../../points/presentation/screens/admin_points_settings_screen.dart';
import '../../../points/presentation/screens/admin_referrals_screen.dart';
import '../../../points/presentation/widgets/points_widgets.dart';

class AdminMoreTab extends ConsumerWidget {
  const AdminMoreTab({super.key});

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.signOutTitle),
        content: Text(l10n.signOutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.signOut),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid != null) {
      await ref
          .read(supportRepositoryProvider)
          .setPresence(uid, PresenceState.offline)
          .catchError((Object e) => debugPrint('Presence update failed: $e'));
    }
    await ref.read(authProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final info = ref.watch(currentUserInfoProvider);
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final language = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          children: [
            Text(
              l10n.adminMore,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.admin_panel_settings_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${info.email} · ${isAdmin ? l10n.roleAdmin : l10n.roleSupport}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (isAdmin) ...[
              _Group(
                children: [
                  _Tile(
                    icon: Icons.support_agent_rounded,
                    color: AppColors.primary,
                    title: l10n.supportStaff,
                    subtitle: l10n.supportStaffSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SupportStaffScreen(),
                      ),
                    ),
                  ),
                  _Tile(
                    icon: Icons.insights_rounded,
                    color: AppColors.lostPin,
                    title: l10n.supportOperators,
                    subtitle: l10n.supportOperatorsSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const OperatorsScreen(),
                      ),
                    ),
                  ),
                  _Tile(
                    icon: Icons.people_alt_rounded,
                    color: AppColors.primaryDark,
                    title: l10n.adminUsers,
                    subtitle: l10n.adminUsersSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AdminUsersScreen(),
                      ),
                    ),
                  ),
                  _Tile(
                    icon: Icons.smart_display_rounded,
                    color: AppColors.accent,
                    title: l10n.adminVideos,
                    subtitle: l10n.adminVideosSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AdminVideosScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            _Group(
              children: [
                _Tile(
                  icon: Icons.emergency_rounded,
                  color: AppColors.danger,
                  title: l10n.emergencies,
                  subtitle: l10n.adminEmergenciesSubtitle,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AdminEmergenciesScreen(),
                    ),
                  ),
                ),
                if (isAdmin) ...[
                  _Tile(
                    icon: Icons.contact_phone_rounded,
                    color: AppColors.danger,
                    title: l10n.emergencyContacts,
                    subtitle: l10n.adminContactsSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AdminContactsScreen(),
                      ),
                    ),
                  ),
                  _Tile(
                    icon: Icons.tune_rounded,
                    color: AppColors.danger,
                    title: l10n.emergencySettings,
                    subtitle: l10n.emergencySettingsSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AdminEmergencySettingsScreen(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            if (isAdmin) ...[
              _Group(
                children: [
                  _Tile(
                    icon: Icons.stars_rounded,
                    color: pointsColor,
                    title: l10n.pointsSettings,
                    subtitle: l10n.pointsSettingsSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AdminPointsSettingsScreen(),
                      ),
                    ),
                  ),
                  _Tile(
                    icon: Icons.policy_rounded,
                    color: pointsColor,
                    title: l10n.invitesToReview,
                    subtitle: l10n.invitesToReviewSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AdminReferralsScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            _Group(
              children: [
                _Tile(
                  icon: Icons.translate_rounded,
                  color: AppColors.accent,
                  title: l10n.language,
                  subtitle: '${language.flag}  ${language.nativeName}',
                  onTap: () => showLanguagePicker(context),
                ),
                _Tile(
                  icon: Icons.logout_rounded,
                  color: AppColors.danger,
                  title: l10n.signOut,
                  onTap: () => _signOut(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  final List<Widget> children;

  const _Group({required this.children});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (final (i, child) in children.indexed) ...[
            if (i > 0)
              const Divider(height: 1, indent: 66, color: AppColors.border),
            child,
          ],
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _Tile({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 12.5,
                color: AppColors.textMuted,
              ),
            ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textMuted,
      ),
    );
  }
}
