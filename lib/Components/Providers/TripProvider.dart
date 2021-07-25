import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
import 'package:taxiconnect/Components/Providers/SmartBookingStepsProvider.dart';

///? TRIP PROVIDER
///Hold the provider responsible for the management of trips (rides, deliveries) only.

class TripProvider with ChangeNotifier {
  final String hostname = 'http://192.168.8.109';

  int selectedPassengersNo =
      1; //Hold the current number of selected passengers for a trip - default: 1 , max 4
  bool isGoingToTheSameDestination =
      false; //To know whether or not the passengers are going to the same destination. - default: false, only makes sense for more than 1 passenger
  bool isGoingUntilHome =
      false; //TO know whether or not the passengers are going until home - default: false
  TextEditingController noteInputController =
      new TextEditingController(); //The controller to manipulate the note text input.
  String? pickupNoteText; //The text value of the pickup note - default:null
  String selectedConnectType =
      'ConnectUs'; //The connect type - default : ConnectUs, possible values: ConnectMe, ConnectUs

  Future? ridesEstimationsData;
  // new Future(() {
  //   return [
  //     {
  //       "id": 0,
  //       "category": "Economy",
  //       "ride_type": "RIDE",
  //       "country": "Namibia",
  //       "city": "Windhoek",
  //       "base_fare": 19,
  //       "car_type": "normalTaxiEconomy",
  //       "app_label": "Normal Taxi",
  //       "description": "Enjoy affordable rides",
  //       "media": {"car_app_icon": "../images_res/normaltaxieconomy.jpg"},
  //       "availability": "available"
  //     },
  //     {
  //       "id": 1,
  //       "category": "Economy",
  //       "ride_type": "RIDE",
  //       "country": "Namibia",
  //       "city": "Windhoek",
  //       "base_fare": 20,
  //       "car_type": "electricEconomy",
  //       "app_label": "Electric car",
  //       "description": "Zero emission all the way",
  //       "media": {"car_app_icon": "../images_res/electricEconomy.jpg"},
  //       "availability": "available"
  //     },
  //     {
  //       "id": 2,
  //       "category": "Comfort",
  //       "ride_type": "RIDE",
  //       "country": "Namibia",
  //       "city": "Windhoek",
  //       "base_fare": 70,
  //       "car_type": "comfortNormalRide",
  //       "app_label": "Normal car",
  //       "description": "Ride in comfort",
  //       "media": {"car_app_icon": "../images_res/comfortrideNormal.jpg"},
  //       "availability": "available"
  //     },
  //     {
  //       "id": 3,
  //       "category": "Comfort",
  //       "ride_type": "RIDE",
  //       "country": "Namibia",
  //       "city": "Windhoek",
  //       "base_fare": 65,
  //       "car_type": "comfortElectricRide",
  //       "app_label": "Electric car",
  //       "description": "Get there in silence",
  //       "media": {"car_app_icon": "../images_res/comfortrideElectric.jpg"},
  //       "availability": "unavailable"
  //     },
  //     {
  //       "id": 4,
  //       "category": "Luxury",
  //       "ride_type": "RIDE",
  //       "country": "Namibia",
  //       "city": "Windhoek",
  //       "base_fare": 190,
  //       "car_type": "luxuryNormalRide",
  //       "app_label": "Normal car",
  //       "description": "Enjoy the best luxury",
  //       "media": {"car_app_icon": "../images_res/luxuryRideNormal.jpg"},
  //       "availability": "unavailable"
  //     },
  //     {
  //       "id": 5,
  //       "category": "Luxury",
  //       "ride_type": "RIDE",
  //       "country": "Namibia",
  //       "city": "Windhoek",
  //       "base_fare": 250,
  //       "car_type": "luxuryElectricRide",
  //       "app_label": "Electric car",
  //       "description": "Luxury with zero emission",
  //       "media": {"car_app_icon": "../images_res/luxuryRideElectric.jpg"},
  //       "availability": "unavailable"
  //     }
  //   ];
  // }); //Will hold all the prices estimations coming straight from up.
  Map selectedRideData = {
    "id": 0,
    "category": "Economy",
    "ride_type": "RIDE",
    "country": "Namibia",
    "city": "Windhoek",
    "base_fare": 19,
    "car_type": "normalTaxiEconomy",
    "app_label": "Normal Taxi",
    "description": "Enjoy affordable rides",
    "media": {"car_app_icon": "../images_res/normaltaxieconomy.jpg"},
    "availability": "available"
  }; //Will hold the map containing the selected ride by the user - by default: autoselect the first

  //? The predefined package sizes
  List packagesSizesGeneralData = [
    {
      'app_label': 'Small package',
      'package_type': 'envelope',
      'dimensions': '24cm x 25cm',
      'icon': 'Assets/Images/Delivery/envelope.png'
    },
    {
      'app_label': 'Medium package',
      'package_type': 'small',
      'dimensions': '47cm x 68cm x 50cm',
      'icon': 'Assets/Images/Delivery/small.png'
    },
    {
      'app_label': 'Large package',
      'package_type': 'large',
      'dimensions': '62cm x 46cm x 76cm',
      'icon': 'Assets/Images/Delivery/large.png'
    }
  ];

