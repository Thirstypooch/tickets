import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray900,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.home, size: 20, color: AppColors.brand),
              const SizedBox(width: 8),
              const Text(
                'TICKETS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Discover and book live events, concerts, sports & more.',
            style: TextStyle(fontSize: 14, color: AppColors.gray400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Powered by Ticketmaster',
            style: TextStyle(fontSize: 12, color: AppColors.gray500),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.gray700),
          const SizedBox(height: 12),
          const Text(
            '\u00a9 2026 TICKETS. All rights reserved.',
            style: TextStyle(fontSize: 12, color: AppColors.gray500),
          ),
        ],
      ),
    );
  }
}
