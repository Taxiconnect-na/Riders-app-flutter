import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RenderAnnotation {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  final LatLng _latLng = LatLng(-22.570695, 17.081047);
  final double _zoom = 15.0;

  Set<Marker> _markers = {};

  CustomInfoWindowController get customInfoWindowControllerInstance =>
      this.customInfoWindowController;

  Set<Marker> getAnnotation() {
    _markers.add(
      Marker(
        markerId: MarkerId("marker_id"),
        position: _latLng,
        onTap: () {
          customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "I am here",
                          )
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
            _latLng,
          );
        },
      ),
    );
    //...
    return this._markers;
  }
}
