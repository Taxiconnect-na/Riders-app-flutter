import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiconnect/Modules/LocationOpsHandler/LocationOpsHandler.dart';
import 'package:taxiconnect/Modules/MapStyleData/MapStyleData.dart';

///Doc
///Any reference to "point" here means : Latitude/Longitude geographic coordinates.

class GenericMap extends StatefulWidget {
  const GenericMap({Key? key}) : super(key: key);

  @override
  _GenericMapState createState() => _GenericMapState();
}

class _GenericMapState extends State<GenericMap> {
  //Wake the LocationOpsHandler
  final void locationOpsHandler =
      new LocationOpsHandler().startLocationWatcher();
  //........
  late GoogleMapController mapController;
  final _userCenterPoint = const LatLng(-22.559723, 17.074068);

  void _onMapCreatedHandler(GoogleMapController controller) {
    controller.setMapStyle(new MapStyleData().mapStyleData1);
    this.mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: GoogleMap(
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: _onMapCreatedHandler,
        initialCameraPosition:
            CameraPosition(target: _userCenterPoint, zoom: 15),
      ),
    );
  }
}
