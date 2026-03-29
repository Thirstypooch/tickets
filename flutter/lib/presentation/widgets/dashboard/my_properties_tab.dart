import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/event_providers.dart';
import '../properties/property_card.dart';

class MyPropertiesTab extends ConsumerWidget {
  const MyPropertiesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(featuredEventsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Saved Events', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text('Events you\'ve saved for later', style: TextStyle(fontSize: 14, color: AppColors.gray500)),
        const SizedBox(height: 24),
        events.when(
          data: (list) => list.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Column(
                      children: [
                        Icon(LucideIcons.heart, size: 48, color: AppColors.gray300),
                        const SizedBox(height: 16),
                        const Text('No saved events yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const Text('Save events to find them here later', style: TextStyle(color: AppColors.gray500)),
                      ],
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final cols = constraints.maxWidth >= 900 ? 3 : constraints.maxWidth >= 500 ? 2 : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 0.85,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) => EventCard(event: list[index]),
                    );
                  },
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }
}
