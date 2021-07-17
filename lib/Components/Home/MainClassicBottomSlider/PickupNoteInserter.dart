import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';

class PickupNoteInserter extends StatelessWidget {
  const PickupNoteInserter({Key? key}) : super(key: key);

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
                  child: Text("Pickup note?",
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium', fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Let the driver know of your preferences",
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
                          Expanded(child: PickupNoteInputField()),
                          IsGoingUntilHomeChoice(),
                          GenericRectButton(
                            label:
                                context.watch<TripProvider>().pickupNoteText !=
                                        null
                                    ? 'Next'
                                    : 'Skip',
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

class PickupNoteInputField extends StatefulWidget {
  const PickupNoteInputField({Key? key}) : super(key: key);

  @override
  _PickupNoteInputFieldState createState() => _PickupNoteInputFieldState();
}

class _PickupNoteInputFieldState extends State<PickupNoteInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Container(
        // decoration:
        //     BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
        child: TextField(
          maxLength: 70,
          maxLines: 3,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              counterStyle: TextStyle(fontSize: 15),
              enabledBorder: InputBorder.none,
              labelText: 'Add a note to the driver',
              labelStyle: TextStyle(color: Colors.grey.shade800)),
        ),
      ),
    );
  }
}

//Going to the same place toggle
class IsGoingUntilHomeChoice extends StatefulWidget {
  const IsGoingUntilHomeChoice({Key? key}) : super(key: key);

  @override
  _IsGoingUntilHomeChoiceState createState() => _IsGoingUntilHomeChoiceState();
}

class _IsGoingUntilHomeChoiceState extends State<IsGoingUntilHomeChoice> {
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
                      MaterialStateProperty.all(Color.fromRGBO(9, 110, 212, 1)),
                  value: context.read<TripProvider>().isGoingUntilHome,
                  onChanged: (value) => context
                      .read<TripProvider>()
                      .updateGoingUntilHome(
                          state:
                              !context.read<TripProvider>().isGoingUntilHome)),
            ),
          ),
          Expanded(
            child: Container(
              child: InkWell(
                child: Text(
                  context.read<TripProvider>().isGoingUntilHome
                      ? 'Going until home.'
                      : 'Not going until home.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
