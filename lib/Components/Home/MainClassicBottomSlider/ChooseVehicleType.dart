import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';

class ChooseVehicleType extends StatelessWidget {
  final ScrollController controller;
  const ChooseVehicleType({Key? key, required this.controller})
      : super(key: key);

  //? Ride scheduling
  void startScheduleRideProcess(BuildContext context) {
    //! Safely initialize the current date and time+15min
    context
        .read<TripProvider>()
        .updateDateScheduledTrip(date: DateTime.now()); //Date
    context.read<TripProvider>().updateTimeScheduledTrip(
        time: TimeOfDay.fromDateTime(
            DateTime.now().add(Duration(minutes: 15)))); //Time
    //!...
    context
        .read<HomeProvider>()
        .panelController
        .animatePanelToPosition(0, curve: Curves.easeInOutCubic);
    //this._selectDate(context);
    Future tripScheduleModal = showModalBottomSheet(
        //enableDrag: false,
        context: context,
        builder: (context) {
          return Container(
              color: Colors.white,
              child: SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                color: Colors.white,
                child: Container(
                  //decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Column(
                    children: [
                      Container(
                        //decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text('Schedule your ride',
                              style: TextStyle(
                                  fontFamily: 'MoveTextMedium', fontSize: 23)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(),
                      InkWell(
                        onTap: () => this._selectDate(context),
                        child: Container(
                          //decoration: BoxDecoration(border: Border.all(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                                '${DateFormat('EEE, MMM d').format(context.watch<TripProvider>().selectedScheduledDate)}',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () => this._selectTime(context),
                        child: Container(
                          //decoration: BoxDecoration(border: Border.all(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                                'At ${context.read<TripProvider>().formatTimeToAMPorPMformat(time: context.watch<TripProvider>().selectedScheduledTime)}',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                      Expanded(child: Text('')),
                      FittedBox(
                        child: GenericRectButton(
                            label: 'Confirm pickup time',
                            labelFontSize: 20,
                            isArrowShow: false,
                            actuatorFunctionl: () {
                              Navigator.pop(context); //Close schedule modal
                              //Reopen the main Panel
                              context
                                  .read<HomeProvider>()
                                  .panelController
                                  .animatePanelToPosition(1,
                                      curve: Curves.easeInOutCubic);
                            }),
                      )
                    ],
                  ),
                ),
              )));
        });
    //...
    tripScheduleModal.then((value) {
      //? Modal closed - restore the main Panel
      context
          .read<HomeProvider>()
          .panelController
          .animatePanelToPosition(1, curve: Curves.easeInOutCubic);
    });
  }

  //?Select futuree booking date
  void _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        helpText: 'PICKUP DATE',
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 2)));

    log(selectedDate.toString());
    if (selectedDate != null) {
      context.read<TripProvider>().updateDateScheduledTrip(date: selectedDate);
    }
  }

  //?Select future booking time
  void _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        helpText: 'PICKUP TIME',
        initialTime:
            TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 15))));

    if (selectedTime != null) {
      context.read<TripProvider>().updateTimeScheduledTrip(
          time: selectedTime.replacing(hour: selectedTime.hourOfPeriod));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        top: false,
        child: Container(
          // decoration:
          //     BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Choose a vehicle, or swipe up for more",
                      style: TextStyle(
                          fontFamily: 'MoveTextRegular', fontSize: 13)),
                ),
                Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: CreateDynamicallyListOfCars(
                                    controller: this.controller,
                                  ))),
                          PaymentMethodSelector(),
                          GenericRectButton(
                            label: 'Confirm',
                            activateTrailing: true,
                            labelFontSize: 22,
                            isArrowShow: false,
                            horizontalPadding: 10,
                            actuatorTrailingFunctional: () =>
                                this.startScheduleRideProcess(context),
                            actuatorFunctionl: () =>
                                showMaterialModalBottomSheet(
                                    duration: Duration(milliseconds: 400),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                          color: Colors.white,
                                          child: SafeArea(
                                              bottom: false,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.white,
                                                child: Search(),
                                              )));
                                    }),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Create dynamically the list of car types
class CreateDynamicallyListOfCars extends StatefulWidget {
  final ScrollController controller;
  const CreateDynamicallyListOfCars({Key? key, required this.controller})
      : super(key: key);

  @override
  _CreateDynamicallyListOfCarsState createState() =>
      _CreateDynamicallyListOfCarsState(controller: this.controller);
}

