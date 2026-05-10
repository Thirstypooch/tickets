import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../data/models/event_filter.dart';
import '../../providers/event_providers.dart';
import 'app_header.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      endDrawer: const _MobileDrawer(),
      body: child,
    );
  }
}

class _MobileDrawer extends ConsumerWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            ListTile(
              leading: const Icon(LucideIcons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.search),
              title: const Text('Explorar Eventos'),
              onTap: () {
                Navigator.pop(context);
                ref.read(eventFilterProvider.notifier).state =
                    const EventFilter();
                context.go('/events');
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.layoutDashboard),
              title: const Text('Panel'),
              onTap: () {
                Navigator.pop(context);
                context.go('/dashboard');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LucideIcons.plusCircle),
              title: const Text('Mis Entradas'),
              onTap: () {
                Navigator.pop(context);
                context.go('/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }
}
