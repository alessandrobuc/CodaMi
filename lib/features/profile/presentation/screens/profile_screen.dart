import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../location/presentation/screens/city_setup_screen.dart';
import '../../../reports/presentation/screens/my_reports_screen.dart';
import '../providers/profile_provider.dart';
import 'language_screen.dart';
import '../widgets/delete_account_dialog.dart';
import '../../../legal/legal_content.dart';
import '../../../legal/legal_screen.dart';
import '../../../moderation/presentation/screens/blocked_users_screen.dart';
import '../../../notifications/presentation/screens/notification_settings_screen.dart';
import '../../../support/presentation/screens/help_support_screen.dart';
import '../../../emergency/presentation/screens/emergencies_screen.dart';
import '../../../emergency/presentation/screens/emergency_contacts_screen.dart';
import '../../../points/presentation/screens/invite_screen.dart';
import '../../../points/presentation/screens/points_screen.dart';
import '../../../points/presentation/widgets/points_widgets.dart';
import '../../../feedback/presentation/widgets/feedback_sheet.dart';
import '../../../petitions/presentation/screens/petitions_screen.dart';
import '../../../petitions/presentation/widgets/petition_widgets.dart';
import '../../../whats_new/presentation/screens/whats_new_screen.dart';
import '../../../app_update/data/app_update_repository.dart';
import '../../../app_update/presentation/update_widgets.dart';
import 'package:in_app_review/in_app_review.dart';

class ProfileScreen extends ConsumerWidget {
  final VoidCallback onOpenPets;

  const ProfileScreen({super.key, required this.onOpenPets});

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.signOutTitle),
        content: Text(context.l10n.signOutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(context.l10n.signOut),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authProvider.notifier).logout();
    }
  }

  Future<void> _confirmDeleteAccount(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await confirmAccountDeletion(context);
    if (!confirmed || !context.mounted) return;

    final navigator = Navigator.of(context, rootNavigator: true);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
              const SizedBox(width: 18),
              Expanded(child: Text(context.l10n.deletingAccount)),
            ],
          ),
        ),
      ),
    );
    try {
      await ref.read(authProvider.notifier).deleteAccount();
      navigator.pop();
    } catch (e) {
      navigator.pop();
      if (context.mounted) SnackbarUtils.showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(currentUserInfoProvider);
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final language = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          children: [
            Text(
              l10n.profileTitle,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.surface,
                      foregroundImage: info.photoUrl != null
                          ? NetworkImage(info.photoUrl!)
                          : null,
                      child: Text(
                        info.initials,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (info.email.isNotEmpty)
                          Text(
                            info.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: 24),
            _SectionCard(
              children: [
                _ProfileTile(
                  icon: Icons.pets_rounded,
                  color: AppColors.accent,
                  title: l10n.myPets,
                  onTap: onOpenPets,
                ),
                _ProfileTile(
                  icon: Icons.campaign_rounded,
                  color: AppColors.lostPin,
                  title: l10n.myReports,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MyReportsScreen()),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.location_city_rounded,
                  color: AppColors.primary,
                  title: l10n.homeCity,
                  subtitle: info.city ?? l10n.notSet,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CitySetupScreen(isEditing: true),
                    ),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.translate_rounded,
                  color: AppColors.accent,
                  title: l10n.language,
                  subtitle: '${language.flag}  ${language.nativeName}',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LanguageScreen()),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.block_rounded,
                  color: AppColors.danger,
                  title: l10n.blockedUsers,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const BlockedUsersScreen(),
                    ),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.notifications_none_rounded,
                  color: AppColors.primaryDark,
                  title: l10n.notifications,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationSettingsScreen(),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 16),
            _SectionCard(
              children: [
                _ProfileTile(
                  icon: Icons.stars_rounded,
                  color: pointsColor,
                  title: l10n.myPoints,
                  subtitle: l10n.pointsTotal(
                    ref.watch(userProfileProvider).value?.points ?? 0,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PointsScreen()),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.group_add_rounded,
                  color: AppColors.primary,
                  title: l10n.inviteFriends,
                  subtitle: l10n.inviteFriendsSubtitle,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const InviteScreen()),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.emergency_rounded,
                  color: AppColors.danger,
                  title: l10n.emergencies,
                  subtitle: l10n.emergenciesSubtitle,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const EmergenciesScreen(),
                    ),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.contact_phone_rounded,
                  color: AppColors.danger,
                  title: l10n.emergencyContacts,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const EmergencyContactsScreen(),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 125.ms, duration: 400.ms),
            const SizedBox(height: 16),
            _SectionCard(
              children: [
                _ProfileTile(
                  icon: Icons.campaign_rounded,
                  color: petitionColor,
                  title: l10n.petitions,
                  subtitle: l10n.petitionsSubtitle,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PetitionsScreen()),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.support_agent_rounded,
                  color: AppColors.primary,
                  title: l10n.helpSupport,
                  subtitle: l10n.helpSupportSubtitle,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HelpSupportScreen(),
                    ),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.rate_review_rounded,
                  color: pointsColor,
                  title: l10n.feedbackSend,
                  subtitle: l10n.sendFeedbackSubtitle,
                  onTap: () => showFeedbackSheet(context),
                ),
                if (defaultTargetPlatform == TargetPlatform.android)
                  _ProfileTile(
                    icon: Icons.star_rounded,
                    color: AppColors.accent,
                    title: l10n.rateCodaMi,
                    subtitle: l10n.rateCodaMiSubtitle,
                    onTap: () => InAppReview.instance.openStoreListing(),
                  )
                else if (ref.watch(appVersionConfigProvider).value?.appStoreId
                    case final id? when id.isNotEmpty)
                  _ProfileTile(
                    icon: Icons.star_rounded,
                    color: AppColors.accent,
                    title: l10n.rateCodaMi,
                    subtitle: l10n.rateCodaMiSubtitleIos,
                    onTap: () =>
                        InAppReview.instance.openStoreListing(appStoreId: id),
                  ),
                if (ref.watch(appUpdateProvider) case final update
                    when update.outdated)
                  _ProfileTile(
                    icon: Icons.system_update_rounded,
                    color: AppColors.primary,
                    title: l10n.updateAvailableTitle,
                    subtitle: l10n.updateBanner(update.latest),
                    onTap: () => showUpdateSheet(context),
                  ),
                _ProfileTile(
                  icon: Icons.auto_awesome_rounded,
                  color: AppColors.primary,
                  title: l10n.whatsNew,
                  subtitle: l10n.whatsNewSubtitle,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const WhatsNewScreen()),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.privacy_tip_outlined,
                  color: AppColors.primary,
                  title: l10n.privacyPolicy,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          const LegalScreen(document: LegalDocument.privacy),
                    ),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.description_outlined,
                  color: AppColors.primaryDark,
                  title: l10n.termsOfUse,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          const LegalScreen(document: LegalDocument.terms),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => _confirmLogout(context, ref),
              icon: const Icon(Icons.logout_rounded),
              label: Text(l10n.signOut),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.danger,
                minimumSize: const Size.fromHeight(54),
                side: const BorderSide(color: AppColors.danger),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _confirmDeleteAccount(context, ref),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textMuted,
                minimumSize: const Size.fromHeight(44),
              ),
              child: Text(l10n.deleteAccount),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;

  const _SectionCard({required this.children});

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
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, indent: 64, color: AppColors.border),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
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
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textMuted,
      ),
    );
  }
}
