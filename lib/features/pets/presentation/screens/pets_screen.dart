import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/pets_entity.dart';
import '../providers/pets_provider.dart';
import '../widgets/pets_widget.dart';
import 'pet_detail_screen.dart';
import 'pet_form_screen.dart';

class PetsScreen extends ConsumerWidget {
  const PetsScreen({super.key});

  Future<void> _addPet(BuildContext context) async {
    final name = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const PetFormScreen(),
      ),
    );
    if (name != null && context.mounted) {
      SnackbarUtils.showSuccess(context, '$name was added to your pets.');
    }
  }

  void _openPet(BuildContext context, Pet pet) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PetDetailScreen(pet: pet)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsState = ref.watch(myPetsProvider);
    final pets = petsState.value ?? const <Pet>[];
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            bottom: false,
            sliver: SliverToBoxAdapter(
              child: _Header(
                count: petsState.hasValue ? pets.length : null,
                onAdd: () => _addPet(context),
              ),
            ),
          ),
          if (petsState.isLoading && !petsState.hasValue)
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
              sliver: PetGridSkeleton(),
            )
          else if (petsState.hasError && !petsState.hasValue)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: EmptyState(
                    icon: Icon(Icons.cloud_off_rounded),
                    color: AppColors.lostPin,
                    title: 'Couldn\'t load your pets',
                    message: 'Check your connection and try again.',
                  ),
                ),
              ),
            )
          else if (pets.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset),
                  child: EmptyState(
                    icon: const Icon(Icons.pets_rounded),
                    color: AppColors.accent,
                    title: 'No pets yet',
                    message:
                        'Add your pets now so you can report them in seconds if they ever get lost.',
                    action: ElevatedButton.icon(
                      onPressed: () => _addPet(context),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Add your first pet'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.74,
                ),
                itemCount: pets.length + 1,
                itemBuilder: (context, i) {
                  final child = i == pets.length
                      ? AddPetTile(onTap: () => _addPet(context))
                      : PetCard(
                          key: ValueKey(pets[i].id),
                          pet: pets[i],
                          onTap: () => _openPet(context, pets[i]),
                        );
                  return child
                      .animate()
                      .fadeIn(delay: (60 * i).ms, duration: 400.ms)
                      .slideY(
                        begin: 0.12,
                        end: 0,
                        delay: (60 * i).ms,
                        curve: Curves.easeOutCubic,
                      );
                },
              ),
            ),
          SliverToBoxAdapter(child: SizedBox(height: bottomInset + 16)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int? count;
  final VoidCallback onAdd;

  const _Header({required this.count, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitle = switch (count) {
      null || 0 => 'Keep your pets\' profiles ready, just in case.',
      1 => '1 furry friend, ready if anything happens.',
      final n => '$n furry friends, ready if anything happens.',
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My pets',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    subtitle,
                    key: ValueKey(subtitle),
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if ((count ?? 0) > 0) ...[
            const SizedBox(width: 12),
            _AddButton(
              onTap: onAdd,
            ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
          ],
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