class _CreateDynamicallyListOfCarsState
    extends State<CreateDynamicallyListOfCars> {
  final ScrollController controller;

  _CreateDynamicallyListOfCarsState({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // decoration:
      //     BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
      child: FutureBuilder(
          future: context.read<TripProvider>().ridesEstimationsData,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.hasError == false) //Good
            {
              //log(snapshot.data.toString());
              return generateListOfVehiclesEstimates(snapshot.data, context);
            }
            //...Loading
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  //Generate list of vehicle estimates.
  Widget generateListOfVehiclesEstimates(List data, BuildContext context) {
    List headerKeeper =
        []; //Responsible for keeping track of the headers and show all of them non duplicatas and at relevant places.

    return Container(
      // decoration:
      //     BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: ListView.builder(
          controller: this.controller,
          padding: EdgeInsets.zero,
          itemCount: data.length,
          itemBuilder: (context, int index) {
            bool shouldShowHeader = headerKeeper.length > 0 &&
                    headerKeeper.last['category']
                            .toString()
                            .trim()
                            .toLowerCase() ==
                        data[index]['category'].toString().trim().toLowerCase()
                ? false
                : true; //Whether or not to show the header
            headerKeeper.add(data[index]);
            //...
            //! Check the availability of the ride
            bool rideAvailability =
                data[index]['availability'].toString().trim().toLowerCase() ==
                    'available';
            //? Check if the ride was selected
            bool wasTheRideSelected = data[index]['car_type'] ==
                context.watch<TripProvider>().selectedRideData['car_type'];
            //...
            return Column(
              children: [
                Visibility(
                    visible: shouldShowHeader,
                    child: Padding(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 15, right: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // decoration:
                          //     BoxDecoration(border: Border.all(width: 1)),
                          child: Text(data[index]['category'].toString().trim(),
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'MoveTextMedium')),
                        ))),
                Opacity(
                  opacity: rideAvailability ? 1 : 0.6,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          child: ListTile(
                            onTap: () => rideAvailability
                                ? context
                                    .read<TripProvider>()
                                    .updateSelectedRide(
                                        rideSelected: data[index],
                                        shouldUpdate: true)
                                : {},
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                                width: 65,
                                height: 55,
                                //decoration: BoxDecoration(border: Border.all(width: 1)),
                                child: Image.asset(context
                                    .read<TripProvider>()
                                    .provideRelevantVehiclesImages(
                                        carType: data[index]['car_type']))),
                            title: Container(
                                alignment: Alignment.topLeft,
                                //decoration: BoxDecoration(border: Border.all(width: 1)),
                                child: Column(
                                  children: [
                                    Text(data[index]['app_label'].toString(),
                                        style: TextStyle(
                                            fontFamily: 'MoveTextMedium',
                                            fontSize: 17)),
                                  ],
                                )),
                            subtitle: rideAvailability
                                ? Text(data[index]['description'])
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        size: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(width: 2),
                                      Text('Unavailable'),
                                    ],
                                  ),
                            trailing: Visibility(
                              visible: rideAvailability,
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 100,
                                //decoration: BoxDecoration(border: Border.all(width: 1)),
                                child: Text(
                                    'N\$ ${data[index]['base_fare'].toString()}',
                                    style: TextStyle(
                                        fontFamily: 'MoveTextBold',
                                        fontSize: 20)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: wasTheRideSelected,
                        child: Container(
                          height: 72,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.15)),
                        ),
                      )
                    ],
                  ),
                ),
                shouldShowHeader
                    ? Divider(
                        height: 15,
                        color: Colors.white,
                      )
                    : SizedBox(
                        height: 50,
                      )
              ],
            );
          }),
    );
  }
}

class PaymentMethodSelector extends StatefulWidget {
  const PaymentMethodSelector({Key? key}) : super(key: key);

  @override
  _PaymentMethodSelectorState createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 1, color: Colors.grey.shade100))),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListTile(
              onTap: () => print('Selected preferred payment method.'),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 5,
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    //border: Border.all(width: 1),
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(14, 132, 145, 1)),
                child: Icon(Icons.account_balance_wallet,
                    size: 23, color: Colors.white),
              ),
              title: Text('Wallet',
                  style: TextStyle(fontFamily: 'MoveTextMedium', fontSize: 16)),
              trailing: Icon(Icons.chevron_right))),
    );
  }
}
