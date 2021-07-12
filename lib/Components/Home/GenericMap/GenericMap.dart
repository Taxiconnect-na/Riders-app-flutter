import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    this.mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: GoogleMap(
          onMapCreated: _onMapCreatedHandler,
          initialCameraPosition:
              CameraPosition(target: _userCenterPoint, zoom: 15),
        ));
  }
}
