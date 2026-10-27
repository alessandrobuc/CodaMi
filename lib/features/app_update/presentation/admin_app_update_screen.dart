import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../l10n/l10n.dart';
import '../../admin/presentation/widgets/settings_fields.dart';
import '../../whats_new/data/release_notes_repository.dart';
import '../../whats_new/domain/release_note.dart';
import '../../whats_new/presentation/providers/whats_new_provider.dart';
import '../../whats_new/presentation/screens/admin_release_notes_screen.dart';
import '../data/app_update_repository.dart';
import '../domain/app_update.dart';

// Edits `config/appVersion`: the version in each store and the oldest one
// still allowed. Users read it on every start, no new build needed.
class AdminAppUpdateScreen extends ConsumerStatefulWidget {
  const AdminAppUpdateScreen({super.key});

  @override
  ConsumerState<AdminAppUpdateScreen> createState() =>
      _AdminAppUpdateScreenState();
}

class _AdminAppUpdateScreenState extends ConsumerState<AdminAppUpdateScreen> {
  final _androidLatest = TextEditingController();
  final _androidMinimum = TextEditingController();
  final _iosLatest = TextEditingController();
  final _iosMinimum = TextEditingController();
  final _appStoreId = TextEditingController();
  AppVersionConfig _saved = const AppVersionConfig();
  final _errors = <TextEditingController, String>{};
  bool _loading = true;
  bool _saving = false;

