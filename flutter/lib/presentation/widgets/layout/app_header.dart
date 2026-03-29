import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/auth_providers.dart';
import '../../providers/theme_providers.dart';

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuth = ref.watch(isAuthenticatedProvider);
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
              'CRIBS',
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
            onPressed: () => context.go('/properties'),
            child: const Text('Explore'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Become a Host'),
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
        if (isAuth) ...[
          PopupMenuButton<String>(
            offset: const Offset(0, 48),
            onSelected: (value) {
              switch (value) {
                case 'dashboard':
                  context.go('/dashboard');
                case 'properties':
                  context.go('/properties');
                case 'logout':
                  ref.read(isAuthenticatedProvider.notifier).state = false;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'dashboard', child: Text('Dashboard')),
              const PopupMenuItem(value: 'properties', child: Text('My Properties')),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 'logout', child: Text('Log Out')),
            ],
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.brand,
                child: Icon(LucideIcons.user, size: 16, color: Colors.white),
              ),
            ),
          ),
        ] else ...[
          TextButton(
            onPressed: () {
              ref.read(isAuthenticatedProvider.notifier).state = true;
            },
            child: const Text('Log In'),
          ),
          if (isDesktop)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(isAuthenticatedProvider.notifier).state = true;
                },
                child: const Text('Sign Up'),
              ),
            ),
        ],
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
