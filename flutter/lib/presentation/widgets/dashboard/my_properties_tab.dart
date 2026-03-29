import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/property_providers.dart';
import '../common/status_badge.dart';

class MyPropertiesTab extends ConsumerWidget {
  const MyPropertiesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostProperties = ref.watch(hostPropertiesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Properties',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage your property listings',
                  style: TextStyle(fontSize: 14, color: AppColors.gray500),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.plus, size: 16),
              label: const Text('Add New Property'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        hostProperties.when(
          data: (properties) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Property')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Bookings')),
                DataColumn(label: Text('Rating')),
                DataColumn(label: Text('Earnings')),
                DataColumn(label: Text('')),
              ],
              rows: properties
                  .map((p) => DataRow(cells: [
                        DataCell(Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: p.image,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(p.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                Text(p.location,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.gray500)),
                              ],
                            ),
                          ],
                        )),
                        DataCell(StatusBadge(status: p.status)),
                        DataCell(Text('${p.bookings}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(
                          p.rating != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(LucideIcons.star,
                                        size: 14,
                                        color: AppColors.starYellow),
                                    const SizedBox(width: 4),
                                    Text('${p.rating}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )
                              : const Text('No ratings yet',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.gray400)),
                        ),
                        DataCell(Text(p.earnings,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (value) {},
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                  value: 'view', child: Text('View')),
                              const PopupMenuItem(
                                  value: 'edit', child: Text('Edit')),
                              const PopupMenuItem(
                                  value: 'archive', child: Text('Archive')),
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
