import 'package:flutter/material.dart';

class PropertyFilter {
  final RangeValues priceRange;
  final String propertyType;
  final List<String> selectedAmenities;

  const PropertyFilter({
    this.priceRange = const RangeValues(0, 1000),
    this.propertyType = 'all',
    this.selectedAmenities = const [],
  });

  PropertyFilter copyWith({
    RangeValues? priceRange,
    String? propertyType,
    List<String>? selectedAmenities,
  }) {
    return PropertyFilter(
      priceRange: priceRange ?? this.priceRange,
      propertyType: propertyType ?? this.propertyType,
      selectedAmenities: selectedAmenities ?? this.selectedAmenities,
    );
  }

  static const List<String> amenityOptions = [
    'WiFi',
    'Kitchen',
    'Pool',
    'Parking',
    'Air Conditioning',
    'Gym',
    'Pet Friendly',
    'Balcony',
  ];

  static const List<({String value, String label})> propertyTypeOptions = [
    (value: 'all', label: 'All Types'),
    (value: 'apartment', label: 'Apartment'),
    (value: 'house', label: 'House'),
    (value: 'loft', label: 'Loft'),
    (value: 'condo', label: 'Condo'),
  ];
}
