import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/models/dashboard_stat.dart';

final dashboardStatsProvider = Provider<List<DashboardStat>>((ref) {
  return [
    DashboardStat(
      title: 'Events Attended',
      value: '8',
      icon: LucideIcons.calendar,
      description: 'Total bookings',
      trend: '2 upcoming',
    ),
    DashboardStat(
      title: 'Upcoming Events',
      value: '2',
      icon: LucideIcons.ticket,
      description: 'Confirmed reservations',
      trend: 'You have plans!',
    ),
    DashboardStat(
      title: 'Total Spent',
      value: '\$2,248',
      icon: LucideIcons.dollarSign,
      description: 'Lifetime spending',
      trend: 'Keep exploring',
    ),
    DashboardStat(
      title: 'Average Rating',
      value: '4.7',
      icon: LucideIcons.star,
      description: 'Your review average',
      trend: '6 reviews given',
    ),
  ];
});
