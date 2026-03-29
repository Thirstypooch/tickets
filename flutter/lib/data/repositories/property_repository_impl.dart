import '../datasources/mock_properties.dart';
import '../models/property.dart';
import '../models/property_filter.dart';
import 'property_repository.dart';

class MockPropertyRepository implements PropertyRepository {
  @override
  Future<List<PropertySummary>> getProperties() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return MockProperties.listing;
  }

  @override
  Future<List<PropertySummary>> getFeaturedProperties() async {
    return MockProperties.featured;
  }

  @override
  Future<PropertyDetail> getPropertyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // For now, always return the single mock detail
    return MockProperties.detail;
  }

  @override
  Future<List<PropertySummary>> filterProperties(
    List<PropertySummary> properties,
    PropertyFilter filter,
  ) async {
    return properties.where((p) {
      final inPriceRange =
          p.price >= filter.priceRange.start && p.price <= filter.priceRange.end;
      return inPriceRange;
    }).toList();
  }

  @override
  Future<List<HostProperty>> getHostProperties() async {
    return const [
      HostProperty(
        id: '1',
        name: 'Modern Loft in Downtown',
        location: 'New York, NY',
        status: 'published',
        bookings: 12,
        rating: 4.9,
        earnings: '\$3,200',
        image: 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&fit=crop',
      ),
      HostProperty(
        id: '2',
        name: 'Beach House in Malibu',
        location: 'Malibu, CA',
        status: 'published',
        bookings: 8,
        rating: 4.8,
        earnings: '\$2,800',
        image: 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&fit=crop',
      ),
      HostProperty(
        id: '3',
        name: 'Mountain Cabin Retreat',
        location: 'Aspen, CO',
        status: 'pending',
        bookings: 0,
        rating: null,
        earnings: '\$0',
        image: 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&fit=crop',
      ),
    ];
  }
}
