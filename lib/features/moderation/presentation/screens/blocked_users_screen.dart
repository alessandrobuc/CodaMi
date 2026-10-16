import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/moderation_repository.dart';
import '../providers/moderation_provider.dart';

class BlockedUsersScreen extends ConsumerWidget {
  const BlockedUsersScreen({super.key});

  Future<void> _unblock(
    BuildContext context,
    WidgetRef ref,
    String userId,
    String name,
  ) async {
    final l10n = context.l10n;
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    try {
      await ref.read(moderationRepositoryProvider).unblock(uid, userId);
      if (context.mounted) {
        SnackbarUtils.showSuccess(context, l10n.userUnblocked(name));
      }
    } catch (_) {
      if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final blocked = ref.watch(blockedUsersProvider).entries.toList()
      ..sort((a, b) => a.value.toLowerCase().compareTo(b.value.toLowerCase()));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.blockedUsers),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: blocked.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  l10n.noBlockedUsers,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              itemCount: blocked.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final MapEntry(key: userId, value: stored) = blocked[i];
                final name = stored.isEmpty ? l10n.unknownUser : stored;
                return Material(
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.danger.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.block_rounded,
                        color: AppColors.danger,
                      ),
                    ),
                    title: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: TextButton(
                      onPressed: () => _unblock(context, ref, userId, name),
                      child: Text(l10n.unblock),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
