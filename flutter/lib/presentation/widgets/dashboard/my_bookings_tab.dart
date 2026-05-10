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
        const Text('Todas las Reservas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text('Tu historial completo de reservas', style: TextStyle(fontSize: 14, color: AppColors.gray500)),
        const SizedBox(height: 24),
        bookings.when(
          data: (list) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Evento')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Lugar')),
                DataColumn(label: Text('Entradas')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Estado')),
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
