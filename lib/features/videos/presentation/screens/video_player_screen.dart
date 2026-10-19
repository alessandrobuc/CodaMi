import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/system_bars.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/video_entity.dart';
import '../providers/videos_provider.dart';
import '../widgets/video_labels.dart';
import '../widgets/video_thumbnail.dart';

const _skip = Duration(seconds: 10);
const _hideAfter = Duration(seconds: 3);

String _time(Duration d) {
  final minutes = d.inMinutes;
  final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final Video video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _controlsVisible = true;
  bool _seeking = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller?.dispose();
    SystemChrome.setPreferredOrientations(const []);
    showSystemBars();
    super.dispose();
  }

  Future<void> _start() async {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    );
    setState(() {
      _controller = controller;
      _failed = false;
    });
    try {
      await controller.initialize();
    } catch (_) {
      if (mounted && _controller == controller) setState(() => _failed = true);
      return;
    }
    if (!mounted || _controller != controller) return;
    setState(() {});
    await controller.play();
    _scheduleHide();
    ref.read(watchedVideosProvider.notifier).add(widget.video.id);
  }

  Future<void> _retry() async {
    final old = _controller;
    await _start();
    await old?.dispose();
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(_hideAfter, () {
      if (mounted && (_controller?.value.isPlaying ?? false)) {
        setState(() => _controlsVisible = false);
      }
    });
  }

  void _toggleControls() {
    setState(() => _controlsVisible = !_controlsVisible);
    if (_controlsVisible) _scheduleHide();
  }

  void _showControls() {
    if (!_controlsVisible) setState(() => _controlsVisible = true);
    _scheduleHide();
  }

  bool _ended(VideoPlayerValue value) =>
      value.isInitialized &&
      !value.isPlaying &&
      value.duration > Duration.zero &&
      value.position >= value.duration - const Duration(milliseconds: 300);

  Future<void> _playPause() async {
    final controller = _controller;
    if (controller == null) return;
    final value = controller.value;
    if (_ended(value)) {
      await _seekTo(Duration.zero);
      await controller.play();
    } else if (value.isPlaying) {
      await controller.pause();
    } else {
      await controller.play();
    }
    _showControls();
  }

  Future<void> _seekTo(Duration target) async {
    final controller = _controller;
    if (controller == null) return;
    final duration = controller.value.duration;
    final clamped = target < Duration.zero
        ? Duration.zero
        : target > duration
        ? duration
        : target;
    setState(() => _seeking = true);
    try {
      await controller.seekTo(clamped);
    } finally {
      if (mounted) setState(() => _seeking = false);
    }
    _showControls();
  }

  void _skipBy(Duration offset) {
    final controller = _controller;
    if (controller == null) return;
    _seekTo(controller.value.position + offset);
  }

  void _toggleFullscreen(bool landscape) {
    if (landscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      showSystemBars();
      // Let the phone rotate freely again once it is back in portrait.
      Future.delayed(const Duration(seconds: 1), () {
        SystemChrome.setPreferredOrientations(const []);
      });
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
    _showControls();
  }

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    final player = _PlayerArea(
      video: widget.video,
      controller: _controller,
      failed: _failed,
      seeking: _seeking,
      controlsVisible: _controlsVisible,
      landscape: landscape,
      ended: _ended,
      onTap: _toggleControls,
      onPlayPause: _playPause,
      onSkip: _skipBy,
      onSeek: _seekTo,
      onScrubStart: () => _hideTimer?.cancel(),
      onRetry: _retry,
      onFullscreen: () => _toggleFullscreen(landscape),
      onBack: () => Navigator.of(context).maybePop(),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: landscape
            ? player
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.sizeOf(context).height * 0.6,
                      ),
                      child: AspectRatio(
                        aspectRatio: _aspectRatio,
                        child: player,
                      ),
                    ),
                    Expanded(child: _Details(video: widget.video)),
                  ],
                ),
              ),
      ),
    );
  }

  double get _aspectRatio {
    final value = _controller?.value;
    if (value == null || !value.isInitialized) return 16 / 9;
    return value.aspectRatio.clamp(0.75, 2.4);
  }
}

class _PlayerArea extends StatelessWidget {
  final Video video;
  final VideoPlayerController? controller;
  final bool failed;
  final bool seeking;
  final bool controlsVisible;
  final bool landscape;
  final bool Function(VideoPlayerValue) ended;
  final VoidCallback onTap;
  final VoidCallback onPlayPause;
  final ValueChanged<Duration> onSkip;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onScrubStart;
  final VoidCallback onRetry;
  final VoidCallback onFullscreen;
  final VoidCallback onBack;

