import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/ui/shared/widgets/splash/splash.dart';
import 'package:go_router/go_router.dart';

Page<T> buildPageWithDefaultTransition<T extends Object?>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool maintainState = true,
  bool fullscreenDialog = false,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      final slideAnimation = tween.animate(curvedAnimation);

      final secondarySlideAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.3, 0.0),
      ).animate(curvedAnimation);

      return Stack(
        children: [
          if (secondaryAnimation.status != AnimationStatus.dismissed)
            SlideTransition(
              position: secondarySlideAnimation,
              child: Container(), 
            ),
          SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        ],
      );
    },
  );
}

Page<T> buildPageWithModalTransition<T extends Object?>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool maintainState = true,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    maintainState: maintainState,
    fullscreenDialog: true,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeOutCubic;

      final slideAnimation = Tween(begin: begin, end: end).animate(
        CurvedAnimation(parent: animation, curve: curve),
      );

      return SlideTransition(
        position: slideAnimation,
        child: child,
      );
    },
  );
}

Page<T> buildPageWithFadeTransition<T extends Object?>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool maintainState = true,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    maintainState: maintainState,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash Screen con fade
    GoRoute(
      path: '/',
      name: 'splash',
      pageBuilder: (context, state) => buildPageWithFadeTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),
    
    // Home con animación iOS default
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const Placeholder(),
      ),
      routes: [
       
      ],
    ),
  ],
);

