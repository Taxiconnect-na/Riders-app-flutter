import 'package:flutter/material.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/ConnectMeUsSelection.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/GenericGreeting.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/RideDeliverySelection.dart';

import 'PassengersNumberSelection.dart';

//Main classic bottom slider
class MainClassicBottomSlider extends StatelessWidget {
  final ScrollController controller;
  const MainClassicBottomSlider({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        children: [DisplayAssigner()],
      ),
    );
  }
}

///Display assigner
///Responsible for showing the right content
class DisplayAssigner extends StatelessWidget {
  const DisplayAssigner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PassengersNumberSelection(),
    );
  }
}
