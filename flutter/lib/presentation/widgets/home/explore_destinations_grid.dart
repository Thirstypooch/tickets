import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../data/datasources/mock_destinations.dart';
import 'destination_card.dart';

class ExploreDestinationsGrid extends StatelessWidget {
  const ExploreDestinationsGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
            return DestinationCard(destination: destinations[index])
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
