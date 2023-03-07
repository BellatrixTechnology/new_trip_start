import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here_sdk/mapview.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/services/index.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController());
    CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(59.892365, 10.790427),
      zoom: 5,
    );
    // mapController.getData(context);
    return GetBuilder<MapController>(
      builder: (mapCtrl) => Scaffold(
        body: GoogleMap(
          initialCameraPosition: kGooglePlex,
          onMapCreated: (GoogleMapController ctrl) {
            // mapController.controller.complete(ctrl);
             mapController.controller = ctrl;
          },
          markers: Set.from(mapCtrl.markersList),
          polylines: Set.from(mapCtrl.polylines.value),
          myLocationButtonEnabled: false,
          // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
          //     northeast: LatLng(mapController.startPlace.position!.lat,
          //         mapController.startPlace.position!.lng),
          //     southwest: LatLng(mapController.endPlace.position!.lat,
          //         mapController.endPlace.position!.lng))),
        ),
      ),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }
      srvRouting.init(hereMapController);
      // _routingExample = RoutingExample(_showDialog, hereMapController);
      // const double distanceToEarthInMeters = 8000;
      // MapMeasure mapMeasureZoom =
      //     MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      // hereMapController.camera.lookAtPointWithMeasure(
      //     GeoCoordinates(52.530932, 13.384915), mapMeasureZoom);
    });
  }
}
