import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../videos/data/videos_repository.dart';
import '../../../videos/domain/entities/video_entity.dart';
import '../../../videos/presentation/providers/videos_provider.dart';
import '../../../videos/presentation/widgets/video_labels.dart';
import '../../../videos/presentation/widgets/video_thumbnail.dart';

// Matches the limit in storage.rules.
const _maxVideoBytes = 200 * 1024 * 1024;

const _tagIcons = {
  'dog': FontAwesomeIcons.dog,
  'cat': FontAwesomeIcons.cat,
  'other': FontAwesomeIcons.paw,
  'general': FontAwesomeIcons.earthEurope,
};

class AdminVideoFormScreen extends ConsumerStatefulWidget {
  final Video? video;

  const AdminVideoFormScreen({super.key, this.video});

  @override
  ConsumerState<AdminVideoFormScreen> createState() =>
      _AdminVideoFormScreenState();
}

class _AdminVideoFormScreenState extends ConsumerState<AdminVideoFormScreen> {
  late final _title = TextEditingController(text: widget.video?.title);
  late VideoCategory _category =
      widget.video?.category ?? VideoCategory.educational;
  late final Set<String> _tags = {...?widget.video?.tags};
  late String _language = widget.video?.language ?? allLanguages;
  late bool _active = widget.video?.active ?? true;
  File? _file;
  VideoPlayerController? _preview;
  File? _thumbnail;
  bool _removeCover = false;
  double? _progress;
  bool _showErrors = false;

  bool get _isEditing => widget.video != null;

