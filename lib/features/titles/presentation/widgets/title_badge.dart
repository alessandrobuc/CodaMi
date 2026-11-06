import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/titles.dart';
import '../providers/titles_provider.dart';
import 'title_labels.dart';

class TitleChip extends StatelessWidget {
  final TitleLevel title;
  final bool small;
  // For use on the green profile card.
  final bool onDark;

  const TitleChip(
    this.title, {
    super.key,
    this.small = false,
    this.onDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final special = title.id.isManual || title.id == TitleId.donor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: onDark
            ? Colors.white.withValues(alpha: 0.18)
            : special
            ? AppColors.accent.withValues(alpha: 0.14)
            : AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title.emoji, style: TextStyle(fontSize: small ? 12 : 14)),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              title.name(context.l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: small ? 11.5 : 13,
                fontWeight: FontWeight.w700,
                color: onDark
                    ? Colors.white
                    : special
                    ? AppColors.rewardText
                    : AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Another user's main title, or nothing while titles are switched off.
class UserTitle extends ConsumerWidget {
  final String uid;
  final bool small;

  const UserTitle(this.uid, {super.key, this.small = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (uid.isEmpty || !ref.watch(titlesAvailableProvider)) {
      return const SizedBox.shrink();
    }
    final title = ref.watch(publicTitlesProvider(uid)).value?.title;
    if (title == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: TitleChip(title, small: small),
    );
  }
}

// Up to three titles, for a pet sitter's profile.
class UserTitleTags extends ConsumerWidget {
  final String uid;

  const UserTitleTags(this.uid, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (uid.isEmpty || !ref.watch(titlesAvailableProvider)) {
      return const SizedBox.shrink();
    }
    final tags = ref.watch(publicTitlesProvider(uid)).value?.tags ?? const [];
    if (tags.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 6,
        runSpacing: 6,
        children: [for (final t in tags) TitleChip(t, small: true)],
      ),
    );
  }
}
