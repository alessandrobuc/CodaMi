import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/pets_entity.dart';

const maleColor = Color(0xFF3B82F6);
const femaleColor = Color(0xFFE5679A);

FaIconData speciesIcon(PetSpecies species) => switch (species) {
  PetSpecies.dog => FontAwesomeIcons.dog,
  PetSpecies.cat => FontAwesomeIcons.cat,
  PetSpecies.other => FontAwesomeIcons.paw,
};

Color speciesColor(PetSpecies species) => switch (species) {
  PetSpecies.dog => AppColors.primary,
  PetSpecies.cat => AppColors.accent,
  PetSpecies.other => AppColors.primaryDark,
};

IconData? sexIcon(PetSex? sex) => switch (sex) {
  PetSex.male => Icons.male_rounded,
  PetSex.female => Icons.female_rounded,
  _ => null,
};

Color sexColor(PetSex? sex) => switch (sex) {
  PetSex.male => maleColor,
  PetSex.female => femaleColor,
  _ => AppColors.textMuted,
};

class PetImage extends StatelessWidget {
  final PetPhoto? photo;
  final BoxFit fit;

  const PetImage({super.key, required this.photo, this.fit = BoxFit.cover});

  PetImage.url(String? url, {super.key, this.fit = BoxFit.cover})
    : photo = url == null ? null : PetPhoto.remote(url);

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    if (photo == null) return const _PhotoFallback();
    if (photo.isLocal) {
      return Image.file(
        File(photo.localPath!),
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, _, _) => const _PhotoFallback(),
      );
    }
    return _RetryingNetworkImage(url: photo.url!, fit: fit);
  }
}

class _RetryingNetworkImage extends StatefulWidget {
  final String url;
  final BoxFit fit;

  const _RetryingNetworkImage({required this.url, required this.fit});

  @override
  State<_RetryingNetworkImage> createState() => _RetryingNetworkImageState();
}

class _RetryingNetworkImageState extends State<_RetryingNetworkImage> {
  static const _maxRetries = 2;
  int _attempt = 0;
  bool _retryScheduled = false;

  void _scheduleRetry() {
    if (_retryScheduled || _attempt >= _maxRetries) return;
    _retryScheduled = true;
    Future.delayed(Duration(seconds: 2 * (_attempt + 1)), () async {
      await CachedNetworkImage.evictFromCache(widget.url);
      if (!mounted) return;
      setState(() {
        _attempt++;
        _retryScheduled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey('${widget.url}#$_attempt'),
      imageUrl: widget.url,
      fit: widget.fit,
      width: double.infinity,
      height: double.infinity,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: (_, _) => const ShimmerBox(),
      errorWidget: (_, _, _) {
        _scheduleRetry();
        return _attempt < _maxRetries
            ? const ShimmerBox()
            : const _PhotoFallback();
      },
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.08),
      alignment: Alignment.center,
      child: FaIcon(
        FontAwesomeIcons.paw,
        size: 36,
        color: AppColors.primary.withValues(alpha: 0.4),
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double radius;

  const ShimmerBox({super.key, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: AppColors.border.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(radius),
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(duration: 1400.ms, color: Colors.white.withValues(alpha: 0.6));
  }
}

class FrostedPill extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const FrostedPill({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class PetCard extends StatefulWidget {
  final Pet pet;
  final VoidCallback onTap;

  const PetCard({super.key, required this.pet, required this.onTap});

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final pet = widget.pet;
    final sex = sexIcon(pet.sex);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryDark.withValues(alpha: 0.16),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: 'pet-photo-${pet.id}',
                  child: PetImage.url(pet.coverUrl),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.45, 1],
                      colors: [Colors.transparent, Color(0xCC0B1F19)],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: FrostedPill(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          speciesIcon(pet.species),
                          size: 11,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          pet.species.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (sex != null)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(sex, size: 18, color: sexColor(pet.sex)),
                    ),
                  ),
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              pet.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          if (pet.photoUrls.length > 1) ...[
                            const SizedBox(width: 6),
                            Icon(
                              Icons.photo_library_outlined,
                              size: 13,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${pet.photoUrls.length}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
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

class AddPetTile extends StatelessWidget {
  final VoidCallback onTap;

  const AddPetTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: const DashedBorderPainter(radius: 24),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Add pet',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final double radius;
  final Color color;

  const DashedBorderPainter({
    this.radius = 20,
    this.color = const Color(0xFF9FC2B5),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          (Offset.zero & size).deflate(1),
          Radius.circular(radius),
        ),
      );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 8), paint);
        distance += 14;
      }
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}

class PetGridSkeleton extends StatelessWidget {
  const PetGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 0.74,
      children: List.generate(4, (_) => const ShimmerBox(radius: 24)),
    );
  }
}
