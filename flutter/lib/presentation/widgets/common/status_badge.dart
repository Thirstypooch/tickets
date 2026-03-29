import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor) = _colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  (Color, Color) get _colors {
    switch (status) {
      case 'confirmed':
      case 'published':
        return (AppColors.brand.withValues(alpha: 0.1), AppColors.brand);
      case 'pending':
        return (AppColors.warningOrange.withValues(alpha: 0.1), AppColors.warningOrange);
      case 'completed':
        return (AppColors.successGreen.withValues(alpha: 0.1), AppColors.successGreen);
      default:
        return (AppColors.gray100, AppColors.gray600);
    }
  }
}
