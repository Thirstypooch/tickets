import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/event.dart';

/// Event card — used in featured grid and events list.
class EventCard extends StatelessWidget {
  final EventSummary event;
  final int? animationIndex;

  const EventCard({
    super.key,
    required this.event,
    this.animationIndex,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = GestureDetector(
      onTap: () => context.go('/events/${event.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with category badge
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: event.image,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.gray200),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.gray200,
                      child: const Icon(LucideIcons.image, color: AppColors.gray400),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.brand.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        event.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (event.priceMin != null)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          'From \$${event.priceMin!.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(LucideIcons.calendar, size: 13, color: AppColors.gray500),
                      const SizedBox(width: 4),
                      Text(event.date, style: const TextStyle(fontSize: 13, color: AppColors.gray500)),
                      if (event.time != null) ...[
                        const Text(' · ', style: TextStyle(color: AppColors.gray400)),
                        Text(event.time!.substring(0, 5), style: const TextStyle(fontSize: 13, color: AppColors.gray500)),
                      ],
                    ],
                  ),
                  if (event.venueName.isNotEmpty || event.city.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.mapPin, size: 13, color: AppColors.gray500),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            [event.venueName, event.location].where((s) => s.isNotEmpty).join(' · '),
                            style: const TextStyle(fontSize: 13, color: AppColors.gray500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (animationIndex != null) {
      card = card
          .animate()
          .fadeIn(duration: 500.ms, delay: (animationIndex! * 100).ms)
          .slideY(begin: 0.1, duration: 500.ms, delay: (animationIndex! * 100).ms);
    }

    return card;
  }
}
