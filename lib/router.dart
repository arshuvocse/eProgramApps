
import 'package:go_router/go_router.dart';
import 'package:myapp/views/dashboard_view.dart';
import 'package:myapp/views/login_view.dart';
import 'viewmodels/auth_viewmodel.dart';

class AppRouter {
  final AuthViewModel authViewModel;

  AppRouter({required this.authViewModel});

  late final router = GoRouter(
    refreshListenable: authViewModel,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginView(),
        redirect: (context, state) {
          if (authViewModel.isAuthenticated) {
            return '/dashboard';
          }
          return null;
        },
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardView(),
        redirect: (context, state) {
          if (!authViewModel.isAuthenticated) {
            return '/';
          }
          return null;
        },
      ),
    ],
  );
}
