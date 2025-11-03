
import 'package:go_router/go_router.dart';
import 'package:myapp/views/dashboard_view.dart';
import 'package:myapp/views/sync_data_view.dart';
import 'package:myapp/views/login_view.dart';
import 'package:myapp/views/splash_view.dart';
import 'package:myapp/views/settings_view.dart';

class AppRouter {
  late final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: '/sync-data',
        builder: (context, state) => const SyncDataView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
    ],
    redirect: (context, state) async {
      if (state.matchedLocation == '/') {
        await Future.delayed(const Duration(seconds: 2));
        return '/login';
      }
      return null;
    },
  );
}
