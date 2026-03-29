/// Matches NestJS VenueDto.
class Venue {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;
  final double? latitude;
  final double? longitude;
  final String timezone;
  final String imageUrl;

  const Venue({
    required this.id,
    required this.name,
    this.address = '',
    required this.city,
    this.state = '',
    this.country = '',
    this.latitude,
    this.longitude,
    this.timezone = '',
    this.imageUrl = '',
  });

  String get location => state.isNotEmpty ? '$city, $state' : city;

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String? ?? '',
      city: json['city'] as String,
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      timezone: json['timezone'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}
