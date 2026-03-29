import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../search/search_bar.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.7;
    return SizedBox(
      height: height.clamp(400, 700),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          CachedNetworkImage(
            imageUrl:
                'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=1200&h=800&fit=crop',
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: AppColors.gray800),
            errorWidget: (_, __, ___) => Container(color: AppColors.gray800),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Live Events. Real Moments.',
                  style: AppTypography.display.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.2, duration: 800.ms),
                const SizedBox(height: 16),
                Text(
                  'Concerts, sports, theatre & more — find your next experience',
                  style: AppTypography.bodyLg.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 200.ms)
                    .slideY(begin: 0.2, duration: 800.ms, delay: 200.ms),
                const SizedBox(height: 32),
                const SizedBox(
                  width: 600,
                  child: CribsSearchBar(),
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 400.ms)
                    .slideY(begin: 0.2, duration: 800.ms, delay: 400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
