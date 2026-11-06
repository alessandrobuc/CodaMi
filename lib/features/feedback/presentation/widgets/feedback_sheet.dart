import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../pets/presentation/widgets/pet_form_widgets.dart';
import '../../../points/domain/points.dart';
import '../../../points/presentation/providers/points_provider.dart';
import '../../../points/presentation/widgets/points_widgets.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../whats_new/presentation/providers/whats_new_provider.dart';
import '../../data/feedback_repository.dart';
import '../../domain/feedback.dart';
import 'feedback_labels.dart';

// [asked] is true when the app asked the question itself, about [area].
Future<void> showFeedbackSheet(
  BuildContext context, {
  FeedbackArea? area,
  bool asked = false,
}) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: AppColors.surface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
  ),
  builder: (_) => _FeedbackSheet(area: area, asked: asked),
);

class _FeedbackSheet extends ConsumerStatefulWidget {
  final FeedbackArea? area;
  final bool asked;

  const _FeedbackSheet({this.area, required this.asked});

  @override
  ConsumerState<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends ConsumerState<_FeedbackSheet> {
  final _comment = TextEditingController();
  FeedbackType? _type;
  late FeedbackArea _area = widget.area ?? FeedbackArea.general;
  int _rating = 0;
  String? _screenshot;
  bool _sending = false;

  bool get _aboutArea =>
      widget.asked &&
      widget.area != null &&
      widget.area != FeedbackArea.general;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _pickScreenshot() async {
    final path = await pickPhoto(context, from: ImageSource.gallery);
    if (path != null && mounted) setState(() => _screenshot = path);
  }

  Future<void> _send() async {
    final uid = ref.read(userProfileProvider).value?.uid;
    if (uid == null || _sending || !feedbackReady(_rating, _comment.text)) {
      return;
    }
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final repo = ref.read(feedbackRepositoryProvider);
    setState(() => _sending = true);
    try {
      final points = await repo.submit(
        uid: uid,
        type: _type ?? FeedbackType.general,
        area: _area,
        rating: _rating,
        comment: _comment.text.trim(),
        asked: widget.asked,
        screenshot: _screenshot,
        appVersion: ref.read(appVersionProvider).value ?? '',
        lang: ref.read(localeProvider).code,
      );
      repo.markSent(uid).catchError((Object e) {
        debugPrint('Feedback pause not saved: $e');
      });
      if (!mounted) return;
      SnackbarUtils.showSuccess(
        context,
        points > 0 ? l10n.feedbackThanksPoints(points) : l10n.feedbackThanks,
      );
      navigator.pop();
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      SnackbarUtils.showError(context, switch (e.code) {
        'resource-exhausted' => l10n.fbLimitToday,
        'unavailable' || 'deadline-exceeded' => l10n.checkConnection,
        _ => l10n.actionFailed,
      });
    } catch (e) {
      debugPrint('Feedback not sent: $e');
      if (!mounted) return;
      setState(() => _sending = false);
      SnackbarUtils.showError(context, l10n.checkConnection);
    }
  }

  Future<void> _dontAsk() async {
    final uid = ref.read(userProfileProvider).value?.uid;
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    if (uid != null) {
      try {
        await ref.read(feedbackRepositoryProvider).optOut(uid);
      } catch (e) {
        debugPrint('Feedback opt-out not saved: $e');
      }
    }
    if (!mounted) return;
    SnackbarUtils.showSuccess(context, l10n.fbDontAskDone);
    navigator.pop();
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final config =
        ref.watch(pointsConfigProvider).value ?? const PointsConfig();
    final sent = ref.watch(userProfileProvider).value?.feedbackSent ?? false;
    final offer = !sent && config.feedbackPoints > 0;
    final ready = feedbackReady(_rating, _comment.text);
    final title = !widget.asked
        ? l10n.feedbackSend
        : _aboutArea
        ? l10n.fbQuickTitle
        : l10n.feedbackTitle;
    final body = _aboutArea
        ? l10n.fbQuickBody
        : widget.asked
        ? l10n.feedbackBody
        : l10n.fbSelfBody;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              24,
              12,
              24,
              MediaQuery.paddingOf(context).bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _aboutArea ? _area.icon : Icons.rate_review_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                ),
                if (_aboutArea) ...[
                  const SizedBox(height: 10),
                  Center(child: _AreaPill(area: _area)),
                ],
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.textMuted,
                  ),
                ),
                if (offer) ...[
                  const SizedBox(height: 12),
                  Center(child: _PointsOffer(points: config.feedbackPoints)),
                ],
                _label(l10n.fbTypeLabel),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final type in FeedbackType.choices)
                      _TypeChip(
                        type: type,
                        selected: _type == type,
                        onTap: _sending
                            ? null
                            : () {
                                HapticFeedback.selectionClick();
                                setState(
                                  () => _type = _type == type ? null : type,
                                );
                              },
                      ),
                  ],
                ),
                if (!_aboutArea) ...[
                  _label(l10n.fbAreaLabel),
                  _AreaPicker(
                    value: _area,
                    onChanged: _sending
                        ? null
                        : (area) => setState(() => _area = area),
                  ),
                ],
                _label(l10n.fbRatingLabel),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var star = 1; star <= 5; star++)
                      IconButton(
                        iconSize: 38,
                        tooltip: '$star',
                        onPressed: _sending
                            ? null
                            : () {
                                HapticFeedback.selectionClick();
                                setState(
                                  () => _rating = _rating == star ? 0 : star,
                                );
                              },
                        icon: AnimatedScale(
                          scale: star <= _rating ? 1.1 : 1,
                          duration: const Duration(milliseconds: 150),
                          child: Icon(
                            star <= _rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: star <= _rating
                                ? AppColors.accent
                                : AppColors.border,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _comment,
                  enabled: !_sending,
                  minLines: 3,
                  maxLines: 6,
                  maxLength: feedbackCommentMax,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: (_type ?? FeedbackType.general).hint(l10n),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                _Screenshot(
                  path: _screenshot,
                  onAdd: _sending ? null : _pickScreenshot,
                  onRemove: _sending
                      ? null
                      : () => setState(() => _screenshot = null),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        l10n.fbAutoInfo,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: !ready || _sending ? null : _send,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: _sending
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.feedbackSend),
                ),
                if (!ready)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      l10n.fbNeedSomething,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: _sending
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: Text(l10n.feedbackLater),
                ),
                if (widget.asked)
                  TextButton(
                    onPressed: _sending ? null : _dontAsk,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textMuted,
                    ),
                    child: Text(
                      l10n.fbDontAsk,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
              ],
            ),
          ),
          PositionedDirectional(
            top: 8,
            end: 8,
            child: IconButton(
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              onPressed: _sending ? null : () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_rounded),
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _AreaPill extends StatelessWidget {
  final FeedbackArea area;

  const _AreaPill({required this.area});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        area.label(context.l10n),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}

class _PointsOffer extends StatelessWidget {
  final int points;

  const _PointsOffer({required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: pointsColor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stars_rounded,
            size: 18,
            color: AppColors.rewardText,
          ),
          const SizedBox(width: 6),
          Text(
            context.l10n.feedbackPointsOffer(points),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.rewardText,
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final FeedbackType type;
  final bool selected;
  final VoidCallback? onTap;

  const _TypeChip({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? type.color.withValues(alpha: 0.12)
          : AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected ? type.color : AppColors.border,
          width: selected ? 1.6 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                type.icon,
                size: 18,
                color: selected ? type.color : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                type.label(context.l10n),
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  color: selected ? AppColors.text : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AreaPicker extends StatelessWidget {
  final FeedbackArea value;
  final ValueChanged<FeedbackArea>? onChanged;

  const _AreaPicker({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DropdownButtonFormField<FeedbackArea>(
      initialValue: value,
      isExpanded: true,
      borderRadius: BorderRadius.circular(16),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      items: [
        for (final area in FeedbackArea.values)
          DropdownMenuItem(
            value: area,
            child: Row(
              children: [
                Icon(area.icon, size: 20, color: AppColors.primary),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    area.label(l10n),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
      onChanged: onChanged == null
          ? null
          : (area) {
              if (area != null) onChanged!(area);
            },
    );
  }
}

class _Screenshot extends StatelessWidget {
  final String? path;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const _Screenshot({
    required this.path,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final file = path;
    if (file == null) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: OutlinedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_photo_alternate_rounded, size: 20),
          label: Text(context.l10n.fbScreenshotAdd),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      );
    }
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.file(
              File(file),
              width: 96,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
            top: -8,
            end: -8,
            child: Material(
              color: AppColors.text,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onRemove,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
