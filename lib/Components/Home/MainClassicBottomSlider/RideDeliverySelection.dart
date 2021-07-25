import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiconnect/Components/Home/Delivery/DeliveryIntroScreen.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/PackageReceiverDeliveryInput.dart';
import 'package:taxiconnect/Components/Providers/SmartBookingStepsProvider.dart';
import 'BasicProductSelection.dart';
import 'PackageSizeDeliverySelect.dart';
import 'package:provider/provider.dart';

class RideDeliverySelection extends StatelessWidget {
  const RideDeliverySelection({Key? key}) : super(key: key);

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
                  child: Text("You're the boss",
                      style: TextStyle(
                          fontFamily: 'MoveTextMedium', fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Choose the desired service",
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
                      child: Row(
                        children: [
                          BasicProductSelection(
                              actuatorFunctionl: () => context
                                  .read<SmartBookingStepsProvider>()
                                  .navigateToFutureDestRoute(context: context),
                              iconString: 'Assets/Images/normaltaxieconomy.jpg',
                              productName: 'Ride',
                              arrowMoveForwardBackgroundColor:
                                  Colors.grey.shade300,
                              arrowMoveForwardColor: Colors.black,
                              shortDescription:
                                  'The easiest way to move around the city.'),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.27,
                            width: 1.5,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.white,
                                  Colors.black,
                                  Colors.white
                                ])),
                          ),
                          BasicProductSelection(
                              actuatorFunctionl: () =>
                                  showMaterialModalBottomSheet(
                                      duration: Duration(milliseconds: 350),
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
                                                  child: DeliveryIntroScreen(),
                                                )));
                                      }),
                              iconString: 'Assets/Images/box_delivery.png',
                              iconSize: 31,
                              productName: 'Delivery',
                              arrowMoveForwardBackgroundColor:
                                  Colors.grey.shade300,
                              arrowMoveForwardColor: Colors.black,
                              shortDescription:
                                  'Send your packages from one place to another.'),
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
