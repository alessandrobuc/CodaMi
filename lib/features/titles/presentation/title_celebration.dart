import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/locale_provider.dart';
import '../domain/titles.dart';
import 'providers/titles_provider.dart';
import 'screens/achievements_screen.dart';
import 'widgets/title_badge.dart';
import 'widgets/title_labels.dart';

bool _showing = false;

// The highest new level of each title, from keys like "rescuer_2".
List<TitleLevel> freshTitles(Set<String> keys, Set<String> seen) {
  final best = <TitleId, int>{};
  for (final key in keys.difference(seen)) {
    final cut = key.lastIndexOf('_');
    final id = TitleId.of(key.substring(0, cut));
    final level = int.tryParse(key.substring(cut + 1)) ?? 0;
    if (id != null && level > (best[id] ?? 0)) best[id] = level;
  }
  return [for (final e in best.entries) TitleLevel(e.key, e.value)];
}

// Once per new title, after the user is back on the main screens.
Future<void> celebrateNewTitles(
  BuildContext context,
  WidgetRef ref,
  String uid,
  Achievements a, {
  required bool Function() isIdle,
}) async {
  if (_showing || !ref.read(titlesAvailableProvider)) return;
  final prefs = ref.read(sharedPreferencesProvider);
  final key = 'titles_seen_$uid';
  final seen = prefs.getStringList(key)?.toSet() ?? const <String>{};
  final fresh = freshTitles(a.unlockedKeys, seen);
  if (fresh.isEmpty) return;
  _showing = true;
  try {
    await prefs.setStringList(key, a.unlockedKeys.union(seen).toList());
    for (var i = 0; i < 100; i++) {
      await Future<void>.delayed(const Duration(seconds: 3));
      if (!context.mounted) return;
      if (!isIdle()) continue;
      await showDialog<void>(
        context: context,
        builder: (_) => _CelebrationDialog(titles: fresh),
      );
      return;
    }
  } finally {
    _showing = false;
  }
}

class _CelebrationDialog extends StatelessWidget {
  final List<TitleLevel> titles;

  const _CelebrationDialog({required this.titles});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final first = titles.first;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                  width: 96,
                  height: 96,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.35),
                        blurRadius: 28,
                      ),
                    ],
                  ),
                  child: Text(
                    first.id.isCounted || first.id == TitleId.ambassador
                        ? '🏆'
                        : first.emoji,
                    style: const TextStyle(fontSize: 46),
                  ),
                )
                .animate()
                .scale(
                  begin: const Offset(0.3, 0.3),
                  duration: 700.ms,
                  curve: Curves.elasticOut,
                )
                .then()
                .shimmer(duration: 1200.ms, color: Colors.white54),
            const SizedBox(height: 18),
            Text(
              titles.length == 1
                  ? l10n.ttlNewTitle
                  : l10n.ttlNewTitles(titles.length),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final (i, t) in titles.take(6).indexed)
                  TitleChip(t)
                      .animate()
                      .fadeIn(delay: (300 + 120 * i).ms)
                      .scale(begin: const Offset(0.8, 0.8)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.ttlCelebrateBody,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () {
                final navigator = Navigator.of(context);
                navigator.pop();
                navigator.push(
                  MaterialPageRoute(builder: (_) => const AchievementsScreen()),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(l10n.ttlSeeAll),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
