import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/services/index.dart';

class AddVehicleCtrl extends GetxController {
  var isVehichleAddedModalExpanded = false.obs;
  BottomTabController bottomTabController = Get.find();

  TextEditingController regNum = TextEditingController();
  TextEditingController vehBrand = TextEditingController();
  TextEditingController vehFuelCmp = TextEditingController();
  TextEditingController vehLength = TextEditingController();
  TextEditingController vehWeight = TextEditingController();
  TextEditingController vehClass = TextEditingController();
  TextEditingController vehFuelType = TextEditingController();
  var fuelTypeid = '';

  var carWeight = 0.obs;

  var isFetchingRecord = false.obs;
  var showClassInput = true.obs;

  var fuelTypes = [
    {
      "name": "Bensin / ladbar hybrid",
      "isSelected": false,
      "id": 1,
    },
    {
      "name": "Diesel",
      "isSelected": false,
      "id": 2,
    },
    {
      "name": "Elbil",
      "isSelected": false,
      "id": 5,
    },
    {
      "name": "Nullutslipp og gass",
      "isSelected": false,
      "id": 12,
    }
  ].obs;

  var euroClassTypes = [
    {
      "name": "Euro 5 og eldre (Or older)",
      "isSelected": false,
    },
    {
      "name": "Euro 6",
      "isSelected": false,
    },
    {
      "name": "Nullutslipp og gass (0 emissions or Gas/Lpg)",
      "isSelected": false,
    },
  ].obs;

  var vehicleGroups = [
    {
      "name": "M1",
      "isSelected": false,
    },
    {
      "name": "Others",
      "isSelected": false,
    }
  ].obs;

  onVehicleSave(BuildContext context) {
    if (regNum.text.isEmpty) {
      srvToastAlert.toast('Please enter registration Number'.tr);
    } else if (vehBrand.text.isEmpty) {
      srvToastAlert.toast('Please enter Vehicle Brand/Name'.tr);
    } else if (vehFuelCmp.text.isEmpty) {
      srvToastAlert.toast('Please enter Vehicle Fuel Consumption'.tr);
    } else if (vehLength.text.isEmpty) {
      srvToastAlert.toast('Please enter Vehicle Length in meters'.tr);
    } else if (vehWeight.text.isEmpty) {
      srvToastAlert.toast('Please enter Vehicle Weight in kgs'.tr);
    } else if (double.parse(vehWeight.text) > 3000 && vehClass.text.isEmpty) {
      srvToastAlert.toast('Please select Vehicle Euro Class type'.tr);
    } else if (vehFuelType.text.isEmpty) {
      srvToastAlert.toast('Please select Vehicle Fuel type'.tr);
    } else {
      toggleLoader();
      bottomTabController.getSelectedVehicle();
      srvFirebase.addVehicle({
        "regNum": regNum.text,
        "vehBrand": vehBrand.text,
        "vehFuelCmp": vehFuelCmp.text,
        "vehLength": vehLength.text,
        "vehWeight": vehWeight.text,
        "vehClass": vehClass.text,
        "vehFuelType": vehFuelType.text.toUpperCase() == "BENSIN"
            ? "petrol"
            : vehFuelType.text,
        "color": "0046AC",
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "updatedAt": DateTime.now().millisecondsSinceEpoch,
        "userId": srvFirebase.auth.currentUser!.uid,
        "fuelTypeid": fuelTypeid,
        "vehicleGroup":
            vehicleGroups.where((p0) => p0['isSelected'] = true).first['name'],
        "isSelected": true
      }).then((value) {
        int index = bottomTabController.getSelectedVehicle();
        if (index > -1) {
          bottomTabController.updateSingleVehicleToFirebase(
              bottomTabController.getSelectedVehicle(), {"isSelected": false});
        }
        bottomTabController.getVehicles();

        toggleLoader();
        srvPageRoute.goBack(context);
        AppBottomModal().confirmBottomSheet(
            context,
            () {},
            Image.asset(
              'assets/illustrations/tick.png',
              width: 90,
              height: 90,
            ),
            "Vehicle Added".tr,
            "Your Vehicle has been added successfully".tr,
            'Yes',
            true);
      });
    }
  }

