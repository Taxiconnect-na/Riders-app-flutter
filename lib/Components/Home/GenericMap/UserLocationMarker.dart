//TaxiConnect iconique user location marker
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:taxiconnect/Components/Providers/HomeProvider.dart';
import 'package:provider/provider.dart';

class UserLocationMarker {
  final BuildContext parentBuildContext;

  UserLocationMarker({required this.parentBuildContext});

  Marker getUserLocation() {
    LatLng userPosition = parentBuildContext
                    .read<HomeProvider>()
                    .userLocationCoords['latitude'] !=
                null &&
            parentBuildContext
                    .read<HomeProvider>()
                    .userLocationCoords['longitude'] !=
                null
        ? LatLng(
            parentBuildContext
                .read<HomeProvider>()
                .userLocationCoords['latitude'],
            parentBuildContext
                .read<HomeProvider>()
                .userLocationCoords['longitude'])
        : parentBuildContext.read<HomeProvider>().userCenterPointFallback;

    // Marker userLocation =
    //     /*Marker(
    //     markerId: MarkerId('user_location_point_map'),
    //     position: parentBuildContext
    //                     .read<HomeProvider>()
    //                     .userLocationCoords['latitude'] !=
    //                 null &&
    //             parentBuildContext
    //                     .read<HomeProvider>()
    //                     .userLocationCoords['longitude'] !=
    //                 null
    //         ? LatLng(
    //             parentBuildContext
    //                 .read<HomeProvider>()
    //                 .userLocationCoords['latitude'],
    //             parentBuildContext
    //                 .read<HomeProvider>()
    //                 .userLocationCoords['longitude'])
    //         : parentBuildContext.read<HomeProvider>().userCenterPointFallback,
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));*/
    //     RippleMarker(
    //   markerId: MarkerId('MarkerId1'),
    //   position: userPosition,
    //   ripple: true, //Ripple state
    // );

    return RippleMarker(
        markerId: MarkerId('MarkerId1'), position: userPosition, ripple: true);
  }
}
