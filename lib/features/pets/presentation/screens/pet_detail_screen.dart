import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../domain/entities/pets_entity.dart';
import '../../domain/repositories/pets_repository.dart';
import '../providers/pets_provider.dart';
import '../widgets/pets_widget.dart';
import 'pet_form_screen.dart';

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

class PetDetailScreen extends ConsumerStatefulWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  ConsumerState<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends ConsumerState<PetDetailScreen> {
  final _pageController = PageController();
  int _page = 0;
  bool _deleting = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _edit(Pet pet) async {
    final name = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => PetFormScreen(pet: pet),
      ),
    );
    if (name != null && mounted) {
      if (_page >= pet.photoUrls.length) _pageController.jumpToPage(0);
      SnackbarUtils.showSuccess(context, '$name was updated.');
    }
  }

  Future<void> _delete(Pet pet) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.delete_outline_rounded,
          color: AppColors.danger,
          size: 32,
        ),
        title: Text('Remove ${pet.name}?'),
        content: const Text(
          'This deletes the profile and its photos. It can\'t be undone.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _deleting = true);
    try {
      await ref.read(petsRepositoryProvider).deletePet(pet);
      if (!mounted) return;
      Navigator.of(context).pop();
      SnackbarUtils.showSuccess(context, '${pet.name} was removed.');
    } on PetsException catch (e) {
      if (!mounted) return;
      setState(() => _deleting = false);
      SnackbarUtils.showError(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pet = ref.watch(petByIdProvider(widget.pet.id)) ?? widget.pet;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: height * 0.5,
                pinned: true,
                stretch: true,
                backgroundColor: AppColors.primaryDark,
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _GlassButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                actions: [
                  _GlassButton(
                    icon: Icons.edit_rounded,
                    onTap: _deleting ? null : () => _edit(pet),
                  ),
                  const SizedBox(width: 8),
                  _GlassButton(
                    icon: Icons.delete_outline_rounded,
                    onTap: _deleting ? null : () => _delete(pet),
                  ),
                  const SizedBox(width: 12),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: pet.photoUrls.isEmpty
                            ? 1
                            : pet.photoUrls.length,
                        onPageChanged: (i) => setState(() => _page = i),
                        itemBuilder: (_, i) {
                          final image = PetImage.url(
                            pet.photoUrls.isEmpty ? null : pet.photoUrls[i],
                          );
                          return i == 0
                              ? Hero(tag: 'pet-photo-${pet.id}', child: image)
                              : image;
                        },
                      ),
                      const IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0.25, 0.7, 1],
                              colors: [
                                Color(0x66000000),
                                Colors.transparent,
                                Colors.transparent,
                                Color(0x55000000),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (pet.photoUrls.length > 1)
                        Positioned(
                          bottom: 40,
                          left: 0,
                          right: 0,
                          child: _PageDots(
                            count: pet.photoUrls.length,
                            index: _page,
                          ),
                        ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(24),
                  child: Container(
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  MediaQuery.paddingOf(context).bottom + 24,
                ),
                sliver: SliverList.list(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.name,
                                style: textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text,
                                  height: 1.15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pet.subtitle,
                                style: textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        _SpeciesBadge(species: pet.species),
                      ],
                    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.15),
                    const SizedBox(height: 22),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.3,
                      children:
                          [
                                _InfoTile(
                                  icon: Icons.pets_rounded,
                                  color: AppColors.primary,
                                  label: 'Breed',
                                  value: pet.breed,
                                ),
                                _InfoTile(
                                  icon: Icons.palette_outlined,
                                  color: AppColors.accent,
                                  label: 'Color',
                                  value: pet.color,
                                ),
                                _InfoTile(
                                  icon: Icons.cake_outlined,
                                  color: AppColors.lostPin,
                                  label: 'Age',
                                  value: pet.age,
                                ),
                                _InfoTile(
                                  icon:
                                      sexIcon(pet.sex) ??
                                      Icons.help_outline_rounded,
                                  color: sexColor(pet.sex),
                                  label: 'Sex',
                                  value: pet.sex?.label,
                                ),
                              ]
                              .animate(interval: 60.ms)
                              .fadeIn(duration: 300.ms)
                              .scale(begin: const Offset(0.94, 0.94)),
                    ),
                    if (pet.features != null) ...[
                      const SizedBox(height: 16),
                      _FeaturesCard(
                        text: pet.features!,
                      ).animate().fadeIn(delay: 250.ms, duration: 350.ms),
                    ],
                    const SizedBox(height: 24),
                    _ReportLostCard(
                      petName: pet.name,
                    ).animate().fadeIn(delay: 300.ms, duration: 350.ms),
                    if (pet.createdAt != null) ...[
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'Added ${_months[pet.createdAt!.month - 1]} ${pet.createdAt!.day}, ${pet.createdAt!.year}',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (_deleting)
            const ColoredBox(
              color: Color(0x66000000),
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _GlassButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FrostedPill(
        padding: const EdgeInsets.all(9),
        child: Icon(icon, color: Colors.white, size: 21),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  final int count;
  final int index;

  const _PageDots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == index ? 20 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: i == index ? 1 : 0.55),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}

class _SpeciesBadge extends StatelessWidget {
  final PetSpecies species;

  const _SpeciesBadge({required this.species});

  @override
  Widget build(BuildContext context) {
    final color = speciesColor(species);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(speciesIcon(species), size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            species.label,
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String? value;

  const _InfoTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  value ?? '—',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  final String text;

  const _FeaturesCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 18,
                color: AppColors.accent,
              ),
              SizedBox(width: 8),
              Text(
                'Distinctive features',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(color: AppColors.text, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _ReportLostCard extends StatelessWidget {
  final String petName;

  const _ReportLostCard({required this.petName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lostPin.withValues(alpha: 0.1),
            AppColors.accent.withValues(alpha: 0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lostPin.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'If $petName ever goes missing',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Publish a lost report with this profile in seconds, and neighbours nearby will be alerted.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => SnackbarUtils.showInfo(
              context,
              'Lost reports are coming soon.',
            ),
            icon: const Icon(Icons.campaign_rounded),
            label: Text('Report $petName as lost'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lostPin,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
