import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jenan_admin/features/auth/bloc/auth_bloc.dart';
import 'package:jenan_admin/core/constants/routes/app_routes_consts.dart';
import 'package:jenan_admin/features/auth/presentation/screens/login_screen.dart';
import 'package:jenan_admin/features/splash/presentation/splash_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/users_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/orders_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/reports_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/sellers_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/support_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/finance_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/overview_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/settings_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:jenan_admin/features/dashboard/presentation/screens/marketing_screen.dart';


class AppRouter {
  AppRouter._();

  static GoRouter createRouter(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: AppRoutesConsts.splash,
      refreshListenable: _BlocRefreshStream(authBloc.stream), // عشان كل ما تتغير ال state يتم اخبار redirect عشان يعيد بناء GoRoute

      redirect: (context, state) {
        final authState = authBloc.state;
        final currentPath = state.matchedLocation;
        final isCheckingSession = authState is AuthInitial || authState is AuthCheckingSession;
        final isLoggedIn = authState is AuthAuthenticated;
        final isGoingToSplash = currentPath == AppRoutesConsts.splash;
        final isGoingToLogin = currentPath == AppRoutesConsts.login;

        if (isCheckingSession) {
          return isGoingToSplash ? null : AppRoutesConsts.splash;
        }

        if (isGoingToSplash) {
          return isLoggedIn ? AppRoutesConsts.overview : AppRoutesConsts.login;
        }

        if (!isLoggedIn && !isGoingToLogin) {
          return AppRoutesConsts.login;
        }

        if (isLoggedIn && isGoingToLogin) {
          return AppRoutesConsts.overview;
        }

        return null;
      },

      routes: [
        GoRoute(
          path: AppRoutesConsts.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutesConsts.login,
          builder: (context, state) => const LoginScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return DashboardScreen(child: child);
          },
          routes: [
            GoRoute(
              path: AppRoutesConsts.overview,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: OverviewScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.users,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: UsersScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.sellers,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SellersScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.orders,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: OrdersScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.finance,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FinanceScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.marketing,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MarketingScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.support,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SupportScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.reports,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ReportsScreen(),
              ),
            ),
            GoRoute(
              path: AppRoutesConsts.settings,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}



class _BlocRefreshStream extends ChangeNotifier {
  _BlocRefreshStream(Stream<dynamic> stream) {
    notifyListeners(); // بدونها redirect ما بشتغل أول مرة
    _subscription = stream.asBroadcastStream().listen((_) { // ال Broadcast Stream بفرق عن Single Stream بأنه بضله مفتوح يعمل listen اما Single Stream بعمل listen مرة وحدة وبسكر
      notifyListeners();
    });
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}