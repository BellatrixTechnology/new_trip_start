import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({super.key});
  
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> controller = Completer();
    MapController mapController = Get.put(MapController());
    CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(59.892365, 10.790427),
      zoom: 5,
    );
    // mapController.addMarkers();

    return GetBuilder<MapController>(
      builder: ((mapCtrl) => Scaffold(
            body: GoogleMap(
              initialCameraPosition: kGooglePlex,
              onMapCreated: (GoogleMapController ctrl) {
                controller.complete(ctrl);
              },
              markers: Set.from(mapCtrl.markersList),
              polylines: Set.of(mapCtrl.polylines.values),
            ),
          )),
    );
  }
}
