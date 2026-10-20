import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/admin_repository.dart';
import '../providers/admin_provider.dart';
import 'admin_users_screen.dart';

class AdminUserScreen extends ConsumerStatefulWidget {
  final String uid;

  const AdminUserScreen({super.key, required this.uid});

  @override
  ConsumerState<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends ConsumerState<AdminUserScreen> {
  bool _busy = false;

  Future<bool> _confirm({
    required IconData icon,
    required String title,
    required String message,
    required String action,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(icon, color: AppColors.danger, size: 32),
          title: Text(title),
          content: Text(message, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              child: Text(action),
            ),
          ],
        ),
      ) ==
      true;

  Future<bool> _run(Future<void> Function() action, String success) async {
    setState(() => _busy = true);
    try {
      await action();
      HapticFeedback.lightImpact();
      if (mounted) SnackbarUtils.showSuccess(context, success);
      return true;
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
      return false;
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _toggleDisabled(UserModel user, String name) async {
    final l10n = context.l10n;
    final repo = ref.read(adminRepositoryProvider);
    if (user.disabled) {
      await _run(
        () => repo.setDisabled(user.uid, disabled: false),
        l10n.accountEnabled,
      );
      return;
    }
    final confirmed = await _confirm(
      icon: Icons.person_off_rounded,
      title: l10n.disableUserTitle(name),
      message: l10n.disableUserMessage,
      action: l10n.disableAccount,
    );
    if (!confirmed) return;
    await _run(
      () => repo.setDisabled(user.uid, disabled: true),
      l10n.accountDisabled,
    );
  }

  Future<void> _setStaff(UserModel user, String name, bool staff) async {
    final l10n = context.l10n;
    if (!staff) {
      final confirmed = await _confirm(
        icon: Icons.person_remove_alt_1_rounded,
        title: l10n.removeStaffTitle(name),
        message: '${l10n.removeStaffMessage} ${l10n.removeStaffCasesNote}',
        action: l10n.remove,
      );
      if (!confirmed) return;
    }
    await _run(
      () => ref
          .read(adminRepositoryProvider)
          .setRole(user.uid, staff ? UserRole.support : UserRole.user),
      staff ? l10n.staffAdded(name) : l10n.staffRemoved(name),
    );
  }

  Future<void> _delete(UserModel user, String name) async {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final confirmed = await _confirm(
      icon: Icons.delete_forever_rounded,
      title: l10n.deleteUserTitle(name),
      message: l10n.deleteUserMessage,
      action: l10n.delete,
    );
    if (!confirmed) return;
    final deleted = await _run(
      () => ref.read(adminRepositoryProvider).deleteUser(user.uid),
      l10n.userDeleted,
    );
    if (deleted) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(adminUserProvider(widget.uid));
    final user = state.value;
    final isMe = ref.watch(authStateProvider).value?.uid == widget.uid;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: user == null
          ? Center(
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : Text(l10n.noUsersFound),
            )
          : _body(context, user, isMe),
    );
  }

  Widget _body(BuildContext context, UserModel user, bool isMe) {
    final l10n = context.l10n;
    final name = user.name.isEmpty ? user.email : user.name;
    final reports = ref.watch(userReportCountProvider(user.uid)).value;
    final canManage = !isMe && user.role != UserRole.admin;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        100 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      children: [
        Center(child: UserAvatar(user: user, radius: 40)),
        const SizedBox(height: 12),
        Text(
          name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          children: [
            UserChip(
              label: roleLabel(l10n, user.role),
              color: AppColors.primary,
            ),
            if (user.disabled)
              UserChip(label: l10n.userDisabled, color: AppColors.danger),
          ],
        ),
        const SizedBox(height: 20),
        Material(
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.border),
          ),
          child: Column(
            children: [
              _InfoTile(
                icon: Icons.email_outlined,
                label: l10n.email,
                value: user.email,
              ),
              if (user.phone case final phone? when phone.isNotEmpty)
                _InfoTile(
                  icon: Icons.phone_outlined,
                  label: l10n.phone,
                  value: phone,
                ),
              _InfoTile(
                icon: Icons.location_city_rounded,
                label: l10n.homeCity,
                value: user.city ?? l10n.notSet,
              ),
              _InfoTile(
                icon: Icons.event_rounded,
                label: l10n.memberSince,
                value: shortDate(l10n, user.createdAt),
              ),
              _InfoTile(
                icon: Icons.campaign_rounded,
                label: l10n.adminListings,
                value: reports == null ? '…' : '$reports',
              ),
            ],
          ),
        ),
        if (canManage) ...[
          const SizedBox(height: 12),
          Material(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.border),
            ),
            child: SwitchListTile(
              value: user.role == UserRole.support,
              onChanged:
                  _busy || (user.disabled && user.role != UserRole.support)
                  ? null
                  : (v) => _setStaff(user, name, v),
              secondary: const Icon(
                Icons.support_agent_rounded,
                color: AppColors.primary,
              ),
              title: Text(
                l10n.supportStaffSwitch,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                l10n.supportStaffSwitchSubtitle,
                style: const TextStyle(fontSize: 12.5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          user.disabled
              ? FilledButton.icon(
                  onPressed: _busy ? null : () => _toggleDisabled(user, name),
                  icon: const Icon(Icons.person_rounded),
                  label: Text(l10n.enableAccount),
                )
              : OutlinedButton.icon(
                  onPressed: _busy ? null : () => _toggleDisabled(user, name),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.danger,
                    side: const BorderSide(color: AppColors.danger),
                  ),
                  icon: const Icon(Icons.person_off_rounded),
                  label: Text(l10n.disableAccount),
                ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _busy ? null : () => _delete(user, name),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            icon: _busy
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_forever_rounded),
            label: Text(l10n.deleteAccount),
          ),
        ],
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        label,
        style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
      ),
      subtitle: SelectableText(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
    );
  }
}
