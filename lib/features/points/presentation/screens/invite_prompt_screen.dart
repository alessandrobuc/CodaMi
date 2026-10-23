import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/install_referrer.dart';
import '../../domain/points.dart';
import '../providers/points_provider.dart';
import '../widgets/invite_code_input.dart';
import '../widgets/points_widgets.dart';

// Shown once after sign-up and city setup, so invited friends don't miss the code box.
class InvitePromptScreen extends ConsumerStatefulWidget {
  final String uid;

  const InvitePromptScreen({super.key, required this.uid});

  @override
  ConsumerState<InvitePromptScreen> createState() => _InvitePromptScreenState();
}

class _InvitePromptScreenState extends ConsumerState<InvitePromptScreen> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;
  String? _inviter;
  bool _fromLink = false;

  @override
  void initState() {
    super.initState();
    _code.addListener(() => setState(() {}));
    _fillFromInstall();
  }

  Future<void> _fillFromInstall() async {
    final code = await installInviteCode();
    if (!mounted || code == null || _code.text.isNotEmpty) return;
    if (code == ref.read(userProfileProvider).value?.inviteCode) return;
    _code.text = code;
    setState(() => _fromLink = true);
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _redeem() async {
    if (_busy || _code.text.isEmpty) return;
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
      if (mounted) setState(() => _inviter = inviter);
    } on InviteCodeException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _done() =>
      ref.read(invitePromptSeenProvider.notifier).markSeen(widget.uid);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final days = (ref.watch(pointsConfigProvider).value ?? const PointsConfig())
        .codeEntryDays;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _inviter != null
                ? _Accepted(
                    key: const ValueKey('accepted'),
                    message: l10n.inviteCodeAccepted(_inviter!),
                    onContinue: _done,
                  )
                : SingleChildScrollView(
                    key: const ValueKey('form'),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: _busy ? null : _done,
                            child: Text(l10n.skip),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: pointsColor.withValues(alpha: 0.14),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.card_giftcard_rounded,
                              size: 46,
                              color: pointsColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          l10n.invitePromptTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.invitePromptBody,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          l10n.inviteCodeLabel,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InviteCodeField(
                          controller: _code,
                          large: true,
                          enabled: !_busy,
                          errorText: _error,
                          onChanged: (_) {
                            if (_error != null || _fromLink) {
                              setState(() {
                                _error = null;
                                _fromLink = false;
                              });
                            }
                          },
                          onSubmitted: _redeem,
                        ),
                        if (_fromLink && _error == null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.link_rounded,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  l10n.inviteCodeFromLink,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 20),
                        FilledButton(
                          onPressed: _busy || _code.text.isEmpty
                              ? null
                              : _redeem,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: _busy
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(l10n.useCode),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              size: 18,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                l10n.invitePromptLater(days),
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.35,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _Accepted extends StatelessWidget {
  final String message;
  final VoidCallback onContinue;

  const _Accepted({super.key, required this.message, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 52,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              height: 1.35,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: onContinue,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: Text(context.l10n.continueLabel),
          ),
        ],
      ),
    );
  }
}
