import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/locale_provider.dart';
import '../../auth/data/models/user_model.dart';
import '../../profile/presentation/providers/profile_provider.dart';
import '../../whats_new/presentation/providers/whats_new_provider.dart';
import '../../whats_new/presentation/screens/whats_new_screen.dart';
import '../data/app_update_repository.dart';
import '../domain/app_update.dart';

Future<void> _update(BuildContext context, WidgetRef ref) async {
  final message = context.l10n.updateStoreFailed;
  final opened = await ref.read(openStoreProvider)();
  if (!opened && context.mounted) SnackbarUtils.showError(context, message);
}

// Shows the update sheet once per store version. True when the app is
// outdated, so other startup prompts wait for another day.
Future<bool> showUpdateIfNeeded(BuildContext context, WidgetRef ref) async {
  try {
    await (
      ref.read(appVersionProvider.future),
      ref.read(appVersionConfigProvider.future),
    ).wait.timeout(const Duration(seconds: 10));
  } on TimeoutException {
    return false;
  }
  final update = ref.read(appUpdateProvider);
  if (update.status == UpdateStatus.required) return true;
  if (update.status != UpdateStatus.available) return false;
  if (!ref.read(updatePromptProvider).showSheet(update.latest)) return false;
  await ref.read(updatePromptProvider.notifier).sheetShown(update.latest);
  if (context.mounted) await showUpdateSheet(context);
  return true;
}

Future<void> showUpdateSheet(BuildContext context) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: AppColors.surface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
  ),
  builder: (_) => const _UpdateSheet(),
);

class _UpdateSheet extends ConsumerWidget {
  const _UpdateSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final update = ref.watch(appUpdateProvider);
    final bottom = MediaQuery.paddingOf(context).bottom;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _UpdateIntro(
                  title: l10n.updateAvailableTitle,
                  text: l10n.updateAvailableBody(
                    update.latest,
                    update.installed,
                  ),
                ),
                const _LatestNotes(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, bottom + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _UpdateButton(onPressed: () => _update(context, ref)),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.updateLater),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdateIntro extends StatelessWidget {
  final String title;
  final String text;

  const _UpdateIntro({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.system_update_rounded,
            color: AppColors.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.5,
            height: 1.4,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

// The What's new notes of the store version, when they're published.
class _LatestNotes extends ConsumerWidget {
  const _LatestNotes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(latestNotesProvider).value;
    if (note == null) return const SizedBox.shrink();
    final items = note.itemsFor(ref.watch(localeProvider).code);
    if (items.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.whatsNewVersion(note.version),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          NoteItemsView(items: items),
        ],
      ),
    );
  }
}

class _UpdateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _UpdateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.download_rounded),
      label: Text(context.l10n.updateNow),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}

// On Home while a newer version is in the store. Closing it hides it for a
// few days.
class UpdateBanner extends ConsumerWidget {
  const UpdateBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final update = ref.watch(appUpdateProvider);
    final prompt = ref.watch(updatePromptProvider);
    if (update.status != UpdateStatus.available ||
        !prompt.showBanner(update.latest, DateTime.now())) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => showUpdateSheet(context),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 6, 4, 6),
            child: Row(
              children: [
                const Icon(
                  Icons.system_update_rounded,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.updateBanner(update.latest),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _update(context, ref),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  child: Text(l10n.updateNow),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  visualDensity: VisualDensity.compact,
                  onPressed: () => ref
                      .read(updatePromptProvider.notifier)
                      .hideBanner(update.latest),
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Admins can pass for this session, so a wrong minimum can still be undone.
final _adminPassedGateProvider = NotifierProvider<_AdminPass, bool>(
  _AdminPass.new,
);

class _AdminPass extends Notifier<bool> {
  @override
  bool build() => false;

  void pass() => state = true;
}

// Sits above the whole app and covers it while the installed version is
// below the minimum.
class UpdateGate extends ConsumerWidget {
  final Widget child;

  const UpdateGate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final required =
        ref.watch(appUpdateProvider).status == UpdateStatus.required &&
        !ref.watch(_adminPassedGateProvider);
    if (required) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => FocusManager.instance.primaryFocus?.unfocus(),
      );
    }
    return Stack(
      children: [
        Offstage(
          offstage: required,
          child: ExcludeFocus(excluding: required, child: child),
        ),
        if (required) const _UpdateRequiredScreen(),
      ],
    );
  }
}

class _UpdateRequiredScreen extends ConsumerWidget {
  const _UpdateRequiredScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final update = ref.watch(appUpdateProvider);
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
                children: [
                  _UpdateIntro(
                    title: l10n.updateRequiredTitle,
                    text: l10n.updateRequiredBody(update.latest),
                  ),
                  const _LatestNotes(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _UpdateButton(onPressed: () => _update(context, ref)),
                  if (ref.watch(userRoleProvider) == UserRole.admin) ...[
                    const SizedBox(height: 6),
                    TextButton(
                      onPressed: () =>
                          ref.read(_adminPassedGateProvider.notifier).pass(),
                      child: Text(l10n.updateContinueAsAdmin),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
