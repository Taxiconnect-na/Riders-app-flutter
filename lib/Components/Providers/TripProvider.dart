import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///? TRIP PROVIDER
///Hold the provider responsible for the management of trips (rides, deliveries) only.

class TripProvider with ChangeNotifier {
  int selectedPassengersNo =
      1; //Hold the current number of selected passengers for a trip - default: 1 , max 4
  bool isGoingToTheSameDestination =
      false; //To know whether or not the passengers are going to the same destination. - default: false, only makes sense for more than 1 passenger
  bool isGoingUntilHome =
      false; //TO know whether or not the passengers are going until home - default: false
  TextEditingController noteInputController =
      new TextEditingController(); //The controller to manipulate the note text input.
  String? pickupNoteText; //The text value of the pickup note - default:null
  Future? ridesEstimationsData = new Future(() {
    return [
      {
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
      },
      {
        "id": 1,
        "category": "Economy",
        "ride_type": "RIDE",
        "country": "Namibia",
        "city": "Windhoek",
        "base_fare": 20,
        "car_type": "electricEconomy",
        "app_label": "Electric car",
        "description": "Zero emission all the way",
        "media": {"car_app_icon": "../images_res/electricEconomy.jpg"},
        "availability": "available"
      },
      {
        "id": 2,
        "category": "Comfort",
        "ride_type": "RIDE",
        "country": "Namibia",
        "city": "Windhoek",
        "base_fare": 70,
        "car_type": "comfortNormalRide",
        "app_label": "Normal car",
        "description": "Ride in comfort",
        "media": {"car_app_icon": "../images_res/comfortrideNormal.jpg"},
        "availability": "available"
      },
      {
        "id": 3,
        "category": "Comfort",
        "ride_type": "RIDE",
        "country": "Namibia",
        "city": "Windhoek",
        "base_fare": 65,
        "car_type": "comfortElectricRide",
        "app_label": "Electric car",
        "description": "Get there in silence",
        "media": {"car_app_icon": "../images_res/comfortrideElectric.jpg"},
        "availability": "unavailable"
      },
      {
        "id": 4,
        "category": "Luxury",
        "ride_type": "RIDE",
        "country": "Namibia",
        "city": "Windhoek",
        "base_fare": 190,
        "car_type": "luxuryNormalRide",
        "app_label": "Normal car",
        "description": "Enjoy the best luxury",
        "media": {"car_app_icon": "../images_res/luxuryRideNormal.jpg"},
        "availability": "unavailable"
      },
      {
        "id": 5,
        "category": "Luxury",
        "ride_type": "RIDE",
        "country": "Namibia",
        "city": "Windhoek",
        "base_fare": 250,
        "car_type": "luxuryElectricRide",
        "app_label": "Electric car",
        "description": "Luxury with zero emission",
        "media": {"car_app_icon": "../images_res/luxuryRideElectric.jpg"},
        "availability": "unavailable"
      }
    ];
  }); //Will hold all the prices estimations coming straight from up.
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

  late DateTime
      selectedScheduledDate; //The date selected for the scheduled trip
  late TimeOfDay
      selectedScheduledTime; //The time selected for the scheduled trip
  bool isTripScheduled =
      false; //To know whether or not the trip is scheduled - default: false

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
        return true;
      } else //No, should be 15min diff btwn the current time and the scheduled
      {
        return false;
      }
    } else //No, should be 15min diff btwn the current time and the scheduled
    {
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
}