  fetchVehicleData(VoidCallback callback) {
    if (regNum.text.isEmpty) {
      srvToastAlert.toast('Please enter your vehicle Registration Number');
    } else {
      toggleLoader();
      srvApi.getVehicleDataWithRegistrationNum(regNum.text).then((value) {
        toggleLoader();
        if (value.statusCode == 200) {
          if (value.data != null) {
            // log(jsonEncode(value.data));
            var tekniskGodkjenning = value.data['kjoretoydataListe'][0]
                ['godkjenning']['tekniskGodkjenning'];
            var data = tekniskGodkjenning['tekniskeData'];

            var vehicleGroup = tekniskGodkjenning['kjoretoyklassifisering']
                ['tekniskKode']['kodeVerdi'];

            if (data['generelt']['merke'][0] != null) {
              vehBrand.text = data['generelt']['merke'][0]['merke'];
            }

            if (data['vekter']['egenvekt'] != null) {
              vehWeight.text = data['vekter']['egenvekt'].toString();
              if (data['vekter']['egenvekt'] > 3500) {
                showClassInput.value = true;
                update();
              }
            }

            if (data['dimensjoner']['lengde'] != null) {
              vehLength.text =
                  (data['dimensjoner']['lengde'] * 0.001).toStringAsFixed(2);
            }

            if (data['miljodata']['miljoOgdrivstoffGruppe'].length > 0) {
              var datas = data['miljodata']['miljoOgdrivstoffGruppe'][0]
                  ['forbrukOgUtslipp'];

              if (datas != null && datas[0]['forbrukBlandetKjoring'] != null) {
                print(
                    "datas[0]['forbrukBlandetKjoring'] ${datas[0]['forbrukBlandetKjoring']}");
                vehFuelCmp.text = datas[0]['forbrukBlandetKjoring'].toString();
                // calc10Percent(datas[0]['forbrukBlandetKjoring'])
                //     .toString(); //data['dimensjoner']['lengde'];
              }
            }

            if (data['miljodata'] != null &&
                data['miljodata']['euroKlasse'] != null) {
              if (data['miljodata']['euroKlasse']['kodeVerdi'] != null) {
                vehClass.text = data['miljodata']['euroKlasse']['kodeVerdi'];
              }
            }

            if (data['motorOgDrivverk'] != null &&
                data['motorOgDrivverk']['motor'] != null) {
              if (data['motorOgDrivverk']['motor'].length > 0) {
                if (data['motorOgDrivverk']['motor'][0]['drivstoff'] != null &&
                    data['motorOgDrivverk']['motor'][0]['drivstoff'][0] !=
                        null) {
                  vehFuelType.text = data['motorOgDrivverk']['motor'][0]
                      ['drivstoff'][0]['drivstoffKode']['kodeNavn'];
                  fuelTypeid = data['motorOgDrivverk']['motor'][0]['drivstoff']
                      [0]['drivstoffKode']['kodeVerdi'];
                }
              }
            }

            if (vehicleGroup != null) {
              updateVehicleGroups(vehicleGroup == 'M1' ? 0 : 1);
            }

            callback();
          }
        } else {
          srvToastAlert
              .toast('No Vehicle Found against this register number'.tr);
        }
      });
    }
  }

  checkVehicleWeight() {}

  setFieldValues(Vehicle? vehicle) {
    regNum.text = vehicle!.regNum!;
    vehBrand.text = vehicle.vehBrand!;
    vehFuelCmp.text = vehicle.vehFuelCmp!;
    vehLength.text = vehicle.vehFuelType!;
    vehWeight.text = vehicle.vehWeight!;
    vehClass.text = vehicle.vehClass!;
    vehFuelType.text = vehicle.vehFuelType!;
    fuelTypeid = vehicle.fuelTypeid!;
    updateVehicleGroups(vehicle.vehicleGroup == 'M1' ? 0 : 1);
  }

  updateVehicle(Vehicle? vehicle, BuildContext context) {
    toggleLoader();
    int date = DateTime.now().millisecondsSinceEpoch;
    String vehGroup = vehicleGroups
        .where((p0) => p0['isSelected'] = true)
        .first['name']
        .toString();
    srvFirebase.updateVehicle(vehicle!.docId!, {
      "regNum": regNum.text,
      "vehBrand": vehBrand.text,
      "vehFuelCmp": vehFuelCmp.text,
      "vehLength": vehLength.text,
      "vehWeight": vehWeight.text,
      "vehClass": vehClass.text,
      "vehFuelType": vehFuelType.text.toUpperCase() == "BENSIN"
          ? "petrol"
          : vehFuelType.text,
      "color": "0046AC",
      "userId": srvFirebase.auth.currentUser!.uid,
      "fuelTypeid": fuelTypeid,
      "updatedAt": date,
      "vehicleGroup": vehGroup
    }).then((value) {
      Vehicle v = Vehicle(
          color: "0046AC",
          fuelTypeid: fuelTypeid,
          regNum: regNum.text,
          vehWeight: vehWeight.text,
          vehLength: vehLength.text,
          vehClass: vehClass.text,
          vehBrand: vehBrand.text,
          vehFuelCmp: vehFuelCmp.text,
          vehFuelType: vehFuelType.text,
          docId: vehicle.docId,
          createdAt: vehicle.createdAt,
          updatedAt: date,
          vehicleGroup: vehGroup,
          userId: srvFirebase.auth.currentUser!.uid);
      bottomTabController.updateSingleVehicle(v);
      srvToastAlert.toast('Vehicle Updated Successfully'.tr);
      toggleLoader();
      srvPageRoute.goBack(context);
    });
  }

  toggleLoader() {
    isFetchingRecord.toggle();
    update();
  }

  calc10Percent(double val) {
    double percent = val * 0.10;
    return val + percent;
  }

  updateFuelType(int index) {
    for (var element in fuelTypes) {
      element['isSelected'] = false;
    }
    fuelTypes[index]['isSelected'] = true;
    fuelTypes.refresh();
  }

  updateClassType(int index) {
    for (var element in euroClassTypes) {
      element['isSelected'] = false;
    }
    euroClassTypes[index]['isSelected'] = true;
    euroClassTypes.refresh();
  }

  updateVehicleGroups(int index) {
    for (var element in vehicleGroups) {
      element['isSelected'] = false;
    }
    vehicleGroups[index]['isSelected'] = true;
    vehicleGroups.refresh();
  }
}
