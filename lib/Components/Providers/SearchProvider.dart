import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Components/Providers/SmartBookingStepsProvider.dart';
import 'dart:convert';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';

///? SEARCH PROVIDER
///Hold the provider for the search module only.

class SearchProvider with ChangeNotifier {
  SearchResultsOnQuery getLocationsNetwork =
      new SearchResultsOnQuery(); //Responsible for the network calls for autocomplete.
  Future?
      resultSearchLocations; //Responsible for holding the result of the autocompleted search for all the fields.

  late Map<String, dynamic> pickupLocationData =
      new Map(); //Will hold the pickup location data
  late Map destination1Data =
      new Map(); //Will hold the the passenger 1 data { location_name, city, country, street_name, query }
  late Map destination2Data = new Map(); //Will hold the the passenger 2 data
  late Map destination3Data = new Map(); //Will hold the the passenger 3 data
  late Map destination4Data = new Map(); //Will hold the the passenger 4 data
  int selectedLocationFieldIndex =
      1; //Will hold the index of the selected location field: pickup (0), passenger 1(1), 2(2), 3(3) or 4(4) - default: Passenger 1
  final TextEditingController pickupLocationController =
      new TextEditingController(); //Controller for the pickup location input field.
  final TextEditingController destination1Controller =
      new TextEditingController(); //Controller for the destination 1 loccation input field
  final TextEditingController destination2Controller =
      new TextEditingController(); //Controller for the destination 2 loccation input field
  final TextEditingController destination3Controller =
      new TextEditingController(); //Controller for the destination 3 loccation input field
  final TextEditingController destination4Controller =
      new TextEditingController(); //Controller for the destination 4 loccation input field

  //?1. Update the selected location field index.
  void updateSelectedLocationFieldIndex({required int newLocationIndex}) {
    selectedLocationFieldIndex = newLocationIndex;
    notifyListeners();
  }

  //?2. Update the location query data
  //Update the location query search for individual location fields
  void updateLocationQueryDataPerLocation(
      {required String query, required BuildContext context}) {
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
    //Autocomplete for locations
    if (query.trim().length > 0) {
      resultSearchLocations =
          getLocationsNetwork.getLocations(query: query, context: context);
    } else //Empty query
    {
      resultSearchLocations = null;
    }

    //Update
    notifyListeners();
  }

  //?3. Update the pickup location details
  void updatePickupLocationDetails(
      {required Map<String, dynamic> newLocation}) {
    pickupLocationData = newLocation;
  }

  //?4. Update pickup location input field controller text value
  void updatePickupLocationIFieldController({required String value}) {
    pickupLocationController.text = value;
  }

  //?5. Get current text input controller
  TextEditingController getCurrentTextInputController() {
    switch (this.selectedLocationFieldIndex) {
      case 0:
        return this.pickupLocationController;
      case 1:
        return this.destination1Controller;
      case 2:
        return this.destination2Controller;
      case 3:
        return this.destination3Controller;
      case 4:
        return this.destination4Controller;
      default:
        return new TextEditingController();
    }
  }

  //?6. Update location selected location from inputs fields
  void updateLocationSelectedInputFields(
      {required Map<String, dynamic> locationSelected,
      required BuildContext context}) {
    int wordLimitLength = 20;
    String placeholderInput = locationSelected['location_name']
                .toString()
                .length >
            wordLimitLength
        ? '${locationSelected['location_name'].toString().substring(0, 20)}...'
        : locationSelected['location_name'].toString();

    switch (this.selectedLocationFieldIndex) {
      case 0:
        pickupLocationData = locationSelected;
        //Update the text value controller
        pickupLocationController.text = placeholderInput;
        //Empty the results previously found
        resultSearchLocations = null;
        break;
      case 1:
        destination1Data = locationSelected;
        //Update the text value controller
        destination1Controller.text = placeholderInput;
        //Empty the results previously found
        resultSearchLocations = null;
        break;
      case 2:
        destination2Data = locationSelected;
        //Update the text value controller
        destination2Controller.text = placeholderInput;
        //Empty the results previously found
        resultSearchLocations = null;
        break;
      case 3:
        destination3Data = locationSelected;
        //Update the text value controller
        destination3Controller.text = placeholderInput;
        //Empty the results previously found
        resultSearchLocations = null;
        break;
      case 4:
        destination4Data = locationSelected;
        //Update the text value controller
        destination4Controller.text = placeholderInput;
        //Empty the results previously found
        resultSearchLocations = null;
        break;
      default:
        break;
    }
    //..
    FocusScope.of(context).unfocus();
    //...Check if all the fields are filled, by value and by text placeholder
    if (areAllTheRelevantInputFieldsFilled(context: context)) {
      //?Force pickup location update - if empty
      if (pickupLocationData['location_name'] == null) {
        updatePickupLocationDetails(
            newLocation: context.read<HomeProvider>().userLocationDetails);
      }
      //Good to go! - then dismiss the search window
      //Move forward
      context
          .read<SmartBookingStepsProvider>()
          .navigateToFutureDestRoute(context: context);
      //Dismiss search
      Navigator.pop(context);
      //Gather pricing raw data and compute fare
      context.read<TripProvider>().updatePricingDataForComputation(
          context: context, userLocation: pickupLocationData);
    } else //Skip
    {
      log('All locations not filled yet, wait.');
    }

    notifyListeners();
  }

