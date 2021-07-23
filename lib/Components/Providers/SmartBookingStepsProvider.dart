import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/ChooseVehicleType.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/ConnectMeUsSelection.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/GenericGreeting.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/PassengersNumberSelection.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/PickupNoteInserter.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/RideDeliverySelection.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/SummaryTrip.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:provider/provider.dart';

///? SMART BOOKING STEPS PROVIDER
///Will manage the route steps of the booking and will know exactly what route to provide
///based on the current or future state of the user selection.

class SmartBookingStepsProvider with ChangeNotifier {
  final List<String> _rideWorkflow = [
    'minimal', //Where the  greeting lies - shared
    'productSelection', //?Shared navigation step
    'connectType',
    'passengersNo',
    'destinationInput',
    'pickupNote',
    'rideTypeSelection',
    'summary'
  ]; //Hold all the route steps for a ride booking
  final List<String> _deliveryWorkflow = [
    'minimal', //Where the  greeting lies - shared
    'productSelection', //?Shared navigation step
    'receiverInfoInput',
    'destinationInput',
    'deliveryNote',
    'vehicleTypeSelection',
    'summary'
  ]; //Hold all the route steps for a delivery booking
  String currentProcessMother =
      'ride'; //The current parent process of the navigation (ride or delivery)
  int currentNavigationStateIndex =
      0; //The index representing the current navigation step
  Widget currentWidgetInFocus = GenericGreeting(); //The widget currently shown

  //?1. Get current navigation step name
  String getCurrentNavigationStepName() {
    if (currentProcessMother.trim().toLowerCase() == 'ride') {
      return _rideWorkflow[currentNavigationStateIndex];
    } else if (currentProcessMother.trim().toLowerCase() == 'delivery') {
      return _deliveryWorkflow[currentNavigationStateIndex];
    } else //Ride by default
    {
      return _rideWorkflow[currentNavigationStateIndex];
    }
  }

  //?2. Get future destination route name
  String getFutureDestinationRouteName() {
    if (currentProcessMother.trim().toLowerCase() == 'ride') {
      if (currentNavigationStateIndex + 1 <= _rideWorkflow.length) //Good
      {
        return _rideWorkflow[currentNavigationStateIndex + 1];
      } else {
        return _rideWorkflow[currentNavigationStateIndex];
      }
    } else if (currentProcessMother.trim().toLowerCase() == 'delivery') {
      if (currentNavigationStateIndex + 1 <= _deliveryWorkflow.length) //Good
      {
        return _deliveryWorkflow[currentNavigationStateIndex + 1];
      } else {
        return _deliveryWorkflow[currentNavigationStateIndex];
      }
    } else //Ride by default
    {
      if (currentNavigationStateIndex + 1 <= _rideWorkflow.length) //Good
      {
        return _rideWorkflow[currentNavigationStateIndex + 1];
      } else {
        return _rideWorkflow[currentNavigationStateIndex];
      }
    }
  }

  //?2. Get previous destination route name
  String getPreviousDestinationRouteName() {
    if (currentProcessMother.trim().toLowerCase() == 'ride') {
      if (currentNavigationStateIndex - 1 >= 0) //Good
      {
        return _rideWorkflow[currentNavigationStateIndex - 1];
      } else {
        return _rideWorkflow[currentNavigationStateIndex];
      }
    } else if (currentProcessMother.trim().toLowerCase() == 'delivery') {
      if (currentNavigationStateIndex - 1 >= 0) //Good
      {
        return _deliveryWorkflow[currentNavigationStateIndex - 1];
      } else {
        return _deliveryWorkflow[currentNavigationStateIndex];
      }
    } else //Ride by default
    {
      if (currentNavigationStateIndex - 1 >= 0) //Good
      {
        return _rideWorkflow[currentNavigationStateIndex - 1];
      } else {
        return _rideWorkflow[currentNavigationStateIndex];
      }
    }
  }

  //?3. Provide the current widget to show
  Widget getRelevantWidgetToShowIntheSlider(
      {required BuildContext context,
      required String processParentName,
      required int navigationStepIndex}) {
    if (processParentName == 'ride') {
      // 'minimal', //Where the  greeting lies - shared
      // 'productSelection', //?Shared navigation step
      // 'connectType',
      // 'passengersNo',
      // 'destinationInput',  --NOT included
      // 'pickupNote',
      // 'rideTypeSelection',
      // 'summary'
      switch (_rideWorkflow[navigationStepIndex]) {
        case 'minimal':
          return GenericGreeting();
        case 'productSelection':
          return RideDeliverySelection();
        case 'connectType':
          return ConnectMeUsSelection();
        case 'passengersNo':
          return PassengersNumberSelection();
        case 'pickupNote':
          return PickupNoteInserter();
        case 'rideTypeSelection':
          return ChooseVehicleType(
              controller: context.read<HomeProvider>().parenControllerChild);
        case 'summary':
          return SummaryTrip(
              controller: context.read<HomeProvider>().parenControllerChild);
        default:
          return GenericGreeting();
      }
    } else //Delivery
    {
      // 'minimal', //Where the  greeting lies - shared
      // 'productSelection', //?Shared navigation step
      // 'receiverInfoInput', --Not included
      // 'destinationInput',  --Not included
      // 'deliveryNote',
      // 'vehicleTypeSelection',
      // 'summary'
      switch (_deliveryWorkflow[navigationStepIndex]) {
        case 'minimal':
          return GenericGreeting();
        case 'productSelection':
          return RideDeliverySelection();
        case 'deliveryNote':
          return PickupNoteInserter();
        case 'rideTypeSelection':
          return ChooseVehicleType(
              controller: context.read<HomeProvider>().parenControllerChild);
        case 'summary':
          return SummaryTrip(
              controller: context.read<HomeProvider>().parenControllerChild);
        default:
          return GenericGreeting();
      }
    }
  }

  //?3. Navigate to future destination route
  void navigateToFutureDestRoute() {
    int currentStateIndex = currentNavigationStateIndex;
    int futureStateIndex = currentStateIndex + 1;
    int previousStateIndex = currentNavigationStateIndex - 1 >= 0
        ? currentNavigationStateIndex - 1
        : currentNavigationStateIndex;
    //...
    if (currentProcessMother == 'ride') {
    } else //Delivery
    {}
  }
}
