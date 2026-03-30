import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/theme_providers.dart';

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 768;

    return AppBar(
      toolbarHeight: 64,
      leading: null,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.home, size: 24, color: AppColors.brand),
            const SizedBox(width: 8),
            const Text(
              'TICKETS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (isDesktop) ...[
          TextButton(
            onPressed: () => context.go('/events'),
            child: const Text('Events'),
          ),
          TextButton(
            onPressed: () => context.go('/dashboard'),
            child: const Text('Dashboard'),
          ),
        ],
        // Theme toggle
        IconButton(
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? LucideIcons.sun
                : LucideIcons.moon,
            size: 20,
          ),
          onPressed: () {
            final current = ref.read(themeModeProvider);
            ref.read(themeModeProvider.notifier).state =
                current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
          },
        ),
        if (!isDesktop)
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(LucideIcons.menu, size: 20),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
      ],
    );
  }
}
