import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';

import 'package:taxiconnect/Modules/LocationOpsHandler/PositionConverter.dart';

///Responsible for handling all the operations related to the geographic
///position of the user.

class LocationOpsHandler {
  //? Attributes - very important
  final BuildContext parentContext;
  final String hostname = 'http://192.168.8.109:9090';
  //...
  LocationOpsHandler({required this.parentContext});
  //Location location = new Location();
  Duration intervalRecurrence = Duration(seconds: 2);

  //?1. Continuously get the location service status and permission status of the user.
  //Responsible for cheking the location service and permission status.
  Future<Map> healthCheckServiceAndPermission() async {
    if (parentContext
            .read<HomeProvider>()
            .locationServicesStatus['isLocationServiceEnabled'] ==
        false) //Location service disabled
    {
      return {
        'isLocationServiceEnabled': parentContext
            .read<HomeProvider>()
            .locationServicesStatus['isLocationServiceEnabled'],
        'isLocationPermissionGranted': parentContext
            .read<HomeProvider>()
            .locationServicesStatus['isLocationPermissionGranted']
      };
    }
    //...
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission.toString() != 'LocationPermission.whileInUse' &&
        permission.toString() !=
            'LocationPermission.always') //Permission denied
    {
      return {
        'isLocationServiceEnabled': parentContext
            .read<HomeProvider>()
            .locationServicesStatus['isLocationServiceEnabled'],
        'isLocationPermissionGranted': false
      };
    }

    //All good
    return {
      'isLocationServiceEnabled': true,
      'isLocationPermissionGranted': true
    };
  }

  //? 2. Get the  user's location details
  //Responsible for getting the user's latitude and logitude, or any other location related infos.
  Future getUserLocation({bool shouldGetNewLocation = true}) async {
    if (shouldGetNewLocation) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
    } else //Get the last known location - useful especially when a permission is denied
    {
      return await Geolocator.getLastKnownPosition();
    }
  }

  //? 3. Request location permission
  void requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission.toString() != 'LocationPermission.whileInUse' &&
        permission.toString() != 'LocationPermission.always') {
      await Geolocator.requestPermission();
    }
  }

  //? 4. GPRS Status streamer
  void gprsStatusStreamer() {
    // ignore: cancel_subscriptions
    Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      parentContext
          .read<HomeProvider>()
          .updateGPRSServiceStatusAndLocationPermissions(
              gprsServiceStatus:
                  status.toString() == 'ServiceStatus.enabled' ? true : false,
              locationPermission: parentContext
                  .read<HomeProvider>()
                  .locationServicesStatus['isLocationServiceEnabled']);
    });
  }

  //? 5 . Geocode the current point
  void geocodeThisPoint(
      {required double latitude, required double longitude}) async {
    String urlString =
        '$hostname/getUserLocationInfos?latitude=$latitude&longitude=$longitude&user_fingerprint=${parentContext.read<HomeProvider>().user_fingerprint}';
    Response response = await get(Uri.parse(Uri.encodeFull(urlString)));

    if (response.statusCode == 200) {
      //log(response.body);
      parentContext.read<HomeProvider>().updateUsersCurrentLocation(
          newCurrentLocation: json.decode(response.body));
    } else //Some error
    {
      print(response.statusCode);
    }
  }

  //...
  void startLocationWatcher() async {
    print('Watcher active and running!');
    PositionConverter positionConverter =
        new PositionConverter(); //To parse the coordinates (Position) data
    //Ask once for the location permission
    this.requestLocationPermission();
    this.gprsStatusStreamer();

    Timer.periodic(intervalRecurrence, (Timer t) {
      //Perform the location health check
      Future healthCheck = this.healthCheckServiceAndPermission();
      healthCheck.then((status) {
        //? Update the state if necessary
        parentContext
            .read<HomeProvider>()
            .updateGPRSServiceStatusAndLocationPermissions(
                gprsServiceStatus: status['isLocationServiceEnabled'],
                locationPermission: status['isLocationPermissionGranted']);
        //....
        if (status['isLocationServiceEnabled'] &&
            status[
                'isLocationPermissionGranted']) //Has full permission - get the coordinates
        {
          Future userPosition = this.getUserLocation();
          userPosition.then((value) {
            if (value != null) {
              value = positionConverter.parseToMap(
                  positionString: value.toString());

              parentContext
                  .read<HomeProvider>()
                  .updateRidersLocationCoordinates(
                      latitude: value['latitude'],
                      longitude: value['longitude']);

              //Geocode the point
              this.geocodeThisPoint(
                  latitude: value['latitude'], longitude: value['longitude']);
            }
          });
        } else //Is missing one Permission - get the last coordinates
        {
          Future userPosition =
              this.getUserLocation(shouldGetNewLocation: false);
          userPosition.then((value) {
            if (value != null) {
              value = positionConverter.parseToMap(
                  positionString: value.toString());

              parentContext
                  .read<HomeProvider>()
                  .updateRidersLocationCoordinates(
                      latitude: value['latitude'],
                      longitude: value['longitude']);
            }
          });
        }
      });
    });
  }
}
