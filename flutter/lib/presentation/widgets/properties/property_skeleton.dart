import 'package:flutter/material.dart';
import '../common/shimmer_widget.dart';

class PropertySkeleton extends StatelessWidget {
  const PropertySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(width: double.infinity, height: 180),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 180, height: 18),
                SizedBox(height: 8),
                ShimmerBox(width: 120, height: 14),
                SizedBox(height: 12),
                Row(
                  children: [
                    ShimmerBox(width: 24, height: 24, borderRadius: 12),
                    SizedBox(width: 8),
                    ShimmerBox(width: 100, height: 14),
                    Spacer(),
                    ShimmerBox(width: 80, height: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
