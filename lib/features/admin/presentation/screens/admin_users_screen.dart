import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/admin_repository.dart';
import '../providers/admin_provider.dart';
import 'admin_user_screen.dart';

// With `pickStaff`, tapping a user adds them to the support team and pops
// with their name instead of opening their details.
class AdminUsersScreen extends ConsumerStatefulWidget {
  final bool pickStaff;

  const AdminUsersScreen({super.key, this.pickStaff = false});

  @override
  ConsumerState<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends ConsumerState<AdminUsersScreen> {
  final _search = TextEditingController();
  List<UserModel>? _results;
  bool _searching = false;
  String? _searchError;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _runSearch() async {
    final text = _search.text.trim();
    if (text.isEmpty) return _clear();
    if (text.length < 2) {
      setState(() => _searchError = context.l10n.searchTooShort);
      return;
    }
    setState(() {
      _searching = true;
      _searchError = null;
    });
    try {
      final found = await ref.read(adminRepositoryProvider).searchUsers(text);
      if (mounted) setState(() => _results = found);
    } catch (_) {
      if (mounted) setState(() => _searchError = context.l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  Future<void> _makeStaff(UserModel user) async {
    final l10n = context.l10n;
    final name = user.name.isEmpty ? user.email : user.name;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.support_agent_rounded,
          color: AppColors.primary,
          size: 32,
        ),
        title: Text(l10n.makeStaffTitle(name)),
        content: Text(l10n.makeStaffMessage, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.makeStaff),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref
          .read(adminRepositoryProvider)
          .setRole(user.uid, UserRole.support);
      if (mounted) Navigator.pop(context, name);
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  void _clear() {
    _search.clear();
    setState(() {
      _results = null;
      _searchError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(adminUsersProvider);
    final limit = ref.watch(adminLimitProvider(usersListKey));
    final all = state.value ?? const <UserModel>[];
    final hasMore = _results == null && all.length > limit;
    final users = _results ?? all.take(limit).toList();

    final Widget list;
    if (_results == null && state.isLoading && !state.hasValue) {
      list = const Center(child: CircularProgressIndicator());
    } else if (_results == null && state.hasError && !state.hasValue) {
      list = Center(child: Text(l10n.actionFailed));
    } else if (users.isEmpty) {
      list = Center(
        child: Text(
          l10n.noUsersFound,
          style: const TextStyle(color: AppColors.textMuted),
        ),
      );
    } else {
      list = ListView.separated(
        padding: EdgeInsets.fromLTRB(
          20,
          4,
          20,
          100 + MediaQuery.viewPaddingOf(context).bottom,
        ),
        itemCount: users.length + (hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          if (i == users.length) {
            return Center(
              child: TextButton.icon(
                onPressed: () => ref
                    .read(adminLimitProvider(usersListKey).notifier)
                    .loadMore(loaded: all.length),
                icon: const Icon(Icons.expand_more_rounded),
                label: Text(l10n.loadMore),
              ),
            );
          }
          final user = users[i];
          if (!widget.pickStaff) return UserTile(user: user);
          final canPick = !user.role.isStaff && !user.disabled;
          return UserTile(
            user: user,
            enabled: canPick,
            onTap: canPick ? () => _makeStaff(user) : null,
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.pickStaff ? l10n.pickStaffTitle : l10n.adminUsers),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          if (widget.pickStaff)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Text(
                l10n.pickStaffHint,
                style: const TextStyle(color: AppColors.textMuted),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: TextField(
              controller: _search,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _runSearch(),
              decoration: InputDecoration(
                hintText: l10n.searchUsersHint,
                errorText: _searchError,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searching
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : _results != null
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: _clear,
                      )
                    : null,
              ),
            ),
          ),
          Expanded(child: list),
        ],
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final UserModel user;

  // Defaults to opening the user's details.
  final VoidCallback? onTap;
  final bool enabled;

  const UserTile({
    super.key,
    required this.user,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = user.name.isEmpty ? user.email : user.name;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        enabled: enabled,
        onTap:
            onTap ??
            (enabled
                ? () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AdminUserScreen(uid: user.uid),
                    ),
                  )
                : null),
        leading: UserAvatar(user: user),
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          [if (user.name.isNotEmpty) user.email, ?user.city].join(' · '),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: user.disabled
            ? UserChip(label: l10n.userDisabled, color: AppColors.danger)
            : user.role.isStaff
            ? UserChip(
                label: roleLabel(l10n, user.role),
                color: AppColors.primary,
              )
            : const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
      ),
    );
  }
}

String roleLabel(AppLocalizations l10n, UserRole role) => switch (role) {
  UserRole.admin => l10n.roleAdmin,
  UserRole.support => l10n.roleSupport,
  UserRole.user => l10n.roleUser,
};

class UserAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;

  const UserAvatar({super.key, required this.user, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    final photo = user.photoUrl;
    final initial = (user.name.isEmpty ? user.email : user.name)
        .trim()
        .characters
        .firstOrNull
        ?.toUpperCase();
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
      backgroundImage: photo == null || photo.isEmpty
          ? null
          : NetworkImage(photo),
      child: photo == null || photo.isEmpty
          ? Text(
              initial ?? '?',
              style: TextStyle(
                fontSize: radius * 0.8,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            )
          : null,
    );
  }
}

class UserChip extends StatelessWidget {
  final String label;
  final Color color;

  const UserChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