  List<TextEditingController> get _fields => [
    _androidLatest,
    _androidMinimum,
    _iosLatest,
    _iosMinimum,
    _appStoreId,
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final c in _fields) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    try {
      _saved = await ref.read(appUpdateRepositoryProvider).watch().first;
    } catch (e) {
      debugPrint('App version settings not loaded: $e');
    }
    _androidLatest.text = _saved.android.latest;
    _androidMinimum.text = _saved.android.minimum;
    _iosLatest.text = _saved.ios.latest;
    _iosMinimum.text = _saved.ios.minimum;
    _appStoreId.text = _saved.appStoreId;
    if (mounted) setState(() => _loading = false);
  }

  String _message(VersionFormError error) {
    final l10n = context.l10n;
    return switch (error) {
      VersionFormError.badVersion => l10n.appUpdatesBadVersion,
      VersionFormError.minimumAboveLatest => l10n.appUpdatesMinimumAbove,
      VersionFormError.badAppStoreId => l10n.appUpdatesBadStoreId,
    };
  }

  bool _validate() {
    _errors.clear();
    void platform(TextEditingController latest, TextEditingController min) {
      final latestError = checkPlatform(latest.text.trim(), '');
      if (latestError != null) _errors[latest] = _message(latestError);
      final error = checkPlatform(latest.text.trim(), min.text.trim());
      if (error != null && !_errors.containsKey(latest)) {
        _errors[min] = _message(error);
      }
    }

    platform(_androidLatest, _androidMinimum);
    platform(_iosLatest, _iosMinimum);
    final id = _appStoreId.text.trim();
    if (id.isNotEmpty && !appStoreIdPattern.hasMatch(id)) {
      _errors[_appStoreId] = _message(VersionFormError.badAppStoreId);
    }
    setState(() {});
    return _errors.isEmpty;
  }

  Future<bool> _confirmMinimum(List<String> raised) async {
    if (raised.isEmpty) return true;
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.appUpdatesRequireTitle),
        content: Text(l10n.appUpdatesRequireBody(raised.join(' / '))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.appUpdatesRequireConfirm),
          ),
        ],
      ),
    );
    return ok == true;
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_validate()) {
      SnackbarUtils.showError(context, l10n.petitionFixFields);
      return;
    }
    final config = AppVersionConfig(
      android: PlatformVersions(
        latest: _androidLatest.text.trim(),
        minimum: _androidMinimum.text.trim(),
      ),
      ios: PlatformVersions(
        latest: _iosLatest.text.trim(),
        minimum: _iosMinimum.text.trim(),
      ),
      appStoreId: _appStoreId.text.trim(),
    );
    bool raised(String now, String before) =>
        now.isNotEmpty && (before.isEmpty || compareVersions(now, before) > 0);
    if (!await _confirmMinimum([
      if (raised(config.android.minimum, _saved.android.minimum))
        config.android.minimum,
      if (raised(config.ios.minimum, _saved.ios.minimum)) config.ios.minimum,
    ])) {
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(appUpdateRepositoryProvider).save(config);
      _saved = config;
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
    final installed = ref.watch(appVersionProvider).value;

    Widget field(
      TextEditingController c,
      String label,
      String help, {
      String hint = '1.2.0',
    }) => _TextTile(
      controller: c,
      label: label,
      help: help,
      hint: hint,
      error: _errors[c],
      onChanged: () {
        if (_errors.isNotEmpty) setState(_errors.clear);
      },
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.appUpdates),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: settingsListPadding(context),
              children: [
                SettingsHeader(
                  icon: Icons.system_update_rounded,
                  color: AppColors.primary,
                  title: l10n.appUpdatesSubtitle,
                  text: l10n.appUpdatesIntro,
                ),
                if (installed != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 4),
                    child: Text(
                      l10n.appUpdatesThisPhone(installed),
                      style: const TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                SettingsSection(
                  title: l10n.appUpdatesAndroid,
                  icon: Icons.android_rounded,
                  children: [
                    field(
                      _androidLatest,
                      l10n.appUpdatesLatest,
                      l10n.appUpdatesLatestHelp,
                    ),
                    _NotesStatus(controller: _androidLatest),
                    field(
                      _androidMinimum,
                      l10n.appUpdatesMinimum,
                      l10n.appUpdatesMinimumHelp,
                    ),
                  ],
                ),
                SettingsSection(
                  title: l10n.appUpdatesIos,
                  icon: Icons.phone_iphone_rounded,
                  color: AppColors.primaryDark,
                  children: [
                    field(
                      _iosLatest,
                      l10n.appUpdatesLatest,
                      l10n.appUpdatesLatestHelp,
                    ),
                    _NotesStatus(controller: _iosLatest),
                    field(
                      _iosMinimum,
                      l10n.appUpdatesMinimum,
                      l10n.appUpdatesMinimumHelp,
                    ),
                    field(
                      _appStoreId,
                      l10n.appUpdatesStoreId,
                      l10n.appUpdatesStoreIdHelp,
                      hint: '1234567890',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSaveButton(
                  label: l10n.save,
                  saving: _saving,
                  onPressed: _save,
                ),
              ],
            ),
    );
  }
}

class _TextTile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String help;
  final String hint;
  final String? error;
  final VoidCallback onChanged;

  const _TextTile({
    required this.controller,
    required this.label,
    required this.help,
    required this.hint,
    required this.error,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (_) => onChanged(),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: help,
          helperMaxLines: 4,
          errorText: error,
          errorMaxLines: 3,
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

// Whether the What's new notes of the typed version are ready, since
// users see them in the update message.
class _NotesStatus extends ConsumerStatefulWidget {
  final TextEditingController controller;

  const _NotesStatus({required this.controller});

  @override
  ConsumerState<_NotesStatus> createState() => _NotesStatusState();
}

class _NotesStatusState extends ConsumerState<_NotesStatus> {
  String _version = '';
  Future<ReleaseNote?>? _note;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_check);
    _check();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_check);
    super.dispose();
  }

  void _check() {
    final version = widget.controller.text.trim();
    if (version == _version) return;
    setState(() {
      _version = version;
      _note = isVersion(version)
          ? ref.read(releaseNotesRepositoryProvider).find(version)
          : null;
    });
  }

  Future<void> _openNotes() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const AdminReleaseNotesScreen()));
    if (!mounted) return;
    setState(
      () => _note = ref.read(releaseNotesRepositoryProvider).find(_version),
    );
  }

  @override
  Widget build(BuildContext context) {
    final note = _note;
    if (note == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    return FutureBuilder(
      future: note,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const SizedBox(height: 48);
        }
        final found = snap.data;
        final (text, icon, color) = switch (found) {
          ReleaseNote(published: true) => (
            l10n.appUpdatesNotesPublished(_version),
            Icons.check_circle_rounded,
            AppColors.primary,
          ),
          ReleaseNote() => (
            l10n.appUpdatesNotesDraft(_version),
            Icons.edit_note_rounded,
            AppColors.rewardText,
          ),
          null => (
            l10n.appUpdatesNotesMissing(_version),
            Icons.info_outline_rounded,
            AppColors.textMuted,
          ),
        };
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 13.5, color: color),
                ),
              ),
              TextButton(onPressed: _openNotes, child: Text(l10n.whatsNew)),
            ],
          ),
        );
      },
    );
  }
}
