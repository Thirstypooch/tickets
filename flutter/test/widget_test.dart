import 'package:flutter_test/flutter_test.dart';
import 'package:cribs_flutter/core/utils/booking_calculator.dart';

void main() {
  group('BookingCalculator', () {
    test('calculates correct breakdown for 3 nights at \$250', () {
      final result = BookingCalculator.calculate(
        pricePerNight: 250,
        checkIn: DateTime(2024, 2, 15),
        checkOut: DateTime(2024, 2, 18),
      );

      expect(result.nights, 3);
      expect(result.subtotal, 750.0);
      expect(result.serviceFee, closeTo(105.0, 0.01)); // 750 * 0.14
      expect(result.taxes, closeTo(60.0, 0.01)); // 750 * 0.08
      expect(result.total, closeTo(915.0, 0.01)); // 750 + 105 + 60
    });

    test('returns zero for same-day checkout', () {
      final result = BookingCalculator.calculate(
        pricePerNight: 250,
        checkIn: DateTime(2024, 2, 15),
        checkOut: DateTime(2024, 2, 15),
      );

      expect(result.nights, 0);
      expect(result.total, 0);
    });

    test('handles single night', () {
      final result = BookingCalculator.calculate(
        pricePerNight: 100,
        checkIn: DateTime(2024, 1, 1),
        checkOut: DateTime(2024, 1, 2),
      );

      expect(result.nights, 1);
      expect(result.subtotal, 100.0);
      expect(result.serviceFee, closeTo(14.0, 0.01));
      expect(result.taxes, closeTo(8.0, 0.01));
      expect(result.total, closeTo(122.0, 0.01));
    });
  });
}
