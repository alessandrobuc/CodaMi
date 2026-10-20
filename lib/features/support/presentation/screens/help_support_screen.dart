import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/support_case.dart';
import '../providers/support_provider.dart';
import '../widgets/case_tile.dart';
import 'new_case_screen.dart';
import 'support_case_screen.dart';

class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  void _start(BuildContext context, CaseKind kind) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => NewCaseScreen(kind: kind)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final cases = ref.watch(myCasesProvider);
    final live = ref.watch(liveChatAvailableProvider);
    final online = live.value == true;
    final list = cases.value ?? const <SupportCase>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l10n.helpSupport)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(liveChatAvailableProvider.future),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            60 + MediaQuery.viewPaddingOf(context).bottom,
          ),
          children: [
            Text(
              l10n.supportIntroTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.supportIntroMessage,
              style: const TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),
            _OptionCard(
              icon: Icons.forum_rounded,
              color: AppColors.primary,
              title: l10n.supportStartChat,
              subtitle: live.isLoading
                  ? null
                  : online
                  ? l10n.supportStartChatOnline
                  : l10n.supportChatOffline,
              online: online,
              enabled: online,
              onTap: () => _start(context, CaseKind.chat),
            ),
            const SizedBox(height: 10),
            _OptionCard(
              icon: Icons.mail_outline_rounded,
              color: AppColors.accent,
              title: l10n.supportSendRequest,
              subtitle: l10n.supportSendRequestSubtitle,
              onTap: () => _start(context, CaseKind.ticket),
            ),
            const SizedBox(height: 26),
            Text(
              l10n.supportMyRequests,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 10),
            if (cases.isLoading && !cases.hasValue)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: EmptyState(
                  icon: const Icon(Icons.support_agent_rounded),
                  title: l10n.supportNoRequests,
                  message: l10n.supportNoRequestsMessage,
                ),
              )
            else
              for (final c in list)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CaseTile(
                    supportCase: c,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SupportCaseScreen(caseId: c.id),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final bool enabled;
  final bool online;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.enabled = true,
    this.online = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, color: color),
                    ),
                    if (online)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: const Color(0xFF16A34A),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.5,
                          color: AppColors.text,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (enabled)
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMuted,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
