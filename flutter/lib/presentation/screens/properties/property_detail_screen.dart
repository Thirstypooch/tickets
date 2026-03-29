import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../providers/property_providers.dart';
import '../../widgets/properties/property_gallery.dart';
import '../../widgets/properties/property_details_section.dart';
import '../../widgets/properties/property_reviews_section.dart';
import '../../widgets/properties/booking_widget.dart';
import '../../widgets/layout/app_footer.dart';

class PropertyDetailScreen extends ConsumerStatefulWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  ConsumerState<PropertyDetailScreen> createState() =>
      _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends ConsumerState<PropertyDetailScreen> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(propertyDetailProvider(widget.propertyId));
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppSpacing.breakpointLg;

    return detail.when(
      data: (property) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sub-header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.gray200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => context.go('/properties'),
                    icon: const Icon(LucideIcons.arrowLeft, size: 16),
                    label: const Text('Back to properties'),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.share, size: 16),
                        label: const Text('Share'),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            setState(() => _isFavorited = !_isFavorited),
                        icon: Icon(
                          LucideIcons.heart,
                          size: 16,
                          color: _isFavorited ? AppColors.heartRed : null,
                        ),
                        label: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
                  const SizedBox(height: 4),
                  Text(
                    property.location,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Gallery
                  PropertyGallery(images: property.images)
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 100.ms)
                      .slideY(begin: 0.1, delay: 100.ms),
                  const SizedBox(height: 32),

                  // Main content
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: details + reviews
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              PropertyDetailsSection(property: property)
                                  .animate()
                                  .fadeIn(duration: 500.ms, delay: 200.ms),
                              const SizedBox(height: 48),
                              PropertyReviewsSection(
                                reviews: property.reviews,
                                rating: property.rating,
                                reviewCount: property.reviewCount,
                              ).animate()
                                  .fadeIn(duration: 500.ms, delay: 300.ms),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        // Right: booking widget
                        SizedBox(
                          width: 380,
                          child: BookingWidget(
                            price: property.price,
                            rating: property.rating,
                            reviewCount: property.reviewCount,
                          ).animate()
                              .fadeIn(duration: 500.ms, delay: 400.ms),
                        ),
                      ],
                    )
                  else ...[
                    // Mobile: stacked
                    PropertyDetailsSection(property: property),
                    const SizedBox(height: 32),
                    BookingWidget(
                      price: property.price,
                      rating: property.rating,
                      reviewCount: property.reviewCount,
                    ),
                    const SizedBox(height: 32),
                    PropertyReviewsSection(
                      reviews: property.reviews,
                      rating: property.rating,
                      reviewCount: property.reviewCount,
                    ),
                  ],
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
