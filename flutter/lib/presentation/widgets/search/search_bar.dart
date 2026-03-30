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
            SizedBox(width: compact ? 8 : 16),
            Flexible(
              child: Text(
                'Search events, artists, venues...',
                style: TextStyle(
                  fontSize: compact ? 14 : 15,
                  color: AppColors.gray500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
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
