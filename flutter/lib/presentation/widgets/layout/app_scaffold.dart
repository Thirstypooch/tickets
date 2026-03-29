import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'app_header.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      endDrawer: _MobileDrawer(),
      body: child,
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            ListTile(
              leading: const Icon(LucideIcons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.search),
              title: const Text('Browse Events'),
              onTap: () {
                Navigator.pop(context);
                context.go('/events');
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.layoutDashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                context.go('/dashboard');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LucideIcons.plusCircle),
              title: const Text('My Tickets'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
