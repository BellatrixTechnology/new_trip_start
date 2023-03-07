import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong_to_osgrid/latlong_to_osgrid.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:utm/utm.dart';
import 'package:xml/xml.dart';

class MapController extends GetxController {
  RxList<Marker> markersList = RxList([]);
  List<LatLng> polylineCoordinates = [];
  RxSet<Polyline> polylines = RxSet({});
  late PolylinePoints polylinePoints;

  late BitmapDescriptor destIcon;
  late BitmapDescriptor startIcon;

  var text = 'fetching'.obs;

  List<dynamic> features = [];
  List<dynamic> directions = [];
  List<dynamic> tolls = [];
  RxList<Map> summary = RxList([]);
  Place startPlace = Place();
  Place endPlace = Place();
  late GoogleMapController controller;

  var autopass = true.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  getData(String stops) async {
    var response = await srvApi.getRouteData(stops);
    // "278533.80079608515,6658558.8728278065;93895.00050445361,6909396.81459309");
    //  .then((response) async {
    polylineCoordinates = [];
    polylines = RxSet({});
    update();
    refresh();

    features = response.data['routes']['features'];
    directions = response.data['directions'];

    for (var i = 0; i < features.length; i++) {
      var feature = features[i];
      Map<String, dynamic> direction = directions[i];

      var summary = await getFuelPrice(
          feature['attributes']['Total_Meters'].toDouble(),
          feature['attributes']['Total_Toll small'].toString(),
          i);

      feature['attributes']['summary'] = summary;

      // Convert the UTM coordinates to WGS84 lat/long coordinates
      var path = feature['geometry']['paths'][0];
      List<dynamic> latLngList = path.map((point) {
        int easting = point[0];
        int northing = point[1];
        UtmCoordinate coordinate =
            srvOsGridConverter.utmToLatlong(easting, northing);
        double latitude = coordinate.lat;
        double longitude =
            coordinate.lon; // convert UTM easting/northing to WGS84 longitude
        return [latitude, longitude];
      }).toList();

      polylineCoordinates = [];
      polylineCoordinates.clear();
      for (var point in latLngList) {
        polylineCoordinates.add(LatLng(point[0], point[1]));
      }

      PolylineId id = PolylineId(direction['routeName']);
      Polyline polyline = Polyline(
        polylineId: id,
        color: kPrimaryColor,
        points: polylineCoordinates,
        width: 3,
      );

      polylines.add(polyline);

      List<dynamic> dirfeatures = direction['features'];
      for (var attributes in dirfeatures) {
        if (attributes['attributes']['roadFeatures'] != null) {
          List<dynamic> att = attributes['attributes']['roadFeatures'];
          for (var i = 0; i < att.length; i++) {
            if (att[i]['attributeType'] == 'nvdb:bomstasjon') {
              UtmCoordinate coordinate = srvOsGridConverter.utmToLatlong(
                  att[i]['location'][0]['easting'],
                  att[i]['location'][0]['northing']);
              tolls.add({
                "latLng": LatLng(coordinate.lat, coordinate.lon),
                "att": att[i]
              });
            }
          }
        }
      }
    }
    // });
    polylines.refresh();
    update();
    refresh();
    addMarkerstoMap();
  }

  addMarkerstoMap() async {
    Uint8List tollIcon = await toMarkerIcon(
        '<svg width="50" height="50" viewBox="0 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg"><linearGradient id="paint0_linear_302_20" x1="25" y1="0" x2="25" y2="50" gradientUnits="userSpaceOnUse"><stop stop-color="#149BD7"/><stop offset="1" stop-color="#2F4D99"/></linearGradient><path d="M0 9.09091C0 4.07014 4.07014 0 9.09091 0H40.9091C45.9299 0 50 4.07014 50 9.09091V40.9091C50 45.9299 45.9299 50 40.9091 50H9.09091C4.07014 50 0 45.9299 0 40.9091V9.09091Z" fill="url(#paint0_linear_302_20)"/><path d="M43.1818 25C43.1818 35.0415 35.0415 43.1818 25 43.1818C14.9585 43.1818 6.81818 35.0415 6.81818 25C6.81818 14.9585 14.9585 6.81818 25 6.81818C35.0415 6.81818 43.1818 14.9585 43.1818 25Z" fill="white"/><path d="M24.8545 31.8182L21.0182 25.6727L19.2727 27.8V31.8182H17.2909V19.0909H19.2727V25.1636L24.1455 19.0909H26.4545L22.3273 24.1091L27.0364 31.8182H24.8545Z" fill="#0146AB"/><path d="M28.3649 24.9455C28.3649 23.9152 28.3467 23.1758 28.3104 22.7273H30.0013C30.0498 23.2121 30.074 23.7455 30.074 24.3273V24.5091H30.1285C30.371 23.8909 30.7528 23.4121 31.274 23.0727C31.8073 22.7212 32.4316 22.5455 33.1467 22.5455C33.3407 22.5455 33.5164 22.5636 33.674 22.6V24.0545C33.5892 24.0303 33.4013 24.0182 33.1104 24.0182C32.577 24.0182 32.0801 24.1758 31.6195 24.4909C31.171 24.7939 30.8134 25.2121 30.5467 25.7455C30.2922 26.2667 30.1649 26.8424 30.1649 27.4727V31.8182H28.3649V24.9455Z" fill="#0146AB"/><defs></defs></svg>',
        60,
        60);

    final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(tollIcon);
    markersList.clear();
    markersList = RxList([]);
    markersList.refresh();
    update();
    refresh();
    for (var element in tolls) {
      markersList.add(
        Marker(
            markerId:
                MarkerId(element['att']['distanceAlongSegment'].toString()),
            icon: svgMarker,
            position: element['latLng']),
      );
    }
    markersList.refresh();
    addStartMarker(startPlace.position!);
    endStartMarker(endPlace.position!);
    update();
    refresh();
  }

