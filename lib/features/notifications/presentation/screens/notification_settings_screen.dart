import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../data/notification_sounds.dart';
import '../../domain/entities/notification_prefs.dart';
import '../providers/notification_settings_provider.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  static const _icons = {
    AlertType.lost: (Icons.search_rounded, AppColors.lostPin),
    AlertType.found: (Icons.volunteer_activism_rounded, AppColors.foundPin),
    AlertType.resolved: (Icons.home_rounded, AppColors.accent),
    AlertType.support: (Icons.support_agent_rounded, AppColors.primaryDark),
  };

  Future<void> _run(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } catch (_) {
      if (context.mounted) {
        SnackbarUtils.showError(context, context.l10n.actionFailed);
      }
    }
  }

  Future<void> _chooseSound(
    BuildContext context,
    WidgetRef ref,
    AlertType type,
  ) async {
    final current = ref.read(notificationPrefsProvider)[type].sound;
    final picked = await showModalBottomSheet<AlertSound>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _SoundSheet(type: type, current: current),
    );
    ref.read(notificationSoundsProvider).stop();
    if (picked == null || picked == current || !context.mounted) return;
    await _run(
      context,
      () => ref.read(notificationSettingsProvider).setSound(type, picked),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final prefs = ref.watch(notificationPrefsProvider);
    final settings = ref.read(notificationSettingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.notifications),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          Text(
            l10n.notificationSettingsIntro,
            style: const TextStyle(color: AppColors.textMuted, height: 1.4),
          ),
          const SizedBox(height: 16),
          for (final type in AlertType.values) ...[
            _AlertCard(
              icon: _icons[type]!.$1,
              color: _icons[type]!.$2,
              title: type.title(l10n),
              description: type.description(l10n),
              prefs: prefs[type],
              onToggle: (on) =>
                  _run(context, () => settings.setEnabled(type, on)),
              onSound: () => _chooseSound(context, ref, type),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final AlertPrefs prefs;
  final ValueChanged<bool> onToggle;
  final VoidCallback onSound;

  const _AlertCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.prefs,
    required this.onToggle,
    required this.onSound,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SwitchListTile(
            value: prefs.enabled,
            onChanged: onToggle,
            contentPadding: const EdgeInsets.fromLTRB(14, 6, 10, 6),
            secondary: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            subtitle: Text(
              description,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: prefs.enabled
                ? Column(
                    children: [
                      const Divider(
                        height: 1,
                        indent: 66,
                        color: AppColors.border,
                      ),
                      ListTile(
                        onTap: onSound,
                        contentPadding: const EdgeInsets.fromLTRB(66, 0, 14, 0),
                        title: Text(
                          l10n.notificationSound,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 160),
                              child: Text(
                                prefs.sound.label(l10n),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textMuted,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _SoundSheet extends ConsumerStatefulWidget {
  final AlertType type;
  final AlertSound current;

  const _SoundSheet({required this.type, required this.current});

  @override
  ConsumerState<_SoundSheet> createState() => _SoundSheetState();
}

class _SoundSheetState extends ConsumerState<_SoundSheet> {
  late AlertSound _selected = widget.current;

  // A phone sound picked in this sheet, shown until the sheet closes.
  late AlertSound? _custom =
      widget.current.kind == SoundKind.system ||
          widget.current.kind == SoundKind.file
      ? widget.current
      : null;

  bool _saved = false;

  late final NotificationSounds _sounds = ref.read(notificationSoundsProvider);

  @override
  void dispose() {
    final custom = _custom;
    final kept = _saved && _selected == custom;
    if (custom?.kind == SoundKind.file && custom != widget.current && !kept) {
      _sounds.deleteFile(custom!.value!);
    }
    super.dispose();
  }

  void _select(AlertSound sound) {
    setState(() => _selected = sound);
    _sounds.play(sound);
  }

  Future<void> _pick(Future<AlertSound?> Function() pick) async {
    try {
      final sound = await pick();
      if (sound == null || !mounted) return;
      final previous = _custom;
      if (previous?.kind == SoundKind.file && previous != widget.current) {
        _sounds.deleteFile(previous!.value!);
      }
      setState(() => _custom = sound);
      _select(sound);
    } on PlatformException {
      if (mounted) {
        SnackbarUtils.showError(context, context.l10n.soundPickFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final caps = ref.watch(soundCapabilitiesProvider).value;
    final options = [
      AlertSound.deviceDefault,
      AlertSound.silent,
      for (final name in bundledSounds) AlertSound.bundled(name),
    ];

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text(
                widget.type.title(l10n),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 8),
                children: [
                  for (final sound in [...options, ?_custom])
                    _SoundTile(
                      label: sound.label(l10n),
                      icon: switch (sound.kind) {
                        SoundKind.silent => Icons.volume_off_rounded,
                        SoundKind.system => Icons.ring_volume_rounded,
                        SoundKind.file => Icons.music_note_rounded,
                        _ => Icons.music_note_outlined,
                      },
                      selected: sound == _selected,
                      onTap: () => _select(sound),
                    ),
                  if (caps != null && (caps.systemSounds || caps.files)) ...[
                    const Divider(height: 24, color: AppColors.border),
                    if (caps.systemSounds)
                      _SoundTile(
                        label: l10n.soundFromPhone,
                        icon: Icons.add_alert_rounded,
                        action: true,
                        onTap: () => _pick(
                          () => _sounds.pickSystemSound(current: _selected),
                        ),
                      ),
                    if (caps.files)
                      _SoundTile(
                        label: l10n.soundFromFile,
                        icon: Icons.library_music_rounded,
                        action: true,
                        onTap: () => _pick(_sounds.pickAudioFile),
                      ),
                  ] else if (caps != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Text(
                        l10n.soundIosNote,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: ElevatedButton(
                onPressed: () {
                  _saved = true;
                  Navigator.pop(context, _selected);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(l10n.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoundTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final bool action;
  final VoidCallback onTap;

  const _SoundTile({
    required this.label,
    required this.icon,
    required this.onTap,
    this.selected = false,
    this.action = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = action || selected ? AppColors.primary : AppColors.textMuted;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: color),
      title: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: selected || action ? FontWeight.w600 : FontWeight.w500,
          color: action ? AppColors.primary : AppColors.text,
        ),
      ),
      trailing: action
          ? const Icon(Icons.chevron_right_rounded, color: AppColors.primary)
          : selected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
          : const Icon(Icons.circle_outlined, color: AppColors.border),
    );
  }
}
