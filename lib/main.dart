import 'package:attendance/presentation/page/history/bloc/history/history_bloc.dart';
import 'package:attendance/presentation/page/home/bloc/bloc/attendance_bloc.dart';
import 'package:attendance/presentation/page/setting/bloc/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/theme.dart';
import 'data/cache/shared_prefs.dart';
import 'di/locator.dart' as di;
import 'presentation/page/setting/bloc/theme/theme_bloc.dart';
import 'presentation/route/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final router = appRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<ThemeBloc>()),
        BlocProvider(create: (context) => di.locator<LocationBloc>()..add(const LocationEvent.getLocation())),
        BlocProvider(create: (context) => di.locator<AttendanceBloc>()),
        BlocProvider(create: (context) => di.locator<HistoryBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              theme: (isDark) => MaterialApp.router(
                title: 'Attendance',
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                routerDelegate: router.routerDelegate,
                routeInformationParser: router.routeInformationParser,
                routeInformationProvider: router.routeInformationProvider,
              )
          );
        },
      ),
    );
  }
}
