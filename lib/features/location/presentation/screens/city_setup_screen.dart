import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/places_service.dart';
import '../../data/models/city_place.dart';
import '../providers/location_provider.dart';

class CitySetupScreen extends ConsumerStatefulWidget {
  final bool isEditing;

  const CitySetupScreen({super.key, this.isEditing = false});

  @override
  ConsumerState<CitySetupScreen> createState() => _CitySetupScreenState();
}

class _CitySetupScreenState extends ConsumerState<CitySetupScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();
  Timer? _debounce;
  int _requestId = 0;

  List<PlaceSuggestion> _suggestions = const [];
  CityPlace? _selected;
  String? _error;
  bool _searching = false;
  bool _resolving = false;
  bool _saving = false;

  PlacesService get _places => ref.read(placesServiceProvider);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    setState(() {
      _selected = null;
      _error = null;
    });
    if (value.trim().length < 2) {
      setState(() {
        _suggestions = const [];
        _searching = false;
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 300), () => _search(value));
  }

  Future<void> _search(String value) async {
    final requestId = ++_requestId;
    setState(() => _searching = true);
    try {
      final results = await _places.searchCities(value);
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _suggestions = results;
        _error = results.isEmpty ? 'No cities found for "$value".' : null;
      });
    } on PlacesException catch (e) {
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _suggestions = const [];
        _error = e.message;
      });
    } finally {
      if (mounted && requestId == _requestId) {
        setState(() => _searching = false);
      }
    }
  }

  Future<void> _select(PlaceSuggestion suggestion) async {
    _focusNode.unfocus();
    _requestId++;
    setState(() {
      _resolving = true;
      _suggestions = const [];
      _controller.text = suggestion.mainText;
    });
    try {
      final place = await _places.cityDetails(suggestion);
      if (!mounted) return;
      setState(() {
        _selected = place;
        _controller.text = place.label;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted || !_scrollController.hasClients) return;
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
      });
    } on PlacesException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _resolving = false);
    }
  }

  void _clear() {
    _controller.clear();
    _onChanged('');
    _focusNode.requestFocus();
  }

  Future<void> _save() async {
    final place = _selected;
    final uid = ref.read(authStateProvider).value?.uid;
    if (place == null || uid == null) return;

    setState(() => _saving = true);
    try {
      await ref.read(homeCityRepositoryProvider).saveHomeCity(uid, place);
      if (!mounted) return;
      if (widget.isEditing) {
        SnackbarUtils.showSuccess(
          context,
          'Home city updated to ${place.city}.',
        );
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        SnackbarUtils.showError(
          context,
          'Couldn\'t save your city. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final compact = MediaQuery.sizeOf(context).height < 760;
    final typing =
        keyboardOpen || _focusNode.hasFocus || _suggestions.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -110,
            right: -90,
            child: _Blob(
              size: 300,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
          Positioned(
            top: 220,
            left: -130,
            child: _Blob(
              size: 240,
              color: AppColors.accent.withValues(alpha: 0.12),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        if (widget.isEditing)
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_rounded),
                            color: AppColors.text,
                          )
                        else ...[
                          Image.asset(AppAssets.logo, width: 34, height: 34),
                          const SizedBox(width: 8),
                          Text(
                            'CodaMi',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AnimatedSize(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOutCubic,
                            child: typing
                                ? const SizedBox(
                                    width: double.infinity,
                                    height: 12,
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: compact ? 8 : 20,
                                    ),
                                    child: Center(
                                      child: SizedBox.square(
                                        dimension: compact ? 124 : 170,
                                        child: FittedBox(
                                          child: _PinIllustration(
                                            confirmed: _selected != null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          Text.rich(
                                TextSpan(
                                  text: widget.isEditing
                                      ? 'Change your '
                                      : 'Where are ',
                                  children: [
                                    TextSpan(
                                      text: widget.isEditing ? 'city' : 'you?',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                style: textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text,
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 400.ms)
                              .slideY(begin: 0.2, end: 0),
                          const SizedBox(height: 8),
                          Text(
                            'Pick your city so we can show lost & found pets near you and let you know when a pet goes missing in your area.',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textMuted,
                              height: 1.5,
                            ),
                          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                          const SizedBox(height: 18),
                          _SearchField(
                            controller: _controller,
                            focusNode: _focusNode,
                            loading: _searching || _resolving,
                            confirmed: _selected != null,
                            onChanged: _onChanged,
                            onClear: _clear,
                          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                          const SizedBox(height: 12),
                          _buildResults(textTheme),
                        ],
                      ),
                    ),
                  ),
                  _ContinueButton(
                    enabled: _selected != null && !_resolving,
                    saving: _saving,
                    label: widget.isEditing ? 'Save city' : 'Continue',
                    onPressed: _save,
                  ),
                  if (!widget.isEditing && !keyboardOpen) ...[
                    const SizedBox(height: 4),
                    Center(
                      child: TextButton(
                        onPressed: _saving
                            ? null
                            : () => ref.read(authProvider.notifier).logout(),
                        child: const Text(
                          'Not you? Sign out',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(TextTheme textTheme) {
    final Widget child;
    if (_selected != null) {
      child = _SelectedCityCard(
        key: const ValueKey('selected'),
        place: _selected!,
      );
    } else if (_suggestions.isNotEmpty) {
      child = _SuggestionList(
        key: ValueKey(_suggestions.first.placeId),
        suggestions: _suggestions,
        query: _controller.text,
        onSelect: _select,
      );
    } else if (_error != null) {
      child = _MessageCard(key: ValueKey(_error), message: _error!);
    } else {
      child = const SizedBox.shrink(key: ValueKey('empty'));
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      layoutBuilder: (current, previous) => Stack(
        alignment: Alignment.topCenter,
        children: [...previous, ?current],
      ),
      child: child,
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool loading;
  final bool confirmed;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.focusNode,
    required this.loading,
    required this.confirmed,
    required this.onChanged,
    required this.onClear,
  });

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(
              alpha: focusNode.hasFocus ? 0.14 : 0.0,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: 'Search your city, e.g. Milano',
          prefixIcon: Icon(
            confirmed ? Icons.location_on_rounded : Icons.search_rounded,
            color: confirmed ? AppColors.primary : AppColors.textMuted,
          ),
          suffixIcon: loading
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.2),
                  ),
                )
              : controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.close_rounded),
                  color: AppColors.textMuted,
                ),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: _border(AppColors.border),
          enabledBorder: _border(
            confirmed ? AppColors.primary : AppColors.border,
          ),
          focusedBorder: _border(AppColors.primary, 1.5),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  final List<PlaceSuggestion> suggestions;
  final String query;
  final ValueChanged<PlaceSuggestion> onSelect;

  const _SuggestionList({
    super.key,
    required this.suggestions,
    required this.query,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: suggestions.length,
        separatorBuilder: (_, _) =>
            const Divider(height: 1, indent: 60, color: AppColors.border),
        itemBuilder: (context, i) {
          final s = suggestions[i];
          return InkWell(
                onTap: () => onSelect(s),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.location_city_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HighlightedText(text: s.mainText, query: query),
                            if (s.area.isNotEmpty)
                              Text(
                                s.area,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textMuted),
                              ),
                          ],
                        ),
                      ),
                      if (s.country.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        _CountryTag(country: s.country),
                      ],
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: (40 * i).ms, duration: 250.ms)
              .slideX(begin: 0.06, end: 0, curve: Curves.easeOutCubic);
        },
      ),
    );
  }
}

class _CountryTag extends StatelessWidget {
  final String country;

  const _CountryTag({required this.country});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 110),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.public_rounded,
              size: 13,
              color: AppColors.textMuted,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                country,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;

  const _HighlightedText({required this.text, required this.query});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: AppColors.text,
      fontWeight: FontWeight.w500,
    );
    final q = query.trim().toLowerCase();
    final index = q.isEmpty ? -1 : text.toLowerCase().indexOf(q);
    if (index < 0) {
      return Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: base,
      );
    }
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + q.length),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          TextSpan(text: text.substring(index + q.length)),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: base,
    );
  }
}

