import '../models/ticket_booking.dart';
import 'ticket_booking_repository.dart';

class MockBookingRepository implements TicketBookingRepository {
  @override
  Future<List<TicketBooking>> getUpcoming() async {
    return const [
      TicketBooking(
        id: '1',
        userId: 'mock-user',
        tmEventId: 'vvG1iZ4mKRbmDe',
        quantity: 2,
        unitPrice: 149.50,
        totalPrice: 299.00,
        status: 'confirmed',
        createdAt: '2026-03-20T10:00:00Z',
        eventSnapshot: EventSnapshot(
          name: 'Taylor Swift | The Eras Tour',
          date: '2026-06-15',
          venueName: 'Madison Square Garden',
          city: 'New York',
          image: 'https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
        ),
      ),
      TicketBooking(
        id: '2',
        userId: 'mock-user',
        tmEventId: 'vvG1iZ4mKRbmDf',
        quantity: 4,
        unitPrice: 250.00,
        totalPrice: 1000.00,
        status: 'confirmed',
        createdAt: '2026-03-18T14:30:00Z',
        eventSnapshot: EventSnapshot(
          name: 'NBA Finals Game 5',
          date: '2026-06-20',
          venueName: 'Crypto.com Arena',
          city: 'Los Angeles',
          image: 'https://images.pexels.com/photos/2834917/pexels-photo-2834917.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
        ),
      ),
    ];
  }

  @override
  Future<List<TicketBooking>> getPast() async {
    return const [
      TicketBooking(
        id: '3',
        userId: 'mock-user',
        tmEventId: 'vvG1iZ4mKRbmDg',
        quantity: 2,
        unitPrice: 175.00,
        totalPrice: 350.00,
        status: 'completed',
        createdAt: '2026-01-10T09:00:00Z',
        eventSnapshot: EventSnapshot(
          name: 'Hamilton',
          date: '2026-01-15',
          venueName: 'CIBC Theatre',
          city: 'Chicago',
          image: 'https://images.pexels.com/photos/713149/pexels-photo-713149.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
        ),
      ),
      TicketBooking(
        id: '4',
        userId: 'mock-user',
        tmEventId: 'vvG1iZ4mKRbmDh',
        quantity: 1,
        unitPrice: 599.00,
        totalPrice: 599.00,
        status: 'completed',
        createdAt: '2025-12-01T11:00:00Z',
        eventSnapshot: EventSnapshot(
          name: 'Coachella Valley Music Festival',
          date: '2026-04-10',
          venueName: 'Empire Polo Club',
          city: 'Indio',
          image: 'https://images.pexels.com/photos/1190297/pexels-photo-1190297.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
        ),
      ),
    ];
  }

  @override
  Future<List<TicketBooking>> getAll() async {
    final upcoming = await getUpcoming();
    final past = await getPast();
    return [...upcoming, ...past];
  }

  @override
  Future<TicketBooking> createBooking({
    required String tmEventId,
    required int quantity,
    required double unitPrice,
  }) async {
    return TicketBooking(
      id: 'new-${DateTime.now().millisecondsSinceEpoch}',
      userId: 'mock-user',
      tmEventId: tmEventId,
      quantity: quantity,
      unitPrice: unitPrice,
      totalPrice: quantity * unitPrice,
      status: 'confirmed',
      createdAt: DateTime.now().toIso8601String(),
      eventSnapshot: const EventSnapshot(
        name: 'Mock Event',
        date: '2026-07-01',
        venueName: 'Mock Venue',
        city: 'Mock City',
        image: '',
      ),
    );
  }
}
