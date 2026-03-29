import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../providers/booking_form_providers.dart';
import '../common/guest_counter.dart';

/// Ticket booking widget for event detail page.
/// Replaces the old property booking widget (dates + guests → quantity + buy).
class TicketBookingWidget extends ConsumerWidget {
  final String eventId;
  final double? priceMin;
  final double? priceMax;
  final String ticketmasterUrl;

  const TicketBookingWidget({
    super.key,
    required this.eventId,
    this.priceMin,
    this.priceMax,
    required this.ticketmasterUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(ticketQuantityProvider);
    final hasPrice = priceMin != null;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price header
          if (hasPrice)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'From \$${priceMin!.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                if (priceMax != null && priceMax != priceMin) ...[
                  const SizedBox(width: 4),
                  Text(
                    '- \$${priceMax!.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 16, color: AppColors.gray500),
                  ),
                ],
                const SizedBox(width: 8),
                const Text(
                  'per ticket',
                  style: TextStyle(fontSize: 14, color: AppColors.gray500),
                ),
              ],
            )
          else
            const Text(
              'Price TBD',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          const SizedBox(height: 20),

          // Ticket quantity
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray300),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TICKETS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                GuestCounter(
                  value: quantity,
                  onChanged: (v) =>
                      ref.read(ticketQuantityProvider.notifier).state = v,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Price breakdown
          if (hasPrice) ...[
            _PriceRow(
              '${quantity}x tickets',
              '\$${(priceMin! * quantity).toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),
            _PriceRow(
              'Service fee',
              '\$${(priceMin! * quantity * 0.14).toStringAsFixed(2)}',
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            _PriceRow(
              'Estimated total',
              '\$${(priceMin! * quantity * 1.14).toStringAsFixed(2)}',
              bold: true,
            ),
            const SizedBox(height: 16),
          ],

          // Book button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // In a real app, this creates a booking via the API
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Booking confirmed! (demo)')),
                );
              },
              icon: const Icon(LucideIcons.ticket, size: 18),
              label: const Text('Get Tickets'),
            ),
          ),
          const SizedBox(height: 8),

          // Ticketmaster link
          Center(
            child: TextButton.icon(
              onPressed: () {
                // In a real app, launch URL
              },
              icon: const Icon(LucideIcons.externalLink, size: 14),
              label: const Text('View on Ticketmaster'),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 13),
              ),
            ),
          ),

          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Powered by Ticketmaster',
              style: TextStyle(fontSize: 11, color: AppColors.gray400),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _PriceRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 16 : 14,
      fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
      color: bold ? AppColors.gray900 : AppColors.gray700,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style.copyWith(color: AppColors.gray900)),
      ],
    );
  }
}
