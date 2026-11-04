import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../moderation/presentation/providers/moderation_provider.dart';
import '../../../moderation/presentation/widgets/flag_actions.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../domain/sitting.dart';
import '../providers/sitting_provider.dart';
import '../widgets/sitting_widgets.dart';

Future<void> openChatWith(
  BuildContext context,
  WidgetRef ref,
  String otherId,
  String otherName,
) async {
  final l10n = context.l10n;
  final me = ref.read(authStateProvider).value?.uid;
  final myName = ref.read(userProfileProvider).value?.name ?? '';
  if (me == null || me == otherId) return;
  try {
    final id = await ref
        .read(sittingRepositoryProvider)
        .openChat(me: me, myName: myName, other: otherId, otherName: otherName);
    if (context.mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              ChatScreen(chatId: id, otherId: otherId, otherName: otherName),
        ),
      );
    }
  } catch (e) {
    debugPrint('Chat not opened: $e');
    if (context.mounted) SnackbarUtils.showError(context, l10n.sitCantMessage);
  }
}

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final me = ref.watch(authStateProvider).value?.uid ?? '';
    final blocked = ref.watch(blockedUsersProvider);
    final state = ref.watch(myChatsProvider);
    final chats = [
      for (final c in state.value ?? const <SittingChat>[])
        if (c.lastAt != null && !blocked.containsKey(c.otherOf(me))) c,
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.sitChats),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: !state.hasValue
          ? const Center(child: CircularProgressIndicator())
          : chats.isEmpty
          ? SittingEmpty(
              icon: Icons.chat_bubble_outline_rounded,
              text: l10n.sitNoChats,
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: chats.length,
              separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
              itemBuilder: (context, i) {
                final c = chats[i];
                final other = c.otherOf(me);
                final name = c.names[other] ?? '';
                final unread = c.unreadFor(me);
                return ListTile(
                  leading: SittingAvatar(name: name),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: unread ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    c.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (c.lastAt != null)
                        Text(
                          DateFormat.MMMd(l10n.localeName).format(c.lastAt!),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      if (unread)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: sittingColor,
                          ),
                        ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        chatId: c.id,
                        otherId: other,
                        otherName: name,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ChatScreen extends ConsumerStatefulWidget {
  final String chatId;
  final String otherId;
  final String otherName;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.otherId,
    required this.otherName,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _text = TextEditingController();
  bool _sending = false;
  String? _readUpTo;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _markRead(List<ChatMessage> messages, String me) {
    final latest = messages.firstOrNull;
    if (latest == null || latest.id == _readUpTo || latest.senderId == me) {
      return;
    }
    _readUpTo = latest.id;
    ref
        .read(sittingRepositoryProvider)
        .markRead(widget.chatId, me)
        .catchError((_) {});
  }

  Future<void> _send(String me) async {
    final l10n = context.l10n;
    final text = _text.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(sittingRepositoryProvider)
          .send(widget.chatId, me: me, to: widget.otherId, text: text);
      _text.clear();
    } catch (e) {
      debugPrint('Message not sent: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.sitCantMessage);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final me = ref.watch(authStateProvider).value?.uid ?? '';
    final iBlocked = ref
        .watch(blockedUsersProvider)
        .containsKey(widget.otherId);
    final state = ref.watch(chatMessagesProvider(widget.chatId));
    final messages = state.value ?? const <ChatMessage>[];
    if (state.hasValue) _markRead(messages, me);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                gradient: sittingGradient,
                shape: BoxShape.circle,
              ),
              child: SittingAvatar(name: widget.otherName, radius: 17),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(widget.otherName, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'report') {
                await flagWith(
                  context,
                  (reason, note) => ref
                      .read(sittingRepositoryProvider)
                      .flag(
                        reporterId: me,
                        kind: SittingFlagKind.chat,
                        targetId: widget.chatId,
                        targetOwnerId: widget.otherId,
                        reason: reason,
                        note: note,
                      ),
                );
              } else if (v == 'block' && context.mounted) {
                await blockUser(
                  context,
                  ref,
                  userId: widget.otherId,
                  name: widget.otherName,
                );
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'report', child: Text(l10n.sitReport)),
              if (!iBlocked)
                PopupMenuItem(
                  value: 'block',
                  child: Text(l10n.blockUser(widget.otherName)),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? SittingEmpty(
                    icon: Icons.waving_hand_outlined,
                    text: l10n.sitSayHello(widget.otherName),
                  )
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      final m = messages[i];
                      final mine = m.senderId == me;
                      // The list runs bottom-up: a day label goes above the first message of each day.
                      final older = i + 1 < messages.length
                          ? messages[i + 1]
                          : null;
                      final newDay =
                          m.at != null &&
                          (older?.at == null ||
                              !DateUtils.isSameDay(older!.at, m.at));
                      final sameSender =
                          older != null &&
                          older.senderId == m.senderId &&
                          !newDay;
                      const r = Radius.circular(18);
                      const tail = Radius.circular(4);
                      final bubble = Align(
                        alignment: mine
                            ? AlignmentDirectional.centerEnd
                            : AlignmentDirectional.centerStart,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                          ),
                          margin: EdgeInsets.only(top: sameSender ? 2 : 8),
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
                          decoration: BoxDecoration(
                            gradient: mine ? sittingGradient : null,
                            color: mine ? null : AppColors.surface,
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: r,
                              topEnd: r,
                              bottomStart: mine ? r : tail,
                              bottomEnd: mine ? tail : r,
                            ),
                            border: mine
                                ? null
                                : Border.all(color: AppColors.border),
                            boxShadow: mine
                                ? [
                                    BoxShadow(
                                      color: sittingColor.withValues(
                                        alpha: 0.18,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                m.text,
                                style: TextStyle(
                                  height: 1.3,
                                  color: mine ? Colors.white : AppColors.text,
                                ),
                              ),
                              if (m.at != null)
                                Text(
                                  DateFormat.Hm(l10n.localeName).format(m.at!),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: mine
                                        ? Colors.white70
                                        : AppColors.textMuted,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                      if (!newDay) return bubble;
                      final today = DateUtils.isSameDay(m.at, DateTime.now());
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14, bottom: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.border.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                today
                                    ? l10n.heatLegendToday
                                    : DateFormat.yMMMd(
                                        l10n.localeName,
                                      ).format(m.at!),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                          bubble,
                        ],
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: iBlocked
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      l10n.sitYouBlocked(widget.otherName),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textMuted),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 8, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _text,
                            maxLength: 1000,
                            maxLines: 4,
                            minLines: 1,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: l10n.sitMessageHint,
                              counterText: '',
                              isDense: true,
                              filled: true,
                              fillColor: AppColors.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: sittingColor,
                          ),
                          onPressed: _sending ? null : () => _send(me),
                          icon: const Icon(Icons.send_rounded),
                        ),
                      ],
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
            child: Text(
              l10n.sitChatSafety,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.5,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
