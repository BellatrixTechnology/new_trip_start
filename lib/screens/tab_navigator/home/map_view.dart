// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context) {
    // MapController mapController = Get.put(MapController());

    CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(59.892365, 10.790427),
      zoom: 5,
    );
    // mapController.getData(context);
    // return GetBuilder<MapController>(
    //   builder: (mapCtrl) =>
    return GetBuilder<MapController>(
      builder: (controller) => Scaffold(
        body: Obx(
          () => GoogleMap(
            onTap: (x) {
              // print(x);s
            },
            // gestureRecognizers: <Set>{}
            //   ..add(Factory<EagerGestureRecognizer>(
            //       () => EagerGestureRecognizer())),
            gestureRecognizers: Set()
              ..add(Factory<EagerGestureRecognizer>(
                  () => EagerGestureRecognizer())),
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController ctrl) {
              // mapController.controller.complete(ctrl);
              controller.controller = ctrl;
            },
            markers: controller.markersList, //Set.from(mapCtrl.markersList),
            polylines: Set.from(controller.polylines),
            myLocationButtonEnabled: false,
            // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            //     northeast: LatLng(mapController.startPlace.position!.lat,
            //         mapController.startPlace.position!.lng),
            //     southwest: LatLng(mapController.endPlace.position!.lat,
            //         mapController.endPlace.position!.lng))),
          ),
        ),
        // ),
      ),
    );
  }
}
