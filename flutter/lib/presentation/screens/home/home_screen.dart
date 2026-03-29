import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../widgets/home/hero_section.dart';
import '../../widgets/home/featured_properties_grid.dart';
import '../../widgets/home/explore_destinations_grid.dart';
import '../../widgets/layout/app_footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeroSection(),
          // Featured Properties
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Featured Properties', style: AppTypography.h1),
                const SizedBox(height: 8),
                Text(
                  'Hand-picked properties for an unforgettable experience',
                  style: AppTypography.body.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                const FeaturedPropertiesGrid(),
              ],
            ),
          ),
          // Explore Destinations
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Explore Destinations', style: AppTypography.h1),
                const SizedBox(height: 8),
                Text(
                  'Browse properties in top cities around the world',
                  style: AppTypography.body.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                const ExploreDestinationsGrid(),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
