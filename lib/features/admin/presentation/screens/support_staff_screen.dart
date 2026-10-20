import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/admin_repository.dart';
import '../providers/admin_provider.dart';
import 'admin_users_screen.dart';

class SupportStaffScreen extends ConsumerWidget {
  const SupportStaffScreen({super.key});

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final added = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const AdminUsersScreen(pickStaff: true),
      ),
    );
    if (added != null && context.mounted) {
      SnackbarUtils.showSuccess(context, context.l10n.staffAdded(added));
    }
  }

  Future<void> _remove(
    BuildContext context,
    WidgetRef ref,
    StaffMember member,
  ) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.removeStaffTitle(member.name)),
        content: Text(
          '${l10n.removeStaffMessage} ${l10n.removeStaffCasesNote}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.remove),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref
          .read(adminRepositoryProvider)
          .setRole(member.uid, UserRole.user);
      if (context.mounted) {
        SnackbarUtils.showSuccess(
          context,
          l10n.staffRemoved(member.name.isEmpty ? member.email : member.name),
        );
      }
    } catch (_) {
      if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final staff = ref.watch(supportStaffProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.supportStaff),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context, ref),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: Text(l10n.addSupportStaff),
      ),
      body: staff.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.actionFailed)),
        data: (members) => members.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    l10n.noSupportStaff,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textMuted),
                  ),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  120 + MediaQuery.viewPaddingOf(context).bottom,
                ),
                itemCount: members.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final member = members[i];
                  return Material(
                    color: AppColors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.12,
                        ),
                        child: const Icon(
                          Icons.support_agent_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(
                        member.name.isEmpty ? member.email : member.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: member.name.isEmpty ? null : Text(member.email),
                      trailing: IconButton(
                        tooltip: l10n.remove,
                        icon: const Icon(
                          Icons.person_remove_alt_1_rounded,
                          color: AppColors.danger,
                        ),
                        onPressed: () => _remove(context, ref, member),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
