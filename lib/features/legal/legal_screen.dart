import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/snackbar_utils.dart';
import '../../l10n/l10n.dart';
import 'legal_content.dart';

class LegalScreen extends StatelessWidget {
  final LegalDocument document;

  const LegalScreen({super.key, required this.document});

  Future<void> _contact(BuildContext context, String title) async {
    final failure = context.l10n.emailFailed;
    final uri = Uri(
      scheme: 'mailto',
      path: legalEmail,
      query: 'subject=${Uri.encodeComponent('CodaMi – $title')}',
    );
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && context.mounted) SnackbarUtils.showError(context, failure);
    } catch (_) {
      if (context.mounted) SnackbarUtils.showError(context, failure);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final code = l10n.localeName;
    final sections = legalSections(document, code);
    final textTheme = Theme.of(context).textTheme;
    final title = document == LegalDocument.privacy
        ? l10n.privacyPolicy
        : l10n.termsOfUse;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: SelectionArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            4,
            20,
            32 + MediaQuery.paddingOf(context).bottom,
          ),
          children: [
            Text(
              l10n.legalLastUpdated(
                DateFormat.yMMMMd(code).format(legalUpdated),
              ),
              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            for (final section in sections) ...[
              const SizedBox(height: 22),
              Text(
                section.heading,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                section.body,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.55,
                  color: AppColors.text,
                ),
              ),
            ],
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.legalQuestions,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => _contact(context, title),
                    icon: const Icon(Icons.mail_outline_rounded),
                    label: Text(l10n.contactUs),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
