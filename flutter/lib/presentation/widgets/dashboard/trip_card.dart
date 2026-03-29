import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/trip.dart';
import '../common/status_badge.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 500;
          if (isWide) {
            return IntrinsicHeight(
              child: Row(
                children: [
                  SizedBox(
                    width: 192,
                    child: CachedNetworkImage(
                      imageUrl: trip.property.image,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                  Expanded(child: _Content(trip: trip)),
                ],
              ),
            );
          }
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: trip.property.image,
                  fit: BoxFit.cover,
                ),
              ),
              _Content(trip: trip),
            ],
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final Trip trip;
  const _Content({required this.trip});

  @override
  Widget build(BuildContext context) {
    final isUpcoming = trip.status == 'confirmed';
    final isPast = trip.status == 'completed';

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.property.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.mapPin,
                            size: 14, color: AppColors.gray500),
                        const SizedBox(width: 4),
                        Text(
                          trip.property.location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.calendar,
                            size: 14, color: AppColors.gray500),
                        const SizedBox(width: 4),
                        Text(
                          '${trip.checkIn} - ${trip.checkOut}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StatusBadge(status: trip.status),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${trip.guests} guests · Total: ${CurrencyFormatter.format(trip.total)}',
                style: const TextStyle(fontSize: 13, color: AppColors.gray600),
              ),
              if (isPast && trip.rating != null)
                Row(
                  children: [
                    const Icon(LucideIcons.star,
                        size: 14, color: AppColors.starYellow),
                    const SizedBox(width: 4),
                    Text(
                      '${trip.rating}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              if (isUpcoming)
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.messageCircle, size: 14),
                  label: const Text('Contact Host'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                ),
              if (isPast && trip.rating == null)
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.star, size: 14),
                  label: const Text('Leave Review'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
