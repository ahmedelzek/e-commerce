import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/cache/cache_helper.dart';
import 'package:e_commerce/core/cache/cache_keys.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';
import 'package:e_commerce/domain/entities/user/user_entity.dart';
import 'package:e_commerce/features/auth/views/login/login_screen.dart';
import 'package:e_commerce/features/auth/views/main_auth/auth_screen.dart';
import 'package:e_commerce/features/auth/views/register/register_screen.dart';
import 'package:e_commerce/features/cart/views/cart_screen.dart';
import 'package:e_commerce/features/checkout/views/checkout_screen.dart';
import 'package:e_commerce/features/master/master_screen.dart';
import 'package:e_commerce/features/my_favorites/views/favorites_screen.dart';
import 'package:e_commerce/features/my_orders/views/my_orders_screen.dart';
import 'package:e_commerce/features/my_profile/views/update_profile_screen.dart';
import 'package:e_commerce/features/product/views/product_screen.dart';
import 'package:e_commerce/features/search/views/search_screen.dart';
import 'package:e_commerce/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/order/order_entity.dart';
import '../../features/my_orders/views/order_detials_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late final GoRouter appRouter;

Future<void> initRouter() async {
  final token = await CacheHelper.getValue(CacheKeys.accessToken);
  final isLoggedIn = token != null && token.toString().isNotEmpty;

  appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: isLoggedIn ? AppRouterKeys.master : AppRouterKeys.authKey,
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
      GoRoute(
        path: AppRouterKeys.master,
        name: AppRouterKeys.master,
        builder: (context, state) => MasterScreen(),
      ),
      GoRoute(
        path: AppRouterKeys.product,
        name: AppRouterKeys.product,
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ProductScreen(product: product);
        },
      ),
      GoRoute(
        path: AppRouterKeys.updateProfile,
        name: AppRouterKeys.updateProfile,
        builder: (context, state) {
          final user = state.extra as UserEntity;
          return UpdateProfileScreen(user: user);
        },
      ),
      GoRoute(
        path: AppRouterKeys.cart,
        name: AppRouterKeys.cart,
        builder: (context, state) => CartScreen(),
      ),
      GoRoute(
        path: AppRouterKeys.checkout,
        name: AppRouterKeys.checkout,
        builder: (context, state) => CheckoutScreen(),
      ),
      GoRoute(
        path: AppRouterKeys.myOrders,
        name: AppRouterKeys.myOrders,
        builder: (context, state) => MyOrdersScreen(),
      ),
      GoRoute(
        path: AppRouterKeys.settings,
        name: AppRouterKeys.settings,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: AppRouterKeys.orderDetails,
        name: AppRouterKeys.orderDetails,
        builder: (context, state) => OrderDetailsScreen(
          order: state.extra as OrderEntity,
        ),
      ),
      GoRoute(
        path: AppRouterKeys.search,
        name: AppRouterKeys.search,
        builder: (context, state) => SearchScreen(),
      ),
      GoRoute(
        path: AppRouterKeys.myFavorites,
        name: AppRouterKeys.myFavorites,
        builder: (context, state) => FavoritesScreen(),
      ),
    ],
  );
}
