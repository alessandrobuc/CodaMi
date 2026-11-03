import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/invite_code.dart';

enum _Kind { qr, flyer }

// The personal QR code and a printable flyer, saved or shared as images.
class InviteQrScreen extends StatefulWidget {
  final String code;

  const InviteQrScreen({super.key, required this.code});

  @override
  State<InviteQrScreen> createState() => _InviteQrScreenState();
}

class _InviteQrScreenState extends State<InviteQrScreen> {
  final _qrKey = GlobalKey();
  final _flyerKey = GlobalKey();
  _Kind _kind = _Kind.qr;
  bool _busy = false;

  Future<_Rendered?> _render() async {
    final key = _kind == _Kind.qr ? _qrKey : _flyerKey;
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;
    final image = await boundary.toImage(pixelRatio: 4);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    if (data == null) return null;
    return _Rendered(
      data.buffer.asUint8List(),
      _kind == _Kind.qr
          ? 'codami_qr_${widget.code}'
          : 'codami_flyer_${widget.code}',
    );
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      final image = await _render();
      if (image == null) throw StateError('Nothing to save');
      if (!await Gal.hasAccess() && !await Gal.requestAccess()) {
        if (mounted) SnackbarUtils.showError(context, l10n.inviteSaveDenied);
        return;
      }
      await Gal.putImageBytes(image.bytes, name: image.name);
      if (mounted) SnackbarUtils.showSuccess(context, l10n.inviteSaved);
    } catch (e) {
      debugPrint('Invite image not saved: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.inviteSaveDenied);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share() async {
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      final image = await _render();
      if (image == null) throw StateError('Nothing to share');
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              image.bytes,
              mimeType: 'image/png',
              name: '${image.name}.png',
            ),
          ],
          fileNameOverrides: ['${image.name}.png'],
          text: l10n.inviteShareText(widget.code, inviteLink(widget.code)),
        ),
      );
    } catch (e) {
      debugPrint('Invite image not shared: $e');
      if (mounted) SnackbarUtils.showError(context, l10n.actionFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.inviteQrScreenTitle),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 4, 20, bottom + 24),
        children: [
          SegmentedButton<_Kind>(
            segments: [
              ButtonSegment(
                value: _Kind.qr,
                icon: const Icon(Icons.qr_code_2_rounded),
                label: Text(l10n.inviteQrCode),
              ),
              ButtonSegment(
                value: _Kind.flyer,
                icon: const Icon(Icons.description_rounded),
                label: Text(l10n.inviteFlyer),
              ),
            ],
            selected: {_kind},
            showSelectedIcon: false,
            onSelectionChanged: (s) => setState(() => _kind = s.first),
          ),
          const SizedBox(height: 18),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.text.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: _kind == _Kind.qr
                    ? RepaintBoundary(
                        key: _qrKey,
                        child: _QrCard(code: widget.code),
                      )
                    : RepaintBoundary(
                        key: _flyerKey,
                        child: _Flyer(code: widget.code),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _kind == _Kind.qr ? l10n.inviteQrHelp : l10n.inviteFlyerHelp,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _busy ? null : _share,
                  icon: const Icon(Icons.share_rounded),
                  label: Text(l10n.shareInvite),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _busy ? null : _save,
                  icon: const Icon(Icons.download_rounded),
                  label: Text(l10n.inviteSaveToPhotos),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Rendered {
  final Uint8List bytes;
  final String name;

  _Rendered(this.bytes, this.name);
}

class InviteQr extends StatelessWidget {
  final String code;
  final double size;

  const InviteQr({super.key, required this.code, required this.size});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: inviteQrLink(code),
      size: size,
      padding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: AppColors.primaryDark,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: AppColors.text,
      ),
    );
  }
}

class _QrCard extends StatelessWidget {
  final String code;

  const _QrCard({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(
            builder: (context, c) => InviteQr(code: code, size: c.maxWidth),
          ),
          const SizedBox(height: 14),
          Text(
            code,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: 6,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _Flyer extends StatelessWidget {
  final String code;

  const _Flyer({required this.code});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AspectRatio(
      aspectRatio: 1 / 1.414,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(AppAssets.logo, width: 52, height: 52),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.flyerTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.flyerText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 18, 28, 10),
                child: LayoutBuilder(
                  builder: (context, c) => Center(
                    child: InviteQr(
                      code: code,
                      size: c.maxHeight < c.maxWidth ? c.maxHeight : c.maxWidth,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              l10n.flyerScan,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                l10n.flyerCode(code),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.flyerFree,
              style: const TextStyle(
                fontSize: 11.5,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
