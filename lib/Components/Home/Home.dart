import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taxiconnect/Components/Home/GenericMap/GenericMap.dart';
import 'package:taxiconnect/Components/Home/MainClassicBottomSlider/MainClassicBottomSlider.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxiconnect/Modules/LocationOpsHandler/LocationOpsHandler.dart';
import 'package:taxiconnect/Modules/Search/Search.dart';

import 'HeaderGeneralCaptain.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final panelController = PanelController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.initHomeScreenMeasurements(
        screenSize: Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight));

    //Wake the LocationOpsHandler
    new LocationOpsHandler(parentContext: context).startLocationWatcher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(child: Text('Hey!')),
      ),
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
                    Container(
                      height: context.watch<HomeProvider>().relativeMapHeight,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: GenericMap(),
                    ),
                  ],
                ),
              ),
            ),
            panelBuilder: (controller) => Column(
              children: [
                GestureDetector(
                  onTap: () => Provider.of<HomeProvider>(context, listen: false)
                          .isPanelShown
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
              context.read<HomeProvider>().updatePanelShownStatus(true);
              print('PANEL OPENED!');
            },
            onPanelClosed: () {
              context.read<HomeProvider>().updatePanelShownStatus(false);
              print('PANEL CLOSED!');
            },
            onPanelSlide: (double position) {
              context.read<HomeProvider>().updateRefocusAndMapPositions(
                  sliderPositionHeight: position,
                  screenSize: Size(
                      ScreenUtil().screenWidth, ScreenUtil().screenHeight));
            },
          ),
          Positioned(
            right: 20.0,
            bottom: context.watch<HomeProvider>().relativeFocusButtonPosition,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Colors.black,
                size: 35,
              ),
              onPressed: context
                              .read<HomeProvider>()
                              .userLocationCoords['latitude'] !=
                          null &&
                      context
                              .read<HomeProvider>()
                              .userLocationCoords['longitude'] !=
                          null
                  ? () async {
                      context.read<HomeProvider>().mapController.future.then(
                          (value) => value.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      context
                                          .read<HomeProvider>()
                                          .userLocationCoords['latitude'],
                                      context
                                          .read<HomeProvider>()
                                          .userLocationCoords['longitude']),
                                  zoom:
                                      context.read<HomeProvider>().mapZoom))));
                    }
                  : () {},
              backgroundColor: Colors.white,
            ),
          ),
          SafeArea(child: HeaderGeneralCaptain()),
          //Search()
        ],
      ),
    );
  }
}
