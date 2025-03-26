import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/home/home_page.dart';
import '../views/loading/loading_page.dart';
import '../views/project/project_detail_page.dart';
import 'app_router_const.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final ctx = navigatorKey.currentContext!;

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRouterConst.loadingPage,
    routes: [
      GoRoute(
        path: '/project-detail',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProjectDetailPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0), // Slide in from right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppRouterConst.loadingPage,
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        path: AppRouterConst.homePage,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Scaffold(
        body: Center(child: Text('Error: ${state.error}')),
      ),
    ),
  );
}
