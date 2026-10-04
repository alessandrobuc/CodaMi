import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';

class AuthBackground extends StatefulWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3200),
  )..repeat();

  @override
  void dispose() {
    _loop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -50,
            child: _Circle(
              size: 200,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          Positioned(
            top: 180,
            left: -70,
            child: _Circle(
              size: 160,
              color: AppColors.accent.withValues(alpha: 0.12),
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _loop,
              builder: (_, _) => _PawTrail(t: _loop.value),
            ),
          ),
          Positioned.fill(child: widget.child),
        ],
      ),
    );
  }
}

class AuthHeaderContent extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool showMail;
  final bool compact;

  const AuthHeaderContent({
    super.key,
    required this.title,
    required this.subtitle,
    this.showMail = false,
    this.compact = false,
  });

  @override
  State<AuthHeaderContent> createState() => _AuthHeaderContentState();
}

class _AuthHeaderContentState extends State<AuthHeaderContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3200),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _pulse,
          builder: (_, child) =>
              CustomPaint(painter: _PulsePainter(_pulse.value), child: child),
          child: Container(
            width: widget.compact ? 68 : 88,
            height: widget.compact ? 68 : 88,
            padding: EdgeInsets.all(widget.compact ? 8 : 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: widget.showMail
                  ? Icon(
                      Icons.mark_email_unread_rounded,
                      key: const ValueKey('mail'),
                      size: widget.compact ? 32 : 40,
                      color: AppColors.accent,
                    )
                  : Image.asset(AppAssets.logo, key: const ValueKey('logo')),
            ),
          ),
        ).animate().scale(duration: 700.ms, curve: Curves.elasticOut),
        SizedBox(height: widget.compact ? 10 : 14),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: Column(
            key: ValueKey(widget.title),
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (!widget.compact) ...[
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class AuthSheet extends StatelessWidget {
  final Widget child;

  const AuthSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _SheetPainter(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          16,
          20,
          MediaQuery.paddingOf(context).bottom + 16,
        ),
        child: child,
      ),
    );
  }
}

class _SheetPainter extends CustomPainter {
  const _SheetPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(0, 24)
      ..quadraticBezierTo(w * 0.25, 64, w * 0.5, 40)
      ..quadraticBezierTo(w * 0.78, 12, w, 48)
      ..lineTo(w, h + 2000)
      ..lineTo(0, h + 2000)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.background);
  }

  @override
  bool shouldRepaint(_SheetPainter oldDelegate) => false;
}

class _PulsePainter extends CustomPainter {
  final double t;

  _PulsePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final base = size.width / 2;
    for (var i = 0; i < 2; i++) {
      final p = (t + i / 2) % 1.0;
      canvas.drawCircle(
        center,
        base + 34 * Curves.easeOut.transform(p),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = Colors.white.withValues(alpha: (1 - p) * 0.4),
      );
    }
  }

  @override
  bool shouldRepaint(_PulsePainter oldDelegate) => oldDelegate.t != t;
}

class _PawTrail extends StatelessWidget {
  final double t;

  const _PawTrail({required this.t});

  static const _steps = [
    Offset(0.06, 0.32),
    Offset(0.13, 0.26),
    Offset(0.19, 0.2),
    Offset(0.82, 0.28),
    Offset(0.88, 0.2),
    Offset(0.94, 0.12),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          for (var i = 0; i < _steps.length; i++)
            Positioned(
              left: _steps[i].dx * constraints.maxWidth,
              top: _steps[i].dy * constraints.maxHeight,
              child: Opacity(
                opacity: _stepOpacity(i % 3),
                child: Transform.rotate(
                  angle: (i < 3 ? 0.5 : -0.4) + (i.isEven ? 0.15 : -0.15),
                  child: const FaIcon(
                    FontAwesomeIcons.paw,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  double _stepOpacity(int i) {
    final phase = (t - i * 0.18) % 1.0;
    return 0.22 * math.max(0, math.sin(phase * math.pi * 1.6)).clamp(0.0, 1.0);
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;

  const _Circle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class AuthModeToggle extends StatelessWidget {
  final bool isLogin;
  final ValueChanged<bool> onChanged;

  const AuthModeToggle({
    super.key,
    required this.isLogin,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              _ToggleLabel(
                label: 'Log In',
                selected: isLogin,
                onTap: () => onChanged(true),
              ),
              _ToggleLabel(
                label: 'Sign Up',
                selected: !isLogin,
                onTap: () => onChanged(false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToggleLabel extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleLabel({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: selected ? Colors.white : AppColors.textMuted,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final GlobalKey<FormFieldState<String>>? fieldKey;

  const AuthTextField({
    super.key,
    this.fieldKey,
    this.onChanged,
    required this.controller,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscured = true;

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword && _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
        prefixIconColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.error)) return AppColors.danger;
          if (states.contains(WidgetState.focused)) return AppColors.primary;
          return AppColors.textMuted;
        }),
        suffixIcon: widget.isPassword
            ? ExcludeFocus(
                child: IconButton(
                  onPressed: () => setState(() => _obscured = !_obscured),
                  icon: Icon(
                    _obscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textMuted,
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
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

class SpamNote extends StatelessWidget {
  const SpamNote({super.key});

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
              "Can't find the reset email? Check your Spam or Junk folder, it sometimes lands there.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.text,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String asset;
  final String label;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.asset,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.text,
        minimumSize: const Size.fromHeight(50),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        side: const BorderSide(color: AppColors.border),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(asset, width: 22, height: 22),
          const SizedBox(width: 12),
          Flexible(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
