import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/screen_space.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/screens/admin_user_screen.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/feedback_repository.dart';
import '../../domain/feedback.dart';
import '../widgets/feedback_labels.dart';
import 'admin_feedback_settings_screen.dart';

const _page = 200;

final _feedbackProvider = StreamProvider.autoDispose
    .family<List<FeedbackEntry>, int>(
      (ref, limit) =>
          ref.watch(feedbackRepositoryProvider).watchLatest(limit: limit),
    );

final _screenshotProvider = FutureProvider.autoDispose.family<String, String>(
  (ref, path) => ref.watch(feedbackRepositoryProvider).screenshotUrl(path),
);

class AdminFeedbackScreen extends ConsumerStatefulWidget {
  const AdminFeedbackScreen({super.key});

  @override
  ConsumerState<AdminFeedbackScreen> createState() =>
      _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends ConsumerState<AdminFeedbackScreen> {
  int _limit = _page;
  List<FeedbackEntry> _last = const [];
  FeedbackStatus _status = FeedbackStatus.open;
  FeedbackType? _type;
  FeedbackArea? _area;
  // 0 means "no stars given".
  int? _stars;

  bool _matches(FeedbackEntry e) =>
      e.status == _status &&
      (_type == null || e.type == _type) &&
      (_area == null || e.area == _area) &&
      (_stars == null || e.rating == _stars);

  Future<void> _update(
    FeedbackEntry entry, {
    FeedbackStatus? status,
    String? note,
    bool notify = false,
  }) async {
    final l10n = context.l10n;
    try {
      final notified = await ref
          .read(feedbackRepositoryProvider)
          .update(entry.id, status: status, note: note, notify: notify);
      if (!mounted) return;
      SnackbarUtils.showSuccess(
        context,
        notified ? l10n.fbAdminNotified : l10n.settingsSaved,
      );
    } catch (e) {
      debugPrint('Feedback not updated: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  Future<void> _setStatus(FeedbackEntry entry, FeedbackStatus status) async {
    if (status == entry.status) return;
    if (status != FeedbackStatus.done || entry.thanked) {
      return _update(entry, status: status);
    }
    final notify = await showDialog<bool>(
      context: context,
      builder: (_) => const _DoneDialog(),
    );
    if (notify == null || !mounted) return;
    await _update(entry, status: status, notify: notify);
  }

  Future<void> _editNote(FeedbackEntry entry) async {
    final note = await showDialog<String>(
      context: context,
      builder: (_) => _NoteDialog(initial: entry.note),
    );
    if (note == null || note == entry.note || !mounted) return;
    await _update(entry, note: note);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(_feedbackProvider(_limit));
    final all = _last = state.value ?? _last;
    final isAdmin =
        ref.watch(userProfileProvider).value?.role == UserRole.admin;
    final counts = {
      for (final s in FeedbackStatus.values)
        s: all.where((e) => e.status == s).length,
    };
    final shown = all.where(_matches).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.adminFeedback),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (isAdmin)
            IconButton(
              tooltip: l10n.fbAdminSettings,
              icon: const Icon(Icons.tune_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AdminFeedbackSettingsScreen(),
                ),
              ),
            ),
        ],
      ),
      body: all.isEmpty && state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : all.isEmpty && state.hasError
          ? Center(child: Text(l10n.actionFailed))
          : all.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: EmptyState(
                  icon: const Icon(
                    Icons.rate_review_rounded,
                    size: 44,
                    color: AppColors.accent,
                  ),
                  color: AppColors.accent,
                  title: l10n.adminFeedback,
                  message: l10n.adminFeedbackEmpty,
                ),
              ),
            )
          : ListView(
              padding: EdgeInsets.fromLTRB(16, 4, 16, endSpace(context)),
              children: [
                _Overview(overview: overviewOf(all, DateTime.now())),
                const SizedBox(height: 14),
                _StatusTabs(
                  selected: _status,
                  counts: counts,
                  onSelect: (s) => setState(() => _status = s),
                ),
                const SizedBox(height: 10),
                _Filters(
                  type: _type,
                  area: _area,
                  stars: _stars,
                  onType: (t) => setState(() => _type = t),
                  onArea: (a) => setState(() => _area = a),
                  onStars: (s) => setState(() => _stars = s),
                ),
                const SizedBox(height: 12),
                if (shown.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      l10n.fbAdminEmptyTab,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                for (final entry in shown) ...[
                  _FeedbackCard(
                    entry: entry,
                    onStatus: (s) => _setStatus(entry, s),
                    onNote: () => _editNote(entry),
                    onUser: isAdmin && entry.uid.isNotEmpty
                        ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AdminUserScreen(uid: entry.uid),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: 10),
                ],
                if (all.length >= _limit)
                  Center(
                    child: TextButton.icon(
                      onPressed: () => setState(() => _limit += _page),
                      icon: const Icon(Icons.expand_more_rounded),
                      label: Text(l10n.loadMore),
                    ),
                  ),
              ],
            ),
    );
  }
}

