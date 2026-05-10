import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/datasources/mock_destinations.dart';
import '../../../data/models/event_filter.dart';
import '../../providers/event_providers.dart';
import 'destination_card.dart';

class ExploreDestinationsGrid extends ConsumerWidget {
  const ExploreDestinationsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = MockDestinations.all;
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            final destination = destinations[index];
            return DestinationCard(
              destination: destination,
              onTap: () {
                ref.read(eventFilterProvider.notifier).state =
                    EventFilter(city: destination.name);
                context.go('/events');
              },
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: (index * 100).ms)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  duration: 500.ms,
                  delay: (index * 100).ms,
                );
          },
        );
      },
    );
  }
}
