import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';

class GuestCounter extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;

  const GuestCounter({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$value ${value == 1 ? 'guest' : 'guests'}',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        _CounterButton(
          icon: LucideIcons.minus,
          onTap: value > min ? () => onChanged(value - 1) : null,
        ),
        const SizedBox(width: 8),
        _CounterButton(
          icon: LucideIcons.plus,
          onTap: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CounterButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: disabled ? AppColors.gray200 : AppColors.gray300,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: disabled ? AppColors.gray300 : AppColors.gray700,
        ),
      ),
    );
  }
}
