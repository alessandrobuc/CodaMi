import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/points_repository.dart';
import '../../domain/points.dart';
import '../providers/points_provider.dart';
import '../widgets/invite_code_input.dart';
import '../widgets/points_widgets.dart';

const _storeLink =
    'https://play.google.com/store/apps/details?id=com.codami.app';

final _inviteCodeProvider = FutureProvider<String>((ref) async {
  final saved = ref.read(userProfileProvider).value?.inviteCode;
  return saved ?? ref.read(pointsRepositoryProvider).inviteCode();
});

class InviteScreen extends ConsumerWidget {
  const InviteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final code = ref.watch(_inviteCodeProvider);
    final config =
        ref.watch(pointsConfigProvider).value ?? const PointsConfig();
    final invites = ref.watch(myInvitesProvider).value ?? const [];
    final profile = ref.watch(userProfileProvider).value;
    final canEnterCode =
        profile != null &&
        profile.referredBy == null &&
        DateTime.now().difference(profile.createdAt).inDays <
            config.codeEntryDays;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.inviteFriends),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
        children: [
          Text(
            l10n.inviteIntro,
            style: const TextStyle(
              fontSize: 15,
              height: 1.45,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Text(
                  l10n.yourInviteCode,
                  style: const TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 6),
                code.when(
                  data: (value) => SelectableText(
                    value,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 6,
                      color: AppColors.text,
                    ),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(),
                  ),
                  error: (_, _) => TextButton(
                    onPressed: () => ref.invalidate(_inviteCodeProvider),
                    child: Text(l10n.actionFailed),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: code.value == null
                            ? null
                            : () {
                                Clipboard.setData(
                                  ClipboardData(text: code.value!),
                                );
                                SnackbarUtils.showSuccess(
                                  context,
                                  l10n.codeCopied,
                                );
                              },
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        label: Text(l10n.copyCode),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: code.value == null
                            ? null
                            : () => SharePlus.instance.share(
                                ShareParams(
                                  text: l10n.inviteShareText(
                                    code.value!,
                                    '$_storeLink&referrer=${code.value!}',
                                  ),
                                ),
                              ),
                        icon: const Icon(Icons.share_rounded, size: 18),
                        label: Text(l10n.shareInvite),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.howInvitesWork,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          _Step(number: 1, text: l10n.inviteStep1),
          _Step(
            number: 2,
            text: l10n.inviteStep2(
              config.qualifyDays,
              config.qualifyWithinDays,
            ),
          ),
          _Step(number: 3, text: l10n.inviteStep3(config.referralQualified)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final rule in config.levels)
                Chip(
                  avatar: const Icon(
                    Icons.workspace_premium_rounded,
                    size: 18,
                    color: pointsColor,
                  ),
                  label: Text(
                    l10n.levelRule(
                      rule.level.label(l10n),
                      rule.minFriends,
                      rule.bonus,
                    ),
                  ),
                ),
            ],
          ),
          if (canEnterCode) ...[const SizedBox(height: 22), const _EnterCode()],
          const SizedBox(height: 22),
          Text(
            l10n.yourInvites,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          if (invites.isEmpty)
            Text(
              l10n.noInvitesYet,
              style: const TextStyle(color: AppColors.textMuted),
            )
          else
            for (final invite in invites)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: pointsColor.withValues(alpha: 0.15),
                  child: Text(
                    invite.inviteeName.isEmpty
                        ? '?'
                        : invite.inviteeName[0].toUpperCase(),
                    style: const TextStyle(
                      color: pointsColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                title: Text(
                  invite.inviteeName.isEmpty
                      ? l10n.aFriend
                      : invite.inviteeName,
                ),
                subtitle: Text(_statusLabel(l10n, invite.status)),
                trailing: invite.status == ReferralStatus.qualified
                    ? Text(
                        '+${config.referralQualified}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              ),
        ],
      ),
    );
  }

  static String _statusLabel(AppLocalizations l10n, ReferralStatus status) =>
      switch (status) {
        ReferralStatus.pending => l10n.inviteStatusPending,
        ReferralStatus.qualified => l10n.inviteStatusQualified,
        ReferralStatus.review => l10n.inviteStatusReview,
        ReferralStatus.rejected => l10n.inviteStatusRejected,
        ReferralStatus.expired => l10n.inviteStatusExpired,
      };
}

class _Step extends StatelessWidget {
  final int number;
  final String text;

  const _Step({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: pointsColor,
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.4, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnterCode extends ConsumerStatefulWidget {
  const _EnterCode();

  @override
  ConsumerState<_EnterCode> createState() => _EnterCodeState();
}

class _EnterCodeState extends ConsumerState<_EnterCode> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _redeem() async {
    final l10n = context.l10n;
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final inviter = await redeemInviteCode(
        ref,
        l10n,
        _code.text,
        ownCode: ref.read(userProfileProvider).value?.inviteCode,
      );
      if (mounted) {
        SnackbarUtils.showSuccess(context, l10n.inviteCodeAccepted(inviter));
      }
    } on InviteCodeException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pointsColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.haveInviteCode,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InviteCodeField(
                  controller: _code,
                  errorText: _error,
                  enabled: !_busy,
                  onChanged: (_) {
                    if (_error != null) setState(() => _error = null);
                  },
                  onSubmitted: _redeem,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: _busy ? null : _redeem,
                  child: _busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.useCode),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
