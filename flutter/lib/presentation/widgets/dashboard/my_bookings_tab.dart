import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../providers/booking_providers.dart';
import '../common/avatar_widget.dart';
import '../common/status_badge.dart';

class MyBookingsTab extends ConsumerWidget {
  const MyBookingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Bookings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'Manage bookings for your properties',
          style: TextStyle(fontSize: 14, color: AppColors.gray500),
        ),
        const SizedBox(height: 24),
        bookings.when(
          data: (list) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Guest')),
                DataColumn(label: Text('Property')),
                DataColumn(label: Text('Dates')),
                DataColumn(label: Text('Guests')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('')),
              ],
              rows: list
                  .map((b) => DataRow(cells: [
                        DataCell(Row(
                          children: [
                            AvatarWidget(imageUrl: b.guest.avatar, size: 36),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(b.guest.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                Text(b.guest.email,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.gray500)),
                              ],
                            ),
                          ],
                        )),
                        DataCell(Text(b.property,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormatter.medium(DateTime.parse(b.checkIn)),
                              style: const TextStyle(fontSize: 13),
                            ),
                            Text(
                              'to ${DateFormatter.medium(DateTime.parse(b.checkOut))}',
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.gray500),
                            ),
                          ],
                        )),
                        DataCell(Text('${b.guests}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(Text(CurrencyFormatter.format(b.total),
                            style:
                                const TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(StatusBadge(status: b.status)),
                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (value) {},
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                  value: 'message',
                                  child: Text('Message Guest')),
                              if (b.status == 'pending') ...[
                                const PopupMenuItem(
                                    value: 'approve',
                                    child: Text('Approve')),
                                const PopupMenuItem(
                                    value: 'decline',
                                    child: Text('Decline')),
                              ],
                            ],
                            child: const Icon(LucideIcons.moreHorizontal,
                                size: 18),
                          ),
                        ),
                      ]))
                  .toList(),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }
}
