import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/services/index.dart';

class RouteDetailCtrl extends GetxController {
  MapController mapController = Get.put(MapController());
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(59.892365, 10.790427),
    zoom: 5,
  );

  var isLoading = false.obs;

  PolylinePoints polylinePoints = PolylinePoints();
  // RxList<Marker> markersList = RxList([]);
  RxSet<Marker> markersList = RxSet({});
  List<LatLng> polylineCoordinates = [];
  RxSet<Polyline> polylines = RxSet({});
  // late PolylinePoints polylinePoints;
  late GoogleMapController googlemapController;

  RxMap singleRoutePrices = RxMap({});

  var index = 0;

  var feature = {};
  var direction = {};

  RxList tolls = RxList([]);
  RxList ferries = RxList([]);

  List<Map<String, dynamic>> tollList = [];

  @override
  onInit() {
    super.onInit();
    Map arguments = Get.arguments;
    index = arguments['index'];
  }

  get getName => mapController.routeData[index]['info']['routeName'];

  get getTotalPrice =>
      mapController.routeData[index]['info']['price']['withFuel'].toString();

  setIndex(int routeindex) {
    index = routeindex;
  }

  // getTolls() async {
  //   tolls.assignAll([]);
  //   ferries.assignAll([]);

  //   update();
  //   toggleLoading();

  //   var resp = await srvApi.getTolls(
  //       mapController.routeData[index]['summary'],
  //       mapController.carData.value,
  //       mapController.routeData[index]['distance']['value']);
  //   toggleLoading();
  //   if (resp.statusCode == 200) {
  //     var data = resp.data['data'][0];
  //     tolls.addAll(data['tolls']);
  //     ferries.addAll(data['ferry']);
  //     tolls.refresh();
  //     ferries.refresh();
  //     update();
  //     calcPrice(data);
  //     getTollsMarkers(data);
  //   }
  // }

  toggleLoading() {
    isLoading.toggle();
    update();
  }

  getPolyLines(int index) {
    polylineCoordinates = [];
    polylineCoordinates.clear();
    polylines = RxSet({});
    polylines.clear();
    Polyline polyline = mapController.polylines.elementAt(index);
    polylines.add(polyline);
    polylines.refresh();
    return;
  }

  addMarkerstoMap(int index) async {
    Uint8List tollIcon =
        await srvOsGridConverter.toMarkerIcon(ktollMarker, 60, 60);

    final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(tollIcon);
    // List tolls =
    tolls = RxList(mapController.routeData[index]['tolls']);
    // print(tolls[0]);
    ferries = RxList(mapController.routeData[index]['ferry']);
    for (var data in tolls) {
      var toll = data;
      if (toll['latitude'] == null || toll['longitude'] == null) {
        var coords =
            srvOsGridConverter.utmToLatlong(toll['easting'], toll['northing']);

        toll['latitude'] = coords.lat;
        toll['longitude'] = coords.lon;
        // var coords =
        //     srvOsGridConverter.utmToLatlong(toll['easting'], toll['northing']);
      }

      markersList.add(
        Marker(
            markerId: MarkerId(toll['title'].toString()),
            icon: svgMarker,
            position: LatLng(toll['latitude'], toll['longitude'])),
      );
      // }
    }

    markersList.refresh();

    addStartMarker();
    endStartMarker();
    update();
    refresh();
    getPolyLines(index);
  }

  // getTollsMarkers(Map data) async {
  //   Uint8List tollIcon =
  //       await srvOsGridConverter.toMarkerIcon(ktollMarker, 60, 60);

  //   final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(tollIcon);
  //   markersList.clear();
  //   markersList = RxList([]);
  //   markersList.refresh();
  //   update();
  //   refresh();
  //   addStartMarker();
  //   endStartMarker();

  //   for (var element in data['tolls']) {
  //     markersList.add(
  //       Marker(
  //         markerId: MarkerId(element['geohash'].toString()),
  //         icon: svgMarker,
  //         position: LatLng(srvShared.anyTypeToDouble(element['latitude']),
  //             srvShared.anyTypeToDouble(element['longitude'])),
  //       ),
  //     );
  //   }
  //   markersList.refresh();
  //   update();
  //   setBounds();
  //   // update();
  // }

  addStartMarker() async {
    Position position = mapController.startPlace.position!;
    // Uint8List startIcon =
    //     await srvOsGridConverter.toMarkerIcon(kstartMarker, 100, 100);

    // final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(startIcon);
    final Uint8List markerIcon = await srvOsGridConverter.getBytesFromAsset(
        'assets/images/start-marker.png', 70);
    markersList.add(Marker(
        markerId: const MarkerId('startMarker'),
        draggable: false,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(position.lat, position.lng)));
    markersList.refresh();
    // update();
  }

  endStartMarker() async {
    // Uint8List startIcon =
    //     await srvOsGridConverter.toMarkerIcon(kendMarker, 83, 100);

    // final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(startIcon);
    final Uint8List markerIcon = await srvOsGridConverter.getBytesFromAsset(
        "assets/images/destination-marker.png", 70);
    Position position = mapController.endPlace.position!;
    markersList.add(Marker(
        markerId: const MarkerId('endMarker'),
        draggable: false,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(position.lat, position.lng)));

    markersList.refresh();
    update();
  }

  setBounds() {
    try {
      googlemapController.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(mapController.startPlace.position!.lat,
                  mapController.startPlace.position!.lng),
              northeast: LatLng(mapController.endPlace.position!.lat,
                  mapController.endPlace.position!.lng),
            ),
            60),
      );
    } catch (e) {
      googlemapController.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(mapController.startPlace.position!.lat,
                  mapController.startPlace.position!.lng),
              southwest: LatLng(mapController.endPlace.position!.lat,
                  mapController.endPlace.position!.lng),
            ),
            60),
      );
    }
  }

  double calcTollPrice(toll) {
    bool isAutoPassOn = mapController.autopass.value;
    bool isRushHourOn = mapController.rushHour.value;

    debugPrint("toll -> $toll");
    double price = 0.0;
    if (!isAutoPassOn && !isRushHourOn) {
      price = double.parse(
          (toll['totalPriceWithoutRushHourWithoutAutoPass'] ?? 0).toString());
    }

    if (isAutoPassOn && isRushHourOn) {
      price =
          double.parse((toll['priceWithRushHourWithAutoPass'] ?? 0).toString());
    }

    if (isAutoPassOn && !isRushHourOn) {
      price = double.parse(
          (toll['priceWithoutRushHourWithAutoPass'] ?? 0).toString());
    }

    if (!isAutoPassOn && isRushHourOn) {
      price = double.parse(
          (toll['totalPriceWithRushHourWithoutAutoPass'] ?? 0).toString());
    }

    return price;
  }

  calcPrice(Map data) {
    var info = data['totalPrice'];
    var fuelPrice = data['totalPriceFuel'];
    var price = {"withFuel": 0.0, "withoutFuel": 0.0};
    var withAutoPassPrice =
        srvFirebase.toDouble(info['totalPriceWithAutoPass']);
    var withoutAutoPassPrice =
        srvFirebase.toDouble(info['totalPriceWithoutAutoPass']);
    var withRushPrice = srvFirebase.toDouble(info['totalPriceWithRushHour']);
    var withoutRushPrice =
        srvFirebase.toDouble(info['totalPriceWithoutRushHour']);

    var gasPrice = srvFirebase.toDouble(fuelPrice ?? 0.0);

    if (mapController.autopass.isTrue && mapController.rushHour.isTrue) {
      price = {
        "withoutFuel": withAutoPassPrice + withRushPrice,
        "withFuel": (withAutoPassPrice + withRushPrice) + gasPrice
      };
    }
    if (mapController.autopass.isTrue && mapController.rushHour.isFalse) {
      price = {
        "withoutFuel": withAutoPassPrice + withoutRushPrice,
        "withFuel": (withAutoPassPrice + withoutRushPrice) + gasPrice
      };
    }
    if (mapController.autopass.isFalse && mapController.rushHour.isTrue) {
      price = {
        "withoutFuel": withRushPrice + withoutAutoPassPrice,
        "withFuel": (withRushPrice + withoutAutoPassPrice) + gasPrice
      };
    }

    if (mapController.autopass.isFalse && mapController.rushHour.isFalse) {
      price = {
        "withoutFuel": withoutAutoPassPrice + withoutRushPrice,
        "withFuel": (withoutAutoPassPrice + withoutRushPrice) + gasPrice
      };
    }

    // log("price $price");
    singleRoutePrices.value = price;
    update();
  }

  String calcFerryPrice(Map<String, dynamic> ferries) {
    double length = double.parse(mapController.carData.value.vehLength!);
    if (length <= 6) {
      return ferries['0 - 6m'];
    } else if (length > 6 && length <= 8) {
      return ferries['6.01 - 8m'];
    } else if (length > 8 && length <= 10) {
      return ferries['8.01 - 10m'];
    } else if (length > 10 && length <= 12.5) {
      return ferries['10.01 - 12.5m'];
    } else if (length > 12.51 && length <= 14.5) {
      return ferries['12.51 - 14.5m'];
    } else if (length > 14.51 && length <= 17.5) {
      return ferries['14.51 - 17.5m'];
    } else if (length > 17.51 && length <= 19.5) {
      return ferries['17.51 - 19.5m'];
    } else if (length > 19.51 && length <= 22) {
      return ferries['19.51 - 22m'];
    }
    return ferries["over 22m"];
    // else if (length > 6 && length <= 8) {
    //   return ferries['6.01 - 8m'];
    // } else if (length > 6 && length <= 8) {
    //   return ferries['6.01 - 8m'];
    // }
  }

  animateCameraOnPosition(double lat, double lng) {
    googlemapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 15),
      ),
    );
  }
}
