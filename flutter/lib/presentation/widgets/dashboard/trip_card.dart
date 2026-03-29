import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/ticket_booking.dart';
import '../common/status_badge.dart';

class BookingCard extends StatelessWidget {
  final TicketBooking booking;

  const BookingCard({super.key, required this.booking});

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
                      imageUrl: booking.eventSnapshot.image,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                  Expanded(child: _Content(booking: booking)),
                ],
              ),
            );
          }
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: booking.eventSnapshot.image,
                  fit: BoxFit.cover,
                ),
              ),
              _Content(booking: booking),
            ],
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final TicketBooking booking;
  const _Content({required this.booking});

  @override
  Widget build(BuildContext context) {
    final snap = booking.eventSnapshot;

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
                      snap.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.mapPin, size: 14, color: AppColors.gray500),
                        const SizedBox(width: 4),
                        Text(
                          '${snap.venueName} · ${snap.city}',
                          style: const TextStyle(fontSize: 13, color: AppColors.gray500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.calendar, size: 14, color: AppColors.gray500),
                        const SizedBox(width: 4),
                        Text(
                          snap.date,
                          style: const TextStyle(fontSize: 13, color: AppColors.gray500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StatusBadge(status: booking.status),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${booking.quantity} ticket${booking.quantity > 1 ? 's' : ''} · \$${booking.totalPrice.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 13, color: AppColors.gray600),
              ),
              if (booking.status == 'confirmed')
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.ticket, size: 14),
                  label: const Text('View Tickets'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                ),
              if (booking.status == 'completed')
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.star, size: 14),
                  label: const Text('Leave Review'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
