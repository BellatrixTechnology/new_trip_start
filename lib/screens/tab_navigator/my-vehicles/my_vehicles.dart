import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_bar.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
// import 'package:new_trip_start/screens/subscription/page.dart';
import 'package:new_trip_start/screens/tab_navigator/my-vehicles/vehicle_item.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class MyVehicles extends StatelessWidget {
  const MyVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    // BottomTabController bottomTabController = Get.find();
    // bottomTabController.getVehicles();
    return GetBuilder<BottomTabController>(
      builder: (btmTabCtrl) => Scaffold(
        extendBody: true,
        appBar:
            AppBars(title: 'My Vehicles'.tr, elevation: 3.0, hideBackbtn: true),
        body: AppGradientBg(
          padding: 0,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: btmTabCtrl.myVehicles.isEmpty
                    ? Center(
                        child: AppText(text: 'No Vehcile Found'.tr),
                      )
                    : Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          itemCount: btmTabCtrl.myVehicles.length,
                          itemBuilder: (context, index) {
                            Vehicle vehicle = btmTabCtrl.myVehicles[index];
                            return VechicleItem(
                              vehicle: vehicle,
                              index: index,
                            );
                          },
                        ),
                      ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppButton(
                        text: 'Add Vehicle'.tr,
                        press: () {
                          // if (btmTabCtrl.myVehicles.isNotEmpty &&
                          //     srvUser.user.isSubscribed == false) {
                          //   srvPageRoute
                          //       .goNextWithGetx(const SubscriptionPage());
                          //   return;
                          // }

                          AppBottomModal().addVehicleModal(context, () {
                            Future.delayed(const Duration(seconds: 3), () {
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
                                  'Yes'.tr,
                                  true);
                            });
                          });
                        },
                        showLoader: false),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
