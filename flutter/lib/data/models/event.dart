import 'venue.dart';
import 'review.dart';

/// Matches NestJS EventSummaryDto — used in list/card views.
class EventSummary {
  final String id;
  final String name;
  final String date;
  final String? time;
  final String image;
  final String city;
  final String state;
  final String venueName;
  final String category;
  final String genre;
  final double? priceMin;
  final double? priceMax;
  final String currency;
  final String status;
  final String url;
  final bool? isFavorited;

  const EventSummary({
    required this.id,
    required this.name,
    required this.date,
    this.time,
    required this.image,
    required this.city,
    required this.state,
    required this.venueName,
    required this.category,
    this.genre = '',
    this.priceMin,
    this.priceMax,
    this.currency = 'USD',
    required this.status,
    required this.url,
    this.isFavorited,
  });

  String get location => state.isNotEmpty ? '$city, $state' : city;

  String get priceDisplay {
    if (priceMin == null) return 'See Ticketmaster';
    if (priceMax != null && priceMax != priceMin) {
      return '\$${priceMin!.toStringAsFixed(0)} - \$${priceMax!.toStringAsFixed(0)}';
    }
    return 'From \$${priceMin!.toStringAsFixed(0)}';
  }

  factory EventSummary.fromJson(Map<String, dynamic> json) {
    return EventSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      time: json['time'] as String?,
      image: json['image'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      venueName: json['venueName'] as String,
      category: json['category'] as String,
      genre: json['genre'] as String? ?? '',
      priceMin: (json['priceMin'] as num?)?.toDouble(),
      priceMax: (json['priceMax'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      status: json['status'] as String,
      url: json['url'] as String,
      isFavorited: json['isFavorited'] as bool?,
    );
  }
}

/// Matches NestJS EventDetailDto — full event page.
class EventDetail extends EventSummary {
  final bool dateTBD;
  final List<String> images;
  final String description;
  final String? note;
  final String? salesStart;
  final String? salesEnd;
  final List<Attraction> attractions;
  final Venue? venue;
  final List<Review> reviews;
  final int reviewCount;
  final double? averageRating;
  final List<EventSummary> similarEvents;

  const EventDetail({
    required super.id,
    required super.name,
    required super.date,
    super.time,
    required super.image,
    required super.city,
    required super.state,
    required super.venueName,
    required super.category,
    super.genre,
    super.priceMin,
    super.priceMax,
    super.currency,
    required super.status,
    required super.url,
    super.isFavorited,
    this.dateTBD = false,
    required this.images,
    required this.description,
    this.note,
    this.salesStart,
    this.salesEnd,
    this.attractions = const [],
    this.venue,
    this.reviews = const [],
    this.reviewCount = 0,
    this.averageRating,
    this.similarEvents = const [],
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      time: json['time'] as String?,
      image: json['image'] as String? ?? '',
      city: json['city'] as String,
      state: json['state'] as String,
      venueName: json['venueName'] as String,
      category: json['category'] as String,
      genre: json['genre'] as String? ?? '',
      priceMin: (json['priceMin'] as num?)?.toDouble(),
      priceMax: (json['priceMax'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      status: json['status'] as String,
      url: json['url'] as String,
      dateTBD: json['dateTBD'] as bool? ?? false,
      images: (json['images'] as List?)?.cast<String>() ?? [],
      description: json['description'] as String? ?? '',
      note: json['note'] as String?,
      salesStart: json['salesStart'] as String?,
      salesEnd: json['salesEnd'] as String?,
      attractions: (json['attractions'] as List?)
              ?.map((a) => Attraction.fromJson(a))
              .toList() ??
          [],
      venue: json['venue'] != null ? Venue.fromJson(json['venue']) : null,
      reviews: (json['reviews'] as List?)
              ?.map((r) => Review.fromJson(r))
              .toList() ??
          [],
      reviewCount: json['reviewCount'] as int? ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      similarEvents: (json['similarEvents'] as List?)
              ?.map((e) => EventSummary.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Attraction {
  final String id;
  final String name;

  const Attraction({required this.id, required this.name});

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
