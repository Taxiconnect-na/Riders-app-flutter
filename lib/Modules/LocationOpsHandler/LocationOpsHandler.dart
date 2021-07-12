import 'package:location/location.dart';
import 'dart:async';

///Responsible for handling all the operations related to the geographic
///position of the user.

class LocationOpsHandler {
  Location location = new Location();
  Duration intervalRecurrence = Duration(seconds: 1);

  //?Continuously get the location service status and permission status of the user.
  void healthCheckServiceAndPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  //...
  void startLocationWatcher() {
    Timer.periodic(intervalRecurrence, (Timer t) {
      print('hey there!');
    });
  }
}
