import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/mock_stats.dart';
import '../../data/models/dashboard_stat.dart';

final dashboardStatsProvider = Provider<List<DashboardStat>>((ref) {
  return MockStats.all;
});
