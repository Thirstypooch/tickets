import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/booking_providers.dart';
import '../common/status_badge.dart';

class MyBookingsTab extends ConsumerWidget {
  const MyBookingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(allBookingsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('All Bookings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text('Your complete booking history', style: TextStyle(fontSize: 14, color: AppColors.gray500)),
        const SizedBox(height: 24),
        bookings.when(
          data: (list) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Event')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Venue')),
                DataColumn(label: Text('Tickets')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Status')),
              ],
              rows: list.map((b) => DataRow(cells: [
                DataCell(Text(b.eventSnapshot.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                DataCell(Text(b.eventSnapshot.date)),
                DataCell(Text(b.eventSnapshot.venueName)),
                DataCell(Text('${b.quantity}', style: const TextStyle(fontWeight: FontWeight.w500))),
                DataCell(Text('\$${b.totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w500))),
                DataCell(StatusBadge(status: b.status)),
              ])).toList(),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }
}
