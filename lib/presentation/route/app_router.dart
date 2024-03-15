import 'package:attendance/presentation/page/history/history_page.dart';
import 'package:attendance/presentation/page/map/map_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../page/dashboard/dashboard_page.dart';
import '../page/home/home_page.dart';
import '../page/setting/setting_page.dart';
import '../page/splash/splash_page.dart';

part 'route_constants.dart';
part 'enums/root_tab.dart';
part 'models/path_parameters.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: RouteConstants.splashPath,
    routes: [
      GoRoute(
        name: RouteConstants.splash,
        path: RouteConstants.splashPath,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: RouteConstants.root,
        path: RouteConstants.rootPath,
        builder: (context, state) {
          final tab =
              int.tryParse(state.pathParameters['root_tab'] ?? '') ?? 0;
          return DashboardPage(
            key: state.pageKey,
            currentTab: tab,
          );
        },
        routes: [
          GoRoute(
            name: RouteConstants.home,
            path: RouteConstants.homePath,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: RouteConstants.history,
            path: RouteConstants.historyPath,
            builder: (context, state) => const HistoryPage(),
          ),
          GoRoute(
            name: RouteConstants.setting,
            path: RouteConstants.setting,
            builder: (context, state) => const SettingPage(),
            routes: [
              GoRoute(
                name: RouteConstants.map,
                path: RouteConstants.mapPath,
                builder: (context, state) => const MapPage(),
              ),
            ]
          )
        ]
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    },
  );
}
