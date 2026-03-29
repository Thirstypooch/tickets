import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../providers/event_providers.dart';
import '../../widgets/properties/property_gallery.dart';
import '../../widgets/properties/property_reviews_section.dart';
import '../../widgets/properties/booking_widget.dart';
import '../../widgets/layout/app_footer.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(eventDetailProvider(widget.eventId));
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppSpacing.breakpointLg;

    return detail.when(
      data: (event) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sub-header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.gray200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => context.go('/events'),
                    icon: const Icon(LucideIcons.arrowLeft, size: 16),
                    label: const Text('Back to events'),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.share, size: 16),
                        label: const Text('Share'),
                      ),
                      TextButton.icon(
                        onPressed: () => setState(() => _isFavorited = !_isFavorited),
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
                  // Category + Status
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.brand.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          event.category,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brand,
                          ),
                        ),
                      ),
                      if (event.genre.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(event.genre, style: const TextStyle(fontSize: 13, color: AppColors.gray500)),
                      ],
                    ],
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    event.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
                  const SizedBox(height: 8),

                  // Date + Venue + City
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.calendar, size: 16, color: AppColors.gray500),
                          const SizedBox(width: 6),
                          Text(
                            '${event.date}${event.time != null ? ' at ${event.time!.substring(0, 5)}' : ''}',
                            style: const TextStyle(fontSize: 15, color: AppColors.gray600),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.mapPin, size: 16, color: AppColors.gray500),
                          const SizedBox(width: 6),
                          Text(
                            '${event.venueName}, ${event.location}',
                            style: const TextStyle(fontSize: 15, color: AppColors.gray600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Gallery
                  PropertyGallery(images: event.images)
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 100.ms),
                  const SizedBox(height: 32),

                  // Main content
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Description
                              if (event.description.isNotEmpty) ...[
                                const Text(
                                  'About this event',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  event.description,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.gray600,
                                    height: 1.6,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Divider(),
                                const SizedBox(height: 24),
                              ],

                              // Venue info
                              if (event.venue != null) ...[
                                const Text(
                                  'Venue',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 12),
                                _VenueCard(venue: event.venue!),
                                const SizedBox(height: 24),
                                const Divider(),
                                const SizedBox(height: 24),
                              ],

                              // Attractions
                              if (event.attractions.isNotEmpty) ...[
                                const Text(
                                  'Performers',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: event.attractions
                                      .map((a) => Chip(label: Text(a.name)))
                                      .toList(),
                                ),
                                const SizedBox(height: 24),
                                const Divider(),
                                const SizedBox(height: 24),
                              ],

                              // Reviews
                              PropertyReviewsSection(
                                reviews: event.reviews,
                                rating: event.averageRating ?? 0,
                                reviewCount: event.reviewCount,
                              ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        SizedBox(
                          width: 380,
                          child: TicketBookingWidget(
                            eventId: event.id,
                            priceMin: event.priceMin,
                            priceMax: event.priceMax,
                            ticketmasterUrl: event.url,
                          ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
                        ),
                      ],
                    )
                  else ...[
                    if (event.description.isNotEmpty) ...[
                      const Text('About this event', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      Text(event.description, style: const TextStyle(fontSize: 15, color: AppColors.gray600, height: 1.6)),
                      const SizedBox(height: 24),
                    ],
                    if (event.venue != null) ...[
                      const Text('Venue', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      _VenueCard(venue: event.venue!),
                      const SizedBox(height: 24),
                    ],
                    TicketBookingWidget(
                      eventId: event.id,
                      priceMin: event.priceMin,
                      priceMax: event.priceMax,
                      ticketmasterUrl: event.url,
                    ),
                    const SizedBox(height: 32),
                    PropertyReviewsSection(
                      reviews: event.reviews,
                      rating: event.averageRating ?? 0,
                      reviewCount: event.reviewCount,
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

class _VenueCard extends StatelessWidget {
  final dynamic venue;
  const _VenueCard({required this.venue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray200),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(venue.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          if (venue.address.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(LucideIcons.mapPin, size: 14, color: AppColors.gray500),
                const SizedBox(width: 6),
                Text('${venue.address}, ${venue.location}', style: const TextStyle(fontSize: 14, color: AppColors.gray500)),
              ],
            ),
          ],
          if (venue.timezone.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(LucideIcons.clock, size: 14, color: AppColors.gray500),
                const SizedBox(width: 6),
                Text(venue.timezone, style: const TextStyle(fontSize: 14, color: AppColors.gray500)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