BoxDecoration _cardDecoration() => BoxDecoration(
  color: AppColors.surface,
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: AppColors.border),
);

class _Overview extends StatelessWidget {
  final FeedbackOverview overview;

  const _Overview({required this.overview});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.insights_rounded,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.fbAdminOverview,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
              ),
              Text(
                '${overview.total}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final type in FeedbackType.choices)
                Expanded(
                  child: Column(
                    children: [
                      Icon(type.icon, color: type.color, size: 22),
                      const SizedBox(height: 4),
                      Text(
                        '${overview.byType[type] ?? 0}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        type.label(l10n),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const Divider(height: 28),
          Text(
            l10n.fbAdminStarsByArea,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          if (overview.starsByArea.isEmpty)
            Text(
              l10n.fbAdminNoStars,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          for (final row in overview.starsByArea)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(row.area.icon, size: 18, color: AppColors.primary),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 110,
                    child: Text(
                      row.area.label(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: row.average / 5,
                        backgroundColor: AppColors.background,
                        color: row.average < 3
                            ? AppColors.accent
                            : AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${row.average.toStringAsFixed(1)} ★ (${row.count})',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _StatusTabs extends StatelessWidget {
  final FeedbackStatus selected;
  final Map<FeedbackStatus, int> counts;
  final ValueChanged<FeedbackStatus> onSelect;

  const _StatusTabs({
    required this.selected,
    required this.counts,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          for (final status in FeedbackStatus.values)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onSelect(status),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: status == selected
                        ? AppColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          status.label(l10n),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: status == selected
                                ? Colors.white
                                : AppColors.textMuted,
                          ),
                        ),
                      ),
                      if ((counts[status] ?? 0) > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: status == selected
                                ? Colors.white.withValues(alpha: 0.22)
                                : AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${counts[status]}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: status == selected
                                  ? Colors.white
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  final FeedbackType? type;
  final FeedbackArea? area;
  final int? stars;
  final ValueChanged<FeedbackType?> onType;
  final ValueChanged<FeedbackArea?> onArea;
  final ValueChanged<int?> onStars;

  const _Filters({
    required this.type,
    required this.area,
    required this.stars,
    required this.onType,
    required this.onArea,
    required this.onStars,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _Pill(
                label: l10n.all,
                selected: type == null,
                onTap: () => onType(null),
              ),
              for (final t in FeedbackType.values)
                _Pill(
                  label: t.label(l10n),
                  icon: t.icon,
                  iconColor: t.color,
                  selected: type == t,
                  onTap: () => onType(type == t ? null : t),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // A null menu value counts as "cancelled", so -1 means all.
            PopupMenuButton<int>(
              tooltip: l10n.fbAreaLabel,
              onSelected: (i) => onArea(i < 0 ? null : FeedbackArea.values[i]),
              itemBuilder: (_) => [
                PopupMenuItem(value: -1, child: Text(l10n.fbAdminAllAreas)),
                for (final a in FeedbackArea.values)
                  PopupMenuItem(
                    value: a.index,
                    child: Row(
                      children: [
                        Icon(a.icon, size: 18, color: AppColors.primary),
                        const SizedBox(width: 10),
                        Text(a.label(l10n)),
                      ],
                    ),
                  ),
              ],
              child: _Pill(
                label: area?.label(l10n) ?? l10n.fbAdminAllAreas,
                icon: area?.icon ?? Icons.apps_rounded,
                selected: area != null,
                trailing: Icons.expand_more_rounded,
              ),
            ),
            PopupMenuButton<int>(
              tooltip: l10n.fbRatingLabel,
              onSelected: (s) => onStars(s < 0 ? null : s),
              itemBuilder: (_) => [
                PopupMenuItem(value: -1, child: Text(l10n.fbAdminAnyStars)),
                for (var s = 5; s >= 1; s--)
                  PopupMenuItem(
                    value: s,
                    child: FeedbackStars(rating: s),
                  ),
                PopupMenuItem(value: 0, child: Text(l10n.fbAdminNoRating)),
              ],
              child: _Pill(
                label: switch (stars) {
                  null => l10n.fbAdminAnyStars,
                  0 => l10n.fbAdminNoRating,
                  final s => '$s ★',
                },
                icon: Icons.star_rounded,
                iconColor: AppColors.accent,
                selected: stars != null,
                trailing: Icons.expand_more_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final IconData? trailing;
  final bool selected;
  final VoidCallback? onTap;

  const _Pill({
    required this.label,
    required this.selected,
    this.icon,
    this.iconColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: const EdgeInsetsDirectional.only(end: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: iconColor ?? AppColors.primary),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              color: selected ? AppColors.primaryDark : AppColors.textMuted,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 2),
            Icon(trailing, size: 18, color: AppColors.textMuted),
          ],
        ],
      ),
    );
    if (onTap == null) return content;
    return GestureDetector(onTap: onTap, child: content);
  }
}

class _FeedbackCard extends StatelessWidget {
  final FeedbackEntry entry;
  final ValueChanged<FeedbackStatus> onStatus;
  final VoidCallback onNote;
  final VoidCallback? onUser;

  const _FeedbackCard({
    required this.entry,
    required this.onStatus,
    required this.onNote,
    required this.onUser,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final time = entry.createdAt;
    final details = [
      entry.asked ? l10n.fbAdminAsked : l10n.fbAdminSelf,
      if (entry.appVersion case final v?) 'v$v',
      entry.device ?? entry.platform,
      entry.lang?.toUpperCase(),
    ].whereType<String>().join(' · ');

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 6, 4),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: Row(
              children: [
                _Badge(
                  icon: entry.type.icon,
                  label: entry.type.label(l10n),
                  color: entry.type.color,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: _Badge(
                    icon: entry.area.icon,
                    label: entry.area.label(l10n),
                    color: AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                if (time != null)
                  Text(
                    timeAgo(l10n, time),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          if (entry.rating > 0) ...[
            const SizedBox(height: 8),
            FeedbackStars(rating: entry.rating),
          ],
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: Text(
              entry.comment.isEmpty ? l10n.feedbackNoComment : entry.comment,
              style: TextStyle(
                fontSize: 14.5,
                height: 1.4,
                fontStyle: entry.comment.isEmpty
                    ? FontStyle.italic
                    : FontStyle.normal,
                color: entry.comment.isEmpty
                    ? AppColors.textMuted
                    : AppColors.text,
              ),
            ),
          ),
          if (entry.screenshotPath case final path?) ...[
            const SizedBox(height: 10),
            _ScreenshotThumb(path: path),
          ],
          if (entry.note.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: const EdgeInsetsDirectional.only(end: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.sticky_note_2_rounded,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.note,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          Text(
            [entry.name, entry.email].where((t) => t.isNotEmpty).join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            details,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
          const Divider(height: 18),
          Row(
            children: [
              PopupMenuButton<FeedbackStatus>(
                tooltip: l10n.fbAdminChangeStatus,
                onSelected: onStatus,
                itemBuilder: (_) => [
                  for (final s in FeedbackStatus.values)
                    CheckedPopupMenuItem(
                      value: s,
                      checked: s == entry.status,
                      child: Text(s.label(l10n)),
                    ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: entry.status.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.status.label(l10n),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: entry.status == FeedbackStatus.open
                              ? AppColors.rewardText
                              : entry.status.color,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.expand_more_rounded,
                        size: 18,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
                ),
              ),
              if (entry.thanked) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.mark_email_read_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    l10n.fbAdminThanked,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              IconButton(
                tooltip: l10n.fbAdminNote,
                icon: const Icon(Icons.edit_note_rounded),
                color: AppColors.textMuted,
                onPressed: onNote,
              ),
              if (onUser != null)
                IconButton(
                  tooltip: l10n.fbAdminOpenUser,
                  icon: const Icon(Icons.person_rounded),
                  color: AppColors.textMuted,
                  onPressed: onUser,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color == AppColors.accent ? AppColors.rewardText : color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreenshotThumb extends ConsumerWidget {
  final String path;

  const _ScreenshotThumb({required this.path});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(_screenshotProvider(path)).value;
    return GestureDetector(
      onTap: url == null
          ? null
          : () => showDialog<void>(
              context: context,
              builder: (_) => Dialog.fullscreen(
                backgroundColor: Colors.black,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: InteractiveViewer(
                        maxScale: 5,
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: IconButton(
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).closeButtonTooltip,
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 90,
          height: 130,
          color: AppColors.background,
          child: url == null
              ? const Center(
                  child: Icon(
                    Icons.image_rounded,
                    color: AppColors.border,
                    size: 32,
                  ),
                )
              : CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _DoneDialog extends StatefulWidget {
  const _DoneDialog();

  @override
  State<_DoneDialog> createState() => _DoneDialogState();
}

class _DoneDialogState extends State<_DoneDialog> {
  bool _notify = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.fbAdminMarkDoneTitle),
      content: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        value: _notify,
        onChanged: (v) => setState(() => _notify = v),
        title: Text(l10n.fbAdminNotify),
        subtitle: Text(l10n.fbAdminNotifyHelp),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_notify),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}

class _NoteDialog extends StatefulWidget {
  final String initial;

  const _NoteDialog({required this.initial});

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  late final _text = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.fbAdminNote),
      content: TextField(
        controller: _text,
        autofocus: true,
        minLines: 2,
        maxLines: 5,
        maxLength: feedbackNoteMax,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(hintText: l10n.fbAdminNoteHint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_text.text.trim()),
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
