import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Components/Providers/SettingsProvider.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';
import 'package:taxiconnect/Modules/SnackBarMother/SnackBarMother.dart';

//! Panel's optimal height: 600

class SummaryTrip extends StatelessWidget {
  final ScrollController controller;
  const SummaryTrip({Key? key, required this.controller}) : super(key: key);

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
                  child: Text("Summary",
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium', fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Economy",
                      style: TextStyle(
                          fontFamily: 'MoveTextRegular',
                          fontSize: 14,
                          color: Color.fromRGBO(14, 132, 145, 1))),
                ),
                Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //         width: 1, color: Colors.red)),
                                  alignment: Alignment.topLeft,
                                  child: RenderSummaryBooking())),
                          ShowBookingSpecifics(),
                          GenericRectButton(
                            label: 'Connect to your ride',
                            labelFontSize: 22,
                            isArrowShow: true,
                            horizontalPadding: 10,
                            bottomSubtitleText: context
                                    .watch<TripProvider>()
                                    .isTripScheduled
                                ? '${DateFormat('EEE, MMM d').format(context.watch<TripProvider>().selectedScheduledDate)} at ${context.read<TripProvider>().formatTimeToAMPorPMformat(time: context.watch<TripProvider>().selectedScheduledTime)}'
                                : null,
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

//To render all the essential booking details
class RenderSummaryBooking extends StatelessWidget {
  const RenderSummaryBooking({Key? key}) : super(key: key);

  //? Ride scheduling
  void enterCustomFare(BuildContext context) {
    //? Initialized the error 15min ahead snackbar
    SnackBarMother snackBarMother = new SnackBarMother(
        context: context,
        snackText: 'Your custom must be at least N\$amount_selected',
        snackPaddingBottom: 400,
        snackBackgroundcolor: Color.fromRGBO(178, 34, 34, 1));
    //...
    context
        .read<HomeProvider>()
        .panelController
        .animatePanelToPosition(0, curve: Curves.easeInOutCubic);
    //this._selectDate(context);
    Future customFareModal = showModalBottomSheet(
        //enableDrag: false,
        barrierColor: Colors.black.withOpacity(0.2),
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
                          child: Text("What's your custom fare?",
                              style: TextStyle(
                                  fontFamily: 'MoveTextMedium', fontSize: 20)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Container(
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            autocorrect: false,
                            autofocus: true,
                            maxLength: 3,
                            style: TextStyle(
                                fontFamily: 'MoveTextMedium', fontSize: 22),
                            decoration: InputDecoration(
                                counterText: '',
                                labelText: 'Enter your fare',
                                labelStyle:
                                    TextStyle(fontFamily: 'MoveTextRegular'),
                                prefixText: 'N\$',
                                prefixStyle: TextStyle(
                                    fontFamily: 'MoveTextBold', fontSize: 20)),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Container(
                          // decoration:
                          //     BoxDecoration(border: Border.all(width: 1)),
                          width: MediaQuery.of(context).size.width,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontFamily: 'MoveTextRegular',
                                    color: Colors.black,
                                    fontSize: 15),
                                children: [
                                  TextSpan(text: 'Between '),
                                  TextSpan(
                                      text: 'N\$30 ',
                                      style: TextStyle(
                                          fontFamily: 'MoveTextMedium')),
                                  TextSpan(text: 'and '),
                                  TextSpan(
                                      text: 'N\$65.',
                                      style: TextStyle(
                                          fontFamily: 'MoveTextMedium'))
                                ]),
                          ),
                        ),
                      ),
                      Expanded(child: Text('')),
                      FittedBox(
                        child: GenericRectButton(
                            label: 'Set new fare to N\$35',
                            labelFontSize: 20,
                            isArrowShow: false,
                            actuatorFunctionl: () => print('Set custom fare')),
                      )
                    ],
                  ),
                ),
              )));
        });
    //...
    customFareModal.then((value) {
      //? Close the snackbar if previously initialized
      snackBarMother.hideSnackBar();
      //? Modal closed - restore the main Panel
      context
          .read<HomeProvider>()
          .panelController
          .animatePanelToPosition(1, curve: Curves.easeInOutCubic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(context
                            .read<TripProvider>()
                            .provideRelevantVehiclesImages(
                                carType: context
                                    .read<TripProvider>()
                                    .selectedRideData['car_type'])),
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 130,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info,
                              size: 15,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                                '${context.read<TripProvider>().selectedRideData['app_label']}',
                                style: TextStyle(
                                    fontFamily: 'MoveTextMedium',
                                    fontSize: 15,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      alignment: Alignment.center,
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  context
                                      .read<SettingsProvider>()
                                      .getDefaultPaymentMethodIcon(),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  context.read<SettingsProvider>().ucFirst(
                                      text: context
                                          .read<SettingsProvider>()
                                          .defaultPaymentMethod),
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: Container(
                      child: Text(
                        'N\$ 30',
                        style:
                            TextStyle(fontFamily: 'MoveTextBold', fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 65, right: 65),
                    child: Divider(),
                  ),
                  InkWell(
                    onTap: () => this.enterCustomFare(context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        //decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: 'or ',
                                          style: TextStyle(fontSize: 15)),
                                      TextSpan(
                                          text: 'Enter a custom fare',
                                          style: TextStyle(
                                              fontFamily: 'MoveTextBold',
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  14, 132, 145, 1)))
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3, left: 3),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

//SHow the specifics of the booking: is going until home? The N$5 included pickup fees.
class ShowBookingSpecifics extends StatelessWidget {
  const ShowBookingSpecifics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.info,
                  size: 14,
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'MoveTextRegular'),
                        children: [
                          TextSpan(
                              text: 'N\$5',
                              style: TextStyle(fontFamily: 'MoveTextBold')),
                          TextSpan(
                            text: ' pickup fee included.',
                          )
                        ]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Icon(Icons.home,
                      size: 15, color: Color.fromRGBO(14, 132, 145, 1)),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    child: Text('Going until home.'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
