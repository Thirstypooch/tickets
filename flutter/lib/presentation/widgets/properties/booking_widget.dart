import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/booking_calculator.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../providers/booking_form_providers.dart';
import '../common/date_picker_field.dart';
import '../common/guest_counter.dart';
class BookingWidget extends ConsumerWidget {
  final int price;
  final double rating;
  final int reviewCount;

  const BookingWidget({
    super.key,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIn = ref.watch(checkInProvider);
    final checkOut = ref.watch(checkOutProvider);
    final guests = ref.watch(guestsProvider);

    final hasDateRange = checkIn != null && checkOut != null;
    final breakdown = hasDateRange
        ? BookingCalculator.calculate(
            pricePerNight: price,
            checkIn: checkIn,
            checkOut: checkOut,
          )
        : null;

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
          // Price and rating header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$$price',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray900,
                      ),
                    ),
                    const TextSpan(
                      text: ' night',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(LucideIcons.star,
                      size: 14, color: AppColors.starYellow),
                  const SizedBox(width: 4),
                  Text(
                    '$rating',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '· $reviewCount reviews',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Date selection
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray300),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: DatePickerField(
                      label: 'Check in',
                      value: checkIn,
                      onChanged: (d) =>
                          ref.read(checkInProvider.notifier).state = d,
                    ),
                  ),
                ),
                Container(width: 1, height: 50, color: AppColors.gray300),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: DatePickerField(
                      label: 'Check out',
                      value: checkOut,
                      onChanged: (d) =>
                          ref.read(checkOutProvider.notifier).state = d,
                      firstDate: checkIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Guests
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
                  'GUESTS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                GuestCounter(
                  value: guests,
                  onChanged: (v) =>
                      ref.read(guestsProvider.notifier).state = v,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Reserve button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: hasDateRange ? () {} : null,
              child: Text(
                hasDateRange ? 'Reserve' : 'Check availability',
              ),
            ),
          ),

          // Price breakdown
          if (breakdown != null && breakdown.nights > 0) ...[
            const SizedBox(height: 12),
            Center(
              child: Text(
                "You won't be charged yet",
                style: TextStyle(fontSize: 13, color: AppColors.gray500),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            _PriceRow(
              '\$$price x ${breakdown.nights} nights',
              CurrencyFormatter.formatDecimal(breakdown.subtotal),
            ),
            const SizedBox(height: 8),
            _PriceRow(
              'Service fee',
              CurrencyFormatter.formatDecimal(breakdown.serviceFee),
            ),
            const SizedBox(height: 8),
            _PriceRow(
              'Taxes',
              CurrencyFormatter.formatDecimal(breakdown.taxes),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            _PriceRow(
              'Total',
              CurrencyFormatter.formatDecimal(breakdown.total),
              bold: true,
            ),
          ],
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
