import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/events/events_screen.dart';
import '../../presentation/screens/events/event_detail_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/widgets/layout/app_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/events',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: EventsScreen(),
          ),
        ),
        GoRoute(
          path: '/events/:id',
          pageBuilder: (context, state) => NoTransitionPage(
            child: EventDetailScreen(
              eventId: state.pathParameters['id']!,
            ),
          ),
        ),
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DashboardScreen(),
          ),
        ),
      ],
    ),
  ],
);
