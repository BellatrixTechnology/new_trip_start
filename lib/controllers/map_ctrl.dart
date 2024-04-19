import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:new_trip_start/constants.dart';

import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/services/index.dart';
// import 'package:new_trip_start/utils/polyline_decoder.dart';

import 'package:xml/xml.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  // RxList<Marker> markersList = RxList([]);
  RxSet<Marker> markersList = RxSet({});
  // List<LatLng> polylineCoordinates = [];
  RxSet<Polyline> polylines = RxSet({});

  PolylinePoints polylinePoints = PolylinePoints();
  var da = {
    "origin": "59.9138688,10.7522454",
    "destination": "63.4305149,10.3950528",
    "vehicleGroup": "M1",
    "vehFuelType": "petrol",
    "vehFuelCmp": 0.385,
    "cache": true,
    "vehLength": 3.91,
    "type": "gas",
    "travelMode": "driving"
  };

  late BitmapDescriptor destIcon;
  late BitmapDescriptor startIcon;

  var text = 'fetching'.obs;

  List<dynamic> features = [];
  List<dynamic> directions = [];
  List<dynamic> tolls = [];
  RxList<Map> summary = RxList([]);
  List<LatLng> polylineCoordinates = [];

  // GooglePlacesModel startPlace =
  //     GooglePlacesModel(description: "", placeId: "");
  // GooglePlacesModel endPlace = GooglePlacesModel(description: "", placeId: "");
  CityModel startPlace =
      CityModel(name: "", id: -1, latitude: "", longitude: "");
  CityModel endPlace = CityModel(name: "", id: -1, latitude: "", longitude: "");

  var autopass = true.obs;
  var rushHour = true.obs;

  late GoogleMapController controller;
  GoogleMapController? mapController;
  BottomTabController tabController = Get.put(BottomTabController());

  var isFetching = false.obs;

  var routeData = [].obs;

  List rr = [];
  // var tolls = [0];
  Rx<Vehicle> carData = Vehicle().obs;

  toggleisFetching() {
    isFetching.toggle();
    update();
  }

  // Future<void> getDateAndManipulateHere() async {
  //   debugPrint("api called");
  //   var response = await srvApi.getRouteData(
  //       startPlace.position!, endPlace.position!, carData.value);
  //   debugPrint("api called 2");
  //   if (response.statusCode == 200) {
  //     routeData.value = response.data['data'];
  //     debugPrint("api called 3 ${routeData.isNotEmpty}");
  //     if (routeData.isNotEmpty) {
  //       for (var element in routeData) {
  //         polylineCoordinates = [];
  //         polylineCoordinates.clear();
  //         debugPrint("api called 4 ${element['coordinates'].length}");
  //         for (var point in element['coordinates']) {
  //           polylineCoordinates
  //               .add(LatLng(point['latitude'], point['longitude']));
  //         }
  //         debugPrint("api called 5 ${polylineCoordinates.length}");
  //         PolylineId id =
  //             PolylineId('${DateTime.now().millisecondsSinceEpoch}');
  //         polylines.add(Polyline(
  //             polylineId: id,
  //             color: kPrimaryColor,
  //             points: polylineCoordinates,
  //             width: 3,
  //             consumeTapEvents: true,
  //             onTap: () {}));
  //       }
  //     } else {
  //       srvToastAlert.toast("No Route Found");
  //     }
  //   }
  // }

  getData() async {
    // if (kReleaseMode)
    // Future.delayed(const Duration(seconds: 5), () {
    //   srvToastAlert.loaderPopup();
    // });
    // toggleisFetching();
    // srvLoader.showLoader();
    srvToastAlert.loaderPopup(globalContext);

    polylines = RxSet({});
    polylineCoordinates = [];
    markersList.clear();
    markersList = RxSet({});

    // Future.delayed(const Duration(seconds: 10), () {
    //   print("called");
    //   srvToastAlert.closePopup();
    // });
    // return;
    var response = await srvApi.getRouteData(
        startPlace.position!, endPlace.position!, carData.value);

    // ignore: use_build_context_synchronously
    Navigator.of(globalContext, rootNavigator: true).pop();

    // toggleisFetching();
    // srvLoader.hideLoader();
    // print("response $response");
    // if (kReleaseMode)
    // srvPageRoute.goBack(globalContext);
    // Get.back(closeOverlays: true);

    if (response.statusCode == 200) {
      if (response.data['data'] == null) {
        srvToastAlert.toast("No Route Found");
        return;
      }
      if (response.data['data'].length > 0) {
        routeData = RxList(response.data['data']);
        addPolylines();
      } else {
        srvToastAlert.toast("No Route Found");
      }
    }
  }

  addPolylines() async {
    List<Map> tollsCount = [];
    // print(routeData.length);
    for (var i = 0; i < routeData.length; i++) {
      // names.add(routeData[i]['coordinates']['data']);
      // print(routeData[i]['coordinates']);
      if (routeData[i]['coordinates'] == null) {
        decodeAndShowPolylines();
        break;
      }

      // data['tolls'].length
      tollsCount.add({
        "routeName": routeData[i]['summary'],
        "tollCount": routeData[i]['tolls'].length,
      });
      List<LatLng> points =
          (routeData[i]['coordinates']['data'] as List<dynamic>)
              .map<LatLng>((dynamic e) {
        if (e is Map<String, dynamic> &&
            e.containsKey('latitude') &&
            e.containsKey('longitude')) {
          return LatLng(srvShared.anyTypeToDouble(e['latitude']),
              srvShared.anyTypeToDouble(e['longitude']));
        } else {
          throw FormatException('Invalid coordinate format: $e');
        }
      }).toList();

      PolylineId id = PolylineId('${DateTime.now().millisecondsSinceEpoch}');
      polylines.add(Polyline(
          polylineId: id,
          color: kPrimaryColor,
          points: points,
          width: 3,
          consumeTapEvents: true,
          onTap: () {}));
    }
    print("polylines.length ${polylines.length}");
    polylines.refresh();
    update();
    addMarkerstoMap();
    addLog(tollsCount);
  }

  addLog(List name) {
    srvAnalytics.addLog("request", {
      "routeData": name.toString(),
      "start": startPlace.name,
      "end": endPlace.name,
      "start_lat": startPlace.position!.lat,
      "start_lng": startPlace.position!.lng
    });
  }

  decodeAndShowPolylines() {
    List<Map> tollsCount = [];
    for (var route in routeData) {
      // print("object");
      List<LatLng> points = [];
      for (var i = 0; i < route['geometry'].length; i++) {
        points.addAll(polylinePoints
            .decodePolyline(route['geometry'][i].toString())
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList());
      }
      PolylineId id = PolylineId('${DateTime.now().millisecondsSinceEpoch}');
      polylines.add(Polyline(
          polylineId: id,
          color: kPrimaryColor,
          points: points,
          width: 3,
          consumeTapEvents: true,
          onTap: () {}));

      tollsCount.add({
        "routeName": route['summary'],
        "tollCount": route['tolls'].length,
      });
    }
    polylines.refresh();
    update();
    addMarkerstoMap();
    addLog(tollsCount);
  }

  removeAllMarkers(Function onCallback) {
    markersList.clear();
    markersList = RxSet({});
    markersList.refresh();
    update();
    refresh();
    onCallback();
  }

  addMarkerstoMap() {
    removeAllMarkers(() async {
      Uint8List tollIcon =
          await srvOsGridConverter.toMarkerIcon(ktollMarker, 60, 60);
      final BitmapDescriptor svgMarker = BitmapDescriptor.fromBytes(tollIcon);

      // print(
      //     "data['tolls'].length ${routeData.length} ${routeData[0]['tolls'].length}");
      for (var data in routeData) {
        for (var i = 0; i < data['tolls'].length; i++) {
          var toll = data['tolls'][i];
          // print(
          //     "$i ${toll['NAME TOLL STATION']} ${toll['easting']}  ${toll['latitude']}");
          // print(
          //     "$i ${toll['NAME TOLL STATION']} ${toll['northing']} ${toll['longitude']}");
          if (toll['latitude'] == null || toll['longitude'] == null) {
            var coords = srvOsGridConverter.utmToLatlong(
                toll['easting'], toll['northing']);

            toll['latitude'] = coords.lat;
            toll['longitude'] = coords.lon;
          }

          markersList.add(
            Marker(
                markerId: MarkerId(DateTime.now().toString()),
                icon: svgMarker,
                position: LatLng(srvShared.anyTypeToDouble(toll['latitude']),
                    srvShared.anyTypeToDouble(toll['longitude']))),
          );
        }
      }
      // print("markersList.length  ${markersList.length}");
      markersList.refresh();
      update();
      addStartMarker();
      endStartMarker();
      // checkRouteCount();
    });
  }

  checkRouteCount() async {
    // if (result.length > routeData.length) {
    srvApi.refetchRoutesOnServer(
        "${startPlace.position!.lat},${startPlace.position!.lng}",
        "${endPlace.position!.lat},${endPlace.position!.lng}");
    // }
  }

  addStartMarker([bool shouldCheckTolls = false]) async {
    Position position = shouldCheckTolls
        ? Position(
            lat: (routeData[0]['tolls'] as List).first['latitude'],
            lng: (routeData[0]['tolls'] as List).first['longitude'])
        : startPlace.position!;
    final Uint8List markerIcon = await srvOsGridConverter.getBytesFromAsset(
        'assets/images/start-marker.png', 70);

    markersList.add(Marker(
        markerId: const MarkerId('startMarker'),
        draggable: false,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(position.lat, position.lng)));
    markersList.refresh();
    update();
  }

  endStartMarker([bool shouldCheckTolls = false]) async {
    final Uint8List markerIcon = await srvOsGridConverter.getBytesFromAsset(
        "assets/images/destination-marker.png", 70);
    // Position position = endPlace.position!;
    Position position = shouldCheckTolls
        ? Position(
            lat: (routeData[0]['tolls'] as List).last['latitude'],
            lng: (routeData[0]['tolls'] as List).last['longitude'])
        : endPlace.position!;
    markersList.add(Marker(
        markerId: const MarkerId('endMarker'),
        draggable: false,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(position.lat, position.lng)));

    markersList.refresh();
    update();
  }

  Future<Map<String, dynamic>?> getFuelPrice(double totalDis) async {
    String totalDistance = (totalDis * 0.001).toString();

    var response = await srvApi.getFuelData();
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      var elements = xmlDocument.findAllElements('gpp:element').first;
      double fuelCostPerLitre =
          double.parse(elements.findElements('gpp:gasoline').first.innerText);
      String km = totalDistance.substring(0, totalDistance.length - 3);
      km = km.replaceAll(',', '');
      km = km.replaceAll(' ', '');

      double totalLitres =
          (double.parse(carData.value.vehFuelCmp!) / 100.0) * double.parse(km);
      String gasolinePrice =
          (fuelCostPerLitre * totalLitres).toStringAsFixed(2);
      // String totalPrice = (double.parse(gasolinePrice) + double.parse(tollCost))
      //     .toStringAsFixed(2);

      return {
        "gasolinePrice": gasolinePrice,
        "totalLitres": totalLitres,
        // "totalPrice": totalPrice,
      };
    } else {
      return null;
    }
  }

  setMapBounds() {
    try {
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest:
                  LatLng(startPlace.position!.lat, startPlace.position!.lng),
              northeast: LatLng(endPlace.position!.lat, endPlace.position!.lng),
            ),
            50),
      );
    } catch (e) {
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(endPlace.position!.lat, endPlace.position!.lng),
              northeast:
                  LatLng(startPlace.position!.lat, startPlace.position!.lng),
            ),
            50),
      );
    }
  }

  mapAnimateCamera() {
    controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(startPlace.position!.lat, startPlace.position!.lng)));
  }

  calcFuelPrice(int index) async {
    // var fuelData = await getFuelPrice(
    //     srvFirebase.toDouble(routeData[index]['distance']['value']));
    // if (fuelData != null) {
    //   routeData[index]['totalPrice']['fuelPrice'] = fuelData['gasolinePrice'];
    //   // routeData.refresh();
    //   // update();
    calcPrice(index);
    // }
  }

  calcPrice(int index) {
    var info = routeData[index]['totalPrice'] ?? {};
    print("total price $index $info");

    var fuelPrice = routeData[index]['totalPriceFuel'] ?? 0.0;
    var price = {"withFuel": 0.0, "withoutFuel": 0.0};
    // var withAutoPassPrice =
    //     srvFirebase.toDouble(info['totalPriceWithAutoPass']);
    // var withoutAutoPassPrice =
    //     srvFirebase.toDouble(info['totalPriceWithoutAutoPass']);
    // var withRushPrice = srvFirebase.toDouble(info['totalPriceWithRushHour']);
    // var withoutRushPrice =
    //     srvFirebase.toDouble(info['totalPriceWithoutRushHour']);

    // print("price withAutoPassPrice $withAutoPassPrice");
    // print("price withoutAutoPassPrice $withoutAutoPassPrice");
    // print("price withRushPrice $withRushPrice");
    // print("price withoutRushPrice $withoutRushPrice");

    var gasPrice = srvFirebase.toDouble(fuelPrice ?? 0.0);

    if (autopass.isTrue && rushHour.isTrue) {
      price = {
        "withoutFuel": double.parse(info['totalPriceWithRushHourWithAutoPass']
            .toString()), //withAutoPassPrice + withRushPrice,
        "withFuel": double.parse(
                info['totalPriceWithRushHourWithAutoPass'].toString()) +
            gasPrice // (withAutoPassPrice + withRushPrice) + gasPrice
      };
    }
    if (autopass.isTrue && rushHour.isFalse) {
      price = {
        "withoutFuel": double.parse(
            info['totalPriceWithoutRushHourWithAutoPass']
                .toString()), //withAutoPassPrice + withoutRushPrice,
        "withFuel": double.parse(
                info['totalPriceWithoutRushHourWithAutoPass'].toString()) +
            gasPrice, //(withAutoPassPrice + withoutRushPrice) + gasPrice
      };
    }
    if (autopass.isFalse && rushHour.isTrue) {
      price = {
        "withoutFuel": double.parse(
            info['totalPriceWithRushHourWithoutAutoPass']
                .toString()), //withRushPrice + withoutAutoPassPrice,
        "withFuel": double.parse(
                info['totalPriceWithRushHourWithoutAutoPass'].toString()) +
            gasPrice
      };
    }

    if (autopass.isFalse && rushHour.isFalse) {
      price = {
        "withoutFuel": double.parse(
            info['totalPriceWithoutRushHourWithoutAutoPass']
                .toString()), //withoutAutoPassPrice + withoutRushPrice,
        "withFuel": double.parse(
                info['totalPriceWithoutRushHourWithoutAutoPass'].toString()) +
            gasPrice
      };
    }

    print("price $index $price");
    routeData[index]['price'] = price;
    routeData.refresh;
    return price;
  }

  calcAfterToggle() {
    for (var i = 0; i < routeData.length; i++) {
      calcPrice(i);
    }
  }
}

class IsolateModel {
  IsolateModel(this.iteration, this.multiplier);

  final int iteration;
  final int multiplier;
}