class _SelectedCityCard extends StatelessWidget {
  final CityPlace place;

  const _SelectedCityCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded, color: Colors.white),
          ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.city,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  [
                    if ((place.region ?? '').isNotEmpty) place.region,
                    if (place.countryName.isNotEmpty) place.countryName,
                  ].join(', '),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.15, end: 0);
  }
}

class _MessageCard extends StatelessWidget {
  final String message;

  const _MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.lostPin,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.text,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}

class _ContinueButton extends StatelessWidget {
  final bool enabled;
  final bool saving;
  final String label;
  final VoidCallback onPressed;

  const _ContinueButton({
    required this.enabled,
    required this.saving,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled && !saving ? onPressed : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        disabledBackgroundColor: AppColors.border,
        disabledForegroundColor: AppColors.textMuted,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: saving
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(label),
      ),
    );
  }
}

class _PinIllustration extends StatefulWidget {
  final bool confirmed;

  const _PinIllustration({required this.confirmed});

  @override
  State<_PinIllustration> createState() => _PinIllustrationState();
}

class _PinIllustrationState extends State<_PinIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.confirmed ? AppColors.primary : AppColors.accent;

    return SizedBox(
      width: 170,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, _) => CustomPaint(
              size: const Size(170, 170),
              painter: _PulsePainter(_pulse.value, color),
            ),
          ),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipOval(child: CustomPaint(painter: _MiniMapPainter())),
          ),
          Positioned(
            top: 50,
            child: Container(
              width: 26,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ).animate().fadeIn(delay: 450.ms),
          Positioned(
            top: 14,
            child:
                AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.elasticOut,
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Icon(
                        widget.confirmed
                            ? Icons.where_to_vote_rounded
                            : Icons.location_on_rounded,
                        key: ValueKey(widget.confirmed),
                        size: 52,
                        color: color,
                      ),
                    )
                    .animate()
                    .moveY(
                      begin: -60,
                      end: 0,
                      duration: 700.ms,
                      curve: Curves.bounceOut,
                    )
                    .fadeIn(duration: 200.ms),
          ),
        ],
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  final double t;
  final Color color;

  _PulsePainter(this.t, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    for (var i = 0; i < 2; i++) {
      final p = (t + i / 2) % 1.0;
      canvas.drawCircle(
        center,
        60 + 25 * Curves.easeOut.transform(p),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = color.withValues(alpha: (1 - p) * 0.35),
      );
    }
  }

  @override
  bool shouldRepaint(_PulsePainter oldDelegate) =>
      oldDelegate.t != t || oldDelegate.color != color;
}

class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFEAF2EE),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.6, h * 0.58, w * 0.3, h * 0.24),
        const Radius.circular(10),
      ),
      Paint()..color = const Color(0xFFD3E9DC),
    );
    canvas.drawPath(
      Path()
        ..moveTo(0, h * 0.82)
        ..cubicTo(w * 0.3, h * 0.66, w * 0.55, h * 1.0, w, h * 0.86),
      Paint()
        ..color = const Color(0xFFC6E0EA)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );
    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.56), road);
    canvas.drawLine(Offset(w * 0.42, 0), Offset(w * 0.5, h), road);
    canvas.drawLine(
      Offset(w * 0.15, h * 0.2),
      Offset(w * 0.35, h),
      road..strokeWidth = 3,
    );
    canvas.drawLine(Offset(w * 0.7, 0), Offset(w * 0.78, h * 0.55), road);
    canvas.drawCircle(
      Offset(w * 0.46, h * 0.53),
      math.min(w, h) * 0.05,
      Paint()..color = AppColors.primary.withValues(alpha: 0.25),
    );
  }

  @override
  bool shouldRepaint(_MiniMapPainter oldDelegate) => false;
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;

  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
