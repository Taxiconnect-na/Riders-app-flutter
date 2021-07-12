import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taxiconnect/Components/Home/GenericMap/GenericMap.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/MainClassicBottomSlider.dart';

import 'HeaderGeneralCaptain.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final panelController = PanelController();
  bool isPanelShown = false; //To know whether or not the panel is shown.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SlidingUpPanel(
            controller: panelController,
            minHeight:
                200, //? Should vary based on the type of content displayed
            maxHeight:
                450, //? Should vary based on the type of content displayed
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            parallaxEnabled: true,
            parallaxOffset: 0.7,
            body: Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: GenericMap(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            panelBuilder: (controller) => Column(
                  children: [
                    GestureDetector(
                      onTap: () => this.isPanelShown
                          ? print(
                              'Keep opened by default - Quick close restriction.')
                          : this.panelController.open(),
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 7,
                              child: Icon(
                                Icons.minimize_rounded,
                                size: 40,
                                color: Colors.grey.shade400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: MainClassicBottomSlider(controller: controller)),
                  ],
                ),
            onPanelOpened: () {
              this.isPanelShown = true;
              print('PANEL OPENED!');
            },
            onPanelClosed: () {
              this.isPanelShown = false;
              print('PANEL CLOSED!');
            }),
        SafeArea(child: HeaderGeneralCaptain()),
      ],
    ));
  }
}