  //!7. Check all locations filled state
  bool areAllTheRelevantInputFieldsFilled({required BuildContext context}) {
    int passengersNumber = context.read<TripProvider>().selectedPassengersNo;

    switch (passengersNumber) {
      case 1:
        return pickupLocationData['location_name'] != null &&
            pickupLocationController.text.trim().length > 0 &&
            destination1Data['location_name'] != null &&
            destination1Controller.text.trim().length > 0;
      case 2:
        return pickupLocationData['location_name'] != null &&
            pickupLocationController.text.trim().length > 0 &&
            destination1Data['location_name'] != null &&
            destination1Controller.text.trim().length > 0 &&
            destination2Data['location_name'] != null &&
            destination2Controller.text.trim().length > 0;
      case 3:
        return pickupLocationData['location_name'] != null &&
            pickupLocationController.text.trim().length > 0 &&
            destination1Data['location_name'] != null &&
            destination1Controller.text.trim().length > 0 &&
            destination2Data['location_name'] != null &&
            destination2Controller.text.trim().length > 0 &&
            destination3Data['location_name'] != null &&
            destination3Controller.text.trim().length > 0;
      case 4:
        return pickupLocationData['location_name'] != null &&
            pickupLocationController.text.trim().length > 0 &&
            destination1Data['location_name'] != null &&
            destination1Controller.text.trim().length > 0 &&
            destination2Data['location_name'] != null &&
            destination2Controller.text.trim().length > 0 &&
            destination3Data['location_name'] != null &&
            destination3Controller.text.trim().length > 0 &&
            destination4Data['location_name'] != null &&
            destination4Controller.text.trim().length > 0;
      default:
        return false;
    }
  }
}

//Responsible for the text autocomplete
class SearchResultsOnQuery {
  String urlStringBackbone =
      'http://192.168.8.109:9091/getSearchedLocations?user_fp=7c57cb6c9471fd33fd265d5441f253eced2a6307c0207dea57c987035b496e6e8dfa7105b86915da';
  //The string to be used for the network get API

  //a. Get the search results as a Future
  //Data to add &query=Khomas&city=Windhoek&country=Namibia
  Future getLocations(
      {required String query, required BuildContext context}) async {
    print(urlStringBackbone);
    Map userLocationDetails = context.read<HomeProvider>().userLocationDetails;
    String newUrlString =
        '${this.urlStringBackbone}&query=$query&city=${userLocationDetails['city']}&country=${userLocationDetails['country']}';
    Response response = await get(Uri.parse(Uri.encodeFull(newUrlString)));

    //Check if there's any value in the text field worth showing the results for
    if (context
            .read<SearchProvider>()
            .getCurrentTextInputController()
            .text
            .trim()
            .length >
        0) //! SHow values since the text input is still filled
    {
      if (response.statusCode == 200) //DecodeSuccessCallback
      {
        return jsonDecode(response.body)['result']['result'];
      } else //Error
      {
        return 403;
      }
    } else //! Don't show the results, since the text input is not filled
    {
      print('Empty text');
      return 403;
    }
  }
}
