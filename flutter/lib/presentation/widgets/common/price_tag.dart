import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PriceTag extends StatelessWidget {
  final int price;

  const PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\$$price',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.gray900,
            ),
          ),
          const TextSpan(
            text: ' / night',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
