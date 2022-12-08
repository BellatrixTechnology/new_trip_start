import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_trip_start/constants.dart';

class MapController extends GetxController {
  RxList<Marker> markersList = RxList([]);

  late BitmapDescriptor destIcon;
  late BitmapDescriptor startIcon;
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  var text = 'fetching'.obs;

  @override
  void onInit() async {
    super.onInit();

    destIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3.2),
        "assets/images/destination-marker.png");

    startIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 10.2),
        "assets/images/my-marker.png");
    addMarkers();
  }

  addMarkers() {
    print("called");
    Marker destmarker = Marker(
        markerId: const MarkerId('arrivalMarker'),
        draggable: false,
        icon: destIcon,
        position: const LatLng(59.945167, 10.758978));
    print("called 2");
    Marker myLocIcon = Marker(
        markerId: const MarkerId('arrivalMarker'),
        draggable: false,
        icon: destIcon,
        position: const LatLng(59.892365, 10.790427));
    markersList.add(destmarker);
    markersList.add(myLocIcon);
    markersList.refresh();
    print("called 3");
    createPolylines(59.892365, 10.790427, 59.945167, 10.758978);
  }

  createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    print("called 4");
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();
    print("called 5");
    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapApiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
      avoidFerries: true,
      optimizeWaypoints: true,
    );

    print("called 6");
    // Adding the coordinates to the list
    polylineCoordinates.clear();
    polylineCoordinates = [];
    polylines = {};

    // Future.delayed(const Duration(seconds: 4), () {
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    print("called 7");

    // Defining an ID
    PolylineId id = PolylineId('');
    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: kPrimaryColor,
      points: polylineCoordinates,
      width: 2,
    );

    // inspect('createPolylines ${polylineCoordinates.length}');

    // Adding the polyline to the map

    polylines[id] = polyline;
    print("called 8");
    text.value = 'fetched';
    update();
    refresh();
    // });
  }
}
