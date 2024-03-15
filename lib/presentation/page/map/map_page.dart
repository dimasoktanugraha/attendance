import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:attendance/presentation/page/setting/bloc/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/colors.dart';
import '../../route/app_router.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final random = Random();

  double long = 0.0, lat = 0.0;
  Set<Marker> _markers = HashSet<Marker>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    CameraPosition currentPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));

    addMarker(position.latitude, position.longitude);

    setState(() {
      lat = position.latitude;
      long = position.longitude; 
    });
  }

  @override
  void initState() {
    getUserCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initPosition,
              myLocationEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,      
              onTap:  (LatLng point){
                print(point.latitude);
                print(point.longitude);   
            
                addMarker(point.latitude, point.longitude);

                setState(() {
                  lat = point.latitude;
                  long = point.longitude; 
                });
              },
            ),
            Positioned(
              bottom: 20,
              left: 60,
              right: 60,
              child: BlocConsumer<LocationBloc, LocationState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (location){
                      context.goNamed(
                        RouteConstants.root,
                        pathParameters: PathParameters(
                          rootTab: RootTab.setting,
                        ).toMap(),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const CircularProgressIndicator(),
                    orElse: () => ElevatedButton(
                      onPressed: () => context.read<LocationBloc>()
                        ..add(LocationEvent.setLocation(lat, long)),
                      child: const Text(
                        "Save Location",
                      ))
                    ,
                  );
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
  
  void addMarker(double latitude, double longitude) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId('office'),
        position: LatLng(latitude, longitude),
        infoWindow: const InfoWindow(
          title: 'office',
        ),
      ));
            
    });
  }
}