  const _PlayerArea({
    required this.video,
    required this.controller,
    required this.failed,
    required this.seeking,
    required this.controlsVisible,
    required this.landscape,
    required this.ended,
    required this.onTap,
    required this.onPlayPause,
    required this.onSkip,
    required this.onSeek,
    required this.onScrubStart,
    required this.onRetry,
    required this.onFullscreen,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;
    if (failed || controller == null) {
      return _Shell(
        onBack: onBack,
        child: failed ? _ErrorView(onRetry: onRetry) : const SizedBox(),
      );
    }

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        if (value.hasError) {
          return _Shell(
            onBack: onBack,
            child: _ErrorView(onRetry: onRetry),
          );
        }
        final initialized = value.isInitialized;
        final isEnded = ended(value);
        final loading = !initialized || seeking || value.isBuffering;
        final visible = controlsVisible || !value.isPlaying || isEnded;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (initialized)
                Center(
                  child: AspectRatio(
                    aspectRatio: value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                )
              else
                Opacity(
                  opacity: 0.5,
                  child: VideoThumbnail(
                    video: video,
                    playSize: 0,
                    showDuration: false,
                  ),
                ),
              AnimatedOpacity(
                opacity: visible ? 1 : 0,
                duration: const Duration(milliseconds: 220),
                child: IgnorePointer(
                  ignoring: !visible,
                  child: _Controls(
                    value: value,
                    loading: loading,
                    ended: isEnded,
                    landscape: landscape,
                    title: video.title,
                    onPlayPause: onPlayPause,
                    onSkip: onSkip,
                    onSeek: onSeek,
                    onScrubStart: onScrubStart,
                    onFullscreen: onFullscreen,
                    onBack: onBack,
                  ),
                ),
              ),
              // Loading stays visible even when the controls are hidden.
              if (loading && !visible) const Center(child: _Spinner()),
            ],
          ),
        );
      },
    );
  }
}

class _Shell extends StatelessWidget {
  final Widget child;
  final VoidCallback onBack;

  const _Shell({required this.child, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(child: child),
        PositionedDirectional(
          top: 4,
          start: 4,
          child: _RoundButton(icon: Icons.arrow_back_rounded, onTap: onBack),
        ),
      ],
    );
  }
}

class _Controls extends StatelessWidget {
  final VideoPlayerValue value;
  final bool loading;
  final bool ended;
  final bool landscape;
  final String title;
  final VoidCallback onPlayPause;
  final ValueChanged<Duration> onSkip;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onScrubStart;
  final VoidCallback onFullscreen;
  final VoidCallback onBack;

