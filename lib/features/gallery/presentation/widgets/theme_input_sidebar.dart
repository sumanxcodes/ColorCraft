import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';

class ThemeInputSidebar extends StatelessWidget {
  const ThemeInputSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.sidebarWidth,
      decoration: const BoxDecoration(
        gradient: AppColors.sidebarGradient,
        border: Border(
          right: BorderSide(color: AppColors.borderLight, width: 2),
        ),
      ),
      padding: const EdgeInsets.all(AppDimensions.p24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Logo Section
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.p12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const FaIcon(
                  FontAwesomeIcons.palette,
                  color: AppColors.primaryStart,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppDimensions.p16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ColorCraft Kids',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      'Create Your Magic!',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.p48),

          // 2. Theme Input
          const Text(
            '🎭 What do you want to draw?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppDimensions.p12),
          TextField(
            decoration: InputDecoration(
              hintText: 'e.g. A magical forest...',
              prefixIcon: const Padding(
                padding: EdgeInsets.all(12),
                child: FaIcon(
                  FontAwesomeIcons.wandMagicSparkles,
                  color: AppColors.textMedium,
                  size: 18,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.r16),
                borderSide: const BorderSide(
                  color: AppColors.borderLight,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.r16),
                borderSide: const BorderSide(
                  color: AppColors.borderLight,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.r16),
                borderSide: const BorderSide(
                  color: AppColors.primaryStart,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(AppDimensions.p16),
            ),
          ),

          const SizedBox(height: AppDimensions.p24),

          // 3. Child Name Input
          const Text(
            '👤 Your Name (Optional)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppDimensions.p8),
          TextField(
            decoration: InputDecoration(
              hintText: 'e.g. Emma',
              prefixIcon: const Padding(
                padding: EdgeInsets.all(12),
                child: FaIcon(
                  FontAwesomeIcons.userPen,
                  color: AppColors.textMedium,
                  size: 16,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.r12),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.r12),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              contentPadding: const EdgeInsets.all(AppDimensions.p12),
            ),
          ),

          const SizedBox(height: AppDimensions.p32),

          // 4. Quick Theme Chips
          const Text(
            '⚡ Quick Ideas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppDimensions.p12),
          Wrap(
            spacing: AppDimensions.p8,
            runSpacing: AppDimensions.p8,
            children: [
              _buildChip(FontAwesomeIcons.horse, 'Unicorns'),
              _buildChip(FontAwesomeIcons.dragon, 'Dragons'),
              _buildChip(FontAwesomeIcons.rocket, 'Space'),
              _buildChip(FontAwesomeIcons.wandMagicSparkles, 'Fairies'),
              _buildChip(FontAwesomeIcons.paw, 'Animals'),
              _buildChip(FontAwesomeIcons.water, 'Ocean'),
            ],
          ),

          const Spacer(),

          // 5. Generate Button
          Container(
            height: AppDimensions.buttonHeight,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppDimensions.r24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryEnd.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // TODO: Implement generation flow
                },
                borderRadius: BorderRadius.circular(AppDimensions.r24),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: AppDimensions.p8),
                    Text(
                      'Create Magic Pages!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return ActionChip(
      avatar: FaIcon(icon, size: 16, color: AppColors.textMedium),
      label: Text(label),
      backgroundColor: Colors.white,
      side: const BorderSide(color: AppColors.borderMedium),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      onPressed: () {
        // TODO: Populate prompt
      },
    );
  }
}
