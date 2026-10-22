import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/data/admin_repository.dart';
import '../../../admin/presentation/providers/admin_provider.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/support_repository.dart';
import '../../domain/support_case.dart';
import '../providers/support_provider.dart';
import '../widgets/support_labels.dart';

// The case on screen, so a push for it doesn't also show a banner.
final visibleSupportCase = ValueNotifier<String?>(null);

Future<void> runSupportAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  final l10n = context.l10n;
  try {
    await action();
  } on FirebaseFunctionsException catch (e) {
    if (!context.mounted) return;
    SnackbarUtils.showError(context, switch (e.code) {
      'already-exists' => l10n.supportAlreadyTaken,
      'resource-exhausted' => l10n.supportTooManyOpen,
      _ => l10n.actionFailed,
    });
  } catch (_) {
    if (context.mounted) SnackbarUtils.showError(context, l10n.actionFailed);
  }
}

class SupportCaseScreen extends ConsumerStatefulWidget {
  final String caseId;
  final bool asStaff;

  const SupportCaseScreen({
    super.key,
    required this.caseId,
    this.asStaff = false,
  });

  @override
  ConsumerState<SupportCaseScreen> createState() => _SupportCaseScreenState();
}

class _SupportCaseScreenState extends ConsumerState<SupportCaseScreen> {
  String? _previous;

  @override
  void initState() {
    super.initState();
    _previous = visibleSupportCase.value;
    visibleSupportCase.value = widget.caseId;
  }

  @override
  void dispose() {
    visibleSupportCase.value = _previous;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(supportCaseProvider(widget.caseId));
    final supportCase = state.value;

    if (supportCase == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.background),
        body: Center(
          child: state.isLoading
              ? const CircularProgressIndicator()
              : Text(l10n.actionFailed),
        ),
      );
    }

    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          supportCase.subject,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        Text(
          '${supportCase.reference} · ${supportCase.kind.label(l10n)}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
    final chat = _ChatView(supportCase: supportCase, asStaff: widget.asStaff);

    if (!widget.asStaff) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          title: title,
          actions: [
            if (supportCase.status.isActive)
              IconButton(
                tooltip: l10n.supportMarkSolved,
                icon: const Icon(Icons.task_alt_rounded),
                onPressed: () => _markSolved(supportCase),
              ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: _UserStatusStrip(supportCase: supportCase),
          ),
        ),
        body: chat,
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          title: title,
          actions: [_StaffMenu(supportCase: supportCase)],
        ),
        body: Column(
          children: [
            _StaffHeader(supportCase: supportCase),
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorPadding: const EdgeInsets.all(3),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textMuted,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                  tabs: [
                    Tab(text: l10n.supportChat),
                    Tab(text: l10n.supportDetails),
                    Tab(text: l10n.supportTimeline),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: TabBarView(
                children: [
                  chat,
                  _DetailsView(supportCase: supportCase),
                  _TimelineView(caseId: widget.caseId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _markSolved(SupportCase supportCase) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.task_alt_rounded,
          color: AppColors.primary,
          size: 32,
        ),
        title: Text(l10n.supportMarkSolved),
        content: Text(
          l10n.supportMarkSolvedConfirm,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.supportMarkSolved),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await runSupportAction(
      context,
      () => ref
          .read(supportRepositoryProvider)
          .setStatus(supportCase.id, CaseStatus.resolved),
    );
  }
}

class _UserStatusStrip extends StatelessWidget {
  final SupportCase supportCase;

  const _UserStatusStrip({required this.supportCase});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          StatusBadge(supportCase.status),
          const SizedBox(width: 10),
          Icon(supportCase.category.icon, size: 16, color: AppColors.textMuted),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              supportCase.category.label(l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.5,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Who asked, who handles it, how long the user has waited, and the main action.
class _StaffHeader extends ConsumerWidget {
  final SupportCase supportCase;

  const _StaffHeader({required this.supportCase});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = supportCase;
    final uid = ref.watch(authStateProvider).value?.uid;
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final waiting = c.waitingFor();
    final repo = ref.read(supportRepositoryProvider);
    final mine = c.assignedTo == uid;
    final name = c.userName.isEmpty ? c.userEmail : c.userName;

    final Widget? action;
    if (!c.status.isActive) {
      action = null;
    } else if (!c.isAssigned) {
      action = FilledButton.icon(
        onPressed: () => runSupportAction(context, () => repo.takeCase(c.id)),
        icon: const Icon(Icons.pan_tool_alt_rounded, size: 18),
        label: Text(l10n.supportTake),
      );
    } else if (mine || isAdmin) {
      action = OutlinedButton.icon(
        onPressed: () => runSupportAction(
          context,
          () => repo.setStatus(c.id, CaseStatus.resolved),
        ),
        icon: const Icon(Icons.task_alt_rounded, size: 18),
        label: Text(l10n.supportResolve),
      );
    } else {
      action = null;
    }

    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              _Initial(name: name, color: c.status.color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    if (c.userName.isNotEmpty && c.userEmail.isNotEmpty)
                      Text(
                        c.userEmail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              StatusBadge(c.status),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    InfoPill(
                      icon: Icons.support_agent_rounded,
                      text: c.assignedName ?? l10n.supportUnassigned,
                      color: c.isAssigned
                          ? AppColors.primary
                          : AppColors.lostPin,
                    ),
                    if (waiting != null)
                      InfoPill(
                        icon: c.overdue
                            ? Icons.alarm_rounded
                            : Icons.schedule_rounded,
                        text: c.overdue
                            ? '${l10n.supportOverdue} · ${formatDuration(l10n, waiting)}'
                            : l10n.supportWaitingFor(
                                formatDuration(l10n, waiting),
                              ),
                        color: c.overdue ? AppColors.danger : AppColors.accent,
                      ),
                  ],
                ),
              ),
              if (action != null) ...[const SizedBox(width: 8), action],
            ],
          ),
        ],
      ),
    );
  }
}

