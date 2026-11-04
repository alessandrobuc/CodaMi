import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../moderation/presentation/widgets/flag_actions.dart';
import '../../data/sitting_repository.dart';
import '../../domain/sitting.dart';
import '../providers/sitting_provider.dart';
import '../widgets/sitting_widgets.dart';
import 'request_screens.dart';
import 'sitter_screens.dart';

extension SittingFlagKindView on SittingFlagKind {
  IconData get icon => switch (this) {
    SittingFlagKind.request => Icons.event_note_outlined,
    SittingFlagKind.sitter => Icons.badge_outlined,
    SittingFlagKind.review => Icons.star_outline_rounded,
    SittingFlagKind.chat => Icons.forum_outlined,
  };

  Color get color => switch (this) {
    SittingFlagKind.request => sittingColor,
    SittingFlagKind.sitter => AppColors.primary,
    SittingFlagKind.review => const Color(0xFFB7791F),
    SittingFlagKind.chat => AppColors.danger,
  };

  String label(AppLocalizations l10n) => switch (this) {
    SittingFlagKind.request => l10n.sitKindRequest,
    SittingFlagKind.sitter => l10n.sitKindSitter,
    SittingFlagKind.review => l10n.sitKindReview,
    SittingFlagKind.chat => l10n.sitKindChat,
  };
}

class AdminSittingScreen extends ConsumerWidget {
  const AdminSittingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final flags = ref.watch(sittingFlagsProvider).value?.length ?? 0;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(l10n.sitTitle),
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(54),
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: sittingColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: sittingColor.withValues(alpha: 0.15)),
              ),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  gradient: sittingGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: sittingColor,
                labelStyle: const TextStyle(fontWeight: FontWeight.w800),
                labelPadding: const EdgeInsets.symmetric(horizontal: 14),
                tabs: [
                  Tab(
                    height: 36,
                    child: _TabLabel(Icons.tune_rounded, l10n.sitAdminSettings),
                  ),
                  Tab(
                    height: 36,
                    child: Badge(
                      isLabelVisible: flags > 0,
                      label: Text('$flags'),
                      offset: const Offset(10, -6),
                      child: _TabLabel(
                        Icons.flag_outlined,
                        l10n.sitAdminReported,
                      ),
                    ),
                  ),
                  Tab(
                    height: 36,
                    child: _TabLabel(
                      Icons.event_note_outlined,
                      l10n.sitTabRequests,
                    ),
                  ),
                  Tab(
                    height: 36,
                    child: _TabLabel(Icons.badge_outlined, l10n.sitTabSitters),
                  ),
                  Tab(
                    height: 36,
                    child: _TabLabel(
                      Icons.star_outline_rounded,
                      l10n.sitAdminReviews,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            _Settings(),
            _Reported(),
            _Requests(),
            _Sitters(),
            _Reviews(),
          ],
        ),
      ),
    );
  }
}

Future<void> _hide(
  BuildContext context,
  WidgetRef ref,
  SittingFlagKind kind,
  String id,
  bool hidden,
) => runSitting(
  context,
  () => ref.read(sittingRepositoryProvider).setHidden(kind, id, hidden),
  success: hidden ? context.l10n.sitHiddenDone : context.l10n.sitShownDone,
);

class _Settings extends ConsumerStatefulWidget {
  const _Settings();

  @override
  ConsumerState<_Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<_Settings> {
  SittingConfig? _config;
  final _days = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _days.dispose();
    super.dispose();
  }

  Future<void> _write(SittingConfig c) async {
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    await ref.read(sittingRepositoryProvider).saveConfig(c, adminId: adminId);
  }

