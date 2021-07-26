import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String getFutureDestinationRouteName({required int navigationStepIndex}) {
    if (currentProcessMother.trim().toLowerCase() == 'ride') {
      if (navigationStepIndex + 1 < _rideWorkflow.length) //Good
      {
        return _rideWorkflow[navigationStepIndex + 1];
      } else {
        return _rideWorkflow[navigationStepIndex];
      }
    } else if (currentProcessMother.trim().toLowerCase() == 'delivery') {
      if (navigationStepIndex + 1 < _deliveryWorkflow.length) //Good
      {
        return _deliveryWorkflow[navigationStepIndex + 1];
      } else {
        return _deliveryWorkflow[navigationStepIndex];
      }
    } else //Ride by default
    {
      if (navigationStepIndex + 1 < _rideWorkflow.length) //Good
      {
        return _rideWorkflow[navigationStepIndex + 1];
      } else {
        return _rideWorkflow[navigationStepIndex];
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
    log('process name --> $processParentName');
    log('current step index --> ${navigationStepIndex.toString()}');
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

  //?Restore height size
  void restoreHeightSize(
      {required int currentStateIndex,
      required BuildContext context,
      double percPanelOpening = 1}) {
    if (getFutureDestinationRouteName(navigationStepIndex: currentStateIndex) ==
        'rideTypeSelection') {
      context.read<HomeProvider>().updatePanelMinMaxHeights(
          newMinHeight: 200,
          newMaxHeight: (ScreenUtil().screenHeight * 0.6) + 120);
      context.read<HomeProvider>().panelController.animatePanelToPosition(1.0,
          curve: Curves.easeInOutCubic); //Raise panel height
    } else if (getFutureDestinationRouteName(
            navigationStepIndex: currentStateIndex) ==
        'summary') {
      context.read<HomeProvider>().updatePanelMinMaxHeights(
          newMinHeight: 200,
          newMaxHeight: (ScreenUtil().screenHeight * 0.6) + 120);
      context.read<HomeProvider>().panelController.animatePanelToPosition(1.0,
          curve: Curves.easeInOutCubic); //Raise panel height
    } else //Restore to half the height size
    {
      context.read<HomeProvider>().updatePanelMinMaxHeights(
          newMinHeight: 200,
          newMaxHeight: ScreenUtil().screenHeight * 0.55,
          percPanelOpening: percPanelOpening);
    }
    //...
    //----------------------------------------
  }

  //?3. Navigate to future destination route
  void navigateToFutureDestRoute(
      {required BuildContext context, bool wasDueToPanel = false}) {
    int currentStateIndex = currentNavigationStateIndex;
    int futureStateIndex = currentStateIndex + 1;
    int previousStateIndex = currentNavigationStateIndex - 1 >= 0
        ? currentNavigationStateIndex - 1
        : currentNavigationStateIndex;

    //...
    if (wasDueToPanel == true &&
        futureStateIndex ==
            1) //!Only allow once if it was due to the panel up action
    {
      futureNavigatorProcessor(
          context: context,
          currentStateIndex: currentStateIndex,
          futureStateIndex: futureStateIndex,
          previousStateIndex: previousStateIndex);
    } else if (wasDueToPanel == false) //!Navigate
    {
      futureNavigatorProcessor(
          context: context,
          currentStateIndex: currentStateIndex,
          futureStateIndex: futureStateIndex,
          previousStateIndex: previousStateIndex);
    }
  }

  //? Future navigator processor
  void futureNavigatorProcessor(
      {required BuildContext context,
      required int currentStateIndex,
      required int futureStateIndex,
      required int previousStateIndex}) {
    currentNavigationStateIndex = futureStateIndex == 4
        ? futureStateIndex + 1
        : futureStateIndex; //?Very important
    futureStateIndex = futureStateIndex == 4
        ? futureStateIndex + 1
        : futureStateIndex; //!Avoid empty destinations (eg: DestinationInput, receiver input, package size selection)

    //?Restore height size
    restoreHeightSize(currentStateIndex: currentStateIndex, context: context);
    //----------------------------------------

    if (currentProcessMother == 'ride') {
      currentProcessMother = 'ride';
      //...
      currentWidgetInFocus = getRelevantWidgetToShowIntheSlider(
          context: context,
          processParentName: currentProcessMother,
          navigationStepIndex: futureStateIndex);
      //Update avery change
      notifyListeners();
    } else //Delivery
    {}
  }

  //?4. Navigate to future destination route
  void navigateToPreviousDestRoute(
      {required BuildContext context,
      bool wasDueToPanel = false,
      bool doSkipLabelClose = true}) {
    int currentStateIndex = currentNavigationStateIndex;
    int futureStateIndex = currentStateIndex + 1;
    int previousStateIndex = currentNavigationStateIndex - 1 >= 0
        ? currentNavigationStateIndex - 1
        : currentNavigationStateIndex;

    if (wasDueToPanel == true &&
        currentStateIndex ==
            0) //!Only allow once if it was due to the panel up action
    {
      previousNavigatorProcessor(
          context: context,
          currentStateIndex: currentStateIndex,
          futureStateIndex: futureStateIndex,
          previousStateIndex: previousStateIndex,
          doSkipLabelClose: doSkipLabelClose);
    } else if (wasDueToPanel == false) //!Navigate
    {
      previousNavigatorProcessor(
          context: context,
          currentStateIndex: currentStateIndex,
          futureStateIndex: futureStateIndex,
          previousStateIndex: previousStateIndex,
          doSkipLabelClose: doSkipLabelClose);
    }
  }

  //? Previous navigator processor
  void previousNavigatorProcessor(
      {required BuildContext context,
      required int currentStateIndex,
      required int futureStateIndex,
      required int previousStateIndex,
      bool doSkipLabelClose = true}) {
    //?Restore height size
    restoreHeightSize(currentStateIndex: currentStateIndex, context: context);
    //----------------------------------------
    currentWidgetInFocus = GenericGreeting();
    //! Restore for minimal
    if (getPreviousDestinationRouteName() == 'minimal' &&
        doSkipLabelClose == false) {
      //?Restore height size
      restoreHeightSize(
          currentStateIndex: currentStateIndex,
          context: context,
          percPanelOpening: 0.0);
      //----------------------------------------
      context.read<HomeProvider>().panelController.animatePanelToPosition(0.0,
          curve: Curves.easeInOutCubic); //Raise panel height
    }

    previousStateIndex = previousStateIndex == 4
        ? previousStateIndex - 1
        : previousStateIndex; //!Avoid empty destinations (eg: DestinationInput, receiver input, package size selection)
    currentNavigationStateIndex = previousStateIndex; //?Very important

    currentWidgetInFocus = getRelevantWidgetToShowIntheSlider(
        context: context,
        processParentName: currentProcessMother,
        navigationStepIndex: previousStateIndex);
    //...
    notifyListeners();
  }
}
