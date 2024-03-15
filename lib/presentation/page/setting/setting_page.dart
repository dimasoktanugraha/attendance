import 'package:attendance/presentation/page/setting/bloc/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/colors.dart';
import '../../route/app_router.dart';
import '../../widget/location_item.dart';
import 'bloc/theme/theme_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Office Location"),
                trailing: ElevatedButton(
                  onPressed: (){
                    context.goNamed(
                      RouteConstants.map,
                      pathParameters: PathParameters(
                        rootTab: RootTab.setting,
                      ).toMap(),
                    );
                  },
                  child: const Text(
                    "Setup",
                  ),
                ),
              ),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    loaded: (location) {
                      return locationItem(location.latitude, location.longitude);
                    }
                  );
                },
              ),
              SizedBox(height: 20,),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    theme: (isDark){
                      return ListTile(
                        leading: const Icon(Icons.dark_mode),
                        title: Text((isDark) ? "Dark Theme" : "Light Theme"),
                        trailing: Switch(
                          value: isDark,
                          onChanged: (value) => context.read<ThemeBloc>().add(const ThemeEvent.toogleTheme())),
                      );
                    }
                  );
                },
              )
            ],
          ),
        ),
    );
  }
}
