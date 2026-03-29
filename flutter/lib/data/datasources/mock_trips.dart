import '../models/trip.dart';

class MockTrips {
  MockTrips._();

  static const upcoming = [
    Trip(
      id: '1',
      property: TripProperty(
        title: 'Modern Loft in Downtown',
        location: 'New York, NY',
        image: 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
      ),
      checkIn: '2024-02-15',
      checkOut: '2024-02-18',
      guests: 2,
      total: 750,
      status: 'confirmed',
    ),
    Trip(
      id: '2',
      property: TripProperty(
        title: 'Beach House in Malibu',
        location: 'Malibu, CA',
        image: 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
      ),
      checkIn: '2024-03-10',
      checkOut: '2024-03-15',
      guests: 4,
      total: 2000,
      status: 'confirmed',
    ),
  ];

  static const past = [
    Trip(
      id: '3',
      property: TripProperty(
        title: 'Mountain Cabin Retreat',
        location: 'Aspen, CO',
        image: 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
      ),
      checkIn: '2024-01-05',
      checkOut: '2024-01-10',
      guests: 3,
      total: 1600,
      status: 'completed',
      rating: 5,
    ),
    Trip(
      id: '4',
      property: TripProperty(
        title: 'Urban Studio Apartment',
        location: 'San Francisco, CA',
        image: 'https://images.pexels.com/photos/2029667/pexels-photo-2029667.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&fit=crop',
      ),
      checkIn: '2023-12-20',
      checkOut: '2023-12-25',
      guests: 2,
      total: 900,
      status: 'completed',
      rating: 4,
    ),
  ];
}