class _Initial extends StatelessWidget {
  final String name;
  final Color color;

  const _Initial({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    final letter = name.trim().characters.firstOrNull?.toUpperCase() ?? '?';
    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        shape: BoxShape.circle,
      ),
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

class _StaffMenu extends ConsumerWidget {
  final SupportCase supportCase;

  const _StaffMenu({required this.supportCase});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final uid = ref.watch(authStateProvider).value?.uid;
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final c = supportCase;
    final canManage = isAdmin || c.assignedTo == uid;
    final canReassign = isAdmin && c.status.isActive;
    if (c.status == CaseStatus.closed || (!canManage && !canReassign)) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onSelected: (value) => switch (value) {
        'status' => _pickStatus(context, ref),
        'reassign' => _reassign(context, ref),
        _ => null,
      },
      itemBuilder: (context) => [
        if (canManage)
          PopupMenuItem(
            value: 'status',
            child: ListTile(
              leading: const Icon(Icons.flag_circle_outlined),
              title: Text(l10n.supportChangeStatus),
            ),
          ),
        if (canReassign)
          PopupMenuItem(
            value: 'reassign',
            child: ListTile(
              leading: const Icon(Icons.swap_horiz_rounded),
              title: Text(l10n.supportReassign),
            ),
          ),
      ],
    );
  }

