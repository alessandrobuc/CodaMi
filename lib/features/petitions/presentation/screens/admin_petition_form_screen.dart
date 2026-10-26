import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../admin/presentation/widgets/settings_fields.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/petition.dart';
import '../../domain/petitions_repository.dart';
import '../providers/petitions_provider.dart';
import '../widgets/petition_widgets.dart';
import 'petitions_screen.dart';

class AdminPetitionFormScreen extends ConsumerStatefulWidget {
  final Petition? petition;

  const AdminPetitionFormScreen({super.key, this.petition});

  @override
  ConsumerState<AdminPetitionFormScreen> createState() =>
      _AdminPetitionFormScreenState();
}

class _AdminPetitionFormScreenState
    extends ConsumerState<AdminPetitionFormScreen> {
  late final PetitionDraft? _old = widget.petition?.draft;
  late final _url = TextEditingController(text: _old?.url);
  late final _title = TextEditingController(text: _old?.title);
  late final _source = TextEditingController(text: _old?.source);
  late final _country = TextEditingController(text: _old?.country);
  late final _summary = TextEditingController(text: _old?.summary);
  late final _issue = TextEditingController(text: _old?.issue);
  late final _action = TextEditingController(text: _old?.action);
  late final _why = TextEditingController(text: _old?.why);
  late final _rejectReason = TextEditingController(text: _old?.rejectReason);
  late PetitionTopic _topic = _old?.topic ?? PetitionTopic.pets;
  late DateTime? _startedOn = _old?.startedOn;
  late bool _imagePermission = _old?.imagePermission ?? false;
  late PetitionReview _review = _old?.review ?? PetitionReview.pending;
  late PetitionStatus _status = _old?.status ?? PetitionStatus.active;
  late PetitionChecks _checks = _old?.checks ?? const PetitionChecks();
  File? _newImage;
  bool _removeImage = false;
  bool _showErrors = false;
  bool _saving = false;

  bool get _editing => widget.petition != null;

  bool get _hasImage =>
      _newImage != null || (!_removeImage && widget.petition?.imageUrl != null);

  List<TextEditingController> get _controllers => [
    _url,
    _title,
    _source,
    _country,
    _summary,
    _issue,
    _action,
    _why,
    _rejectReason,
  ];

  // Red marks update as the admin types, once a save was tried.
  void _onText() {
    if (_showErrors) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (final c in _controllers) {
      c.addListener(_onText);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  PetitionDraft get _draft => PetitionDraft(
    url: _url.text,
    title: _title.text,
    source: _source.text,
    topic: _topic,
    country: _country.text,
    startedOn: _startedOn,
    summary: _summary.text,
    issue: _issue.text,
    action: _action.text,
    why: _why.text,
    imagePermission: _hasImage && _imagePermission,
    review: _review,
    status: _status,
    checks: _checks,
    rejectReason: _rejectReason.text,
  );

  Set<PetitionProblem> get _problems =>
      _showErrors ? petitionProblems(_draft, hasImage: _hasImage) : const {};

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 82,
    );
    if (picked == null || !mounted) return;
    final file = File(picked.path);
    if (await file.length() >= PetitionLimits.imageBytes) {
      if (mounted) {
        SnackbarUtils.showError(context, context.l10n.petitionImageTooBig);
      }
      return;
    }
    setState(() {
      _newImage = file;
      _removeImage = false;
      _imagePermission = false;
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _startedOn ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) setState(() => _startedOn = picked);
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final problems = petitionProblems(_draft, hasImage: _hasImage);
    if (problems.isNotEmpty) {
      setState(() => _showErrors = true);
      SnackbarUtils.showError(
        context,
        problems.contains(PetitionProblem.checks)
            ? l10n.petitionChecksNeeded
            : problems.contains(PetitionProblem.imagePermission)
            ? l10n.petitionImagePermissionNeeded
            : l10n.petitionFixFields,
      );
      return;
    }
    final adminId = ref.read(authStateProvider).value?.uid;
    if (adminId == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(petitionsRepositoryProvider)
          .save(
            existing: widget.petition,
            draft: _draft,
            adminId: adminId,
            image: _newImage != null
                ? NewImage(_newImage!)
                : _removeImage
                ? const RemoveImage()
                : const KeepImage(),
          );
      if (!mounted) return;
      SnackbarUtils.showSuccess(context, l10n.settingsSaved);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Petition not saved: $e');
      if (!mounted) return;
      setState(() => _saving = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.petitionDeleteTitle),
        content: Text(l10n.petitionDeleteBody),
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
    setState(() => _saving = true);
    try {
      await ref.read(petitionsRepositoryProvider).delete(widget.petition!);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final problems = _problems;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_editing ? l10n.petitionEdit : l10n.petitionAdd),
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
      body: AbsorbPointer(
        absorbing: _saving,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: settingsListPadding(context),
          children: [
            SettingsSection(
              title: l10n.petitionSectionSource,
              icon: Icons.link_rounded,
              color: petitionColor,
              children: [
                const SizedBox(height: 12),
                _Field(
                  controller: _url,
                  label: l10n.petitionUrl,
                  hint: 'https://',
                  keyboard: TextInputType.url,
                  maxLength: PetitionLimits.url,
                  error: problems.contains(PetitionProblem.url)
                      ? l10n.petitionUrlInvalid
                      : null,
                  suffix: IconButton(
                    tooltip: l10n.petitionView,
                    icon: const Icon(Icons.open_in_new_rounded),
                    onPressed: () {
                      final d = _draft.trimmed();
                      openPetition(context, Petition(id: '', draft: d));
                    },
                  ),
                ),
                _Field(
                  controller: _title,
                  label: l10n.petitionTitle,
                  maxLength: PetitionLimits.title,
                  error: problems.contains(PetitionProblem.title)
                      ? l10n.requiredField
                      : null,
                ),
                _Field(
                  controller: _source,
                  label: l10n.petitionSource,
                  hint: 'Change.org, Care2, Avaaz…',
                  maxLength: PetitionLimits.source,
                  error: problems.contains(PetitionProblem.source)
                      ? l10n.requiredField
                      : null,
                ),
                _Field(
                  controller: _country,
                  label: l10n.petitionCountry,
                  help: l10n.petitionCountryHelp,
                  maxLength: PetitionLimits.country,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      alignment: AlignmentDirectional.centerStart,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.event_rounded),
                    label: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _startedOn == null
                                ? l10n.petitionStartedOnPick
                                : l10n.petitionStartedOn(
                                    shortDate(l10n, _startedOn!),
                                  ),
                          ),
                        ),
                        if (_startedOn != null)
                          InkWell(
                            onTap: () => setState(() => _startedOn = null),
                            child: const Icon(Icons.close_rounded, size: 18),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: l10n.petitionTopic,
              icon: Icons.category_rounded,
              color: petitionColor,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final topic in PetitionTopic.values)
                        _Choice(
                          label: topic.label(l10n),
                          icon: topic.icon,
                          selected: _topic == topic,
                          color: petitionColor,
                          onTap: () => setState(() => _topic = topic),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: l10n.petitionSectionText,
              icon: Icons.edit_note_rounded,
              color: petitionColor,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child: Text(
                    l10n.petitionOwnWordsHelp,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                _Field(
                  controller: _summary,
                  label: l10n.petitionSummary,
                  lines: 3,
                  maxLength: PetitionLimits.summary,
                  error: problems.contains(PetitionProblem.summary)
                      ? l10n.requiredField
                      : null,
                ),
                _Field(
                  controller: _issue,
                  label: l10n.petitionIssue,
                  lines: 5,
                  maxLength: PetitionLimits.issue,
                  error: problems.contains(PetitionProblem.issue)
                      ? l10n.requiredField
                      : null,
                ),
                _Field(
                  controller: _action,
                  label: l10n.petitionAction,
                  lines: 3,
                  maxLength: PetitionLimits.action,
                  error: problems.contains(PetitionProblem.action)
                      ? l10n.requiredField
                      : null,
                ),
                _Field(
                  controller: _why,
                  label: l10n.petitionWhy,
                  lines: 3,
                  maxLength: PetitionLimits.why,
                  error: problems.contains(PetitionProblem.why)
                      ? l10n.requiredField
                      : null,
                ),
              ],
            ),
            SettingsSection(
              title: l10n.petitionImage,
              icon: Icons.image_rounded,
              color: petitionColor,
              children: [
                const SizedBox(height: 12),
                _ImagePreview(
                  file: _newImage,
                  url: _removeImage ? null : widget.petition?.imageUrl,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.photo_library_rounded),
                        label: Text(
                          _hasImage
                              ? l10n.petitionImageChange
                              : l10n.petitionImageAdd,
                        ),
                      ),
                    ),
                    if (_hasImage) ...[
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        onPressed: () => setState(() {
                          _newImage = null;
                          _removeImage = true;
                          _imagePermission = false;
                        }),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                        ),
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: Text(l10n.remove),
                      ),
                    ],
                  ],
                ),
                if (_hasImage)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _imagePermission,
                    onChanged: (v) =>
                        setState(() => _imagePermission = v ?? false),
                    title: Text(
                      l10n.petitionImagePermission,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            problems.contains(PetitionProblem.imagePermission)
                            ? AppColors.danger
                            : AppColors.text,
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      l10n.petitionImageHelp,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
              ],
            ),
            SettingsSection(
              title: l10n.petitionChecks,
              icon: Icons.fact_check_rounded,
              color: problems.contains(PetitionProblem.checks)
                  ? AppColors.danger
                  : AppColors.primary,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l10n.petitionChecksHelp,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                _Check(
                  label: l10n.petitionCheckExists,
                  value: _checks.exists,
                  onChanged: (v) =>
                      setState(() => _checks = _checks.copyWith(exists: v)),
                ),
                _Check(
                  label: l10n.petitionCheckGenuine,
                  value: _checks.genuine,
                  onChanged: (v) =>
                      setState(() => _checks = _checks.copyWith(genuine: v)),
                ),
                _Check(
                  label: l10n.petitionCheckGoal,
                  value: _checks.clearGoal,
                  onChanged: (v) =>
                      setState(() => _checks = _checks.copyWith(clearGoal: v)),
                ),
                _Check(
                  label: l10n.petitionCheckHonest,
                  value: _checks.notMisleading,
                  onChanged: (v) => setState(
                    () => _checks = _checks.copyWith(notMisleading: v),
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: l10n.petitionReview,
              icon: Icons.gavel_rounded,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final review in PetitionReview.values)
                        _Choice(
                          label: review.label(l10n),
                          icon: review.icon,
                          selected: _review == review,
                          color: review.color,
                          onTap: () => setState(() => _review = review),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    l10n.petitionReviewHelp,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                if (_review == PetitionReview.rejected)
                  _Field(
                    controller: _rejectReason,
                    label: l10n.petitionRejectReason,
                    lines: 2,
                    maxLength: PetitionLimits.rejectReason,
                  ),
              ],
            ),
            SettingsSection(
              title: l10n.petitionStatus,
              icon: Icons.flag_rounded,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final status in PetitionStatus.values)
                        _Choice(
                          label: status.label(l10n),
                          selected: _status == status,
                          color: status.color,
                          onTap: () => setState(() => _status = status),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    l10n.petitionStatusHelp,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.petition case final p?
                when p.updatedAt != null || p.createdAt != null)
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  [
                    if (p.createdAt != null)
                      l10n.petitionAddedOn(shortDate(l10n, p.createdAt!)),
                    if (p.publishedAt != null)
                      l10n.petitionPublishedOn(shortDate(l10n, p.publishedAt!)),
                    if (p.updatedAt != null)
                      l10n.petitionUpdatedOn(shortDate(l10n, p.updatedAt!)),
                  ].join(' · '),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            SettingsSaveButton(
              label: l10n.save,
              saving: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? help;
  final String? error;
  final int lines;
  final int maxLength;
  final TextInputType? keyboard;
  final Widget? suffix;

  const _Field({
    required this.controller,
    required this.label,
    required this.maxLength,
    this.hint,
    this.help,
    this.error,
    this.lines = 1,
    this.keyboard,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        minLines: lines,
        maxLines: lines == 1 ? 1 : lines + 4,
        maxLength: maxLength,
        keyboardType: keyboard ?? (lines > 1 ? TextInputType.multiline : null),
        autocorrect: keyboard != TextInputType.url,
        textCapitalization: keyboard == TextInputType.url
            ? TextCapitalization.none
            : TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: help,
          helperMaxLines: 2,
          errorText: error,
          errorMaxLines: 2,
          alignLabelWithHint: lines > 1,
          suffixIcon: suffix,
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _Choice({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: icon == null
          ? null
          : Icon(icon, size: 18, color: selected ? Colors.white : color),
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      selectedColor: color,
      backgroundColor: AppColors.surface,
      shape: const StadiumBorder(),
      side: BorderSide(color: selected ? color : AppColors.border),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: selected ? Colors.white : AppColors.text,
      ),
      onSelected: (_) => onTap(),
    );
  }
}

class _Check extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _Check({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: (v) => onChanged(v ?? false),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, color: AppColors.text),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final File? file;
  final String? url;

  const _ImagePreview({this.file, this.url});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    if (file != null) {
      return ClipRRect(
        borderRadius: radius,
        child: Image.file(file!, height: 170, fit: BoxFit.cover),
      );
    }
    if (url != null) {
      return PetitionImage(
        petition: Petition(
          id: '',
          draft: const PetitionDraft(
            url: '',
            title: '',
            source: '',
            topic: PetitionTopic.other,
            summary: '',
            issue: '',
            action: '',
            why: '',
          ),
          imageUrl: url,
        ),
        height: 170,
        borderRadius: radius,
      );
    }
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: radius,
        border: Border.all(color: AppColors.border),
      ),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textMuted,
          size: 36,
        ),
      ),
    );
  }
}