  Future<Uint8List> toMarkerIcon(
      String svgString, double width, double height) async {
    final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");
    final Picture picture =
        svgDrawableRoot.toPicture(size: Size(width, height));
    final img = await picture.toImage(width.toInt(), height.toInt());
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  addStartMarker(Position position) async {
    Uint8List startIcon = await toMarkerIcon(
        '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="16" cy="16" r="16" fill="#0046AC" fill-opacity="0.3"/><circle cx="16" cy="16" r="10" fill="#0046AC"/></svg>',
        100,
        100);

    final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(startIcon);

    markersList.add(Marker(
        markerId: const MarkerId('startMarker'),
        draggable: false,
        icon: svgMarker,
        position: LatLng(position.lat, position.lng)));
    markersList.refresh();
    update();
  }

  endStartMarker(Position position) async {
    Uint8List startIcon = await toMarkerIcon(
        '<svg width="43" height="61" viewBox="0 0 43 61" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M21.4111 0C9.58646 0 0 9.58647 0 21.4111C0 30.8392 13.6132 51.548 19.1301 59.5557C20.3748 61.3614 22.4474 61.3614 23.6921 59.5557C29.209 51.5466 42.8222 30.8406 42.8222 21.4111C42.8222 9.58647 33.2357 0 21.4111 0ZM21.4111 9.99186C24.4397 9.99186 27.3442 11.195 29.4857 13.3365C31.6272 15.478 32.8303 18.3825 32.8303 21.4111C32.8303 22.9107 32.535 24.3956 31.9611 25.7811C31.3872 27.1665 30.5461 28.4254 29.4857 29.4858C28.4253 30.5461 27.1665 31.3873 25.7811 31.9611C24.3956 32.535 22.9107 32.8304 21.4111 32.8304C18.3825 32.8304 15.478 31.6273 13.3365 29.4858C11.1949 27.3442 9.99184 24.4397 9.99184 21.4111C9.99184 18.3825 11.1949 15.478 13.3365 13.3365C15.478 11.195 18.3825 9.99186 21.4111 9.99186Z" fill="#0046AC"/></svg>',
        83,
        100);

    final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(startIcon);

    markersList.add(Marker(
        markerId: const MarkerId('endMarker'),
        draggable: false,
        icon: svgMarker,
        position: LatLng(position.lat, position.lng)));

    markersList.refresh();
    update();
  }

  addMarkers() async {
    destIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3.2),
        "assets/images/destination-marker.png");

    startIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 10.2),
        "assets/images/my-marker.png");

    Marker destmarker = Marker(
        markerId: const MarkerId('arrivalMarker'),
        draggable: false,
        icon: destIcon,
        position: const LatLng(59.945167, 10.758978));

    Marker myLocIcon = Marker(
        markerId: const MarkerId('arrivalMarker'),
        draggable: false,
        icon: startIcon,
        position: const LatLng(59.892365, 10.790427));
    markersList.add(destmarker);
    markersList.add(myLocIcon);
    markersList.refresh();
    createPolylines(59.892365, 10.790427, 59.945167, 10.758978);
  }

  createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // print("called 4");
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();
    // print("called 5");
    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapApiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
      avoidFerries: true,
      optimizeWaypoints: true,
    );

    // print("called 6");
    // Adding the coordinates to the list
    polylineCoordinates.clear();
    polylineCoordinates = [];
    polylines = RxSet({});

    // Future.delayed(const Duration(seconds: 4), () {

    print(result.points.length);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    // print("called 7");

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

    polylines.add(polyline); //[id] = polyline;
    // print("called 8");
    text.value = 'fetched';
    update();
    refresh();
    // });
  }

  Future<Map<String, dynamic>?> getFuelPrice(
      double totalDis, String tollCost, int index) async {
    String totalDistance = (totalDis * 0.001).toString();
    var response = await srvApi.getFuelData("${totalDis * 0.001} km", tollCost);
    // .then((response) {
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      var elements = xmlDocument.findAllElements('gpp:element').first;
      double fuelCostPerLitre =
          double.parse(elements.findElements('gpp:gasoline').first.text);
      String km = totalDistance.substring(0, totalDistance.length - 3);
      km = km.replaceAll(',', '');
      km = km.replaceAll(' ', '');

      double totalLitres = (11.11 / 100.0) * double.parse(km);
      String gasolinePrice =
          (fuelCostPerLitre * totalLitres).toStringAsFixed(2);
      String totalPrice = (double.parse(gasolinePrice) + double.parse(tollCost))
          .toStringAsFixed(2);
      return {
        "gasolinePrice": gasolinePrice,
        "totalLitres": totalLitres,
        "totalPrice": totalPrice,
      };

      // summary.refresh();
      // update();
      // print(summary);
    } else {
      return null;
    }
    // }).catchError((error) {
    //   // srvToastAlert.toast(error.toString());
    //   return {};
    // });
  }

  setMapBounds() {
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(endPlace.position!.lat, endPlace.position!.lng),
            northeast:
                LatLng(startPlace.position!.lat, startPlace.position!.lng),
          ),
          20),
    );
  }

  mapAnimateCamera() {
    controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(startPlace.position!.lat, startPlace.position!.lng)));
  }
}
