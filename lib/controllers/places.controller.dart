import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:xml/xml.dart';

class PlaceController extends GetxController {
  RxList<Place> places = RxList([]);
  var isSearching = false.obs;
  TextEditingController placeSearch = TextEditingController();
  TextEditingController startPlaceCtrl = TextEditingController();
  TextEditingController endPlaceCtrl = TextEditingController();
  RxList availRoutes = RxList([]);

  Place startPlace = Place();
  Place endPlace = Place();

  var switchToNext = false.obs;
  var availRoutetitle = 'Available Route'.obs;

  var isFindigRoutes = false.obs;

  MapController map_ctrl = Get.find();

  getSearchResult(String text) async {
    toggleSearch();
    places = RxList([]);
    var resp = await srvApi.getPlaceByKeyWords(text);
    toggleSearch();
    if (resp.statusCode == 200) {
      if (resp.data['items'].length > 0) {
        for (var obj in resp.data['items']) {
          places.add(Place.fromjson(obj));
        }
        places.refresh();
      }
    }
  }

  toggleSearch() {
    isSearching.toggle();
    update();
  }

  toggleFindingRoute() {
    isFindigRoutes.toggle();
    update();
  }

  onPlaceSelect(Place place, bool isDestination) {
    if (!isDestination) {
      inspect(place.position);
      startPlace = place;
      startPlaceCtrl.text = place.title!;
      map_ctrl.startPlace = startPlace;
      map_ctrl.addStartMarker(place.position!);
      map_ctrl.mapAnimateCamera();
    } else {
      endPlace = place;
      endPlaceCtrl.text = place.title!;
      // findRoutesAndData();

      var startUtm = srvOsGridConverter.fromLatLon(
          startPlace.position!.lat, startPlace.position!.lng, 33);
      var endUtm = srvOsGridConverter.fromLatLon(
          endPlace.position!.lat, endPlace.position!.lng, 33);
      map_ctrl.endPlace = endPlace;
      map_ctrl.endStartMarker(endPlace.position!);
      map_ctrl.setMapBounds();
      String stops =
          '${startUtm['easting']},${startUtm['northing']};${endUtm['easting']},${endUtm['northing']}';
      // print(stops);
      map_ctrl.getData(stops);
      // srvRouting.addRoute();
    }
  }

  findRoutesAndData() {
    // inspect(startPlace.position);
    // inspect(endPlace.position);
    toggleFindingRoute();
    srvApi.getAllData(startPlace.position!, endPlace.position!).then((value) {
      if (value.statusCode == 200) {
        availRoutes = RxList(value.data['routes']);
        availRoutes.refresh();
        drawAllPaths();
        toggleFindingRoute();
        update();
      } else {
        toggleFindingRoute();
      }
      // inspect(value.data['routes'][0]);
    });
  }

  drawAllPaths() {
    srvRouting.clearMap();
    srvRouting.boudMapWithLatLng(startPlace.position!, endPlace.position!);
    srvRouting.addMyMarker(startPlace.position!);
    srvRouting.addDestMarker(endPlace.position!);

    for (var route in availRoutes) {
      for (var section in route['sections']) {
        srvRouting.showAllRouteOnMap(section['polyline']);
        if (section['tolls'] != null) {
          for (var toll in section['tolls']) {
            var loc = toll['tollCollectionLocations'][0]['location'];
            Position position = Position(lat: loc['lat'], lng: loc['lng']);
            srvRouting.addMultipleMarkers(position);
          }
        }
      }
    }
  }

  getFuelPrice(String totalDis, String tollCost, int index) async {
    double totalDistance = double.parse(totalDis.replaceAll(" km", ""));
    // print("totalDis $totalDis");
    srvApi.getFuelData("$totalDistance km", "394.0").then((response) {
      // print('response.statusCode ${response.statusCode}');
      // print(response.data);
      if (response.statusCode == 200) {
        XmlDocument xmlDocument = XmlDocument.parse(response.data);
        var elements = xmlDocument.findAllElements('gpp:element').first;
        double fuelCostPerLitre =
            double.parse(elements.findElements('gpp:gasoline').first.text);
        // print("fuelCostPerLitre $");

        // double dis = double.parse(totalDis);
        // int fialDis = dis.ceil();
        String km = totalDis.substring(0, totalDis.length - 3);
        km = km.replaceAll(',', '');
        // km = km.replaceAll('.', '');
        km = km.replaceAll(' ', '');

        // print('$km $tollCost');

        double totalLitres = (11.11 / 100.0) *
            double.parse(km); //widget.litresPerKm * double.parse(km);

        String gasolinePrice =
            (fuelCostPerLitre * totalLitres).toStringAsFixed(2);
        String totalPrice =
            (double.parse(gasolinePrice) + double.parse(tollCost))
                .toStringAsFixed(2);

        availRoutes[index]['sections'][0]['travelSummary']['totalSpent'] =
            totalPrice;
        availRoutes[index]['sections'][0]['travelSummary']['gasolinePrice'] =
            gasolinePrice;
        availRoutes.refresh();
        update();

        // print("gasolinePrice $gasolinePrice");
        // print("totalLitres $totalLitres");
        // print("_totalPrice $_totalPrice");
      } else {}
    }).catchError((error) {
      // srvToastAlert.toast(error.toString());
    });
  }
}
