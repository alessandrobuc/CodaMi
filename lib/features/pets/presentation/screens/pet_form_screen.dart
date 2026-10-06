import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/pets_entity.dart';
import '../../domain/repositories/pets_repository.dart';
import '../providers/pets_provider.dart';
import '../widgets/pet_form_widgets.dart';
import '../widgets/pets_widget.dart';

const _maxPhotos = 4;

const _quickColors = {
  'Black': Color(0xFF2B2B2B),
  'White': Color(0xFFF4F4F4),
  'Brown': Color(0xFF8B5A2B),
  'Golden': Color(0xFFD9A441),
  'Grey': Color(0xFF9CA3AF),
  'Cream': Color(0xFFF1E3C6),
  'Ginger': Color(0xFFE07B39),
};

class PetFormScreen extends ConsumerStatefulWidget {
  final Pet? pet;

  const PetFormScreen({super.key, this.pet});

  @override
  ConsumerState<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends ConsumerState<PetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.pet?.name);
  late final _breed = TextEditingController(text: widget.pet?.breed);
  late final _color = TextEditingController(text: widget.pet?.color);
  late final _age = TextEditingController(text: widget.pet?.age);
  late final _features = TextEditingController(text: widget.pet?.features);

  late List<PetPhoto> _photos = [
    for (final url in widget.pet?.photoUrls ?? const <String>[])
      PetPhoto.remote(url),
  ];
  late PetSpecies? _species = widget.pet?.species;
  late PetSex? _sex = widget.pet?.sex;

  bool _submitted = false;
  bool _saving = false;
  double? _uploadProgress;

  bool get _isEditing => widget.pet != null;

  @override
  void dispose() {
    for (final c in [_name, _breed, _color, _age, _features]) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _isDirty {
    final pet = widget.pet;
    String text(String? v) => v?.trim() ?? '';
    final photos = _photos.map((p) => p.url ?? p.localPath).toList();
    return text(_name.text) != text(pet?.name) ||
        text(_breed.text) != text(pet?.breed) ||
        text(_color.text) != text(pet?.color) ||
        text(_age.text) != text(pet?.age) ||
        text(_features.text) != text(pet?.features) ||
        _species != pet?.species ||
        _sex != pet?.sex ||
        photos.join('|') != (pet?.photoUrls ?? const []).join('|');
  }

  Future<void> _pickPhoto() async {
    if (_photos.length >= _maxPhotos) return;
    final path = await pickPhoto(context);
    if (path == null || !mounted) return;
    setState(() => _photos = [..._photos, PetPhoto.local(path)]);
  }

  void _makeCover(int index) {
    if (index == 0) return;
    HapticFeedback.selectionClick();
    setState(() {
      final photo = _photos[index];
      _photos = [photo, ..._photos.where((p) => p != photo)];
    });
  }

  void _removePhoto(int index) {
    setState(() => _photos = [..._photos]..removeAt(index));
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);
    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid || _photos.isEmpty || _species == null) {
      HapticFeedback.mediumImpact();
      SnackbarUtils.showError(
        context,
        _photos.isEmpty
            ? 'Add at least one photo of your pet.'
            : _species == null
            ? 'Choose whether your pet is a dog, cat or other.'
            : 'Please check the highlighted fields.',
      );
      return;
    }

    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) {
      SnackbarUtils.showError(context, 'Please sign in again to save.');
      return;
    }

    setState(() {
      _saving = true;
      _uploadProgress = _photos.any((p) => p.isLocal) ? 0 : null;
    });
    try {
      await ref
          .read(petsRepositoryProvider)
          .savePet(
            ownerId: uid,
            existing: widget.pet,
            draft: PetDraft(
              name: _name.text,
              species: _species!,
              breed: _breed.text,
              color: _color.text,
              sex: _sex,
              age: _age.text,
              features: _features.text,
              photos: _photos,
            ),
            onUploadProgress: (p) {
              if (mounted) setState(() => _uploadProgress = p);
            },
          );
      if (!mounted) return;
      HapticFeedback.lightImpact();
      Navigator.of(context).pop(_name.text.trim());
    } on PetsException catch (e) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _uploadProgress = null;
      });
      SnackbarUtils.showError(context, e.message);
    }
  }

  Future<void> _close() async {
    FocusScope.of(context).unfocus();
    if (_isDirty && !await _confirmDiscard()) return;
    if (mounted) Navigator.of(context).pop();
  }

  Future<bool> _confirmDiscard() async {
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('Your changes to this pet will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    return discard ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PopScope(
      canPop: !_saving && !_isDirty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop || _saving) return;
        if (await _confirmDiscard() && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 20, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _saving ? null : _close,
                        icon: const Icon(Icons.close_rounded),
                        color: AppColors.text,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _isEditing ? 'Edit ${widget.pet!.name}' : 'New pet',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                      children: [
                        PhotoPickerField(
                          photos: _photos,
                          showError: _submitted && _photos.isEmpty,
                          enabled: !_saving,
                          onAdd: _pickPhoto,
                          onRemove: _removePhoto,
                          onMakeCover: _makeCover,
                        ),
                        const SizedBox(height: 26),
                        const SectionLabel('What kind of pet?'),
                        const SizedBox(height: 10),
                        SpeciesSelector(
                          selected: _species,
                          showError: _submitted && _species == null,
                          onChanged: (s) => setState(() => _species = s),
                        ),
                        const SizedBox(height: 22),
                        const SectionLabel('Name'),
                        const SizedBox(height: 8),
                        AppFormField(
                          controller: _name,
                          hint: 'e.g. Luna',
                          icon: Icons.badge_outlined,
                          textCapitalization: TextCapitalization.words,
                          validator: (v) {
                            final name = v?.trim() ?? '';
                            if (name.isEmpty) {
                              return 'Please enter your pet\'s name';
                            }
                            if (name.length > 40) {
                              return 'Name must be under 40 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 22),
                        const SectionLabel('Sex', optional: true),
                        const SizedBox(height: 10),
                        _SexSelector(
                          selected: _sex,
                          onChanged: (s) => setState(() => _sex = s),
                        ),
                        const SizedBox(height: 22),
                        const SectionLabel('Breed', optional: true),
                        const SizedBox(height: 8),
                        AppFormField(
                          controller: _breed,
                          hint: 'e.g. Golden Retriever, Mixed',
                          icon: Icons.pets_outlined,
                          textCapitalization: TextCapitalization.words,
                          maxLength: 60,
                        ),
                        const SizedBox(height: 22),
                        const SectionLabel('Color', optional: true),
                        const SizedBox(height: 8),
                        AppFormField(
                          controller: _color,
                          hint: 'e.g. Golden with white chest',
                          icon: Icons.palette_outlined,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 60,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 10),
                        _ColorChips(
                          value: _color.text,
                          onSelected: (c) => setState(() => _color.text = c),
                        ),
                        const SizedBox(height: 22),
                        const SectionLabel('Age', optional: true),
                        const SizedBox(height: 8),
                        AppFormField(
                          controller: _age,
                          hint: 'e.g. 3 years, 8 months',
                          icon: Icons.cake_outlined,
                          maxLength: 30,
                        ),
                        const SizedBox(height: 22),
                        const SectionLabel(
                          'Distinctive features',
                          optional: true,
                        ),
                        const SizedBox(height: 8),
                        AppFormField(
                          controller: _features,
                          hint:
                              'Collar, microchip, scars, spots… anything that helps someone recognise your pet.',
                          icon: Icons.auto_awesome_outlined,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 4,
                          maxLength: 500,
                        ),
                      ],
                    ),
                  ),
                ),
                ProgressSaveButton(
                  label: _isEditing ? 'Save changes' : 'Save pet',
                  saving: _saving,
                  progress: _uploadProgress,
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SexSelector extends StatelessWidget {
  final PetSex? selected;
  final ValueChanged<PetSex?> onChanged;

  const _SexSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final (i, sex) in PetSex.values.indexed) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                onChanged(sex == selected ? null : sex);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 48,
                decoration: BoxDecoration(
                  color: sex == selected
                      ? sexColor(sex).withValues(alpha: 0.12)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: sex == selected ? sexColor(sex) : AppColors.border,
                    width: sex == selected ? 1.5 : 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        sexIcon(sex) ?? Icons.help_outline_rounded,
                        size: 18,
                        color: sexColor(sex),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        sex.label,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: sex == selected
                              ? sexColor(sex)
                              : AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ColorChips extends StatelessWidget {
  final String value;
  final ValueChanged<String> onSelected;

  const _ColorChips({required this.value, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final entry in _quickColors.entries)
          GestureDetector(
            onTap: () => onSelected(entry.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.fromLTRB(6, 5, 12, 5),
              decoration: BoxDecoration(
                color: value.trim().toLowerCase() == entry.key.toLowerCase()
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: value.trim().toLowerCase() == entry.key.toLowerCase()
                      ? AppColors.primary
                      : AppColors.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: entry.value,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
