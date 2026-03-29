import 'package:flutter/material.dart';

class DashboardStat {
  final String title;
  final String value;
  final IconData icon;
  final String description;
  final String trend;

  const DashboardStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.description,
    required this.trend,
  });
}
