import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../l10n/app_languages.dart';
import '../../../l10n/l10n.dart';
import '../data/donations_repository.dart';
import '../domain/donations.dart';

const supportColor = Color(0xFFE11D48);

String _euros(int cents) => NumberFormat.currency(
  locale: currentAppLanguage.code,
  symbol: '€',
  decimalDigits: cents % 100 == 0 ? 0 : 2,
).format(cents / 100);

// Shown after a report is published or a pet is found, when the admin has it
// on and the user hasn't seen it recently. Never before the action itself.
Future<void> maybeAskForSupport(WidgetRef ref, DonationTrigger trigger) async {
  final config = ref.read(donationsConfigProvider).value;
  final repo = ref.read(donationsRepositoryProvider);
  if (config == null ||
      !config.shows(trigger) ||
      !promptDue(repo.lastPrompt, DateTime.now(), config.daysBetweenPrompts)) {
    return;
  }
  await Future<void>.delayed(const Duration(milliseconds: 1500));
  final context = appNavigatorKey.currentContext;
  if (context == null || !context.mounted) return;
  await repo.promptShown();
  if (!context.mounted) return;
  await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => _SupportPrompt(trigger: trigger),
  );
}

class _SupportPrompt extends StatelessWidget {
  final DonationTrigger trigger;

  const _SupportPrompt({required this.trigger});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: supportColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: supportColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            trigger == DonationTrigger.afterFound
                ? l10n.supportPromptFoundTitle
                : l10n.supportPromptReportTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.supportPromptText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SupportScreen()));
            },
            style: FilledButton.styleFrom(
              backgroundColor: supportColor,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.favorite_rounded),
            label: Text(l10n.supportCodami),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.feedbackLater),
          ),
        ],
      ),
    );
  }
}

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen({super.key});

  @override
  ConsumerState<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends ConsumerState<SupportScreen> {
  int? _amount;

  void _support(DonationsConfig config) {
    final l10n = context.l10n;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.favorite_rounded, color: supportColor),
        title: Text(l10n.supportThanks),
        content: Text(
          config.paymentsReady ? l10n.supportThanksText : l10n.supportSoon,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.supportClose),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final config =
        ref.watch(donationsConfigProvider).value ?? const DonationsConfig();
    final amount = config.amountsCents.contains(_amount)
        ? _amount!
        : config.amountsCents[config.amountsCents.length ~/ 2];
    final uses = [
      (Icons.dns_rounded, l10n.supportUseServers),
      (Icons.code_rounded, l10n.supportUseDevelopment),
      (Icons.shield_rounded, l10n.supportUseModeration),
      (Icons.support_agent_rounded, l10n.supportUseSupport),
      (Icons.translate_rounded, l10n.supportUseTranslations),
      (Icons.auto_awesome_rounded, l10n.supportUseFeatures),
      (Icons.campaign_rounded, l10n.supportUseCampaigns),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.supportCodami),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          12 + MediaQuery.viewPaddingOf(context).bottom,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: FilledButton.icon(
          onPressed: () => _support(config),
          style: FilledButton.styleFrom(
            backgroundColor: supportColor,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: const Icon(Icons.favorite_rounded),
          label: Text(l10n.supportWith(_euros(amount))),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  supportColor,
                  Color.lerp(supportColor, Colors.black, 0.25)!,
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.volunteer_activism_rounded,
                  color: Colors.white,
                  size: 34,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.supportHeaderTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.supportHeaderText,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.4,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.supportUsesTitle,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                for (final (icon, text) in uses)
                  ListTile(
                    dense: true,
                    leading: Icon(icon, color: supportColor, size: 22),
                    title: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: AppColors.text,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.supportChooseAmount,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final cents in config.amountsCents)
                ChoiceChip(
                  label: Text(_euros(cents)),
                  selected: amount == cents,
                  showCheckmark: false,
                  selectedColor: supportColor,
                  backgroundColor: AppColors.surface,
                  shape: const StadiumBorder(),
                  side: BorderSide(
                    color: amount == cents ? supportColor : AppColors.border,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: amount == cents ? Colors.white : AppColors.text,
                  ),
                  onSelected: (_) => setState(() => _amount = cents),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            l10n.supportFinePrint,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
