import 'host.dart';
import 'review.dart';

class PropertySummary {
  final String id;
  final String title;
  final String location;
  final int price;
  final double rating;
  final String image;
  final Host host;

  const PropertySummary({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
    required this.host,
  });
}

class PropertyDetail {
  final String id;
  final String title;
  final String location;
  final int price;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final HostDetail host;
  final List<String> amenities;
  final String description;
  final int maxGuests;
  final int bedrooms;
  final int bathrooms;
  final List<Review> reviews;

  const PropertyDetail({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.host,
    required this.amenities,
    required this.description,
    required this.maxGuests,
    required this.bedrooms,
    required this.bathrooms,
    required this.reviews,
  });
}

/// Used in the dashboard "My Properties" table.
class HostProperty {
  final String id;
  final String name;
  final String location;
  final String status; // 'published' | 'pending'
  final int bookings;
  final double? rating;
  final String earnings;
  final String image;

  const HostProperty({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.bookings,
    this.rating,
    required this.earnings,
    required this.image,
  });
}
