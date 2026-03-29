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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section
          Wrap(
            spacing: 48,
            runSpacing: 32,
            children: [
              // Brand
              SizedBox(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _SocialIcon(LucideIcons.facebook),
                        _SocialIcon(LucideIcons.twitter),
                        _SocialIcon(LucideIcons.instagram),
                        _SocialIcon(LucideIcons.linkedin),
                      ],
                    ),
                  ],
                ),
              ),
              // Company links
              _FooterColumn(
                title: 'Company',
                links: const ['About', 'Careers', 'Press', 'Blog'],
              ),
              // Support links
              _FooterColumn(
                title: 'Support',
                links: const ['Help Center', 'Contact Us', 'Safety', 'Terms'],
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(color: AppColors.gray700),
          const SizedBox(height: 16),
          const Text(
            '\u00a9 2026 TICKETS. All rights reserved.',
            style: TextStyle(fontSize: 12, color: AppColors.gray500),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Icon(icon, size: 18, color: AppColors.gray400),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            link,
            style: const TextStyle(fontSize: 14, color: AppColors.gray400),
          ),
        )),
      ],
    );
  }
}