  Future<void> _setEnabled(SittingConfig c, bool v) async {
    final l10n = context.l10n;
    final saved = ref.read(sittingConfigProvider).value ?? c;
    setState(() {
      _config = c.copyWith(enabled: v);
      _saving = true;
    });
    try {
      await _write(saved.copyWith(enabled: v));
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (_) {
      if (mounted) {
        setState(() => _config = _config?.copyWith(enabled: !v));
        SnackbarUtils.showError(context, l10n.actionFailed);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _save(SittingConfig c) async {
    final l10n = context.l10n;
    final days = readInt(_days);
    if (days == null || days < 0 || days > 60) {
      SnackbarUtils.showError(context, l10n.sitDaysInvalid);
      return;
    }
    setState(() => _saving = true);
    try {
      await _write(c.copyWith(minAccountDays: days));
      if (mounted) SnackbarUtils.showSuccess(context, l10n.settingsSaved);
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(sittingConfigProvider);
    if (_config == null && state.hasValue) {
      _config = state.value;
      _days.text = '${_config!.minAccountDays}';
    }
    final c = _config;
    if (c == null) return const Center(child: CircularProgressIndicator());
    return AbsorbPointer(
      absorbing: _saving,
      child: ListView(
        padding: settingsListPadding(context),
        children: [
          SettingsHeader(
            icon: Icons.volunteer_activism_rounded,
            color: sittingColor,
            title: l10n.sitTitle,
            text: l10n.sitAdminIntro,
          ),
          SittingTitle(l10n.sitAdminOverview),
          StatGrid(
            tiles: [
              StatTile(
                icon: Icons.event_available_rounded,
                value:
                    '${(ref.watch(latestRequestsProvider).value ?? const <SittingRequest>[]).where((r) => r.status == SittingStatus.open && !r.hidden).length}',
                label: l10n.sitStatOpenRequests,
              ),
              StatTile(
                icon: Icons.badge_outlined,
                value:
                    '${(ref.watch(latestSittersProvider).value ?? const <SitterProfile>[]).where((x) => !x.hidden).length}',
                label: l10n.sitTabSitters,
                color: AppColors.primary,
              ),
              StatTile(
                icon: Icons.flag_outlined,
                value: '${ref.watch(sittingFlagsProvider).value?.length ?? 0}',
                label: l10n.sitAdminReported,
                color: AppColors.danger,
              ),
              StatTile(
                icon: Icons.star_outline_rounded,
                value: '${ref.watch(latestReviewsProvider).value?.length ?? 0}',
                label: l10n.sitAdminReviews,
                color: const Color(0xFFB7791F),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SettingsSection(
            title: l10n.walkShowToUsers,
            icon: Icons.visibility_rounded,
            color: c.enabled ? AppColors.primary : AppColors.textMuted,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: c.enabled,
                onChanged: (v) => _setEnabled(c, v),
                title: Text(
                  c.enabled ? l10n.sitOnHelp : l10n.sitOffHelp,
                  style: const TextStyle(fontSize: 14, color: AppColors.text),
                ),
              ),
            ],
          ),
          SettingsSection(
            title: l10n.sitAdminReviews,
            icon: Icons.star_outline_rounded,
            color: sittingColor,
            children: [
              SettingsNumberTile(
                controller: _days,
                label: l10n.sitMinAccountDays,
                help: l10n.sitMinAccountDaysHelp,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsSaveButton(
            label: l10n.save,
            saving: _saving,
            onPressed: () => _save(c),
          ),
        ],
      ),
    );
  }
}

class _Reported extends ConsumerWidget {
  const _Reported();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final flags = ref.watch(sittingFlagsProvider);
    final repo = ref.read(sittingRepositoryProvider);
    final list = flags.value ?? const <SittingFlag>[];
    if (!flags.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }
    if (list.isEmpty) {
      return SittingEmpty(
        icon: Icons.flag_outlined,
        text: l10n.sitNothingReported,
      );
    }
    void open(Widget screen) =>
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final f in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SittingCard(
              tint: f.kind.color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SittingChip(
                        f.kind.label(l10n),
                        color: f.kind.color,
                        icon: f.kind.icon,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          f.reason.label(l10n),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      if (f.createdAt != null)
                        Text(
                          DateFormat.MMMd(l10n.localeName).format(f.createdAt!),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                    ],
                  ),
                  if (f.note.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(f.note),
                  ],
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (f.kind == SittingFlagKind.request)
                        OutlinedButton(
                          onPressed: () =>
                              open(RequestDetailScreen(requestId: f.targetId)),
                          child: Text(l10n.sitOpen),
                        ),
                      if (f.kind != SittingFlagKind.request)
                        OutlinedButton(
                          onPressed: () =>
                              open(SitterProfileScreen(uid: f.targetOwnerId)),
                          child: Text(l10n.sitViewProfile),
                        ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.danger,
                        ),
                        onPressed: () async {
                          final kind = f.kind == SittingFlagKind.chat
                              ? SittingFlagKind.sitter
                              : f.kind;
                          final id = f.kind == SittingFlagKind.chat
                              ? f.targetOwnerId
                              : f.targetId;
                          await _hide(context, ref, kind, id, true);
                          await repo.dismissFlag(f.id).catchError((_) {});
                        },
                        child: Text(
                          f.kind == SittingFlagKind.chat
                              ? l10n.sitHideTheirProfile
                              : l10n.sitHide,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            runSitting(context, () => repo.dismissFlag(f.id)),
                        child: Text(l10n.sitDismiss),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

Widget _hideToggle(
  BuildContext context,
  WidgetRef ref,
  SittingFlagKind kind,
  String id,
  bool hidden,
) => TextButton(
  style: TextButton.styleFrom(
    foregroundColor: hidden ? AppColors.primary : AppColors.danger,
  ),
  onPressed: () => _hide(context, ref, kind, id, !hidden),
  child: Text(hidden ? context.l10n.sitShow : context.l10n.sitHide),
);

class _Requests extends ConsumerWidget {
  const _Requests();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(latestRequestsProvider);
    final list = state.value ?? const <SittingRequest>[];
    if (!state.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final r in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Opacity(
              opacity: r.hidden ? 0.55 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RequestCard(
                    request: r,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RequestDetailScreen(requestId: r.id),
                      ),
                    ),
                  ),
                  _hideToggle(
                    context,
                    ref,
                    SittingFlagKind.request,
                    r.id,
                    r.hidden,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Sitters extends ConsumerWidget {
  const _Sitters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(latestSittersProvider);
    final list = state.value ?? const <SitterProfile>[];
    if (!state.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final s in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Opacity(
              opacity: s.hidden ? 0.55 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SitterCard(
                    sitter: s,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SitterProfileScreen(uid: s.uid),
                      ),
                    ),
                  ),
                  _hideToggle(
                    context,
                    ref,
                    SittingFlagKind.sitter,
                    s.uid,
                    s.hidden,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Reviews extends ConsumerWidget {
  const _Reviews();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(latestReviewsProvider);
    final list = state.value ?? const <SittingReview>[];
    if (!state.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final r in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Opacity(
              opacity: r.hidden ? 0.55 : 1,
              child: SittingCard(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SitterProfileScreen(uid: r.sitterId),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StarRow(value: r.stars.toDouble()),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            r.reviewerName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (r.hidden)
                          SittingChip(
                            l10n.sitHiddenLabel,
                            color: AppColors.textMuted,
                          ),
                      ],
                    ),
                    if (r.text.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(r.text),
                    ],
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: _hideToggle(
                        context,
                        ref,
                        SittingFlagKind.review,
                        r.id,
                        r.hidden,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TabLabel(this.icon, this.text);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(text)],
  );
}
