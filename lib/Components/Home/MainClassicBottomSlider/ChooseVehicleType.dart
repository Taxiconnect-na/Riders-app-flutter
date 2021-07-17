import 'dart:developer';

import 'package:flutter/material.dart';
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
  Future _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 3)));

    log(selectedDate.toString());
    return selectedDate;
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 5),
                //   child: Text("Pickup note?",
                //       style: TextStyle(
                //           fontFamily: 'MoveTextMedium', fontSize: 18)),
                // ),
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
                          GenericRectButton(
                            label: 'Confirm',
                            labelFontSize: 22,
                            isArrowShow: false,
                            horizontalPadding: 10,
                            actuatorTrailingFunctional: () =>
                                this._selectDate(context),
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
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
      child: FutureBuilder(
          future: context.read<TripProvider>().ridesEstimationsData,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.hasError == false) //Good
            {
              //log(snapshot.data.toString());
              // context
              //     .read<TripProvider>()
              //     .updateSelectedRide(rideSelected: snapshot.data[0]);
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
                            //horizontalTitleGap: 5,
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
                        height: 25,
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
