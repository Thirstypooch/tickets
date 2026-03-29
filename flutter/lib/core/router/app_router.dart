import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/properties/properties_screen.dart';
import '../../presentation/screens/properties/property_detail_screen.dart';
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
          path: '/properties',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PropertiesScreen(),
          ),
        ),
        GoRoute(
          path: '/properties/:id',
          pageBuilder: (context, state) => NoTransitionPage(
            child: PropertyDetailScreen(
              propertyId: state.pathParameters['id']!,
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
