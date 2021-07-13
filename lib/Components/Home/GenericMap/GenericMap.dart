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
  late GoogleMapController mapController;
  final _userCenterPoint = const LatLng(-22.559723, 17.074068);

  void _onMapCreatedHandler(GoogleMapController controller) {
    controller.setMapStyle(new MapStyleData().mapStyleData1);
    this.mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Wake the LocationOpsHandler
    new LocationOpsHandler(parentContext: context).startLocationWatcher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: GoogleMap(
        padding: EdgeInsets.only(bottom: 60),
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: _onMapCreatedHandler,
        initialCameraPosition:
            CameraPosition(target: _userCenterPoint, zoom: 15),
      ),
    );
  }
}
