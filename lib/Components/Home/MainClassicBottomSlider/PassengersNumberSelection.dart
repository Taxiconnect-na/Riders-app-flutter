import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';

class PassengersNumberSelection extends StatelessWidget {
  const PassengersNumberSelection({Key? key}) : super(key: key);

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text("How many are you?",
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium', fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Number of passengers for the ride",
                      style:
                          TextStyle(fontFamily: 'MoveTextLight', fontSize: 14)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Column(
                        children: [
                          Expanded(child: NumberOfPassengersSelector()),
                          IsGoingToTheSamePlaceChoice(),
                          GenericRectButton(
                            label: 'Next',
                            horizontalPadding: 0,
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

//Number of passengers selector
class NumberOfPassengersSelector extends StatefulWidget {
  const NumberOfPassengersSelector({Key? key}) : super(key: key);

  @override
  _NumberOfPassengersSelectorState createState() =>
      _NumberOfPassengersSelectorState();
}

class _NumberOfPassengersSelectorState
    extends State<NumberOfPassengersSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UniquePassengerCircleSelector(
              passengerNo: 1,
              isSelected:
                  context.watch<TripProvider>().selectedPassengersNo == 1
                      ? true
                      : false,
            ),
            UniquePassengerCircleSelector(
              passengerNo: 2,
              isSelected:
                  context.watch<TripProvider>().selectedPassengersNo == 2
                      ? true
                      : false,
            ),
            UniquePassengerCircleSelector(
                passengerNo: 3,
                isSelected:
                    context.watch<TripProvider>().selectedPassengersNo == 3
                        ? true
                        : false),
            UniquePassengerCircleSelector(
              passengerNo: 4,
              isSelected:
                  context.watch<TripProvider>().selectedPassengersNo == 4
                      ? true
                      : false,
            )
          ],
        ),
      ),
    );
  }
}

//Unique passenger circle selector
class UniquePassengerCircleSelector extends StatelessWidget {
  final int passengerNo; //The number representing the passenger: 1,2,3 or 4
  final Color borderColor; //The color of the border
  final Color backgoundColor; //The background color of the selector
  final Color textColor; //The color of the passenger's number label
  final bool
      isSelected; //To indicate the selected passengers number - default: false

  const UniquePassengerCircleSelector(
      {Key? key,
      required this.passengerNo,
      this.isSelected = false,
      this.borderColor = const Color.fromRGBO(14, 132, 145, 1),
      this.backgoundColor = Colors.white,
      this.textColor = Colors.black})
      : super(key: key);
  //...Update theme if selectedd
  Color getBackgroundColor() {
    return this.isSelected ? Color.fromRGBO(14, 132, 145, 1) : Colors.white;
  }

  Color getTextColor() {
    return this.isSelected ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<TripProvider>()
          .updatePassengersNo(newPassengerNo: this.passengerNo),
      child: Container(
        alignment: Alignment.center,
        height: 54,
        width: 54,
        decoration: BoxDecoration(
            color: this.getBackgroundColor(),
            border: Border.all(width: 1.5, color: this.borderColor),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1.5,
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ]),
        child: Text(
          '${this.passengerNo}',
          style: TextStyle(
              fontFamily: 'MoveTextMedium',
              fontSize: 22,
              color: this.getTextColor()),
        ),
      ),
    );
  }
}

//Going to the same place toggle
class IsGoingToTheSamePlaceChoice extends StatefulWidget {
  const IsGoingToTheSamePlaceChoice({Key? key}) : super(key: key);

  @override
  _IsGoingToTheSamePlaceChoiceState createState() =>
      _IsGoingToTheSamePlaceChoiceState();
}

class _IsGoingToTheSamePlaceChoiceState
    extends State<IsGoingToTheSamePlaceChoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 20,
              //decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  fillColor:
                      context.watch<TripProvider>().selectedPassengersNo > 1
                          ? MaterialStateProperty.all(
                              Color.fromRGBO(14, 132, 145, 1))
                          : MaterialStateProperty.all(Colors.grey),
                  value: context.watch<TripProvider>().selectedPassengersNo > 1
                      ? context.read<TripProvider>().isGoingToTheSameDestination
                      : false,
                  onChanged: (value) =>
                      context.watch<TripProvider>().selectedPassengersNo > 1
                          ? context
                              .read<TripProvider>()
                              .updateGoingToTheSameDestSwitch(
                                  state: !context
                                      .read<TripProvider>()
                                      .isGoingToTheSameDestination)
                          : {}),
            ),
          ),
          Expanded(
            child: Container(
              child: InkWell(
                child: Text(
                  context.read<TripProvider>().isGoingToTheSameDestination
                      ? 'All going to the same place'
                      : 'Not going to the same place.',
                  style: TextStyle(
                      fontSize: 18,
                      color:
                          context.watch<TripProvider>().selectedPassengersNo > 1
                              ? Colors.black
                              : Colors.grey),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
