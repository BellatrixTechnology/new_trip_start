import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/screens/profile/profile.dart';
import 'package:new_trip_start/screens/tab_navigator/home/home.dart';
import 'package:new_trip_start/screens/tab_navigator/my-vehicles/my_vehicles.dart';
import 'package:new_trip_start/services/index.dart';

class BottomTabController extends GetxController {
  final selectedTabIndex = 0.obs;
  List<Widget> page = const <Widget>[HomePage(), MyVehicles(), ProfilePage()];

  RxList languages = RxList([
    {"text": "English", "isSelected": true},
    {"text": "Norwegian", "isSelected": false},
  ]);

  RxList<Vehicle> myVehicles = RxList([]);

  @override
  void onInit() {
    super.onInit();
    getVehicles();
  }

  var switchToNext = false.obs;
  var availRoutetitle = 'Available Route'.obs;

  onTabChange(int index) {
    selectedTabIndex.value = index;
    update();
  }

  onLanguageSelect(index) {
    for (var element in languages) {
      element['isSelected'] = false;
    }
    languages[index]['isSelected'] = true;
    languages.refresh();
  }

  getVehicles() async {
    // myVehicles = RxList([]);
    QuerySnapshot data = await srvFirebase.getVehicles();

    for (var element in data.docChanges) {
      List<Vehicle> v =
          myVehicles.where((d) => d.docId == element.doc.id).toList();
      if (v.isEmpty) {
        myVehicles.add(element.doc.data() as Vehicle);
      }
    }
    myVehicles.refresh();
  }

  removeSingleVehicleFromArray(String id) {
    myVehicles.removeWhere((element) => element.docId == id);
    myVehicles.refresh();
  }

  updateSingleVehicle(Vehicle v) {
    int index = myVehicles.indexWhere((d) => d.docId == v.docId);
    if (index > -1) {
      myVehicles[index] = v;
      myVehicles.refresh();
    }
  }

  deleteVehicle(String id, BuildContext context) {
    srvFirebase.deleteVehicle(id).then((value) {
      removeSingleVehicleFromArray(id);
      srvToastAlert.nativeAlert(context, "Vehicle Deleted Successfully");
    }).catchError((e) {
      srvToastAlert.nativeAlert(context,
          "There is an error while deleting this vehicle. Please try agaain later");
    });
  }
}
