import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/property.dart';
import '../common/avatar_widget.dart';
class PropertyDetailsSection extends StatelessWidget {
  final PropertyDetail property;

  const PropertyDetailsSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Property stats
        Row(
          children: [
            Text(
              '${property.maxGuests} guests',
              style: const TextStyle(fontSize: 14, color: AppColors.gray600),
            ),
            const _Dot(),
            Text(
              '${property.bedrooms} bedrooms',
              style: const TextStyle(fontSize: 14, color: AppColors.gray600),
            ),
            const _Dot(),
            Text(
              '${property.bathrooms} bathroom${property.bathrooms > 1 ? 's' : ''}',
              style: const TextStyle(fontSize: 14, color: AppColors.gray600),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),

        // Host info
        Row(
          children: [
            AvatarWidget(imageUrl: property.host.avatar, size: 48),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hosted by ${property.host.name}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    property.host.joinedDate,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _HostStat('Response rate', property.host.responseRate),
            const SizedBox(width: 24),
            _HostStat('Response time', property.host.responseTime),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),

        // Description
        const Text(
          'About this space',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text(
          property.description,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.gray600,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),

        // Amenities
        const Text(
          'What this place offers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: property.amenities.map((amenity) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray200),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _amenityIcon(amenity),
                    size: 18,
                    color: AppColors.gray600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    amenity,
                    style: const TextStyle(fontSize: 14, color: AppColors.gray700),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  static IconData _amenityIcon(String amenity) {
    switch (amenity) {
      case 'WiFi':
        return LucideIcons.wifi;
      case 'Kitchen':
        return LucideIcons.chefHat;
      case 'Air Conditioning':
        return LucideIcons.snowflake;
      case 'Heating':
        return LucideIcons.flame;
      case 'Washer':
        return LucideIcons.shirt;
      case 'Dryer':
        return LucideIcons.wind;
      case 'TV':
        return LucideIcons.tv;
      case 'Workspace':
        return LucideIcons.laptop;
      case 'Pool':
        return LucideIcons.waves;
      case 'Parking':
        return LucideIcons.car;
      case 'Gym':
        return LucideIcons.dumbbell;
      case 'Pet Friendly':
        return LucideIcons.dog;
      case 'Balcony':
        return LucideIcons.columns;
      default:
        return LucideIcons.check;
    }
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text('·', style: TextStyle(color: AppColors.gray400, fontSize: 18)),
    );
  }
}

class _HostStat extends StatelessWidget {
  final String label;
  final String value;

  const _HostStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.gray500),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
