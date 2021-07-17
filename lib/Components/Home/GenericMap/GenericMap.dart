import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiconnect/Components/Home/GenericMap/UserLocationMarker.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:taxiconnect/Modules/MapStyleData/MapStyleData.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animarker/widgets/animarker.dart';

///Doc
///Any reference to "point" here means : Latitude/Longitude geographic coordinates.

class GenericMap extends StatefulWidget {
  const GenericMap({Key? key}) : super(key: key);

  @override
  _GenericMapState createState() => _GenericMapState();
}

class _GenericMapState extends State<GenericMap> {
  void _onMapCreatedHandler(GoogleMapController controller) {
    controller.setMapStyle(new MapStyleData().mapStyleData1);

    context
        .read<HomeProvider>()
        .updateGoogleMapsController(controller: controller);
  }

  @override
  Widget build(BuildContext context) {
    Marker userLocationMarker =
        new UserLocationMarker(parentBuildContext: context)
            .getUserLocation(); //User location marker
    //...
    return Scaffold(
      // backgroundColor: Colors.red,
      body: GoogleMap(
        padding: EdgeInsets.only(
            bottom: 60,
            top: context.watch<HomeProvider>().isPanelShown
                ? MediaQuery.of(context).size.height * 0.20
                : 0),
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: _onMapCreatedHandler,
        initialCameraPosition: CameraPosition(
            target:
                context.watch<HomeProvider>().userLocationCoords['latitude'] !=
                            null &&
                        context
                                .watch<HomeProvider>()
                                .userLocationCoords['longitude'] !=
                            null
                    ? LatLng(
                        context
                            .watch<HomeProvider>()
                            .userLocationCoords['latitude'],
                        context
                            .watch<HomeProvider>()
                            .userLocationCoords['longitude'])
                    : context.read<HomeProvider>().userCenterPointFallback,
            zoom: 15),
      ),
      //     Animarker(
      //   mapId: context.read<HomeProvider>().getMapId(), //Grab Google Map Id
      //   // Other properties
      //   rippleRadius: 0.05, //[0,1.0] range, how big is the circle
      //   useRotation: false,
      //   rippleColor: Colors.blue, // Color of fade ripple circle
      //   rippleDuration: Duration(milliseconds: 1000), //Pulse ripple duration
      //   markers: {userLocationMarker},
      //   child: GoogleMap(
      //     padding: EdgeInsets.only(bottom: 60),
      //     mapToolbarEnabled: false,
      //     zoomControlsEnabled: false,
      //     myLocationButtonEnabled: false,
      //     myLocationEnabled: false,
      //     onMapCreated: _onMapCreatedHandler,
      //     initialCameraPosition: CameraPosition(
      //         target:
      //             context.watch<HomeProvider>().userLocationCoords['latitude'] !=
      //                         null &&
      //                     context
      //                             .watch<HomeProvider>()
      //                             .userLocationCoords['longitude'] !=
      //                         null
      //                 ? LatLng(
      //                     context
      //                         .watch<HomeProvider>()
      //                         .userLocationCoords['latitude'],
      //                     context
      //                         .watch<HomeProvider>()
      //                         .userLocationCoords['longitude'])
      //                 : context.read<HomeProvider>().userCenterPointFallback,
      //         zoom: 15),
      //   ),
      // )
    );
  }
}
