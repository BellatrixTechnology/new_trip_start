import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_outline_button.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_rich_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/add_vehicle.controller.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';

class AppBottomModal {
  bottomSheet(BuildContext context,
      [Widget? icon,
      String? heading,
      String? para,
      String? btnText,
      VoidCallback? onPress]) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          color: kBgLightColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSpacer(spaceValue: 10),
              icon ??
                  const CustomSurffixIcon(
                    svgIcon: 'assets/icons/password.svg',
                    size: 35,
                  ),
              const CustomSpacer(spaceValue: 10),
              AppText(
                text: heading ?? 'Reset Link Sent',
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const CustomSpacer(spaceValue: 5),
              AppText(
                  fontSize: 14,
                  color: kTextColor,
                  text: para ??
                      'We’ve sent reset password link to your \nregistered email.'),
              const CustomSpacer(spaceValue: 20),
              AppButton(
                text: btnText ?? 'OK',
                press: () {
                  if (onPress != null) {
                    onPress();
                    return;
                  }
                  srvPageRoute.goBack(context);
                  srvPageRoute.goBack(context);
                },
                showLoader: false,
              ),
              const CustomSpacer(spaceValue: 20),
            ],
          ),
        );
      },
    );
  }

  confirmBottomSheet(
    BuildContext context,
    Function callback, [
    Widget? icon,
    String? heading,
    String? paragragh,
    String? okBtnText,
    bool? hideButtons,
  ]) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return SafeArea(
            child: Container(
          padding: const EdgeInsets.all(20),
          color: kBgLightColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSpacer(spaceValue: 10),
              icon ??
                  Image.asset('assets/illustrations/delete.png',
                      width: 100, height: 100),
              const CustomSpacer(spaceValue: 10),
              AppText(
                text: heading ?? 'Delete Vehicle?',
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const CustomSpacer(spaceValue: 5),
              AppText(
                  fontSize: 14,
                  color: kTextColor,
                  text: paragragh ??
                      'Are you sure you want to delete this vehicle?'),
              const CustomSpacer(spaceValue: 20),
              hideButtons != null
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppOutlineButton(
                          text: 'No',
                          width: (SizeConfig.screenWidth - 60) / 2,
                          press: () {
                            srvPageRoute.goBack(context);
                            // srvPageRoute.goBack(context);
                          },
                          showLoader: false,
                        ),
                        AppButton(
                          text: okBtnText ?? 'Yes',
                          width: (SizeConfig.screenWidth - 60) / 2,
                          press: () {
                            srvPageRoute.goBack(context);
                            callback();
                          },
                          showLoader: false,
                        ),
                      ],
                    ),
            ],
          ),
        ));
      },
    );
  }

  addVehicleModal(BuildContext context, VoidCallback onFinish,
      [bool? isEditing, Vehicle? vehicle]) {
    AddVehicleCtrl vehicleCtrl = Get.put(AddVehicleCtrl());
    if (isEditing == true) {
      vehicleCtrl.isVehichleAddedModalExpanded.value = true;
      vehicleCtrl.setFieldValues(vehicle);
      vehicleCtrl.update();
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // transitionAnimationController: ,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 3),
              height: vehicleCtrl.isVehichleAddedModalExpanded.isFalse
                  ? null
                  : SizeConfig.screenHeight - (kToolbarHeight),
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              color: kBgLightColor,
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSpacer(spaceValue: 10),
                    Image.asset('assets/illustrations/add.png',
                        width: 120, height: 120),
                    const CustomSpacer(spaceValue: 10),
                    AppText(
                      text: vehicleCtrl.isVehichleAddedModalExpanded.isTrue
                          ? 'Save your Vehicle'
                          : 'Enter Registeration Number',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    const CustomSpacer(spaceValue: 5),
                    AppText(
                        fontSize: 14,
                        color: kTextColor,
                        text: vehicleCtrl.isVehichleAddedModalExpanded.isTrue
                            ? 'Please enter your Vehicle Details below'
                            : 'Please enter your Vehicle Registeration Number'),
                    const CustomSpacer(spaceValue: 10),
                    const AppText(text: 'Vehicle Registeration Number'),
                    const CustomSpacer(spaceValue: 3),
                    AppInput(
                      hintText: 'Enter Registeration Number',
                      controller: vehicleCtrl.regNum,
                    ),
                    const CustomSpacer(spaceValue: 5),
                    Obx(() => Visibility(
                          visible:
                              vehicleCtrl.isVehichleAddedModalExpanded.isTrue,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(text: 'Vehicle Brand'),
                              const CustomSpacer(spaceValue: 3),
                              AppInput(
                                hintText: 'Vehicle Brand',
                                controller: vehicleCtrl.vehBrand,
                              ),
                              const CustomSpacer(spaceValue: 5),
                              const AppText(text: 'Vehicle Fuel Consumption'),
                              const CustomSpacer(spaceValue: 3),
                              AppInput(
                                  controller: vehicleCtrl.vehFuelCmp,
                                  hintText: 'Fuel Consumption/Liter Per 10 Km'),
                              const CustomSpacer(spaceValue: 5),
                              const AppText(text: 'Car Length (Meters)'),
                              const CustomSpacer(spaceValue: 3),
                              AppInput(
                                hintText: 'Car Length (Meters)',
                                controller: vehicleCtrl.vehLength,
                                textInputType: TextInputType.number,
                              ),
                              const CustomSpacer(spaceValue: 5),
                              const AppText(
                                text: 'Car Weight (Kilograms)',
                              ),
                              const CustomSpacer(spaceValue: 3),
                              AppInput(
                                hintText: 'Car Weight (Kilograms)',
                                controller: vehicleCtrl.vehWeight,
                                textInputType: TextInputType.number,
                              ),
                              const CustomSpacer(spaceValue: 5),
                              // Obx(
                              //   () => Visibility(
                              //     visible: vehicleCtrl.showClassInput.value,
                              //     child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(text: 'Euro Class'),
                                  const CustomSpacer(spaceValue: 3),
                                  AppInput(
                                    onPress: () {
                                      selectItemModal(context, false);
                                    },
                                    readOnly: true,
                                    hintText: 'Euro Class',
                                    controller: vehicleCtrl.vehClass,
                                    suffixicon: const Icon(
                                      CupertinoIcons.chevron_down,
                                      color: kBlackColor,
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                              // ),
                              // ),
                              const CustomSpacer(spaceValue: 5),
                              const AppText(text: 'Fuel Type'),
                              const CustomSpacer(spaceValue: 3),
                              AppInput(
                                onPress: () {
                                  selectItemModal(context, true);
                                },
                                readOnly: true,
                                hintText: 'Select Fuel Type',
                                controller: vehicleCtrl.vehFuelType,
                                suffixicon: const Icon(
                                  CupertinoIcons.chevron_down,
                                  color: kBlackColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Visibility(
                      visible: vehicleCtrl.isVehichleAddedModalExpanded.isFalse,
                      child: SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AppText(
                                text: 'OR',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  vehicleCtrl.isVehichleAddedModalExpanded
                                      .toggle();
                                  vehicleCtrl.update();
                                },
                                child: const CustomRichText(
                                    padding: 0,
                                    text1: 'To Add Vehicle Manually. ',
                                    text2: 'Click here'),
                              ),
                            ],
                          )),
                    ),
                    const CustomSpacer(spaceValue: 10),
                    Obx(
                      () => Visibility(
                        visible:
                            vehicleCtrl.isVehichleAddedModalExpanded.isTrue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(text: 'Vehicle Group'),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: vehicleCtrl.vehicleGroups.length,
                              itemBuilder: (context, index) {
                                var item = vehicleCtrl.vehicleGroups[index];
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    vehicleCtrl.updateVehicleGroups(index);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        CustomSurffixIcon(
                                            svgIcon: item['isSelected'] == true
                                                ? "assets/icons/checkmark.svg"
                                                : "assets/icons/unchekmark.svg"),
                                        const CustomSpacer(spaceValue: 5),
                                        AppText(
                                          text: item['name'].toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const CustomSpacer(spaceValue: 10),
                    Obx(
                      () => AppButton(
                        text: vehicleCtrl.isVehichleAddedModalExpanded.isFalse
                            ? 'Submit'
                            : 'Save',
                        press: () {
                          if (isEditing == true) {
                            vehicleCtrl.updateVehicle(vehicle, context);
                            return;
                          }

                          if (vehicleCtrl
                              .isVehichleAddedModalExpanded.isFalse) {
                            vehicleCtrl.fetchVehicleData(() {
                              vehicleCtrl.isVehichleAddedModalExpanded.value =
                                  true;
                              vehicleCtrl.update();
                            });
                          } else {
                            vehicleCtrl.onVehicleSave(context);
                          }
                        },
                        showLoader: vehicleCtrl.isFetchingRecord.value,
                      ),
                    ),
                    const CustomSpacer(spaceValue: 10),
                  ],
                ),
              )),
            ));
      },
    ).whenComplete(() {
      vehicleCtrl.isVehichleAddedModalExpanded.value = false;
      vehicleCtrl.isFetchingRecord.value = false;
      vehicleCtrl.update();
    });
  }

  selectItemModal(BuildContext context, bool isFuelType) {
    AddVehicleCtrl vehicleCtrl = Get.put(AddVehicleCtrl());
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    srvPageRoute.goBack(context);
                  },
                  child: const Icon(Icons.close),
                ),
                const CustomSpacer(spaceValue: 10),
                AppText(
                  text: isFuelType ? "Select Fuel Type" : "Select Euro Class",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  text: isFuelType
                      ? "Please select your Vehicle Fuel Type."
                      : "Please select your Vehicle Euro Class.",
                  fontSize: 14,
                  color: kTextColor,
                ),
                const CustomSpacer(spaceValue: 10),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: isFuelType
                        ? vehicleCtrl.fuelTypes.length
                        : vehicleCtrl.euroClassTypes.length,
                    itemBuilder: ((context, index) {
                      var item = isFuelType
                          ? vehicleCtrl.fuelTypes[index]
                          : vehicleCtrl.euroClassTypes[index];
                      return InkWell(
                        onTap: () {
                          isFuelType
                              ? vehicleCtrl.updateFuelType(index)
                              : vehicleCtrl.updateClassType(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              CustomSurffixIcon(
                                  svgIcon: item['isSelected'] == true
                                      ? "assets/icons/checkmark.svg"
                                      : "assets/icons/unchekmark.svg"),
                              const CustomSpacer(spaceValue: 5),
                              AppText(
                                text: item['name'].toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const CustomSpacer(spaceValue: 20),
                AppButton(
                    text: "Continue",
                    press: () {
                      if (isFuelType) {
                        var selectedType = vehicleCtrl.fuelTypes
                            .where((element) => element['isSelected'] == true)
                            .first;
                        vehicleCtrl.vehFuelType.text =
                            selectedType['name'].toString();
                        vehicleCtrl.fuelTypeid = selectedType['id'].toString();
                      } else {
                        var selectedType = vehicleCtrl.euroClassTypes
                            .where((element) => element['isSelected'] == true)
                            .first;
                        vehicleCtrl.vehClass.text =
                            selectedType['name'].toString();
                        // vehicleCtrl.fuelTypeid = selectedType['id'].toString();
                      }
                      vehicleCtrl.update();
                      srvPageRoute.goBack(context);
                    },
                    showLoader: false),
              ],
            ),
          );
        });
  }

  changeLangModal(
    BuildContext context,
  ) {
    BottomTabController tabController = Get.find();
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return SafeArea(
            child: Container(
          padding: const EdgeInsets.all(20),
          color: kBgLightColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSpacer(spaceValue: 10),
              Image.asset('assets/illustrations/language.png',
                  width: 100, height: 100),
              const CustomSpacer(spaceValue: 10),
              const AppText(
                text: 'Select Langauge',
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const CustomSpacer(spaceValue: 5),
              const AppText(
                  fontSize: 14,
                  color: kTextColor,
                  text: 'Select the Language you prefer'),
              const CustomSpacer(spaceValue: 10),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: tabController.languages.length,
                    itemBuilder: (context, index) {
                      var item = tabController.languages[index];
                      return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            tabController.onLanguageSelect(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomSurffixIcon(
                                    size: 25,
                                    svgIcon: item['isSelected']
                                        ? 'assets/icons/checkmark.svg'
                                        : 'assets/icons/unchekmark.svg'),
                                const CustomSpacer(spaceValue: 10),
                                AppText(
                                  text: item['text'],
                                  fontSize: 18,
                                )
                              ],
                            ),
                          ));
                    },
                  )),
              const CustomSpacer(spaceValue: 20),
              AppButton(
                text: 'Change Language',
                press: () {},
                showLoader: false,
              )
            ],
          ),
        ));
      },
    );
  }
}
