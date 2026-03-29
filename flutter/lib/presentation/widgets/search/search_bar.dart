import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import 'search_dialog.dart';

class CribsSearchBar extends StatelessWidget {
  final bool compact;

  const CribsSearchBar({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openSearch(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 16 : 24,
          vertical: compact ? 10 : 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(compact ? 24 : 32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: compact ? 8 : 16,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.gray200),
        ),
        child: Row(
          mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Icon(
              LucideIcons.search,
              size: compact ? 18 : 20,
              color: AppColors.gray500,
            ),
            SizedBox(width: compact ? 8 : 12),
            if (!compact) ...[
              Expanded(
                child: Row(
                  children: [
                    _SearchSection('Where', 'Search destinations'),
                    _Divider(),
                    _SearchSection('Check in', 'Add dates'),
                    _Divider(),
                    _SearchSection('Check out', 'Add dates'),
                    _Divider(),
                    _SearchSection('Who', 'Add guests'),
                  ],
                ),
              ),
            ] else
              const Text(
                'Search destinations',
                style: TextStyle(fontSize: 14, color: AppColors.gray500),
              ),
          ],
        ),
      ),
    );
  }

  void _openSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SearchDialog(),
    );
  }
}

class _SearchSection extends StatelessWidget {
  final String label;
  final String placeholder;

  const _SearchSection(this.label, this.placeholder);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              placeholder,
              style: const TextStyle(fontSize: 13, color: AppColors.gray400),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28,
      color: AppColors.gray200,
    );
  }
}