  Widget _sheetTitle(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    child: Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
    ),
  );

  Future<void> _pickStatus(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final choice = await showModalBottomSheet<CaseStatus>(
      context: context,
      showDragHandle: true,
      builder: (context) => _BottomInset(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _sheetTitle(context, l10n.supportChangeStatus),
              for (final status in CaseStatus.values)
                if (status != CaseStatus.open)
                  _SheetOption(
                    selected: status == supportCase.status,
                    leading: Icon(Icons.circle, size: 14, color: status.color),
                    title: status.label(l10n),
                    color: status.color,
                    onTap: () => Navigator.pop(context, status),
                  ),
            ],
          ),
        ),
      ),
    );
    if (choice == null || !context.mounted) return;
    await runSupportAction(
      context,
      () =>
          ref.read(supportRepositoryProvider).setStatus(supportCase.id, choice),
    );
  }

  Future<void> _reassign(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final me = ref.read(authStateProvider).value?.uid;
    final staff = await ref
        .read(supportStaffProvider.future)
        .catchError((Object _) => const <StaffMember>[]);
    if (!context.mounted) return;
    final presence = ref.read(staffPresenceProvider).value ?? const {};
    PresenceState stateOf(String uid) =>
        (presence[uid] ?? const StaffPresence()).current();

    Widget avatar(IconData icon, [PresenceState? state]) => Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.12),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        if (state != null)
          Positioned(
            right: -1,
            bottom: -1,
            child: PresenceDot(state, size: 12),
          ),
      ],
    );

    // `''` means back to the queue; null means the sheet was dismissed.
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => _BottomInset(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.7,
          ),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              _sheetTitle(context, l10n.supportAssignTo),
              if (me != null && me != supportCase.assignedTo)
                _SheetOption(
                  leading: avatar(Icons.admin_panel_settings_rounded),
                  title: ref.read(currentUserInfoProvider).name,
                  subtitle: l10n.roleAdmin,
                  onTap: () => Navigator.pop(context, me),
                ),
              for (final member in staff)
                if (member.uid != supportCase.assignedTo)
                  _SheetOption(
                    leading: avatar(
                      Icons.support_agent_rounded,
                      stateOf(member.uid),
                    ),
                    title: member.name.isEmpty ? member.email : member.name,
                    subtitle: stateOf(member.uid).label(l10n),
                    onTap: () => Navigator.pop(context, member.uid),
                  ),
              if (supportCase.isAssigned)
                _SheetOption(
                  leading: avatar(Icons.inbox_rounded),
                  title: l10n.supportBackToQueue,
                  onTap: () => Navigator.pop(context, ''),
                ),
            ],
          ),
        ),
      ),
    );
    if (choice == null || !context.mounted) return;
    await runSupportAction(
      context,
      () => ref
          .read(supportRepositoryProvider)
          .reassignCase(supportCase.id, choice.isEmpty ? null : choice),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _SheetOption({
    required this.leading,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.selected = false,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected ? color.withValues(alpha: 0.1) : AppColors.background,
        borderRadius: BorderRadius.circular(14),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          leading: leading,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: subtitle == null ? null : Text(subtitle!),
          trailing: selected ? Icon(Icons.check_rounded, color: color) : null,
          enabled: !selected,
          onTap: onTap,
        ),
      ),
    );
  }
}

class _ChatView extends ConsumerStatefulWidget {
  final SupportCase supportCase;
  final bool asStaff;

  const _ChatView({required this.supportCase, required this.asStaff});