  late Map
      selectedPackageSize; //Will hold the package size selected by the user.

  late DateTime
      selectedScheduledDate; //The date selected for the scheduled trip
  late TimeOfDay
      selectedScheduledTime; //The time selected for the scheduled trip
  bool isTripScheduled =
      false; //To know whether or not the trip is scheduled - default: false

  //For the custom fare inputs
  final double maximumPercentageCustomFareUpLimit = 0.75; //75%
  double? customFareEntered; //The custom fare entered by the rider
  double? definitiveCustomFare; //The unchanging custom fare after validatiion
  bool isCustomFareConsidered =
      false; //Whether or not a custom fare was applied by the user.

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

  //?3. Update going until home
  void updateGoingUntilHome({required bool state}) {
    isGoingUntilHome = state;
    notifyListeners();
  }

  //?4. Provide the right vehicle images
  //SHould the receive the car type (Eg: normalTaxiEconomy)
  String provideRelevantVehiclesImages({required carType}) {
    Map serverLocalResourcesMap = {
      'normalTaxiEconomy': 'Assets/Images/Vehicles/economy_1.jpg',
      'electricEconomy': 'Assets/Images/Vehicles/economy_2.jpg',
      'comfortNormalRide': 'Assets/Images/Vehicles/comfort_1.jpg',
      'comfortElectricRide': 'Assets/Images/Vehicles/comfort_2.jpg',
      'luxuryNormalRide': 'Assets/Images/Vehicles/luxury_1.jpg',
      'luxuryElectricRide': 'Assets/Images/Vehicles/luxury_2.jpg',
      'electricBikes': 'Assets/Images/Vehicles/delivery_n1.jpg',
      'Motorbike': 'Assets/Images/Vehicles/delivery_n2.jpg',
      'carDelivery': 'Assets/Images/Vehicles/economy_1.jpg',
      'vanDelivery': 'Assets/Images/Vehicles/delivery_big1.jpg',
    };

    try {
      return serverLocalResourcesMap[carType];
    } catch (e) {
      //Return economy by default;
      print(e.toString());
      return serverLocalResourcesMap['normalTaxiEconomy'];
    }
  }

  //!---Pricing and booking meta variables
  Map<String, dynamic> pricingInputDataRaw = new Map();
  Map<String, dynamic> bookingDataSomething = new Map();
  //!-------------------------------------

  //?5. Update selected ride
  void updateSelectedRide(
      {required Map rideSelected, bool shouldUpdate = false}) {
    selectedRideData = rideSelected;
    notifyListeners();
  }

  //?6. Update the date for the scheduled trip
  void updateDateScheduledTrip({required DateTime date}) {
    selectedScheduledDate = date;
    notifyListeners();
  }

  //?7. Update the time for the scheduled trip
  void updateTimeScheduledTrip({required TimeOfDay time}) {
    selectedScheduledTime = time;
    notifyListeners();
  }

  //?8. Confirm scheduled pickup up date and time
  bool confirmScheduledPickupTime() {
    //Check if the time difference between the selected one and current one is not less than 15min
    TimeOfDay refTime = TimeOfDay.now();
    double refTimeSec = (refTime.hour * 3600) + (refTime.minute * 60);
    double scheduledSec = (selectedScheduledTime.hour * 3600) +
        (selectedScheduledTime.minute * 60);

    double diff = scheduledSec - refTimeSec;

    if (diff > 0) //Good
    {
      if (diff >= (15 * 60)) //>=15min
      {
        isTripScheduled = true;
        notifyListeners();
        return true;
      } else //No, should be 15min diff btwn the current time and the scheduled
      {
        notifyListeners();
        return false;
      }
    } else //No, should be 15min diff btwn the current time and the scheduled
    {
      notifyListeners();
      return false;
    }
  }

