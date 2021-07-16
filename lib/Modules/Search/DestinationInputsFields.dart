import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/SearchProvider.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';

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
class SingleDestinationTypeInput extends StatefulWidget {
  final int passengerIndex; //The passenger no individual: 1,2,3 or 4
  final double bottomOutsidePadding; //The outside padding of the input field
  const SingleDestinationTypeInput(
      {Key? key, required this.passengerIndex, this.bottomOutsidePadding = 0})
      : super(key: key);

  @override
  _SingleDestinationTypeInputState createState() =>
      _SingleDestinationTypeInputState(
          passengerIndex: this.passengerIndex,
          bottomOutsidePadding: this.bottomOutsidePadding);
}

class _SingleDestinationTypeInputState
    extends State<SingleDestinationTypeInput> {
  final int passengerIndex; //The passenger no individual: 1,2,3 or 4
  final double bottomOutsidePadding; //The outside padding of the input field
  final FocusNode destinationFocusNode =
      new FocusNode(); //The focus node of the specific destination field.

  _SingleDestinationTypeInputState(
      {required this.passengerIndex, this.bottomOutsidePadding = 0});

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
  void initState() {
    // TODO: implement initState
    super.initState();

    this.destinationFocusNode.addListener(() {
      if (this.destinationFocusNode.hasFocus) {
        context.read<SearchProvider>().updateSelectedLocationFieldIndex(
            newLocationIndex: this.passengerIndex);
        //..
        print(
            'Passenger ${context.read<SearchProvider>().selectedLocationFieldIndex}');
      }
    });
  }

  TextEditingController getTheCurrentTextFieldController() {
    switch (this.passengerIndex) {
      case 1:
        return context.read<SearchProvider>().destination1Controller;
      case 2:
        return context.read<SearchProvider>().destination2Controller;
      case 3:
        return context.read<SearchProvider>().destination3Controller;
      case 4:
        return context.read<SearchProvider>().destination4Controller;
      default:
        return new TextEditingController();
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
              controller: this.getTheCurrentTextFieldController(),
              enableInteractiveSelection: false,
              focusNode: this.destinationFocusNode,
              autofocus: this.passengerIndex == 1 ? true : false,
              showCursor: true,
              onChanged: (value) => context
                  .read<SearchProvider>()
                  .updateLocationQueryDataPerLocation(
                      query: value.trim(), context: context),
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
