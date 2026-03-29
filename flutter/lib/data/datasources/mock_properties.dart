import '../models/property.dart';
import '../models/host.dart';
import '../models/review.dart';

class MockProperties {
  MockProperties._();

  /// 4 featured properties from featured-properties.tsx
  static const featured = [
    PropertySummary(
      id: '1',
      title: 'Modern Loft in Downtown',
      location: 'New York, NY',
      price: 250,
      rating: 4.9,
      image: 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=800&h=600&fit=crop',
      host: Host(
        name: 'Sarah Johnson',
        avatar: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
      ),
    ),
    PropertySummary(
      id: '2',
      title: 'Cozy Beach House',
      location: 'Malibu, CA',
      price: 400,
      rating: 4.8,
      image: 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=800&h=600&fit=crop',
      host: Host(
        name: 'Mike Chen',
        avatar: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
      ),
    ),
    PropertySummary(
      id: '3',
      title: 'Mountain Cabin Retreat',
      location: 'Aspen, CO',
      price: 320,
      rating: 4.9,
      image: 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=800&h=600&fit=crop',
      host: Host(
        name: 'Emma Wilson',
        avatar: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
      ),
    ),
    PropertySummary(
      id: '4',
      title: 'Urban Studio Apartment',
      location: 'San Francisco, CA',
      price: 180,
      rating: 4.7,
      image: 'https://images.pexels.com/photos/2029667/pexels-photo-2029667.jpeg?auto=compress&cs=tinysrgb&w=800&h=600&fit=crop',
      host: Host(
        name: 'David Park',
        avatar: 'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
      ),
    ),
  ];

  /// 6 listing properties from properties/page.tsx
  static const listing = [
    ...featured,
    PropertySummary(
      id: '5',
      title: 'Luxury Penthouse',
      location: 'Miami, FL',
      price: 600,
      rating: 4.9,
      image: 'https://images.pexels.com/photos/1643383/pexels-photo-1643383.jpeg?auto=compress&cs=tinysrgb&w=800&h=600&fit=crop',
      host: Host(
        name: 'Lisa Rodriguez',
        avatar: 'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
      ),
    ),
    PropertySummary(
      id: '6',
      title: 'Historic Brownstone',
      location: 'Boston, MA',
      price: 280,
      rating: 4.6,
      image: 'https://images.pexels.com/photos/1571468/pexels-photo-1571468.jpeg?auto=compress&cs=tinysrgb&w=800&h=600&fit=crop',
      host: Host(
        name: 'James Wilson',
        avatar: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
      ),
    ),
  ];

  /// Full detail for property ID 1, from properties/[id]/page.tsx
  static final detail = PropertyDetail(
    id: '1',
    title: 'Modern Loft in Downtown Manhattan',
    location: 'New York, NY',
    price: 250,
    rating: 4.9,
    reviewCount: 127,
    images: const [
      'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=1200&h=800&fit=crop',
      'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=600&h=400&fit=crop',
      'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=600&h=400&fit=crop',
      'https://images.pexels.com/photos/2029667/pexels-photo-2029667.jpeg?auto=compress&cs=tinysrgb&w=600&h=400&fit=crop',
      'https://images.pexels.com/photos/1643383/pexels-photo-1643383.jpeg?auto=compress&cs=tinysrgb&w=600&h=400&fit=crop',
    ],
    host: const HostDetail(
      name: 'Sarah Johnson',
      avatar: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
      joinedDate: 'Joined in 2019',
      responseRate: '100%',
      responseTime: 'Within an hour',
    ),
    amenities: const [
      'WiFi',
      'Kitchen',
      'Air Conditioning',
      'Heating',
      'Washer',
      'Dryer',
      'TV',
      'Workspace',
    ],
    description:
        'Experience the heart of Manhattan in this stunning modern loft. Located in the vibrant SoHo district, this space offers the perfect blend of luxury and comfort. The open-plan design features floor-to-ceiling windows that flood the space with natural light, exposed brick walls, and contemporary furnishings.\n\nThe fully equipped kitchen boasts high-end appliances and everything you need to prepare meals. The comfortable living area is perfect for relaxing after a day of exploring the city. The bedroom features a plush king-size bed and blackout curtains for a restful night\'s sleep.\n\nYou\'ll be just steps away from world-class shopping, dining, and entertainment. The subway is a 2-minute walk, making it easy to explore all that NYC has to offer.',
    maxGuests: 4,
    bedrooms: 2,
    bathrooms: 1,
    reviews: const [
      Review(
        id: '1',
        user: ReviewUser(
          name: 'Michael Chen',
          avatar: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
        ),
        rating: 5,
        date: '2024-01-15',
        comment: 'Amazing location and beautiful space! Sarah was incredibly responsive and helpful. The loft exceeded our expectations.',
      ),
      Review(
        id: '2',
        user: ReviewUser(
          name: 'Emma Wilson',
          avatar: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
        ),
        rating: 5,
        date: '2024-01-10',
        comment: 'Perfect for our NYC getaway. The space is exactly as described and the location cannot be beat. Highly recommend!',
      ),
      Review(
        id: '3',
        user: ReviewUser(
          name: 'David Park',
          avatar: 'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop',
        ),
        rating: 4,
        date: '2024-01-05',
        comment: 'Great place with excellent amenities. The only minor issue was some street noise, but overall a fantastic stay.',
      ),
    ],
  );
}
