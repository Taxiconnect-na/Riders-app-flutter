import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Components/Providers/SmartBookingStepsProvider.dart';

//Header general captain
//General header for the all app operations in HOME
class HeaderGeneralCaptain extends StatefulWidget {
  const HeaderGeneralCaptain({Key? key}) : super(key: key);

  @override
  _HeaderGeneralCaptainState createState() => _HeaderGeneralCaptainState();
}

class _HeaderGeneralCaptainState extends State<HeaderGeneralCaptain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Container(
            //decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Row(
          children: [
            InkWell(
              onTap: () => context
                          .read<SmartBookingStepsProvider>()
                          .currentNavigationStateIndex <=
                      0
                  ? Scaffold.of(context).openDrawer()
                  : context
                      .read<SmartBookingStepsProvider>()
                      .navigateToPreviousDestRoute(
                          context: context, doSkipLabelClose: false),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6)
                ], color: Colors.white, shape: BoxShape.circle),
                child: context
                            .watch<SmartBookingStepsProvider>()
                            .currentNavigationStateIndex <=
                        0
                    ? Icon(
                        Icons.menu,
                        size: 37,
                      )
                    : Icon(
                        Icons.arrow_back,
                        size: 37,
                      ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
