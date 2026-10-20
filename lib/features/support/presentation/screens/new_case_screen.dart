import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../data/support_repository.dart';
import '../../domain/support_case.dart';
import '../widgets/support_labels.dart';
import 'support_case_screen.dart';

class NewCaseScreen extends ConsumerStatefulWidget {
  final CaseKind kind;

  const NewCaseScreen({super.key, required this.kind});

  @override
  ConsumerState<NewCaseScreen> createState() => _NewCaseScreenState();
}

class _NewCaseScreenState extends ConsumerState<NewCaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subject = TextEditingController();
  final _message = TextEditingController();
  CaseCategory _category = CaseCategory.app;
  bool _sending = false;

  @override
  void dispose() {
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _sending) return;
    setState(() => _sending = true);
    String? caseId;
    await runSupportAction(context, () async {
      caseId = await ref
          .read(supportRepositoryProvider)
          .createCase(
            kind: widget.kind,
            category: _category,
            subject: _subject.text,
            message: _message.text,
          );
    });
    if (!mounted) return;
    setState(() => _sending = false);
    final id = caseId;
    if (id != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SupportCaseScreen(caseId: id)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isChat = widget.kind == CaseKind.chat;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isChat ? l10n.supportNewChat : l10n.supportNewRequest),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            40 + MediaQuery.viewPaddingOf(context).bottom,
          ),
          children: [
            Text(
              l10n.supportCategory,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            for (final category in CaseCategory.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _CategoryOption(
                  category: category,
                  selected: category == _category,
                  onTap: () => setState(() => _category = category),
                ),
              ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subject,
              maxLength: 120,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.supportSubject,
                hintText: l10n.supportSubjectHint,
              ),
              validator: (value) => (value ?? '').trim().length < 3
                  ? l10n.supportSubjectTooShort
                  : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _message,
              minLines: 4,
              maxLines: 8,
              maxLength: 2000,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.supportMessage,
                hintText: l10n.supportMessageHint,
                alignLabelWithHint: true,
              ),
              validator: (value) => (value ?? '').trim().isEmpty
                  ? l10n.supportMessageRequired
                  : null,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _sending ? null : _submit,
              icon: _sending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(isChat ? Icons.forum_rounded : Icons.send_rounded),
              label: Text(isChat ? l10n.supportStartChat : l10n.supportSend),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryOption extends StatelessWidget {
  final CaseCategory category;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryOption({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textMuted;
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.08)
          : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
          width: selected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(category.icon, color: color, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.label(context.l10n),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected ? AppColors.primary : AppColors.text,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
