import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/screens/profile/profile.dart';
// import 'package:new_trip_start/screens/subscription/page.dart';
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
    print(srvApi.getHeader());
    var resp = await srvApi.get(concaturl: "vehicle");

    // srvShared.printWrapped("getting vehicles -> $resp");

    if (resp.statusCode == 200) {
      if (resp.data['status'] == true) {
        for (var element in resp.data['data']) {
          Vehicle vehicle = Vehicle.fromJson(element);

          myVehicles.add(vehicle);
        }

        if (myVehicles.isNotEmpty) {
          selectedVeh = Rx(myVehicles[getSelectedVehicle()]);
          // if (selectedVeh.value.docId != null) {
          Get.find<MapController>().carData = selectedVeh;
          // }
        }
        myVehicles.refresh();
        update();
      }
    }
    // QuerySnapshot data = await srvFirebase.getVehicles();
  }

  addVehicleToList(Vehicle v, BuildContext context) {
    myVehicles.addIf(!myVehicles.contains(v), v);
    makeSelectedCar(myVehicles.length - 1, context);
    myVehicles.refresh();
    update();
  }

  removeSingleVehicleFromArray(String id) {
    myVehicles.removeWhere((element) => element.id.toString() == id);
    myVehicles.refresh();
  }

  updateSingleVehicle(Vehicle v) {
    int index = myVehicles.indexWhere((d) => d.docId == v.docId);
    if (index > -1) {
      myVehicles[index] = v;
      myVehicles.refresh();
    }
  }

  deleteVehicle(String id, BuildContext context) async {
    try {
      var resp = await srvApi.apiUrlDelete(concaturl: "vehicle/$id");
      srvShared.printWrapped(resp.toString());
      removeSingleVehicleFromArray(id);
      if (resp.data['status'] == false) {
        srvToastAlert.toast("something_went_wrong_text".tr);
      }
    } on DioException catch (e) {
      print(e.message);
      srvToastAlert.toast(e.message.toString());
    }
    // srvFirebase.deleteVehicle(id).then((value) {
    //   srvToastAlert.nativeAlert(context, "Vehicle Deleted Successfully".tr);
    // }).catchError((e) {
    //   srvToastAlert.nativeAlert(
    //       context,
    //       "There is an error while deleting this vehicle. Please try agaain later"
    //           .tr);
    // });
  }

  updateSingleVehicleToFirebase(int index, data) {
    // srvFirebase.updateVehicle(myVehicles[index].docId!, data);
  }

  int getSelectedVehicle() {
    int index = myVehicles.indexWhere((element) => element.isSelected == true);
    return index;
  }

  makeSelectedCar(int index, BuildContext context) {
    srvToastAlert.confirmNativeAlert(
        context,
        "Are you sure you want to make this your selected Car?".tr,
        "CONFIRM".tr, () async {
      try {
        for (var v in myVehicles) {
          v.isSelected = false;
        }
        myVehicles[index].isSelected = true;
        selectedVeh = Rx(myVehicles[index]);
        Get.find<MapController>().carData = selectedVeh;
        var resp = await srvApi.apiUrlput(
            concaturl: "vehicle/${selectedVeh.value.id}",
            data: {"isSelected": true});
        srvShared.printWrapped(resp.toString());
        myVehicles.refresh();
        update();
      } catch (e) {
        print(e);
      }

      // int previousIndex = getSelectedVehicle();
      // if (previousIndex > -1) {
      //   updateSingleVehicleToFirebase(previousIndex, {"isSelected": false});
      //   myVehicles[previousIndex].isSelected = false;
      //   update();
      // }
      // for (var element in myVehicles) {
      //   element.isSelected == false;
      // }
      // myVehicles[index].isSelected = true;
      // updateSingleVehicleToFirebase(index, {"isSelected": true});
      // selectedVeh = Rx(myVehicles[index]);
      // Get.find<MapController>().carData = selectedVeh;
      // myVehicles.refresh();
      // update();
    });
  }

  // checkIfUserNotSubscribed(BuildContext context) {
  //   print(srvUser.user.user!.email);
  //   print(srvUser.user.isSubscribed);
  //   if (srvUser.user.isSubscribed == false) {
  //     Future.delayed(const Duration(seconds: 3), () {
  //       srvPageRoute.goNextWithGetx(const SubscriptionPage());
  //     });
  //   }
  // }
}
