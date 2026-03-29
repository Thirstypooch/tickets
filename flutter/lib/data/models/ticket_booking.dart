/// Matches NestJS BookingResponse — a ticket reservation.
/// Replaces both the old Trip and Booking models.
class TicketBooking {
  final String id;
  final String userId;
  final String tmEventId;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String status; // 'confirmed' | 'pending' | 'completed' | 'cancelled'
  final String createdAt;
  final EventSnapshot eventSnapshot;

  const TicketBooking({
    required this.id,
    required this.userId,
    required this.tmEventId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.eventSnapshot,
  });

  factory TicketBooking.fromJson(Map<String, dynamic> json) {
    // Handle both REST (flat) and GraphQL (nested) formats
    final snapshot = json['eventSnapshot'] != null
        ? EventSnapshot.fromJson(json['eventSnapshot'])
        : EventSnapshot(
            name: json['event_name'] as String? ?? '',
            date: json['event_date'] as String? ?? '',
            venueName: json['event_venue_name'] as String? ?? '',
            city: json['event_city'] as String? ?? '',
            image: json['event_image'] as String? ?? '',
          );

    return TicketBooking(
      id: json['id'] as String,
      userId: json['userId'] as String? ?? json['user_id'] as String? ?? '',
      tmEventId: json['tmEventId'] as String? ?? json['tm_event_id'] as String? ?? '',
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ??
          double.tryParse(json['unit_price']?.toString() ?? '0') ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ??
          double.tryParse(json['total_price']?.toString() ?? '0') ?? 0,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String? ?? json['created_at'] as String? ?? '',
      eventSnapshot: snapshot,
    );
  }
}

/// Denormalized event data frozen at booking time.
class EventSnapshot {
  final String name;
  final String date;
  final String venueName;
  final String city;
  final String image;

  const EventSnapshot({
    required this.name,
    required this.date,
    required this.venueName,
    required this.city,
    required this.image,
  });

  factory EventSnapshot.fromJson(Map<String, dynamic> json) {
    return EventSnapshot(
      name: json['name'] as String,
      date: json['date'] as String,
      venueName: json['venueName'] as String,
      city: json['city'] as String,
      image: json['image'] as String,
    );
  }
}
