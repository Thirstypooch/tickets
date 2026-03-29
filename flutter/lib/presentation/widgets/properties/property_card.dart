import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/property.dart';
import '../common/avatar_widget.dart';
import '../common/star_rating.dart';
import '../common/price_tag.dart';

class PropertyCard extends StatelessWidget {
  final PropertySummary property;
  final int? animationIndex;

  const PropertyCard({
    super.key,
    required this.property,
    this.animationIndex,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = GestureDetector(
      onTap: () => context.go('/properties/${property.id}'),
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
            // Image with rating badge
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: property.image,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.gray200),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.gray200,
                      child: const Icon(LucideIcons.image, color: AppColors.gray400),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: RatingBadge(rating: property.rating),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(LucideIcons.mapPin, size: 14, color: AppColors.gray500),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.gray500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      AvatarWidget(imageUrl: property.host.avatar, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          property.host.name,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.gray600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      PriceTag(price: property.price),
                    ],
                  ),
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
