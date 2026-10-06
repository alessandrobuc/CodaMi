import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../domain/entities/pets_entity.dart';
import 'pets_widget.dart';

Future<String?> pickPhoto(BuildContext context) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const PhotoSourceSheet(),
  );
  if (source == null) return null;
  try {
    final file = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 82,
    );
    return file?.path;
  } on PlatformException catch (e) {
    if (context.mounted) {
      final what = source == ImageSource.camera ? 'camera' : 'photo';
      SnackbarUtils.showError(
        context,
        e.code.contains('denied')
            ? 'Please allow $what access in Settings.'
            : 'Couldn\'t open the ${source == ImageSource.camera ? 'camera' : 'gallery'}.',
      );
    }
    return null;
  }
}

class SectionLabel extends StatelessWidget {
  final String text;
  final bool optional;

  const SectionLabel(this.text, {super.key, this.optional = false});

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

class AppFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  const AppFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.keyboardType,
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
      keyboardType: keyboardType,
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

class PhotoPickerField extends StatelessWidget {
  final List<PetPhoto> photos;
  final bool showError;
  final bool enabled;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final ValueChanged<int> onMakeCover;
  final int maxPhotos;
  final String emptyTitle;
  final String emptySubtitle;

  const PhotoPickerField({
    super.key,
    this.maxPhotos = 4,
    this.emptyTitle = 'Add photos of your pet',
    this.emptySubtitle = 'Clear, recent photos help people recognise them',
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
                  emptyTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: showError ? AppColors.danger : AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  showError ? 'At least one photo is required' : emptySubtitle,
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
            itemCount: photos.length + (photos.length < maxPhotos ? 1 : 0),
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
                            '${photos.length}/$maxPhotos',
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

class SpeciesSelector extends StatelessWidget {
  final PetSpecies? selected;
  final bool showError;
  final ValueChanged<PetSpecies> onChanged;

  const SpeciesSelector({
    super.key,
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

class ProgressSaveButton extends StatelessWidget {
  final String label;
  final bool saving;
  final double? progress;
  final VoidCallback onPressed;

  const ProgressSaveButton({
    super.key,
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

class PhotoSourceSheet extends StatelessWidget {
  const PhotoSourceSheet({super.key});

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
