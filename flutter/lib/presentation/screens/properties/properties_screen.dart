import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../providers/property_providers.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/properties/property_card.dart';
import '../../widgets/properties/property_filters_panel.dart';
import '../../widgets/properties/property_skeleton.dart';
import '../../widgets/layout/app_footer.dart';

class PropertiesScreen extends ConsumerWidget {
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtered = ref.watch(filteredPropertiesProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppSpacing.breakpointLg;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Desktop filter sidebar
                if (isDesktop) ...[
                  const SizedBox(
                    width: 300,
                    child: PropertyFiltersPanel(),
                  ),
                  const SizedBox(width: 32),
                ],
                // Main content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mobile filter button
                      if (!isDesktop)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: OutlinedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DraggableScrollableSheet(
                                  initialChildSize: 0.85,
                                  minChildSize: 0.5,
                                  maxChildSize: 0.95,
                                  expand: false,
                                  builder: (context, controller) =>
                                      SingleChildScrollView(
                                    controller: controller,
                                    padding: const EdgeInsets.all(16),
                                    child: const PropertyFiltersPanel(),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(LucideIcons.slidersHorizontal, size: 16),
                            label: const Text('Filters'),
                          ),
                        ),

                      // Header
                      filtered.when(
                        data: (properties) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${properties.length} properties found',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Discover amazing places to stay around the world',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.gray500,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Grid
                            if (properties.isEmpty)
                              EmptyState(
                                icon: LucideIcons.building2,
                                title: 'No properties found',
                                subtitle:
                                    'Try adjusting your filters to see more results.',
                              )
                            else
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final crossAxisCount =
                                      constraints.maxWidth >= 900
                                          ? 3
                                          : constraints.maxWidth >= 500
                                              ? 2
                                              : 1;
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      mainAxisSpacing: 24,
                                      crossAxisSpacing: 24,
                                      childAspectRatio: 0.78,
                                    ),
                                    itemCount: properties.length,
                                    itemBuilder: (context, index) {
                                      return PropertyCard(
                                        property: properties[index],
                                        animationIndex: index,
                                      );
                                    },
                                  );
                                },
                              ),
                          ],
                        ),
                        loading: () => LayoutBuilder(
                          builder: (context, constraints) {
                            final crossAxisCount = constraints.maxWidth >= 900
                                ? 3
                                : constraints.maxWidth >= 500
                                    ? 2
                                    : 1;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 24,
                                crossAxisSpacing: 24,
                                childAspectRatio: 0.78,
                              ),
                              itemCount: 6,
                              itemBuilder: (_, __) => const PropertySkeleton(),
                            );
                          },
                        ),
                        error: (e, _) => Center(child: Text('Error: $e')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
