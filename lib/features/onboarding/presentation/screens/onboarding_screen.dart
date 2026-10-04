import 'package:CodaMi/features/auth/presentation/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_constants.dart';
import '../widgets/onboarding_illustrations.dart';

class _OnboardingPage {
  final String title;
  final String highlight;
  final String subtitle;
  final Color tint;
  final Widget Function(bool active) illustration;

  const _OnboardingPage({
    required this.title,
    required this.highlight,
    required this.subtitle,
    required this.tint,
    required this.illustration,
  });
}

final _pages = [
  _OnboardingPage(
    title: 'Every pet deserves\na ',
    highlight: 'way home',
    subtitle:
        'CodaMi connects neighbours so lost dogs and cats find their way back to the people who love them.',
    tint: AppColors.primary,
    illustration: (active) => CommunityRadarIllustration(active: active),
  ),
  _OnboardingPage(
    title: 'Report a pet\nin ',
    highlight: 'seconds',
    subtitle:
        'Snap a photo, drop the location and publish a lost or found report. Everyone nearby sees it instantly.',
    tint: AppColors.accent,
    illustration: (active) => ReportCardIllustration(active: active),
  ),
  _OnboardingPage(
    title: 'See who\'s\n',
    highlight: 'nearby',
    subtitle:
        'Lost and found pets around you, live on one map, so you always know where to look.',
    tint: AppColors.lostPin,
    illustration: (active) => NearbyMapIllustration(active: active),
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  bool get _isLastPage => _currentPage == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLastPage) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, _, _) => const AuthScreen(),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutQuint,
      );
    }
  }

  double get _page =>
      _controller.hasClients && _controller.position.haveDimensions
      ? _controller.page ?? 0
      : _currentPage.toDouble();

  Color _tintAt(double page) {
    final i = page.floor().clamp(0, _pages.length - 1);
    final j = (i + 1).clamp(0, _pages.length - 1);
    return Color.lerp(_pages[i].tint, _pages[j].tint, page - i)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final tint = _tintAt(_page);
          return Stack(
            children: [
              Positioned(
                top: -120,
                right: -100,
                child: _Blob(size: 340, color: tint.withValues(alpha: 0.14)),
              ),
              Positioned(
                top: 180,
                left: -140,
                child: _Blob(size: 260, color: tint.withValues(alpha: 0.08)),
              ),
              child!,
            ],
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              _TopBar(
                showSkip: !_isLastPage,
                onSkip: () => _controller.animateToPage(
                  _pages.length - 1,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutQuint,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) => _OnboardingPageView(
                    page: _pages[index],
                    index: index,
                    controller: _controller,
                    active: index == _currentPage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 8, 24, 28),
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: _pages.length,
                      effect: const ExpandingDotsEffect(
                        spacing: 8,
                        dotColor: AppColors.border,
                        activeDotColor: AppColors.primary,
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3.5,
                      ),
                    ),
                    const Spacer(),
                    _NextButton(expanded: _isLastPage, onPressed: _next),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.4, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool showSkip;
  final VoidCallback onSkip;

  const _TopBar({required this.showSkip, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 0),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Image.asset(AppAssets.logo, width: 34, height: 34),
            const SizedBox(width: 8),
            Text(
              'CodaMi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark,
              ),
            ),
            const Spacer(),
            AnimatedOpacity(
              opacity: showSkip ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: !showSkip,
                child: TextButton(
                  onPressed: onSkip,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _OnboardingPageView extends StatelessWidget {
  final _OnboardingPage page;
  final int index;
  final PageController controller;
  final bool active;

  const _OnboardingPageView({
    required this.page,
    required this.index,
    required this.controller,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final scroll =
            controller.hasClients && controller.position.haveDimensions
            ? controller.page ?? 0
            : 0.0;
        final delta = (index - scroll).clamp(-1.0, 1.0);
        final width = MediaQuery.sizeOf(context).width;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Transform.translate(
                    offset: Offset(delta * width * 0.35, 0),
                    child: Transform.scale(
                      scale: 1 - delta.abs() * 0.15,
                      child: FittedBox(child: page.illustration(active)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: Opacity(
                  opacity: (1 - delta.abs() * 1.6).clamp(0.0, 1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                            TextSpan(
                              text: page.title,
                              children: [
                                TextSpan(
                                  text: page.highlight,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                              height: 1.2,
                            ),
                          )
                          .animate(target: active ? 1 : 0)
                          .fadeIn(duration: 500.ms)
                          .slideY(
                            begin: 0.3,
                            end: 0,
                            curve: Curves.easeOutQuint,
                          ),
                      const SizedBox(height: 14),
                      Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.textMuted,
                              height: 1.5,
                            ),
                          )
                          .animate(target: active ? 1 : 0)
                          .fadeIn(delay: 120.ms, duration: 500.ms)
                          .slideY(
                            begin: 0.3,
                            end: 0,
                            curve: Curves.easeOutQuint,
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  final bool expanded;
  final VoidCallback onPressed;

  const _NextButton({required this.expanded, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutBack,
        height: 60,
        width: expanded ? 170 : 60,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: expanded
              ? const FittedBox(
                  key: ValueKey('start'),
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Get Started',
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                )
              : const Icon(
                  Icons.arrow_forward_rounded,
                  key: ValueKey('next'),
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
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
