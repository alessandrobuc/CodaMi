import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/screens/admin_user_screen.dart';
import '../../data/points_repository.dart';
import '../../domain/points.dart';
import '../providers/points_provider.dart';

// Invites the anti-fraud checks held back. Nothing is rejected without an admin.
class AdminReferralsScreen extends ConsumerWidget {
  const AdminReferralsScreen({super.key});

  static String flagLabel(AppLocalizations l10n, String flag) => switch (flag) {
    'same_device_as_inviter' => l10n.flagSameDevice,
    'device_used_before' => l10n.flagDeviceUsed,
    'burst' => l10n.flagBurst,
    _ => flag,
  };

  Future<void> _review(
    BuildContext context,
    WidgetRef ref,
    Referral r, {
    required bool approve,
  }) async {
    final l10n = context.l10n;
    try {
      await ref
          .read(pointsRepositoryProvider)
          .review(r.inviteeId, approve: approve);
      if (context.mounted) {
        SnackbarUtils.showSuccess(
          context,
          approve ? l10n.inviteApproved : l10n.inviteRejected,
        );
      }
    } catch (_) {
      if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(invitesToReviewProvider);
    final items = state.value ?? const <Referral>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.invitesToReview),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: state.isLoading && !state.hasValue
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
          ? Center(
              child: EmptyState(
                icon: const Icon(Icons.verified_user_rounded),
                title: l10n.noInvitesToReview,
                message: l10n.noInvitesToReviewMessage,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final r = items[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.inviteeName.isEmpty ? l10n.aFriend : r.inviteeName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                      if (r.createdAt != null)
                        Text(
                          timeAgo(l10n, r.createdAt!),
                          style: const TextStyle(color: AppColors.textMuted),
                        ),
                      const SizedBox(height: 8),
                      for (final flag in r.flags)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.flag_rounded,
                                size: 16,
                                color: AppColors.danger,
                              ),
                              const SizedBox(width: 6),
                              Expanded(child: Text(flagLabel(l10n, flag))),
                            ],
                          ),
                        ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    AdminUserScreen(uid: r.inviterId),
                              ),
                            ),
                            child: Text(l10n.viewInviter),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    AdminUserScreen(uid: r.inviteeId),
                              ),
                            ),
                            child: Text(l10n.viewInvitee),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  _review(context, ref, r, approve: false),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.danger,
                              ),
                              child: Text(l10n.reject),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilledButton(
                              onPressed: () =>
                                  _review(context, ref, r, approve: true),
                              child: Text(l10n.approvePhoto),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
