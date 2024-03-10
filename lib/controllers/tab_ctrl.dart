import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/screens/profile/profile.dart';
import 'package:new_trip_start/screens/subscription/page.dart';
// import 'package:new_trip_start/screens/subscription/page.dart';
import 'package:new_trip_start/screens/tab_navigator/home/home.dart';
import 'package:new_trip_start/screens/tab_navigator/my-vehicles/my_vehicles.dart';
import 'package:new_trip_start/services/index.dart';

class BottomTabController extends GetxController {
  List<Widget> page = const <Widget>[HomePage(), MyVehicles(), ProfilePage()];

  RxList languages = RxList([
    {"text": "English", "isSelected": true},
    {"text": "Norwegian", "isSelected": false},
  ]);

  RxList<Vehicle> myVehicles = RxList([]);
  Rx<Vehicle> selectedVeh = Vehicle().obs;

  @override
  void onInit() {
    super.onInit();
    getVehicles();
    srvAnalytics.inituser();
  }

  final selectedTabIndex = 1.obs;

  onTabChange(int index, BuildContext context) {
    if (index == 0 && myVehicles.isEmpty) {
      srvToastAlert.nativeAlert(
          context,
          "Atleat one vehicle you should be in your list to calculate Route".tr,
          false);
      return;
    }
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
    myVehicles = RxList([]);
    QuerySnapshot data = await srvFirebase.getVehicles();

    for (var element in data.docChanges) {
      Vehicle? v =
          myVehicles.firstWhereOrNull((d) => d.docId == element.doc.id);
      if (v == null) {
        myVehicles.add(element.doc.data() as Vehicle);
      }
    }
    if (myVehicles.isNotEmpty) {
      selectedVeh = Rx(myVehicles[getSelectedVehicle()]);
      if (selectedVeh.value.docId != null) {
        Get.find<MapController>().carData = selectedVeh;
        myVehicles.refresh();
        update();
      }
    }
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
      srvToastAlert.nativeAlert(context, "Vehicle Deleted Successfully".tr);
    }).catchError((e) {
      srvToastAlert.nativeAlert(
          context,
          "There is an error while deleting this vehicle. Please try agaain later"
              .tr);
    });
  }

  updateSingleVehicleToFirebase(int index, data) {
    srvFirebase.updateVehicle(myVehicles[index].docId!, data);
  }

  int getSelectedVehicle() {
    int index = myVehicles.indexWhere((element) => element.isSelected == true);
    return index;
  }

  makeSelectedCar(int index, BuildContext context) {
    srvToastAlert.confirmNativeAlert(
        context,
        "Are you sure you want to make this your selected Car?".tr,
        "CONFIRM".tr, () {
      int previousIndex = getSelectedVehicle();
      if (previousIndex > -1) {
        updateSingleVehicleToFirebase(previousIndex, {"isSelected": false});
        myVehicles[previousIndex].isSelected = false;
        update();
      }
      for (var element in myVehicles) {
        element.isSelected == false;
      }
      myVehicles[index].isSelected = true;
      updateSingleVehicleToFirebase(index, {"isSelected": true});
      selectedVeh = Rx(myVehicles[index]);
      Get.find<MapController>().carData = selectedVeh;
      myVehicles.refresh();
      update();
    });
  }

  checkIfUserNotSubscribed(BuildContext context) {
    print(srvUser.user.user!.email);
    print(srvUser.user.isSubscribed);
    if (srvUser.user.isSubscribed == false) {
      Future.delayed(const Duration(seconds: 3), () {
        srvPageRoute.goNextWithGetx(const SubscriptionPage());
      });
    }
  }
}