  @override
  void dispose() {
    _title.dispose();
    _preview?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picked == null) return;
    final file = File(picked.path);
    if (await file.length() > _maxVideoBytes) {
      if (mounted) SnackbarUtils.showError(context, context.l10n.videoTooLarge);
      return;
    }
    final controller = VideoPlayerController.file(file);
    try {
      await controller.initialize();
    } catch (_) {
      await controller.dispose();
      if (mounted) {
        SnackbarUtils.showError(context, context.l10n.videoLoadError);
      }
      return;
    }
    if (!mounted) {
      await controller.dispose();
      return;
    }
    final old = _preview;
    setState(() {
      _file = file;
      _preview = controller;
    });
    await old?.dispose();
  }

  Future<void> _pickThumbnail() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      imageQuality: 80,
    );
    if (picked == null) return;
    setState(() {
      _thumbnail = File(picked.path);
      _removeCover = false;
    });
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    if (_title.text.trim().isEmpty ||
        _tags.isEmpty ||
        (!_isEditing && _file == null)) {
      setState(() => _showErrors = true);
      return;
    }
    await _preview?.pause();
    final draft = VideoDraft(
      title: _title.text,
      category: _category,
      tags: [
        for (final tag in videoTags)
          if (_tags.contains(tag)) tag,
      ],
      language: _language,
      active: _active,
    );
    final repository = ref.read(videosRepositoryProvider);
    setState(() => _progress = 0);
    try {
      if (_isEditing) {
        final video = widget.video!;
        await repository.update(video.id, draft);
        final cover = _thumbnail;
        if (cover != null) {
          await repository.replaceThumbnail(video, cover);
        } else if (_removeCover && video.thumbnailUrl != null) {
          await repository.removeThumbnail(video);
        }
      } else {
        await repository.create(
          draft: draft,
          video: _file!,
          thumbnail: _thumbnail,
          durationSeconds: _preview?.value.duration.inSeconds,
          createdBy: ref.read(authStateProvider).value?.uid ?? '',
          onProgress: (p) {
            if (mounted) setState(() => _progress = p);
          },
        );
      }
      if (!mounted) return;
      SnackbarUtils.showSuccess(context, l10n.videoSaved);
      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;
      setState(() => _progress = null);
      SnackbarUtils.showError(context, l10n.actionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final busy = _progress != null;

    return PopScope(
      canPop: !busy,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(_isEditing ? l10n.editVideo : l10n.addVideo),
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBar: _SaveBar(
          progress: _progress,
          editing: _isEditing,
          onSave: _save,
        ),
        body: AbsorbPointer(
          absorbing: busy,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              _Section(
                icon: Icons.movie_rounded,
                title: l10n.videoSectionFile,
                children: [
                  if (_isEditing)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _thumbnail != null
                            ? Image.file(_thumbnail!, fit: BoxFit.cover)
                            : _removeCover
                            ? const VideoPlaceholder()
                            : VideoThumbnail(video: widget.video!),
                      ),
                    )
                  else
                    _VideoPicker(
                      preview: _preview,
                      error: _showErrors && _file == null,
                      onPick: _pickVideo,
                    ),
                  const SizedBox(height: 14),
                  _CoverPicker(
                    file: _thumbnail,
                    url: _removeCover ? null : widget.video?.thumbnailUrl,
                    onPick: _pickThumbnail,
                    onRemove: () => setState(() {
                      if (_thumbnail != null) {
                        _thumbnail = null;
                      } else {
                        _removeCover = true;
                      }
                    }),
                  ),
                ],
              ),
              _Section(
                icon: Icons.edit_note_rounded,
                title: l10n.videoSectionDetails,
                children: [
                  TextField(
                    controller: _title,
                    maxLength: 120,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (_) {
                      if (_showErrors) setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: l10n.videoTitle,
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      errorText: _showErrors && _title.text.trim().isEmpty
                          ? l10n.requiredField
                          : null,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _FieldLabel(l10n.videoType),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final category in VideoCategory.values) ...[
                          if (category != VideoCategory.values.first)
                            const SizedBox(width: 10),
                          Expanded(
                            child: _TypeCard(
                              category: category,
                              selected: _category == category,
                              onTap: () => setState(() => _category = category),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              _Section(
                icon: Icons.groups_rounded,
                title: l10n.videoSectionAudience,
                children: [
                  _FieldLabel(l10n.videoAnimals),
                  Text(
                    l10n.videoAnimalsHint,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: _showErrors && _tags.isEmpty
                          ? AppColors.danger
                          : AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.9,
                    children: [
                      for (final tag in videoTags)
                        _TagTile(
                          icon: _tagIcons[tag]!,
                          label: videoTagLabel(tag, l10n),
                          selected: _tags.contains(tag),
                          onTap: () => setState(
                            () => _tags.contains(tag)
                                ? _tags.remove(tag)
                                : _tags.add(tag),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _FieldLabel(l10n.language),
                  DropdownButtonFormField<String>(
                    initialValue: _language,
                    borderRadius: BorderRadius.circular(14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: allLanguages,
                        child: Text('🌍  ${l10n.allLanguages}'),
                      ),
                      for (final language in appLanguages)
                        DropdownMenuItem(
                          value: language.code,
                          child: Text(
                            '${language.flag}  ${language.nativeName}',
                          ),
                        ),
                    ],
                    onChanged: (value) =>
                        setState(() => _language = value ?? allLanguages),
                  ),
                  const SizedBox(height: 12),
                  Material(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(14),
                    child: SwitchListTile(
                      value: _active,
                      onChanged: (on) => setState(() => _active = on),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      secondary: Icon(
                        _active
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: _active
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                      title: Text(
                        l10n.videoVisible,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        l10n.videoVisibleHint,
                        style: const TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _Section({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
    );
  }
}

class _VideoPicker extends StatelessWidget {
  final VideoPlayerController? preview;
  final bool error;
  final VoidCallback onPick;

  const _VideoPicker({
    required this.preview,
    required this.error,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final preview = this.preview;

    if (preview == null) {
      final color = error ? AppColors.danger : AppColors.primary;
      return Material(
        color: color.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withValues(alpha: 0.45), width: 1.5),
        ),
        child: InkWell(
          onTap: onPick,
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.video_library_rounded,
                      color: color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.chooseVideo,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.chooseVideoHint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final value = preview.value;
    final seconds = value.duration.inSeconds;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: Colors.black,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: value.aspectRatio,
                  child: VideoPlayer(preview),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: preview,
                builder: (context, v, _) => GestureDetector(
                  onTap: () => v.isPlaying ? preview.pause() : preview.play(),
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: AnimatedOpacity(
                      opacity: v.isPlaying ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: Center(
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                start: 10,
                bottom: 10,
                child: DurationBadge(
                  label:
                      '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}',
                ),
              ),
              PositionedDirectional(
                end: 8,
                top: 8,
                child: FilledButton.tonalIcon(
                  onPressed: onPick,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    foregroundColor: AppColors.text,
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                  label: Text(l10n.change),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverPicker extends StatelessWidget {
  final File? file;
  final String? url;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const _CoverPicker({
    required this.file,
    required this.url,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final file = this.file;
    final url = this.url;
    final hasCover = file != null || url != null;
    return Row(
      children: [
        SizedBox(
          width: 112,
          height: 64,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: onPick,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ColoredBox(
                      color: AppColors.background,
                      child: file != null
                          ? Image.file(file, fit: BoxFit.cover)
                          : url != null
                          ? CachedNetworkImage(imageUrl: url, fit: BoxFit.cover)
                          : const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.textMuted,
                            ),
                    ),
                  ),
                ),
              ),
              if (hasCover)
                PositionedDirectional(
                  top: -8,
                  end: -8,
                  child: Material(
                    color: AppColors.surface,
                    shape: const CircleBorder(
                      side: BorderSide(color: AppColors.border),
                    ),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onRemove,
                      child: Tooltip(
                        message: l10n.remove,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.close_rounded,
                            size: 16,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.videoCover,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.videoCoverHint,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              TextButton.icon(
                onPressed: onPick,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: Icon(
                  hasCover ? Icons.swap_horiz_rounded : Icons.add_rounded,
                  size: 18,
                ),
                label: Text(hasCover ? l10n.change : l10n.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TypeCard extends StatelessWidget {
  final VideoCategory category;
  final bool selected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final motivational = category == VideoCategory.motivational;
    final color = motivational ? AppColors.accent : AppColors.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected ? color.withValues(alpha: 0.1) : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? color : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      motivational
                          ? Icons.emoji_events_rounded
                          : Icons.school_rounded,
                      color: color,
                    ),
                    const Spacer(),
                    Icon(
                      selected
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      size: 20,
                      color: selected ? color : AppColors.border,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  category.label(l10n),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  motivational
                      ? l10n.videoMotivationalHint
                      : l10n.videoEducationalHint,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TagTile extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TagTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                FaIcon(
                  icon,
                  size: 16,
                  color: selected ? Colors.white : AppColors.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : AppColors.text,
                    ),
                  ),
                ),
                if (selected)
                  const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  final double? progress;
  final bool editing;
  final VoidCallback onSave;

  const _SaveBar({
    required this.progress,
    required this.editing,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final progress = this.progress;
    final busy = progress != null;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (busy && !editing) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.border,
                  ),
                ),
                const SizedBox(height: 10),
              ],
              ElevatedButton.icon(
                onPressed: busy ? null : onSave,
                icon: busy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        editing
                            ? Icons.check_rounded
                            : Icons.cloud_upload_rounded,
                      ),
                label: Text(
                  !busy
                      ? (editing ? l10n.save : l10n.uploadVideo)
                      : editing
                      ? l10n.saving
                      : l10n.uploadingProgress((progress * 100).round()),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
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