  const _Controls({
    required this.value,
    required this.loading,
    required this.ended,
    required this.landscape,
    required this.title,
    required this.onPlayPause,
    required this.onSkip,
    required this.onSeek,
    required this.onScrubStart,
    required this.onFullscreen,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ready = value.isInitialized;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.25, 0.65, 1],
          colors: [
            Color(0x99000000),
            Color(0x00000000),
            Color(0x00000000),
            Color(0xB3000000),
          ],
        ),
      ),
      child: SafeArea(
        top: landscape,
        bottom: landscape,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 4),
                _RoundButton(icon: Icons.arrow_back_rounded, onTap: onBack),
                if (landscape)
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RoundButton(
                    icon: Icons.replay_10_rounded,
                    size: 30,
                    tooltip: l10n.videoBack10,
                    onTap: ready ? () => onSkip(-_skip) : null,
                  ),
                  const SizedBox(width: 28),
                  SizedBox(
                    width: 68,
                    height: 68,
                    child: loading
                        ? const _Spinner()
                        : Material(
                            color: Colors.white.withValues(alpha: 0.18),
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: onPlayPause,
                              child: Icon(
                                ended
                                    ? Icons.replay_rounded
                                    : value.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 42,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 28),
                  _RoundButton(
                    icon: Icons.forward_10_rounded,
                    size: 30,
                    tooltip: l10n.videoForward10,
                    onTap: ready ? () => onSkip(_skip) : null,
                  ),
                ],
              ),
            ),
            if (ready)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 4, 4),
                child: _SeekRow(
                  value: value,
                  onSeek: onSeek,
                  onScrubStart: onScrubStart,
                  landscape: landscape,
                  onFullscreen: onFullscreen,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SeekRow extends StatefulWidget {
  final VideoPlayerValue value;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onScrubStart;
  final bool landscape;
  final VoidCallback onFullscreen;

  const _SeekRow({
    required this.value,
    required this.onSeek,
    required this.onScrubStart,
    required this.landscape,
    required this.onFullscreen,
  });

  @override
  State<_SeekRow> createState() => _SeekRowState();
}

class _SeekRowState extends State<_SeekRow> {
  // While dragging, the bar follows the finger instead of the player.
  double? _drag;

  Duration get _duration => widget.value.duration;

  double get _played {
    final total = _duration.inMilliseconds;
    if (total <= 0) return 0;
    return (widget.value.position.inMilliseconds / total).clamp(0.0, 1.0);
  }

  double get _buffered {
    final total = _duration.inMilliseconds;
    if (total <= 0) return 0;
    var end = 0;
    for (final range in widget.value.buffered) {
      if (range.end.inMilliseconds > end) end = range.end.inMilliseconds;
    }
    return (end / total).clamp(0.0, 1.0);
  }

  double _fraction(Offset local, double width) =>
      (local.dx / width).clamp(0.0, 1.0);

  void _commit() {
    final drag = _drag;
    if (drag == null) return;
    widget.onSeek(_duration * drag);
    setState(() => _drag = null);
  }

  @override
  Widget build(BuildContext context) {
    final shown = _drag ?? _played;
    final textDirection = Directionality.of(context);

    return Row(
      children: [
        Text(
          '${_time(_duration * shown)} / ${_time(_duration)}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              Offset toLtr(Offset p) => textDirection == TextDirection.rtl
                  ? Offset(width - p.dx, p.dy)
                  : p;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: (d) {
                  widget.onScrubStart();
                  setState(
                    () => _drag = _fraction(toLtr(d.localPosition), width),
                  );
                },
                onHorizontalDragUpdate: (d) => setState(
                  () => _drag = _fraction(toLtr(d.localPosition), width),
                ),
                onHorizontalDragEnd: (_) => _commit(),
                onHorizontalDragCancel: () => setState(() => _drag = null),
                onTapUp: (d) {
                  _drag = _fraction(toLtr(d.localPosition), width);
                  _commit();
                },
                child: SizedBox(
                  height: 32,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomPaint(
                      painter: _SeekPainter(
                        played: shown,
                        buffered: _buffered,
                        dragging: _drag != null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        IconButton(
          onPressed: widget.onFullscreen,
          tooltip: widget.landscape
              ? context.l10n.videoExitFullscreen
              : context.l10n.videoFullscreen,
          color: Colors.white,
          icon: Icon(
            widget.landscape
                ? Icons.fullscreen_exit_rounded
                : Icons.fullscreen_rounded,
          ),
        ),
      ],
    );
  }
}

class _SeekPainter extends CustomPainter {
  final double played;
  final double buffered;
  final bool dragging;

  _SeekPainter({
    required this.played,
    required this.buffered,
    required this.dragging,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final height = dragging ? 6.0 : 4.0;
    final top = (size.height - height) / 2;
    final radius = Radius.circular(height / 2);
    void bar(double fraction, Color color) => canvas.drawRRect(
      RRect.fromLTRBR(0, top, size.width * fraction, top + height, radius),
      Paint()..color = color,
    );
    bar(1, Colors.white.withValues(alpha: 0.22));
    bar(buffered, Colors.white.withValues(alpha: 0.45));
    bar(played, AppColors.accent);
    canvas.drawCircle(
      Offset(size.width * played, size.height / 2),
      dragging ? 9 : 7,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_SeekPainter old) =>
      old.played != played ||
      old.buffered != buffered ||
      old.dragging != dragging;
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        shape: BoxShape.circle,
      ),
      child: const CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final String? tooltip;

  const _RoundButton({
    required this.icon,
    required this.onTap,
    this.size = 24,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: tooltip,
      iconSize: size,
      color: Colors.white,
      disabledColor: Colors.white38,
      icon: Icon(icon),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off_rounded, color: Colors.white54, size: 36),
          const SizedBox(height: 10),
          Text(
            l10n.videoLoadError,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(l10n.videoRetry),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final Video video;

  const _Details({required this.video});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final duration = video.durationLabel;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      children: [
        Row(
          children: [
            CategoryPill(
              label: video.category.label(l10n),
              motivational: video.category == VideoCategory.motivational,
              onDark: true,
            ),
            if (duration != null) ...[
              const SizedBox(width: 8),
              DurationBadge(label: duration),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Text(
          video.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w800,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in video.tags)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  videoTagLabel(tag, l10n),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
