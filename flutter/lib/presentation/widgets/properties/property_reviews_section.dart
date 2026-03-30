import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/review.dart';
import '../common/avatar_widget.dart';
import '../common/star_rating.dart';

class PropertyReviewsSection extends StatelessWidget {
  final List<Review> reviews;
  final double rating;
  final int reviewCount;

  const PropertyReviewsSection({
    super.key,
    required this.reviews,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            const Icon(LucideIcons.star, size: 20, color: AppColors.starYellow),
            const SizedBox(width: 6),
            Text(
              '$rating',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '· $reviewCount reviews',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.gray600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Empty state
        if (reviews.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: const Center(
              child: Column(
                children: [
                  Icon(LucideIcons.messageSquare, size: 40, color: AppColors.gray300),
                  SizedBox(height: 12),
                  Text('No reviews yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.gray500)),
                  SizedBox(height: 4),
                  Text('Be the first to share your experience!', style: TextStyle(fontSize: 14, color: AppColors.gray400)),
                ],
              ),
            ),
          ),

        // Review cards
        if (reviews.isNotEmpty)
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;
            if (isWide) {
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: reviews
                    .map((r) => SizedBox(
                          width: (constraints.maxWidth - 24) / 2,
                          child: _ReviewCard(review: r),
                        ))
                    .toList(),
              );
            }
            return Column(
              children: reviews
                  .map((r) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _ReviewCard(review: r),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

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
          Row(
            children: [
              AvatarWidget(imageUrl: review.user.avatar, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateFormatter.medium(DateTime.parse(review.date)),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ),
              StarRating(rating: review.rating, size: 14),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.gray600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
