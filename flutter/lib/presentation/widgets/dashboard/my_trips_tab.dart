import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/trip_providers.dart';
import '../common/empty_state.dart';
import 'trip_card.dart';

class MyTripsTab extends ConsumerWidget {
  const MyTripsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 800,
            child: TabBarView(
              children: [
                _TripList(provider: upcomingTripsProvider, emptyLabel: 'upcoming'),
                _TripList(provider: pastTripsProvider, emptyLabel: 'past'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TripList extends ConsumerWidget {
  final FutureProvider provider;
  final String emptyLabel;

  const _TripList({required this.provider, required this.emptyLabel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(provider);

    return trips.when(
      data: (data) {
        final list = data as List;
        if (list.isEmpty) {
          return EmptyState(
            icon: LucideIcons.calendar,
            title: 'No $emptyLabel trips',
            subtitle: emptyLabel == 'upcoming'
                ? 'Start planning your next adventure!'
                : 'Your completed trips will appear here.',
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) => TripCard(trip: list[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
