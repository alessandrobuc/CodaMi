import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../data/release_notes_repository.dart';
import '../../domain/release_note.dart';
import '../providers/whats_new_provider.dart';
import 'whats_new_screen.dart';

class AdminReleaseNoteFormScreen extends ConsumerStatefulWidget {
  final ReleaseNote? note;

  const AdminReleaseNoteFormScreen({super.key, this.note});

  @override
  ConsumerState<AdminReleaseNoteFormScreen> createState() =>
      _AdminReleaseNoteFormScreenState();
}

class _AdminReleaseNoteFormScreenState
    extends ConsumerState<AdminReleaseNoteFormScreen> {
  late final _version = TextEditingController(text: widget.note?.version);
  late bool _published = widget.note?.published ?? false;
  final _text = <String, Map<NoteSection, TextEditingController>>{};
  String _lang = 'en';
  String? _versionError;
  bool _saving = false;

  bool get _editing => widget.note != null;

  @override
  void initState() {
    super.initState();
    if (!_editing) {
      ref.read(appVersionProvider.future).then((v) {
        if (mounted && _version.text.isEmpty) _version.text = v;
      });
    }
  }

  @override
  void dispose() {
    _version.dispose();
    for (final fields in _text.values) {
      for (final c in fields.values) {
        c.dispose();
      }
    }
    super.dispose();
  }

  Map<NoteSection, TextEditingController> _fields(String lang) =>
      _text.putIfAbsent(lang, () {
        final items = widget.note?.notes[lang] ?? const NoteItems();
        return {
          for (final s in NoteSection.values)
            s: TextEditingController(text: items.textOf(s))
              ..addListener(() => setState(() {})),
        };
      });

  bool _hasText(String lang) {
    final fields = _text[lang];
    if (fields != null) {
      return fields.values.any((c) => c.text.trim().isNotEmpty);
    }
    return !(widget.note?.notes[lang]?.isEmpty ?? true);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final version = _version.text.trim();
    if (!isVersion(version)) {
      setState(() => _versionError = l10n.releaseVersionInvalid);
      return;
    }
    final notes = {
      for (final lang in appLanguages)
        if (_hasText(lang.code))
          lang.code: NoteItems.fromText({
            for (final MapEntry(:key, :value) in _fields(lang.code).entries)
              key: value.text,
          }),
    };
    if (notes['en']?.isEmpty ?? true) {
      setState(() => _lang = 'en');
      SnackbarUtils.showError(context, l10n.releaseEnglishRequired);
      return;
    }
    setState(() {
      _saving = true;
      _versionError = null;
    });
    final repo = ref.read(releaseNotesRepositoryProvider);
    try {
      if (!_editing && await repo.exists(version)) {
        if (mounted) {
          setState(() {
            _saving = false;
            _versionError = l10n.releaseVersionExists;
          });
        }
        return;
      }
      await repo.save(
        ReleaseNote(version: version, published: _published, notes: notes),
      );
      if (!mounted) return;
      SnackbarUtils.showSuccess(context, l10n.settingsSaved);
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final version = widget.note!.version;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.releaseDeleteTitle),
        content: Text(l10n.releaseDeleteBody(version)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(releaseNotesRepositoryProvider).delete(version);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final fields = _fields(_lang);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_editing ? l10n.releaseEdit : l10n.releaseAdd),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (_editing)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.danger,
              onPressed: _saving ? null : _delete,
            ),
        ],
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: settingsListPadding(context),
        children: [
          SettingsSection(
            title: l10n.releaseVersion,
            icon: Icons.tag_rounded,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextField(
                  controller: _version,
                  enabled: !_editing && !_saving,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) {
                    if (_versionError != null) {
                      setState(() => _versionError = null);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '1.1.0',
                    helperText: l10n.releaseVersionHelp,
                    helperMaxLines: 2,
                    errorText: _versionError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                value: _published,
                onChanged: _saving
                    ? null
                    : (v) => setState(() => _published = v),
                title: Text(
                  l10n.published,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(l10n.releasePublishedHelp),
              ),
            ],
          ),
          SettingsSection(
            title: l10n.language,
            icon: Icons.translate_rounded,
            color: AppColors.accent,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 4),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final lang in appLanguages)
                      ChoiceChip(
                        label: Text(
                          '${lang.flag} ${lang.code.toUpperCase()}'
                          '${_hasText(lang.code) ? ' ✓' : ''}',
                        ),
                        selected: _lang == lang.code,
                        showCheckmark: false,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        side: BorderSide(
                          color: _lang == lang.code
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _lang == lang.code
                              ? Colors.white
                              : AppColors.text,
                        ),
                        onSelected: (_) => setState(() => _lang = lang.code),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  l10n.releaseLanguageHelp,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          for (final section in NoteSection.values)
            SettingsSection(
              key: ValueKey('$_lang-${section.value}'),
              title: section.label(l10n),
              icon: section.icon,
              color: section.color,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    controller: fields[section],
                    enabled: !_saving,
                    minLines: 3,
                    maxLines: 8,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      helperText: l10n.releaseLinesHelp,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
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
