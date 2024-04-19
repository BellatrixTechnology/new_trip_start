import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/services/index.dart';

class PlaceController extends GetxController {
  RxList<CityModel> googlePlaces = RxList([]);
  var isSearching = false.obs;
  TextEditingController placeSearch = TextEditingController();
  TextEditingController startPlaceCtrl = TextEditingController();
  TextEditingController endPlaceCtrl = TextEditingController();
  RxList availRoutes = RxList([]);

  CityModel startPlace =
      CityModel(name: "", id: -1, latitude: "", longitude: "");
  CityModel endPlace = CityModel(name: "", id: -1, latitude: "", longitude: "");

  var switchToNext = false.obs;
  var availRoutetitle = 'Available Route'.obs;

  var isFindigRoutes = false.obs;

  MapController mapCtrrl = Get.put(MapController());

  getSearchResult(String text) async {
    if (text.length < 2 && isSearching.isFalse) return;
    toggleSearch();
    // places = RxList([]);
    var resp = await srvApi.getResultForSearchedPlaces(text);

    print(resp);

    toggleSearch();
    if (resp.data['status'] == true) {
      if (resp.data['data'].length > 0) {
        googlePlaces.assignAll([]);
        for (var element in resp.data['data']) {
          int index = googlePlaces.indexWhere((gp) => gp.id == element['id']);
          if (index < 0) {
            googlePlaces.add(CityModel.fromMap(element));
          }
        }
        googlePlaces.refresh();
        update();
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

  onPlaceSelect(CityModel place, bool isDestination) async {
    // var resp = await srvApi.getPlaceDetailsFromPlaceId(place.placeId);
    // if (resp.data['status'] == "OK") {
    //   Map<String, dynamic> pos = resp.data['result']['geometry']['location'];
    //   place.position =
    //       Position.fromjson({"lat": pos['lat'], 'lng': pos['lng']});
    // }
    place.position = Position(
        lat: double.parse(place.latitude), lng: double.parse(place.longitude));

    if (!isDestination) {
      startPlace = place;
      startPlaceCtrl.text = place.name;
      mapCtrrl.startPlace = startPlace;
      mapCtrrl.addStartMarker();
      mapCtrrl.mapAnimateCamera();
      clearSearchData();
    } else {
      endPlace = place;
      endPlaceCtrl.text = place.name;
      mapCtrrl.endPlace = endPlace;
      mapCtrrl.endStartMarker();
      mapCtrrl.setMapBounds();
      mapCtrrl.getData();
      clearSearchData();
    }
  }

  clearSearchData() {
    placeSearch.clear();
    googlePlaces.assignAll([]);
    update();
  }

  findRoutesAndData() {
    toggleFindingRoute();
    srvApi.getAllData(startPlace.position!, endPlace.position!).then((value) {
      if (value.statusCode == 200) {
        availRoutes = RxList(value.data['routes']);
        availRoutes.refresh();
        toggleFindingRoute();
        update();
      } else {
        toggleFindingRoute();
      }
      // inspect(value.data['routes'][0]);
    });
  }
}
