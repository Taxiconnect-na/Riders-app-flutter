import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Components/Providers/TripProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/GenericRectButton/GenericRectButton.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';
import 'package:taxiconnect/Modules/SnackBarMother/SnackBarMother.dart';

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
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.red)),
                                  alignment: Alignment.topLeft,
                                  child: RenderSummaryBooking())),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(width: 1)),
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
                  )
                ],
              )),
        ],
      ),
    );
  }
}
