import 'package:flutter/material.dart';

///? TRIP PROVIDER
///Hold the provider responsible for the management of trips (rides, deliveries) only.

class TripProvider with ChangeNotifier {
  int selectedPassengersNo =
      2; //Hold the current number of selected passengers for a trip - default: 1 , max 4
  bool isGoingToTheSameDestination =
      false; //To know whether or not the passengers are going to the same destination. - default: false, only makes sense for more than 1 passenger

  //! Modifiers
  //?1. Update the passengers number
  void updatePassengersNo({required int newPassengerNo}) {
    if (newPassengerNo > 0) {
      selectedPassengersNo = newPassengerNo;
    } else //Reset to 1
    {
      selectedPassengersNo = 1;
    }
    //...
    notifyListeners();
  }

  //?2 Update going to the same destination switch state
  void updateGoingToTheSameDestSwitch({required bool state}) {
    isGoingToTheSameDestination = state;
    notifyListeners();
  }
}
