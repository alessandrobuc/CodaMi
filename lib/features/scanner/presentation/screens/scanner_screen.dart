import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/app_languages.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/domain/repositories/pets_repository.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../pets/presentation/widgets/pet_form_widgets.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../data/scanner_repository.dart';
import '../../domain/breed_scan.dart';
import '../providers/scanner_provider.dart';
import '../widgets/scanner_widgets.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  // Opened from the pet form: the result offers "Use this breed" and returns it.
  final bool pickBreed;

  const ScannerScreen({super.key, this.pickBreed = false});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  Uint8List? _photo;
  BreedScan? _result;
  bool _scanning = false;

  // With no source, the camera / gallery sheet is shown.
  Future<void> _scan([ImageSource? source]) async {
    final path = await pickPhoto(context, from: source, maxSize: 1280);
    if (path == null || !mounted) return;
    final bytes = await XFile(path).readAsBytes();
    setState(() {
      _photo = bytes;
      _result = null;
      _scanning = true;
    });
    try {
      final result = await ref
          .read(scannerRepositoryProvider)
          .scan(bytes, language: currentAppLanguage.code);
      if (mounted) setState(() => _result = result);
    } on ScanException catch (e) {
      if (!mounted) return;
      final l10n = context.l10n;
      SnackbarUtils.showError(context, switch (e.error) {
        ScanError.limit => l10n.scannerLimit,
        ScanError.off => l10n.scannerOff,
        ScanError.badPhoto => l10n.scannerBadPhoto,
        ScanError.unavailable => l10n.scannerUnavailable,
      });
      setState(() => _photo = null);
    } finally {
      if (mounted) setState(() => _scanning = false);
    }
  }

  Future<void> _saveToPet(BreedScan scan) async {
    final l10n = context.l10n;
    final pets = [...ref.read(myPetsProvider).value ?? const <Pet>[]];
    if (pets.isEmpty) {
      SnackbarUtils.showInfo(context, l10n.scannerNoPets);
      return;
    }
    int rank(Pet p) => p.species == scan.species ? 0 : 1;
    pets.sort((a, b) => rank(a).compareTo(rank(b)));
    final pet = await showModalBottomSheet<Pet>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            ScannerSectionTitle(l10n.scannerChoosePet),
            for (final p in pets)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: scannerColor.withValues(alpha: 0.1),
                  child: FaIcon(
                    speciesIcon(p.species),
                    size: 16,
                    color: scannerColor,
                  ),
                ),
                title: Text(
                  p.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: p.breed == null || p.breed!.isEmpty
                    ? Text(p.species.label(l10n))
                    : Text(p.breed!, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.of(context).pop(p),
              ),
          ],
        ),
      ),
    );
    if (pet == null || !mounted) return;
    try {
      await ref.read(petsRepositoryProvider).saveBreed(pet, scan.breedForPet);
      if (mounted) {
        SnackbarUtils.showSuccess(context, l10n.scannerBreedSaved(pet.name));
      }
    } on PetsException catch (e) {
      if (mounted) SnackbarUtils.showError(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final photo = _photo;
    final result = _result;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.breedScanner),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            if (photo == null)
              _Intro(onScan: _scan)
            else ...[
              _PhotoPreview(photo: photo, scanning: _scanning),
              const SizedBox(height: 16),
              if (_scanning)
                Center(
                  child: Text(
                    l10n.scannerScanning,
                    style: const TextStyle(color: AppColors.textMuted),
                  ),
                )
              else if (result != null) ...[
                if (result.animalFound)
                  BreedScanResult(scan: result)
                else
                  ScannerCard(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          size: 36,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.scannerNoAnimalTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.scannerNoAnimalText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                if (result.animalFound)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: scannerColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: widget.pickBreed
                        ? () => Navigator.of(context).pop(result.breedForPet)
                        : () => _saveToPet(result),
                    icon: Icon(
                      widget.pickBreed
                          ? Icons.check_rounded
                          : Icons.bookmark_add_outlined,
                    ),
                    label: Text(
                      widget.pickBreed
                          ? l10n.scannerUseBreed
                          : l10n.scannerSaveToPet,
                    ),
                  ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: _scan,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(l10n.scannerTryAnother),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  final void Function(ImageSource source) onScan;

  const _Intro({required this.onScan});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget tip(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ScannerNote(icon: icon, text: text, color: AppColors.text),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScannerCard(
          tint: scannerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: scannerColor,
                child: Icon(
                  Icons.document_scanner_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.scannerIntroTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.scannerIntroText,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 6),
              tip(Icons.crop_free_rounded, l10n.scannerTipWhole),
              tip(Icons.wb_sunny_outlined, l10n.scannerTipLight),
              tip(Icons.looks_one_outlined, l10n.scannerTipOne),
            ],
          ),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: scannerColor,
            minimumSize: const Size.fromHeight(52),
          ),
          onPressed: () => onScan(ImageSource.camera),
          icon: const Icon(Icons.photo_camera_rounded),
          label: Text(l10n.takePhoto),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
          onPressed: () => onScan(ImageSource.gallery),
          icon: const Icon(Icons.photo_library_rounded),
          label: Text(l10n.chooseFromGallery),
        ),
        const SizedBox(height: 20),
        ScannerNote(
          icon: Icons.info_outline_rounded,
          text: l10n.scannerEstimate,
        ),
        const SizedBox(height: 10),
        ScannerNote(
          icon: Icons.lock_outline_rounded,
          text: l10n.scannerPrivacy,
        ),
      ],
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  final Uint8List photo;
  final bool scanning;

  const _PhotoPreview({required this.photo, required this.scanning});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.memory(photo, fit: BoxFit.cover),
            if (scanning)
              const ColoredBox(
                color: Color(0x66000000),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BreedScanResult extends StatelessWidget {
  final BreedScan scan;

  const BreedScanResult({super.key, required this.scan});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final top = scan.top!;
    final level = ScanConfidence.of(top.confidence);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScannerCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ScannerChip(
                    text: scan.speciesName.isNotEmpty
                        ? scan.speciesName
                        : scan.species.label(l10n),
                    color: AppColors.primaryDark,
                    icon: Icons.pets_rounded,
                  ),
                  if (scan.mixed)
                    ScannerChip(
                      text: l10n.scannerMixed,
                      color: scannerColor,
                      icon: Icons.merge_type_rounded,
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                l10n.scannerMostLikely,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      top.name,
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n.scannerPercent(top.confidence),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: level.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ConfidenceBar(percent: top.confidence, height: 10),
              const SizedBox(height: 6),
              Text(
                level.label(l10n),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: level.color,
                ),
              ),
            ],
          ),
        ),
        if (scan.poorPhoto) ...[
          const SizedBox(height: 12),
          ScannerCard(
            tint: ScanConfidence.low.color,
            child: ScannerNote(
              icon: Icons.photo_size_select_actual_outlined,
              text: l10n.scannerPoorPhoto,
              color: ScanConfidence.low.color,
            ),
          ),
        ],
        if (scan.others.isNotEmpty) ...[
          const SizedBox(height: 12),
          ScannerCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScannerSectionTitle(
                  scan.mixed ? l10n.scannerMixOthers : l10n.scannerOtherBreeds,
                ),
                for (final b in scan.others)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                b.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              l10n.scannerPercent(b.confidence),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ConfidenceBar(percent: b.confidence),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
        if (scan.note.isNotEmpty) ...[
          const SizedBox(height: 12),
          ScannerCard(
            child: ScannerNote(
              icon: Icons.lightbulb_outline_rounded,
              text: scan.note,
              color: AppColors.text,
            ),
          ),
        ],
        if (scan.facts.isNotEmpty) ...[
          const SizedBox(height: 12),
          ScannerCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScannerSectionTitle(
                  scan.mixed ? l10n.scannerAboutMix : l10n.scannerAboutBreed,
                ),
                for (final e in scan.facts.entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(e.key.icon, size: 20, color: scannerColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.key.label(l10n),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                e.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 14),
        ScannerNote(
          icon: Icons.info_outline_rounded,
          text: l10n.scannerEstimate,
        ),
      ],
    );
  }
}