  @override
  ConsumerState<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<_ChatView>
    with AutomaticKeepAliveClientMixin {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  bool _sending = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  // The list is reversed, so older messages are at the end of the scroll.
  void _onScroll() {
    if (_scroll.position.extentAfter < 300) _loadEarlier();
  }

  void _loadEarlier() {
    final id = widget.supportCase.id;
    final loaded = ref.read(supportMessagesProvider(id)).value?.length;
    if (loaded == null) return;
    ref
        .read(supportLimitProvider(messagesKey(id)).notifier)
        .loadMore(loaded: loaded);
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    final uid = ref.read(authStateProvider).value?.uid;
    if (text.isEmpty || uid == null || _sending) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(supportRepositoryProvider)
          .sendMessage(
            caseId: widget.supportCase.id,
            senderId: uid,
            asStaff: widget.asStaff,
            text: text,
          );
      _controller.clear();
      if (_scroll.hasClients) {
        _scroll.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, context.l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = context.l10n;
    final c = widget.supportCase;
    final uid = ref.watch(authStateProvider).value?.uid;
    final isAdmin = ref.watch(userRoleProvider) == UserRole.admin;
    final messages = ref.watch(supportMessagesProvider(c.id));
    final limit = ref.watch(supportLimitProvider(messagesKey(c.id)));
    if (widget.asStaff && isAdmin) ref.watch(supportStaffProvider);
    final all = messages.value ?? const <SupportMessage>[];
    final hasEarlier = all.length > limit;
    final newestFirst = all.take(limit).toList();

    final (IconData, String)? note = switch (c.status) {
      CaseStatus.closed => (Icons.lock_outline_rounded, l10n.supportClosedNote),
      CaseStatus.resolved when !widget.asStaff => (
        Icons.task_alt_rounded,
        l10n.supportResolvedNote,
      ),
      _ when !widget.asStaff && c.firstResponseAt == null => (
        Icons.schedule_rounded,
        l10n.supportWaitingNote,
      ),
      _ => null,
    };
    final mustTake =
        widget.asStaff && !isAdmin && c.assignedTo != uid && c.status.isActive;
    final canWrite = c.status != CaseStatus.closed && !mustTake;

    return Column(
      children: [
        Expanded(
          child: messages.isLoading && !messages.hasValue
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _scroll,
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                  itemCount: newestFirst.length + 1,
                  itemBuilder: (context, i) {
                    if (i == newestFirst.length) {
                      return hasEarlier
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: TextButton.icon(
                                  onPressed: _loadEarlier,
                                  icon: const Icon(
                                    Icons.history_rounded,
                                    size: 18,
                                  ),
                                  label: Text(l10n.chatLoadEarlier),
                                ),
                              ),
                            )
                          : const SizedBox(height: 4);
                    }
                    final message = newestFirst[i];
                    final older = i + 1 < newestFirst.length
                        ? newestFirst[i + 1]
                        : null;
                    final mine = widget.asStaff
                        ? message.fromStaff
                        : !message.fromStaff;
                    final newDay =
                        older == null ||
                        !_sameDay(older.createdAt, message.createdAt);
                    final firstOfGroup =
                        newDay ||
                        older.fromStaff != message.fromStaff ||
                        older.senderId != message.senderId;
                    return Column(
                      children: [
                        if (newDay && message.createdAt != null)
                          _DayChip(day: message.createdAt!),
                        _Bubble(
                          message: message,
                          mine: mine,
                          author: firstOfGroup ? _author(message, uid) : null,
                          tight: !firstOfGroup,
                        ),
                      ],
                    );
                  },
                ),
        ),
        if (note != null)
          _BottomInset(
            // Only needed when nothing sits below the note.
            enabled: !canWrite && !mustTake,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(note.$1, size: 18, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        note.$2,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (mustTake)
          _BottomInset(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: FilledButton.icon(
                onPressed: c.isAssigned
                    ? null
                    : () => runSupportAction(
                        context,
                        () =>
                            ref.read(supportRepositoryProvider).takeCase(c.id),
                      ),
                icon: const Icon(Icons.pan_tool_alt_rounded),
                label: Text(
                  c.isAssigned
                      ? l10n.eventTaken(c.assignedName ?? '')
                      : l10n.supportTakeToReply,
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        if (canWrite)
          _Composer(controller: _controller, sending: _sending, onSend: _send),
      ],
    );
  }

  bool _sameDay(DateTime? a, DateTime? b) =>
      a != null &&
      b != null &&
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day;

  String? _author(SupportMessage message, String? uid) {
    final l10n = context.l10n;
    final c = widget.supportCase;
    if (!widget.asStaff) return message.fromStaff ? l10n.supportTeam : null;
    if (!message.fromStaff) return c.userName.isEmpty ? null : c.userName;
    if (message.senderId == uid) return null;
    if (message.senderId == c.assignedTo) return c.assignedName;
    if (ref.read(userRoleProvider) != UserRole.admin) return l10n.supportTeam;
    final staff = ref.read(supportStaffProvider).value ?? const [];
    return staff.where((s) => s.uid == message.senderId).firstOrNull?.name ??
        l10n.roleAdmin;
  }
}

class _Composer extends StatelessWidget {
  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  const _Composer({
    required this.controller,
    required this.sending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    );
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _BottomInset(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 5,
                  maxLength: 2000,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: l10n.supportTypeMessage,
                    counterText: '',
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 48,
                height: 48,
                child: IconButton.filled(
                  tooltip: l10n.supportSend,
                  onPressed: sending ? null : onSend,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  icon: sending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send_rounded, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Keeps content above the phone's navigation bar. Some Android phones report
// no bottom padding with edge-to-edge, so the view padding is used, and nothing
// while the keyboard is open because the Scaffold already sits above it.
class _BottomInset extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const _BottomInset({required this.child, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final bottom = keyboardOpen
        ? 0.0
        : MediaQuery.viewPaddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: child,
    );
  }
}

class _DayChip extends StatelessWidget {
  final DateTime day;

  const _DayChip({required this.day});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final days = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime(day.year, day.month, day.day)).inDays;
    final label = switch (days) {
      0 => l10n.chatToday,
      1 => l10n.timeYesterday,
      < 7 => DateFormat.EEEE(l10n.localeName).format(day),
      _ => shortDate(l10n, day),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.border.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final SupportMessage message;
  final bool mine;
  final String? author;

  // A follow-up from the same sender sits closer to the one before it.
  final bool tight;

  const _Bubble({
    required this.message,
    required this.mine,
    this.author,
    this.tight = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final time = message.createdAt;
    final muted = mine ? Colors.white70 : AppColors.textMuted;
    return Align(
      alignment: mine
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: Container(
          margin: EdgeInsets.only(top: tight ? 2 : 8),
          padding: const EdgeInsets.fromLTRB(13, 9, 13, 7),
          decoration: BoxDecoration(
            gradient: mine
                ? const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: mine ? null : AppColors.surface,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(!mine && tight ? 6 : 18),
              topEnd: Radius.circular(mine && tight ? 6 : 18),
              bottomStart: Radius.circular(mine ? 18 : 6),
              bottomEnd: Radius.circular(mine ? 6 : 18),
            ),
            border: mine ? null : Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (author != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    author!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: mine ? Colors.white70 : AppColors.primary,
                    ),
                  ),
                ),
              Text(
                message.text,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.3,
                  color: mine ? Colors.white : AppColors.text,
                ),
              ),
              const SizedBox(height: 3),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: time == null
                    ? Icon(Icons.schedule_rounded, size: 12, color: muted)
                    : Text(
                        clockTime(l10n, time),
                        style: TextStyle(fontSize: 11, color: muted),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final SupportCase supportCase;

  const _DetailsView({required this.supportCase});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = supportCase;
    String at(DateTime? t) => t == null ? '–' : dateTimeLabel(l10n, t);
    String took(Duration? d) => d == null ? '–' : formatDuration(l10n, d);

    final metrics = [
      (
        Icons.hourglass_bottom_rounded,
        l10n.supportWaitToTake,
        took(c.waitToTakeOver),
        AppColors.accent,
      ),
      (
        Icons.reply_rounded,
        l10n.supportFirstReply,
        took(c.firstResponseTime),
        AppColors.primary,
      ),
      (
        Icons.speed_rounded,
        l10n.supportAvgReply,
        took(c.averageResponseTime),
        AppColors.primaryDark,
      ),
      (
        Icons.timer_outlined,
        l10n.supportHandlingTime,
        formatDuration(l10n, c.handlingTime()),
        AppColors.lostPin,
      ),
    ];

    return ListView(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        32 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      children: [
        _SectionTitle(l10n.supportTimes),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.9,
          children: [
            for (final (icon, label, value, color) in metrics)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 16, color: color),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionTitle(l10n.supportPeople),
        _InfoCard(
          rows: [
            (
              Icons.person_outline_rounded,
              l10n.supportUserLabel,
              [c.userName, c.userEmail].where((s) => s.isNotEmpty).join('\n'),
            ),
            (
              Icons.support_agent_rounded,
              l10n.supportOperator,
              c.assignedName ?? l10n.supportUnassigned,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionTitle(l10n.supportRequestInfo),
        _InfoCard(
          rows: [
            (c.kind.icon, l10n.supportType, c.kind.label(l10n)),
            (c.category.icon, l10n.supportCategory, c.category.label(l10n)),
            (
              Icons.chat_bubble_outline_rounded,
              l10n.supportMessagesCount,
              '${c.messageCount}',
            ),
            (
              Icons.add_circle_outline_rounded,
              l10n.supportOpened,
              at(c.createdAt),
            ),
            (
              Icons.pan_tool_alt_outlined,
              l10n.supportTakenOver,
              at(c.assignedAt),
            ),
            if (c.resolvedAt != null)
              (
                Icons.task_alt_rounded,
                l10n.supportResolvedAt,
                at(c.resolvedAt),
              ),
            if (c.closedAt != null)
              (
                Icons.lock_outline_rounded,
                l10n.caseStatusClosed,
                at(c.closedAt),
              ),
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w700,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<(IconData, String, String)> rows;

  const _InfoCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (final (i, (icon, label, value)) in rows.indexed) ...[
            if (i > 0)
              const Divider(height: 1, indent: 54, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(icon, size: 16, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 2,
                    child: SelectableText(
                      value,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimelineView extends ConsumerWidget {
  final String caseId;

  const _TimelineView({required this.caseId});

  String _text(AppLocalizations l10n, SupportEvent e) {
    final name = e.byUser || e.byName.isNotEmpty ? e.byName : l10n.roleAdmin;
    return switch (e.type) {
      CaseEventType.created => l10n.eventCreated(e.byName),
      CaseEventType.taken => l10n.eventTaken(e.byName),
      CaseEventType.reassigned =>
        e.toName == null
            ? [
                l10n.supportBackToQueue,
                if (e.byName.isNotEmpty) e.byName,
              ].join(' · ')
            : l10n.eventReassigned(
                e.fromName ?? l10n.supportUnassigned,
                e.toName!,
              ),
      CaseEventType.status => l10n.eventStatus(
        name,
        (e.toStatus ?? CaseStatus.open).label(l10n),
      ),
      CaseEventType.reopened => l10n.eventReopened,
      CaseEventType.overdue => l10n.eventOverdue,
      CaseEventType.autoClosed => l10n.eventAutoClosed,
    };
  }

  (IconData, Color) _style(SupportEvent e) => switch (e.type) {
    CaseEventType.created => (Icons.add_rounded, AppColors.lostPin),
    CaseEventType.taken => (Icons.pan_tool_alt_rounded, AppColors.primary),
    CaseEventType.reassigned => (
      Icons.swap_horiz_rounded,
      AppColors.primaryDark,
    ),
    CaseEventType.status => (
      Icons.flag_rounded,
      (e.toStatus ?? CaseStatus.open).color,
    ),
    CaseEventType.reopened => (Icons.replay_rounded, AppColors.accent),
    CaseEventType.overdue => (Icons.alarm_rounded, AppColors.danger),
    CaseEventType.autoClosed => (
      Icons.lock_clock_outlined,
      AppColors.textMuted,
    ),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final events = ref.watch(supportEventsProvider(caseId));
    final list = events.value ?? const <SupportEvent>[];
    if (events.isLoading && !events.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        32 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final e = list[i];
        final (icon, color) = _style(e);
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(icon, size: 17, color: color),
                  ),
                  if (i < list.length - 1)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _text(l10n, e),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                        if (e.at != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            dateTimeLabel(l10n, e.at!),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
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
      },
    );
  }
}
