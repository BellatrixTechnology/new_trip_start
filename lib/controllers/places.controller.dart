import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/services/index.dart';

class PlaceController extends GetxController {
  RxList<GooglePlacesModel> googlePlaces = RxList([]);
  var isSearching = false.obs;
  TextEditingController placeSearch = TextEditingController();
  TextEditingController startPlaceCtrl = TextEditingController();
  TextEditingController endPlaceCtrl = TextEditingController();
  RxList availRoutes = RxList([]);

  GooglePlacesModel startPlace =
      GooglePlacesModel(description: "", placeId: "");
  GooglePlacesModel endPlace = GooglePlacesModel(description: "", placeId: "");

  var switchToNext = false.obs;
  var availRoutetitle = 'Available Route'.obs;

  var isFindigRoutes = false.obs;

  MapController mapCtrrl = Get.put(MapController());

  getSearchResult(String text) async {
    if (text.length < 2) return;
    toggleSearch();
    // places = RxList([]);
    var resp = await srvApi.searchPlaces(text);

    // print(resp);

    if (resp != null) {
      toggleSearch();
      if (resp.data['status'] == "OK") {
        if (resp.data['predictions'].length > 0) {
          googlePlaces.assignAll([]);
          for (var element in resp.data['predictions']) {
            int index = googlePlaces
                .indexWhere((gp) => gp.placeId == element['place_id']);
            if (index < 0) {
              googlePlaces.add(GooglePlacesModel.fromJson(element));
            }
          }
          googlePlaces.refresh();
          update();
        }
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

  onPlaceSelect(GooglePlacesModel place, bool isDestination) async {
    var resp = await srvApi.getPlaceDetailsFromPlaceId(place.placeId);
    if (resp.data['status'] == "OK") {
      Map<String, dynamic> pos = resp.data['result']['geometry']['location'];
      place.position =
          Position.fromjson({"lat": pos['lat'], 'lng': pos['lng']});
    }

    if (!isDestination) {
      startPlace = place;
      startPlaceCtrl.text = place.description;
      mapCtrrl.startPlace = startPlace;
      mapCtrrl.addStartMarker();
      mapCtrrl.mapAnimateCamera();
      clearSearchData();
    } else {
      endPlace = place;
      endPlaceCtrl.text = place.description;
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
