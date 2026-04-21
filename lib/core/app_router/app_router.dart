import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/features/auth/views/login/login_screen.dart';
import 'package:e_commerce/features/auth/views/main_auth/auth_screen.dart';
import 'package:e_commerce/features/auth/views/register/register_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRouterKeys.authKey,
  routes: [
    GoRoute(
      path: AppRouterKeys.loginKey,
      name: AppRouterKeys.loginKey,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: AppRouterKeys.registerKey,
      name: AppRouterKeys.registerKey,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: AppRouterKeys.authKey,
      name: AppRouterKeys.authKey,
      builder: (context, state) => AuthScreen(),
    ),

  ],
);