  //?9. Remove previously scheduled date and time
  void removePreviouslyScheduledDateAndTime() {
    selectedScheduledDate = DateTime.now();
    selectedScheduledTime =
        TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 15)));
    isTripScheduled = false; //?Crucial
    //...
    notifyListeners();
  }

  //?10. Format time to AM/PM format
  String formatTimeToAMPorPMformat({required TimeOfDay time}) {
    return '${DateFormat('h:mm a').format(DateFormat('hh:mm').parse('${time.hour}:${time.minute}'))}';
  }

  //?11. Get the prices range in which the custom fare should lie in.
  Map getCustomFareRange() {
    //The maximum custom fare should be = base fare + (based Fare)*60%
    //The minimum custom fare should be = base fare + 1
    double baseFare = double.parse(selectedRideData['base_fare'].toString());
    double maximumCustomFare =
        baseFare + (baseFare * maximumPercentageCustomFareUpLimit);

    return {'max': maximumCustomFare.round(), 'min': baseFare.round() + 1};
  }

  //?12. Update the custom fare value on change
  void updateCustomFareValueOnChange({required double customFareValue}) {
    try {
      if (customFareValue > 0) {
        customFareEntered = customFareValue;
      } else //Set to null
      {
        customFareEntered = null;
      }
    } catch (e) {
      customFareEntered = customFareValue;
    }
    notifyListeners();
  }

  //?13. Set custom fare value
  Map setCustomFareValue() {
    if (customFareEntered != null) //Good
    {
      //Check that the custom fare is within the acceptable range
      Map fareRange = this.getCustomFareRange();
      if (fareRange['min'] <= customFareEntered &&
          fareRange['max'] >= customFareEntered) //Clear
      {
        definitiveCustomFare = customFareEntered; //!Crucial
        isCustomFareConsidered = true;
        notifyListeners();
        return {'response': true};
      } else //Out of Range
      {
        notifyListeners();
        return {'response': 'out_of_range'};
      }
    } else //No value provided
    {
      notifyListeners();
      return {'response': 'no_change'};
    }
  }

  //?14. Remove custom fare previously set
  void removeCustomFare() {
    definitiveCustomFare = null; //!crucial
    customFareEntered = null;
    isCustomFareConsidered = false;
    notifyListeners();
  }

  //?15. Update selected package size
  void updateSelectedPackageSize(
      {required Map packageSizeSelected, bool shouldUpdate = true}) {
    print('Package size updated');
    selectedPackageSize = packageSizeSelected;
    if (shouldUpdate) {
      notifyListeners();
    }
  }

  //?17. Update connect type
  void updateConnectType({required String connecTypeSelected}) {
    selectedConnectType = connecTypeSelected;
  }

  //?18. Update pricing data
  Future updatePricingDataForComputation(
      {required Map<String, dynamic> userLocation,
      required BuildContext context}) async {
    pricingInputDataRaw['user_fingerprint'] =
        context.read<HomeProvider>().user_fingerprint;
    pricingInputDataRaw['country'] = userLocation['country'];
    pricingInputDataRaw['connectType'] = this.selectedConnectType;
    pricingInputDataRaw['timeScheduled'] = 'now';
    pricingInputDataRaw['naturePickup'] =
        'PrivateLocation'; //Force PrivateLocation type if nothing found]
    pricingInputDataRaw['passengersNo'] = this.selectedPassengersNo;
    pricingInputDataRaw['isAllGoingToSameDestination'] =
        this.isGoingToTheSameDestination;
    pricingInputDataRaw['isGoingUntilHome'] =
        this.isGoingUntilHome; //! Will double the fares for the Economy]
    pricingInputDataRaw['rideType'] = context
        .read<SmartBookingStepsProvider>()
        .currentProcessMother
        .toUpperCase()
        .trim(); //RIDE/DELIVERY

    pricingInputDataRaw['pickupData'] = {
      'coordinates': [
        context.read<HomeProvider>().userLocationCoords[
            'latitude'], //TODO: should be set to the selected pickup location
        context.read<HomeProvider>().userLocationCoords['longitude']
      ],
      'location_name':
          userLocation['name'] != null ? userLocation['name'] : false,
      'street_name':
          userLocation['street'] != null ? userLocation['street'] : false,
      'city': userLocation['city'] != null ? userLocation['city'] : false,
    };

    pricingInputDataRaw['destinationData'] = {
      'passenger1Destination':
          context.read<SearchProvider>().destination1Data['location_name'] !=
                  null
              ? context.read<SearchProvider>().destination1Data
              : false, //Passenger 1 destination's details
      'passenger2Destination':
          context.read<SearchProvider>().destination2Data['location_name'] !=
                  null
              ? context.read<SearchProvider>().destination2Data
              : false, //Passenger 2 destination's details
      'passenger3Destination':
          context.read<SearchProvider>().destination3Data['location_name'] !=
                  null
              ? context.read<SearchProvider>().destination3Data
              : false, //Passenger 3 destination's details
      'passenger4Destination':
          context.read<SearchProvider>().destination4Data['location_name'] !=
                  null
              ? context.read<SearchProvider>().destination4Data
              : false, //Passenger 4 destination's details
    };

    //...
    print(pricingInputDataRaw);
    String urlString = '$hostname:9797/getOverallPricingAndAvailabilityDetails';
    Response response = await post(Uri.parse(Uri.encodeFull(urlString)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pricingInputDataRaw));

    if (response.statusCode == 200) //Ok
    {
      print(response.body);
      ridesEstimationsData = new Future(() {
        return json.decode(response.body);
      });
    } else //Error
    {
      print(response.statusCode);
    }
  }
}
