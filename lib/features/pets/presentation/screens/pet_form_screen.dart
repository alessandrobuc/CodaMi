import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/pets_entity.dart';
import '../../domain/repositories/pets_repository.dart';
import '../providers/pets_provider.dart';
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
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PhotoSourceSheet(),
    );
    if (source == null) return;

    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 82,
      );
      if (file == null || !mounted) return;
      setState(() => _photos = [..._photos, PetPhoto.local(file.path)]);
    } on PlatformException catch (e) {
      if (!mounted) return;
      SnackbarUtils.showError(
        context,
        e.code.contains('denied')
            ? 'Please allow ${source == ImageSource.camera ? 'camera' : 'photo'} access in Settings.'
            : 'Couldn\'t open the ${source == ImageSource.camera ? 'camera' : 'gallery'}.',
      );
    }
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
    if (uid == null) return;

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
                      _PhotoPicker(
                        photos: _photos,
                        showError: _submitted && _photos.isEmpty,
                        enabled: !_saving,
                        onAdd: _pickPhoto,
                        onRemove: _removePhoto,
                        onMakeCover: _makeCover,
                      ),
                      const SizedBox(height: 26),
                      const _SectionLabel('What kind of pet?'),
                      const SizedBox(height: 10),
                      _SpeciesSelector(
                        selected: _species,
                        showError: _submitted && _species == null,
                        onChanged: (s) => setState(() => _species = s),
                      ),
                      const SizedBox(height: 22),
                      const _SectionLabel('Name'),
                      const SizedBox(height: 8),
                      _PetTextField(
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
                      const _SectionLabel('Sex', optional: true),
                      const SizedBox(height: 10),
                      _SexSelector(
                        selected: _sex,
                        onChanged: (s) => setState(() => _sex = s),
                      ),
                      const SizedBox(height: 22),
                      const _SectionLabel('Breed', optional: true),
                      const SizedBox(height: 8),
                      _PetTextField(
                        controller: _breed,
                        hint: 'e.g. Golden Retriever, Mixed',
                        icon: Icons.pets_outlined,
                        textCapitalization: TextCapitalization.words,
                        maxLength: 60,
                      ),
                      const SizedBox(height: 22),
                      const _SectionLabel('Color', optional: true),
                      const SizedBox(height: 8),
                      _PetTextField(
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
                      const _SectionLabel('Age', optional: true),
                      const SizedBox(height: 8),
                      _PetTextField(
                        controller: _age,
                        hint: 'e.g. 3 years, 8 months',
                        icon: Icons.cake_outlined,
                        maxLength: 30,
                      ),
                      const SizedBox(height: 22),
                      const _SectionLabel(
                        'Distinctive features',
                        optional: true,
                      ),
                      const SizedBox(height: 8),
                      _PetTextField(
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
              _SaveBar(
                label: _isEditing ? 'Save changes' : 'Save pet',
                saving: _saving,
                progress: _uploadProgress,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final bool optional;

  const _SectionLabel(this.text, {this.optional = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.text,
          ),
        ),
        if (optional) ...[
          const SizedBox(width: 6),
          const Text(
            'Optional',
            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}

class _PetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const _PetTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
  });

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: maxLines > 1
          ? TextInputAction.newline
          : TextInputAction.next,
      buildCounter: maxLines > 1
          ? null
          : (_, {required currentLength, required isFocused, maxLength}) =>
                null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
        prefixIcon: maxLines > 1
            ? Padding(
                padding: const EdgeInsets.only(bottom: 56),
                child: Icon(icon),
              )
            : Icon(icon),
        prefixIconColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.error)) return AppColors.danger;
          if (states.contains(WidgetState.focused)) return AppColors.primary;
          return AppColors.textMuted;
        }),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 16,
        ),
        errorMaxLines: 2,
        border: _border(AppColors.border),
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.primary, 1.5),
        errorBorder: _border(AppColors.danger),
        focusedErrorBorder: _border(AppColors.danger, 1.5),
      ),
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  final List<PetPhoto> photos;
  final bool showError;
  final bool enabled;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final ValueChanged<int> onMakeCover;

  const _PhotoPicker({
    required this.photos,
    required this.showError,
    required this.enabled,
    required this.onAdd,
    required this.onRemove,
    required this.onMakeCover,
  });

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return GestureDetector(
        onTap: enabled ? onAdd : null,
        child: CustomPaint(
          painter: DashedBorderPainter(
            radius: 24,
            color: showError ? AppColors.danger : const Color(0xFF9FC2B5),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: (showError ? AppColors.danger : AppColors.primary)
                  .withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.06, 1.06),
                      duration: 1200.ms,
                      curve: Curves.easeInOut,
                    ),
                const SizedBox(height: 14),
                Text(
                  'Add photos of your pet',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: showError ? AppColors.danger : AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  showError
                      ? 'At least one photo is required'
                      : 'Clear, recent photos help people recognise them',
                  style: TextStyle(
                    fontSize: 12,
                    color: showError ? AppColors.danger : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 124,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: photos.length + (photos.length < _maxPhotos ? 1 : 0),
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              if (i == photos.length) {
                return GestureDetector(
                  onTap: enabled ? onAdd : null,
                  child: CustomPaint(
                    painter: const DashedBorderPainter(radius: 20),
                    child: SizedBox(
                      width: 124,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_photo_alternate_outlined,
                            color: AppColors.primary,
                            size: 30,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${photos.length}/$_maxPhotos',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return _PhotoTile(
                key: ValueKey(photos[i].url ?? photos[i].localPath),
                photo: photos[i],
                isCover: i == 0,
                enabled: enabled,
                onTap: () => onMakeCover(i),
                onRemove: () => onRemove(i),
              ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack);
            },
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tap a photo to make it the cover.',
          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _PhotoTile extends StatelessWidget {
  final PetPhoto photo;
  final bool isCover;
  final bool enabled;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _PhotoTile({
    super.key,
    required this.photo,
    required this.isCover,
    required this.enabled,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 124,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCover ? AppColors.primary : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17.5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              PetImage(photo: photo),
              if (isCover)
                Positioned(
                  left: 6,
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Cover',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: enabled ? onRemove : null,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpeciesSelector extends StatelessWidget {
  final PetSpecies? selected;
  final bool showError;
  final ValueChanged<PetSpecies> onChanged;

  const _SpeciesSelector({
    required this.selected,
    required this.showError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final (i, species) in PetSpecies.values.indexed) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(
            child: _SpeciesCard(
              species: species,
              selected: species == selected,
              showError: showError,
              onTap: () {
                HapticFeedback.selectionClick();
                onChanged(species);
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _SpeciesCard extends StatelessWidget {
  final PetSpecies species;
  final bool selected;
  final bool showError;
  final VoidCallback onTap;

  const _SpeciesCard({
    required this.species,
    required this.selected,
    required this.showError,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = speciesColor(species);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: selected ? 1 : 0.97,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 104,
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, Color.lerp(color, Colors.black, 0.25)!],
                  )
                : null,
            color: selected ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? Colors.transparent
                  : showError
                  ? AppColors.danger
                  : AppColors.border,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : const [],
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      speciesIcon(species),
                      size: 30,
                      color: selected ? Colors.white : color,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      species.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check_rounded, size: 14, color: color),
                  ).animate().scale(duration: 300.ms, curve: Curves.elasticOut),
                ),
            ],
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

class _SaveBar extends StatelessWidget {
  final String label;
  final bool saving;
  final double? progress;
  final VoidCallback onPressed;

  const _SaveBar({
    required this.label,
    required this.saving,
    required this.progress,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final uploading = saving && progress != null && progress! < 1;
    final text = !saving
        ? label
        : uploading
        ? 'Uploading photos… ${(progress! * 100).round()}%'
        : 'Saving…';

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: saving ? null : onPressed,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: saving
                ? AppColors.primary.withValues(alpha: 0.25)
                : AppColors.primary,
            boxShadow: saving
                ? const []
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              if (saving)
                TweenAnimationBuilder<double>(
                  tween: Tween(end: progress ?? 1),
                  duration: const Duration(milliseconds: 250),
                  builder: (_, value, _) => FractionallySizedBox(
                    widthFactor: value.clamp(0.0, 1.0),
                    child: Container(color: AppColors.primary),
                  ),
                ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (saving) ...[
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoSourceSheet extends StatelessWidget {
  const _PhotoSourceSheet();

  @override
  Widget build(BuildContext context) {
    Widget option(IconData icon, String title, String subtitle, ImageSource s) {
      return ListTile(
        onTap: () => Navigator.pop(context, s),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            option(
              Icons.photo_camera_rounded,
              'Take a photo',
              'Use your camera',
              ImageSource.camera,
            ),
            option(
              Icons.photo_library_rounded,
              'Choose from gallery',
              'Pick an existing photo',
              ImageSource.gallery,
            ),
          ],
        ),
      ),
    );
  }
}
