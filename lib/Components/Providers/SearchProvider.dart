import 'package:flutter/material.dart';

///? SEARCH PROVIDER
///Hold the provider for the search module only.

class SearchProvider with ChangeNotifier {
  late Map pickupLocationData = new Map(); //Will hold the pickup location data
  late Map destination1Data =
      new Map(); //Will hold the the passenger 1 data { location_name, city, country, street_name, query }
  late Map destination2Data = new Map(); //Will hold the the passenger 2 data
  late Map destination3Data = new Map(); //Will hold the the passenger 3 data
  late Map destination4Data = new Map(); //Will hold the the passenger 4 data
  int selectedLocationFieldIndex =
      1; //Will hold the index of the selected location field: pickup (0), passenger 1(1), 2(2), 3(3) or 4(4) - default: Passenger 1
  final TextEditingController pickupLocationController =
      new TextEditingController(); //Controller for the pickup location input field.

  //?1. Update the selected location field index.
  void updateSelectedLocationFieldIndex({required int newLocationIndex}) {
    selectedLocationFieldIndex = newLocationIndex;
    notifyListeners();
  }

  //?2. Update the location query data
  //Update the location query search for individual location fields
  void updateLocationQueryDataPerLocation({required String query}) {
    switch (selectedLocationFieldIndex) {
      case 0:
        pickupLocationData['query'] = query;
        break;
      case 1:
        destination1Data['query'] = query;
        break;
      case 2:
        destination2Data['query'] = query;
        break;
      case 3:
        destination3Data['query'] = query;
        break;
      case 4:
        destination4Data['query'] = query;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  //?3. Update the pickup location details
  void updatePickupLocationDetails({required Map newLocation}) {
    pickupLocationData = newLocation;
  }

  //?4. Update pickup location input field controller text value
  void updatePickupLocationIFieldController({required String value}) {
    pickupLocationController.text = value;
  }
}
