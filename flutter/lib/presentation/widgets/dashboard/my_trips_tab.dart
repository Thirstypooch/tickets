import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/booking_providers.dart';
import '../common/empty_state.dart';
import 'trip_card.dart';

/// Shows upcoming bookings — no nested tabs to avoid double underlines.
class MyTripsTab extends ConsumerWidget {
  const MyTripsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(upcomingBookingsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próximos Eventos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        const Text(
          'Tus reservas confirmadas',
          style: TextStyle(fontSize: 14, color: AppColors.gray500),
        ),
        const SizedBox(height: 16),
        bookings.when(
          data: (list) {
            if (list.isEmpty) {
              return const EmptyState(
                icon: LucideIcons.ticket,
                title: 'No hay eventos próximos',
                subtitle: '¡Explorá eventos y reservá tu próxima experiencia!',
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) => BookingCard(booking: list[index]),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }
}
