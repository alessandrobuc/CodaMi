import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_languages.dart';
import '../../l10n/l10n.dart';
import '../../l10n/locale_provider.dart';
import '../constants/app_constants.dart';

class LanguageList extends ConsumerWidget {
  final VoidCallback? onSelected;

  const LanguageList({super.key, this.onSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(localeProvider);

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, language) in appLanguages.indexed) ...[
            if (i > 0)
              const Divider(height: 1, indent: 64, color: AppColors.border),
            ListTile(
              onTap: () {
                ref.read(localeProvider.notifier).select(language);
                onSelected?.call();
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 2,
              ),
              leading: SizedBox(
                width: 38,
                child: Center(
                  child: Text(
                    language.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              title: Text(
                language.nativeName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              subtitle: language.nativeName == language.englishName
                  ? null
                  : Text(
                      language.englishName,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
              trailing: language.code == selected.code
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                    )
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}

Future<void> showLanguagePicker(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.92,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          24 + MediaQuery.paddingOf(context).bottom,
        ),
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
          const SizedBox(height: 16),
          Text(
            context.l10n.chooseLanguage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 16),
          LanguageList(onSelected: () => Navigator.of(context).pop()),
        ],
      ),
    ),
  );
}

class LanguageButton extends ConsumerWidget {
  final bool onDark;

  const LanguageButton({super.key, this.onDark = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);
    final foreground = onDark ? Colors.white : AppColors.text;

    return Material(
      color: onDark ? Colors.white.withValues(alpha: 0.18) : AppColors.surface,
      shape: StadiumBorder(
        side: BorderSide(
          color: onDark
              ? Colors.white.withValues(alpha: 0.35)
              : AppColors.border,
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: () => showLanguagePicker(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(language.flag, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                language.code.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: foreground,
                ),
              ),
              Icon(Icons.expand_more_rounded, size: 18, color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}
