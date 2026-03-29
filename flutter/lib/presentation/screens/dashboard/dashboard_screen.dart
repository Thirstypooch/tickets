import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../widgets/dashboard/dashboard_stats_row.dart';
import '../../widgets/dashboard/my_trips_tab.dart';
import '../../widgets/dashboard/my_properties_tab.dart';
import '../../widgets/dashboard/my_bookings_tab.dart';
import '../../widgets/layout/app_footer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const DashboardStatsRow(),
                  const SizedBox(height: 32),
                  const TabBar(
                    tabs: [
                      Tab(text: 'My Trips'),
                      Tab(text: 'My Properties'),
                      Tab(text: 'My Bookings'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 900,
                    child: TabBarView(
                      children: [
                        const MyTripsTab(),
                        const MyPropertiesTab(),
                        const MyBookingsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
