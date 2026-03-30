import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../widgets/dashboard/dashboard_stats_row.dart';
import '../../widgets/dashboard/my_trips_tab.dart';
import '../../widgets/dashboard/my_properties_tab.dart';
import '../../widgets/dashboard/my_bookings_tab.dart';
import '../../widgets/layout/app_footer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),
                const DashboardStatsRow(),
                const SizedBox(height: 32),
                // Simple segmented control instead of TabBar
                Row(
                  children: [
                    _TabButton('My Events', 0),
                    const SizedBox(width: 8),
                    _TabButton('Saved', 1),
                    const SizedBox(width: 8),
                    _TabButton('History', 2),
                  ],
                ),
                const SizedBox(height: 24),
                // Show selected tab content directly (no TabBarView)
                if (_selectedTab == 0) const MyTripsTab(),
                if (_selectedTab == 1) const MyPropertiesTab(),
                if (_selectedTab == 2) const MyBookingsTab(),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _TabButton(String label, int index) {
    final selected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4F46E5) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? const Color(0xFF4F46E5) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
