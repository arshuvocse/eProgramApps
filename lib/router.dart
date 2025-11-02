
import 'package:go_router/go_router.dart';
import 'package:myapp/views/dashboard_view.dart';
import 'package:myapp/views/data_sync_view.dart';
import 'package:myapp/views/login_view.dart';
import 'package:myapp/views/splash_view.dart';
import 'viewmodels/auth_viewmodel.dart';

class AppRouter {
  final AuthViewModel authViewModel;

  AppRouter({required this.authViewModel});

  late final router = GoRouter(
    refreshListenable: authViewModel,
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
        path: '/data-sync',
        builder: (context, state) => const DataSyncView(),
      ),
    ],
    redirect: (context, state) {
      if (!authViewModel.isAuthCheckComplete) {
        return null; // Stay on splash while checking
      }

      final isLoggingIn = state.matchedLocation == '/login';
      if (!authViewModel.isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      if (authViewModel.isAuthenticated && (state.matchedLocation == '/login' || state.matchedLocation == '/')) {
        return '/dashboard';
      }

      return null; // No redirect needed
    },
  );
}
