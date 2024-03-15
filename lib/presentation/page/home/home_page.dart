import 'dart:async';

import 'package:attendance/domain/usecases/set_attendance.dart';
import 'package:attendance/presentation/page/home/bloc/bloc/attendance_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../widget/address_item.dart';
import '../history/bloc/history/history_bloc.dart';
import '../setting/bloc/location/location_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  double long = 0.0, lat = 0.0;
  String address = "";
  late StreamSubscription<Position> positionStream;
  late LocationSettings locationSettings;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    getAddress(position.latitude, position.longitude);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        // foregroundNotificationConfig: const ForegroundNotificationConfig(
        //   notificationText:
        //   "Example app will continue to receive your location even when you aren't using it",
        //   notificationTitle: "Running in Background",
        //   enableWakeLock: true,
        // )
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position pos) {
      getAddress(pos.latitude, pos.longitude);
      setState(() {
        lat = pos.latitude;
        long = pos.longitude;
      });
    });
  }

  void getAddress(double latitude, double longitude) {
    placemarkFromCoordinates(latitude, longitude).then((placemarks) {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        output = placemarks[0].subAdministrativeArea.toString();
      }

      setState(() {
        address = output;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(children: [
        addressItem(long, lat, address),
        const SizedBox(height: 20 ),
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => SizedBox.shrink(),
              loaded: (location) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(location.latitude == 0.0 && location.longitude == 0.0){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            headerAnimationLoop: false,
                            animType: AnimType.topSlide,
                            title: 'Warning',
                            desc: 'Please Setup First Pinned Office Location in Setting Menu',
                            btnOkOnPress: () {},
                          ).show();
                        }else{
                          context.read<AttendanceBloc>().add(
                            AttendanceEvent.setAttendance('clock-in', lat, long));
                        }
                      },
                      child: const Text(
                        "Clock-In",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(location.latitude == 0.0 && location.longitude == 0.0){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            headerAnimationLoop: false,
                            animType: AnimType.topSlide,
                            title: 'Warning',
                            desc: 'Please Setup First Pinned Office Location in Setting Menu',
                            btnOkOnPress: () {},
                          ).show();
                        }else{
                          context.read<AttendanceBloc>().add(
                              AttendanceEvent.setAttendance('clock-out', lat, long));
                        }
                      },
                      child: const Text(
                        "Clock-Out",
                      ),
                    ),
                  ],
                ),
              )
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        BlocConsumer<AttendanceBloc, AttendanceState>(
            listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              loaded: (attendance) {
                if (attendance.status == 'Approved') {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Success',
                    desc: 'Your Attendance has been Approved',
                    btnOkOnPress: () {
                      debugPrint('OnClick');
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                } else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    headerAnimationLoop: false,
                    title: 'Declined',
                    desc: 'Your location is far from office ( >50m )',
                    btnOkOnPress: () {},
                    btnOkIcon: Icons.cancel,
                    btnOkColor: Colors.red,
                  ).show();
                }

                context
                    .read<HistoryBloc>()
                    .add(const HistoryEvent.getHistory());
              },
              error: (message) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  headerAnimationLoop: false,
                  title: 'Error',
                  desc: message,
                  btnOkOnPress: () {},
                  btnOkIcon: Icons.cancel,
                  btnOkColor: Colors.red,
                ).show();
              });
        }, builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => CircularProgressIndicator());
        })
      ])),
    );
  }
}
