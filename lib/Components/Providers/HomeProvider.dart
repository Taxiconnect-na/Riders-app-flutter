import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:sliding_up_panel/sliding_up_panel.dart';

///? HOME PROVIDER
///Hold the provider responsible for the home's user interface only (exclude all trip->ride,delivery data) !
///! Keep the module-like providers split (create a provider for each of the Components)
///! Eg: For Wallet, create a WalletProvider.dart file, etc...

class HomeProvider with ChangeNotifier {
  final panelController = PanelController(); //!The main panel controller
  late ScrollController
      parenControllerChild; //!The scroll controller return by the main panelController;

  final String user_fingerprint =
      '5b29bb1b9ac69d884f13fd4be2badcd22b72b98a69189bfab806dcf7c5f5541b6cbe8087cf60c791';

  Completer<GoogleMapController> mapController =
      Completer(); //? Resposible for holding the general maps controller.
  double mapZoom = 15; //The current zoom of the map
  bool isPanelShown = false; //To know whether or not the panel is shown.
  double minSliderHeight =
      200; //The minimum height for the slider. - default:200
  double maxSliderHeight = ScreenUtil().screenHeight *
      0.55; //The maximum height for the slider (default:450 - generic). - for rides estimations (default:650 based on the screen)
  double _initRelativeFocusButtonPosition =
      30; //The init and fixed relative focus button position -default: minSliderHeight
  double relativeFocusButtonPosition =
      0; //The relative position of the focus button based on the slider's height - initial: 30
  double relativeMapHeight = 0;
  Map<dynamic, dynamic> locationServicesStatus = {
    'isLocationServiceEnabled': false,
    'isLocationPermissionGranted': false
  }; //Will hold the status of the GPRS service and the one of the location permission.
  late Map userLocationCoords =
      new Map(); //The user location coordinates: lat/long
  //! Add location debug data
  Map<String, dynamic> userLocationDetails =
      new Map(); //The details of the user location: city, location name
  //!----
  final userCenterPointFallback = const LatLng(-22.559723,
      17.074068); //TO be used when the actual user location is not yet found.

  //?0. Update child panel controller
  void updateChildPanelController(
      {required ScrollController newPanelControllerChildValue}) {
    parenControllerChild = newPanelControllerChildValue;
  }

  //?1. Initialize home screen measurements
  //Resposible for initializing the height of the map, the refocus button when the Home component
  //is created only, it happens only once.
  //? Receives the Home Screen size
  void initHomeScreenMeasurements({required Size screenSize}) {
    //Refocus button
    this._initRelativeFocusButtonPosition += this.minSliderHeight;
    this.relativeFocusButtonPosition = this._initRelativeFocusButtonPosition;
    //Map height + a tolerable height factor of 40 (default)
    this.relativeMapHeight = screenSize.height - this.minSliderHeight + 40;
  }

  //?2. Update refocus position
  void updateRefocusAndMapPositions(
      {required double sliderPositionHeight, required Size screenSize}) {
    //Refocus position
    this.relativeFocusButtonPosition =
        (sliderPositionHeight * (this.maxSliderHeight - this.minSliderHeight)) +
            this._initRelativeFocusButtonPosition;
    //Map height
    //this.relativeMapHeight -= sliderPositionHeight;
    notifyListeners();
  }

  //?3. Update panel shown status
  //Defined to true if the panel is shown and false otherwise.
  //? Received the bool for the state
  void updatePanelShownStatus(bool status) {
    if (isPanelShown != status) {
      isPanelShown = status;
      notifyListeners();
    }
  }

  //?4. Update the GPRS service status and the location permission
  void updateGPRSServiceStatusAndLocationPermissions(
      {required bool gprsServiceStatus, required bool locationPermission}) {
    if (gprsServiceStatus !=
            this.locationServicesStatus['isLocationServiceEnabled'] ||
        locationPermission !=
            this.locationServicesStatus[
                'isLocationPermissionGranted']) //new values received
    {
      locationServicesStatus['isLocationServiceEnabled'] = gprsServiceStatus;
      this.locationServicesStatus['isLocationPermissionGranted'] =
          locationPermission;
      //...Update
      print('UPDATED GLOBAL STATE FOR LOCATION SERVICE STATUS');
      notifyListeners();
    }
  }

  //?5. Update the rider's location coordinates
  void updateRidersLocationCoordinates(
      {required double latitude, required double longitude}) {
    if (userLocationCoords != null) {
      if (userLocationCoords['latitude'] != latitude &&
          userLocationCoords['longitude'] != longitude) //new Data received
      {
        //Check if the previous coors were null - if so animate the map marker to the current position
        if (userLocationCoords['latitude'] == null ||
            userLocationCoords['longitude']) {
          mapController.future.then((value) =>
              value.animateCamera(CameraUpdate.zoomBy(16))); //Zoom out first

          mapController.future.then((value) => value.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(latitude, longitude), zoom: mapZoom))));
        }
        //...
        userLocationCoords['latitude'] = latitude;
        userLocationCoords['longitude'] = longitude;
        print('Updated location with new ones');
        //..
        notifyListeners();
      }
    }
  }

  //!6. Update the google maps main controller
  void updateGoogleMapsController({required GoogleMapController controller}) {
    mapController.complete(controller);
    notifyListeners();
  }

  //!6a. Get the map id
  Future<int> getMapId() async {
    return mapController.future.then<int>((value) => value.mapId);
  }

  //?7. Update the current zoom of the map
  void updateCurrentZoomOfMap({required double zoom}) {
    mapZoom = zoom;
    notifyListeners();
  }

  //?8. Update panel's max height
  void updatePanelMinMaxHeights(
      {required double newMinHeight,
      required double newMaxHeight,
      double percPanelOpening = 1}) {
    minSliderHeight = newMinHeight;
    maxSliderHeight = newMaxHeight;
    //Update refocus button
    this.relativeFocusButtonPosition =
        (percPanelOpening * (maxSliderHeight - minSliderHeight)) +
            this._initRelativeFocusButtonPosition;
    //Map height
    //this.relativeMapHeight -= sliderPositionHeight;
    notifyListeners();
  }

  //?9. Update user's current location
  void updateUsersCurrentLocation(
      {required Map<String, dynamic> newCurrentLocation}) {
    //Replace name by location_name
    newCurrentLocation['location_name'] = newCurrentLocation['street'];
    if (!mapEquals(newCurrentLocation, userLocationDetails)) //New data received
    {
      userLocationDetails = newCurrentLocation;
      notifyListeners();
    }
  }
}
