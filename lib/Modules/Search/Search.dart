import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';

///Search destination/pickup location

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
          bottom: false,
          child: Column(
            children: [GoBackPart(), HeaderPart(), BottomPart()],
          )),
    );
  }
}

//Go back part
class GoBackPart extends StatelessWidget {
  const GoBackPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 27, color: Colors.black),
        ),
      ),
    );
  }
}

//Header part
class HeaderPart extends StatefulWidget {
  const HeaderPart({Key? key}) : super(key: key);

  @override
  _HeaderPartState createState() => _HeaderPartState();
}

class _HeaderPartState extends State<HeaderPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 7),
                spreadRadius: 1,
                blurRadius: 6)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: 20,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 1),
                      child: Container(
                        width: 1,
                        height: 45,
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.5)),
                      ),
                    ),
                    Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(9, 110, 212, 1)),
                            color: Color.fromRGBO(9, 110, 212, 1)))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  //decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                width: 1, color: Colors.grey.shade300)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                              maxLength: 35,
                              style: TextStyle(fontSize: 17),
                              decoration: InputDecoration(
                                  counterText: "",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: 'Pickup location',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 11))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DestinationInputsFields()
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//Destination input fields
class DestinationInputsFields extends StatelessWidget {
  const DestinationInputsFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        child: GenerateDestInputsConditionally(),
      ),
    );
  }
}

//Generate destination inputs conditionally to the number of passengers
class GenerateDestInputsConditionally extends StatelessWidget {
  const GenerateDestInputsConditionally({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int passengersNo = context.read<TripProvider>().selectedPassengersNo;

    if (context
        .read<TripProvider>()
        .isGoingToTheSameDestination) //Show one field
    {
      return Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          children: [
            SingleDestinationTypeInput(
              passengerIndex: 1,
              bottomOutsidePadding: 10,
            )
          ],
        ),
      );
    } else //Process
    {
      switch (passengersNo) {
        case 1:
          return Container(
            //decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Column(
              children: [
                SingleDestinationTypeInput(
                  passengerIndex: 1,
                  bottomOutsidePadding: 10,
                )
              ],
            ),
          );
        case 2:
          return Container(
            //decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Column(
              children: [
                SingleDestinationTypeInput(
                  passengerIndex: 1,
                  bottomOutsidePadding: 10,
                ),
                SingleDestinationTypeInput(
                  passengerIndex: 2,
                  bottomOutsidePadding: 10,
                )
              ],
            ),
          );
        case 3:
          return Container(
            //decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Column(
              children: [
                SingleDestinationTypeInput(
                  passengerIndex: 1,
                  bottomOutsidePadding: 10,
                ),
                SingleDestinationTypeInput(
                  passengerIndex: 2,
                  bottomOutsidePadding: 10,
                ),
                SingleDestinationTypeInput(
                  passengerIndex: 3,
                  bottomOutsidePadding: 10,
                )
              ],
            ),
          );
        case 4:
          return Container(
            //decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Column(
              children: [
                SingleDestinationTypeInput(
                  passengerIndex: 1,
                  bottomOutsidePadding: 10,
                ),
                SingleDestinationTypeInput(
                  passengerIndex: 2,
                  bottomOutsidePadding: 10,
                ),
                SingleDestinationTypeInput(
                  passengerIndex: 3,
                  bottomOutsidePadding: 10,
                ),
                SingleDestinationTypeInput(
                  passengerIndex: 4,
                  bottomOutsidePadding: 10,
                )
              ],
            ),
          );
        default:
          return Container(
            child: Text('Please restart the app.'),
          );
      }
    }
  }
}

//Single destination type input
class SingleDestinationTypeInput extends StatelessWidget {
  final int passengerIndex; //The passenger no individual: 1,2,3 or 4
  final double bottomOutsidePadding; //The outside padding of the input field

  SingleDestinationTypeInput(
      {Key? key, required this.passengerIndex, this.bottomOutsidePadding = 0})
      : super(key: key);

  String generatePlaceholder(BuildContext context) {
    if (context.read<TripProvider>().isGoingToTheSameDestination) {
      return 'Where are you going?';
    } else {
      if (context.read<TripProvider>().selectedPassengersNo > 1) {
        return 'Passenger ${this.passengerIndex} destination';
      } else {
        return 'Where are you going?';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: this.bottomOutsidePadding),
      child: Container(
        height: 33,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(width: 1, color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: TextField(
              showCursor: true,
              maxLength: 35,
              style: TextStyle(fontSize: 17),
              decoration: InputDecoration(
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: this.generatePlaceholder(context),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 11))),
        ),
      ),
    );
  }
}

//Bottom part
class BottomPart extends StatefulWidget {
  const BottomPart({Key? key}) : super(key: key);

  @override
  _BottomPartState createState() => _BottomPartState();
}

class _BottomPartState extends State<BottomPart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Text('Bottom part'),
        ),
      ),
    );
  }
}
