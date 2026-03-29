import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/property_filter.dart';
import '../../providers/filter_providers.dart';

class PropertyFiltersPanel extends ConsumerStatefulWidget {
  const PropertyFiltersPanel({super.key});

  @override
  ConsumerState<PropertyFiltersPanel> createState() =>
      _PropertyFiltersPanelState();
}

class _PropertyFiltersPanelState extends ConsumerState<PropertyFiltersPanel> {
  late RangeValues _priceRange;
  late String _propertyType;
  late List<String> _selectedAmenities;

  @override
  void initState() {
    super.initState();
    final filter = ref.read(filterProvider);
    _priceRange = filter.priceRange;
    _propertyType = filter.propertyType;
    _selectedAmenities = List.from(filter.selectedAmenities);
  }

  void _apply() {
    ref.read(filterProvider.notifier).state = PropertyFilter(
      priceRange: _priceRange,
      propertyType: _propertyType,
      selectedAmenities: _selectedAmenities,
    );
  }

  void _clear() {
    setState(() {
      _priceRange = const RangeValues(0, 1000);
      _propertyType = 'all';
      _selectedAmenities = [];
    });
    ref.read(filterProvider.notifier).state = const PropertyFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filters',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),

          // Price Range
          const Text(
            'Price Range',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 1000,
            divisions: 100,
            activeColor: AppColors.brand,
            onChanged: (v) => setState(() => _priceRange = v),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${_priceRange.start.round()}',
                  style: const TextStyle(fontSize: 13, color: AppColors.gray600)),
              Text('\$${_priceRange.end.round()}+',
                  style: const TextStyle(fontSize: 13, color: AppColors.gray600)),
            ],
          ),
          const SizedBox(height: 24),

          // Property Type
          const Text(
            'Property Type',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          ...PropertyFilter.propertyTypeOptions.map((type) => RadioListTile<String>(
            title: Text(type.label, style: const TextStyle(fontSize: 14)),
            value: type.value,
            groupValue: _propertyType,
            onChanged: (v) => setState(() => _propertyType = v!),
            dense: true,
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.brand,
          )),
          const SizedBox(height: 24),

          // Amenities
          const Text(
            'Amenities',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          ...PropertyFilter.amenityOptions.map((amenity) => CheckboxListTile(
            title: Text(amenity, style: const TextStyle(fontSize: 14)),
            value: _selectedAmenities.contains(amenity),
            onChanged: (checked) {
              setState(() {
                if (checked == true) {
                  _selectedAmenities.add(amenity);
                } else {
                  _selectedAmenities.remove(amenity);
                }
              });
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.brand,
            controlAffinity: ListTileControlAffinity.leading,
          )),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // Action buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _apply,
              child: const Text('Apply Filters'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _clear,
              child: const Text('Clear All'),
            ),
          ),
        ],
      ),
    );
  }
}
