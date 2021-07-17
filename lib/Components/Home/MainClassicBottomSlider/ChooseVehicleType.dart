import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';

class ChooseVehicleType extends StatelessWidget {
  const ChooseVehicleType({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Column(
                        children: [
                          Expanded(child: CreateDynamicallyListOfCars()),
                          GenericRectButton(
                            label: 'Confirm',
                            isArrowShow: false,
                            horizontalPadding: 0,
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
  const CreateDynamicallyListOfCars({Key? key}) : super(key: key);

  @override
  _CreateDynamicallyListOfCarsState createState() =>
      _CreateDynamicallyListOfCarsState();
}

class _CreateDynamicallyListOfCarsState
    extends State<CreateDynamicallyListOfCars> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Rides estimates'),
    );
  }
}
