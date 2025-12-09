import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../features/generation/presentation/providers/generation_provider.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';

class GalleryGrid extends ConsumerWidget {
  const GalleryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generationState = ref.watch(generationProvider);

    return Container(
      decoration: const BoxDecoration(gradient: AppColors.bgLightGradient),
      padding: const EdgeInsets.all(AppDimensions.p32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🌟 My Coloring Pages',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement PDF Export
                    },
                    icon: const FaIcon(FontAwesomeIcons.filePdf, size: 20),
                    label: const Text('Export to PDF'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textDark,
                      side: const BorderSide(color: AppColors.borderMedium),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.r12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.p16),
                  TextButton.icon(
                    onPressed: () {
                      ref.read(authRepositoryProvider).signOut();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      size: 20,
                    ),
                    label: const Text('Sign Out'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textMedium,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.p32),

          // Grid Content
          Expanded(
            child: generationState.when(
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.primaryStart),
                    SizedBox(height: 20),
                    Text(
                      'Creating Magic...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.triangleExclamation,
                      size: 48,
                      color: AppColors.primaryStart,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Oops! Magic failed: $err',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textDark),
                    ),
                  ],
                ),
              ),
              data: (images) {
                if (images.isEmpty) {
                  // Show mock grid for initial state
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: AppDimensions.p24,
                          mainAxisSpacing: AppDimensions.p24,
                        ),
                    itemCount: 6,
                    itemBuilder: (context, index) => _buildMockCard(index),
                  );
                }

                // Show generated images
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: AppDimensions.p24,
                    mainAxisSpacing: AppDimensions.p24,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final imageUrl = images[index];
                    return _buildImageCard(imageUrl, index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.r20),
        border: Border.all(color: AppColors.borderMedium, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryStart.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(17),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: FaIcon(
                      FontAwesomeIcons.image,
                      size: 40,
                      color: AppColors.textMedium,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Page ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Text(
                    'Just now',
                    style: TextStyle(fontSize: 12, color: AppColors.textMedium),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.r20),
        border: Border.all(color: AppColors.borderMedium, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryStart.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(17), // 20 - 3 border
                ),
              ),
              child: const Center(
                child: Text('🦄', style: TextStyle(fontSize: 48)),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mock Page ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Text(
                    'Tap "Create"',
                    style: TextStyle(fontSize: 12, color: AppColors.textMedium),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
