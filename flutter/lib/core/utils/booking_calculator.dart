/// Pricing logic extracted from booking-widget.tsx:26-30.
class BookingPriceBreakdown {
  final int nights;
  final double subtotal;
  final double serviceFee;
  final double taxes;
  final double total;

  const BookingPriceBreakdown({
    required this.nights,
    required this.subtotal,
    required this.serviceFee,
    required this.taxes,
    required this.total,
  });
}

class BookingCalculator {
  BookingCalculator._();

  static const double serviceFeeRate = 0.14; // 14%
  static const double taxRate = 0.08; // 8%

  static BookingPriceBreakdown calculate({
    required int pricePerNight,
    required DateTime checkIn,
    required DateTime checkOut,
  }) {
    final nights = checkOut.difference(checkIn).inDays;
    if (nights <= 0) {
      return const BookingPriceBreakdown(
        nights: 0,
        subtotal: 0,
        serviceFee: 0,
        taxes: 0,
        total: 0,
      );
    }

    final subtotal = (nights * pricePerNight).toDouble();
    final serviceFee = subtotal * serviceFeeRate;
    final taxes = subtotal * taxRate;
    final total = subtotal + serviceFee + taxes;

    return BookingPriceBreakdown(
      nights: nights,
      subtotal: subtotal,
      serviceFee: serviceFee,
      taxes: taxes,
      total: total,
    );
  }
}
