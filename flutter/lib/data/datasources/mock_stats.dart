import 'package:lucide_icons/lucide_icons.dart';
import '../models/dashboard_stat.dart';

class MockStats {
  MockStats._();

  static final all = [
    DashboardStat(
      title: 'Total Trips',
      value: '12',
      icon: LucideIcons.calendar,
      description: 'Completed bookings',
      trend: '+2 this month',
    ),
    DashboardStat(
      title: 'Properties Listed',
      value: '3',
      icon: LucideIcons.home,
      description: 'Active listings',
      trend: '+1 this month',
    ),
    DashboardStat(
      title: 'Total Earnings',
      value: '\$4,250',
      icon: LucideIcons.dollarSign,
      description: 'This year',
      trend: '+15% from last year',
    ),
    DashboardStat(
      title: 'Average Rating',
      value: '4.9',
      icon: LucideIcons.star,
      description: 'Across all properties',
      trend: 'Excellent rating',
    ),
  ];
}
