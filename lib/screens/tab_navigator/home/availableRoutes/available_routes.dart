import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/avail_route_detail.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/available_route_map.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/choose_route_view.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/route_item.dart';

import 'package:new_trip_start/screens/tab_navigator/my-vehicles/vehicle_item.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
// import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class AvailableRoutes extends StatelessWidget {
  const AvailableRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    BottomTabController tabController = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: Obx(() => AppText(
                text: tabController.availRoutetitle.value,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kBgLightColor,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              if (tabController.switchToNext.isTrue) {
                tabController.switchToNext.toggle();
                tabController.availRoutetitle.value = 'Available Route';
                tabController.update();
                return;
              }
              srvPageRoute.goBack(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              boxShadow: boxShadow(),
              gradient: kButtonGradientColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
        ),
        body: AppGradientBg(
          padding: 0,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const AvailRouteMaps(),
                const CustomSpacer(spaceValue: 10),
                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final inAnimation = Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: const Offset(0.0, 0.0))
                          .animate(animation);
                      final outAnimation = Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: const Offset(0.0, 0.0))
                          .animate(animation);

                      if (child.key == ValueKey(1)) {
                        return ClipRect(
                          child: SlideTransition(
                            position: inAnimation,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: child,
                            ),
                          ),
                        );
                      } else {
                        return ClipRect(
                          child: SlideTransition(
                            position: outAnimation,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: child,
                            ),
                          ),
                        );
                      }
                    },
                    child: tabController.switchToNext.isTrue
                        ? const AvailRouteDetails()
                        : Column(
                            children: [
                              // const VechicleItem(),
                              const CustomSpacer(spaceValue: 10),
                              const ChooseRouteView(),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return RouteItem(
                                    onPress: () {
                                      tabController.availRoutetitle.value =
                                          'Fv120';
                                      tabController.switchToNext.toggle();
                                      tabController.update();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: tabController.switchToNext.isTrue
                  ? availRouteBottomDetails()
                  : availRouteBottom(),
            )));
  }

  Widget availRouteBottom() {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: boxShadow(),
        color: kBgLightColor,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: (SizeConfig.screenWidth - 60) / 2,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                boxShadow: boxShadow(0.1, 8),
                color: kBgLightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  text: 'Auto Pass',
                  fontSize: 12,
                ),
                Switch.adaptive(
                  value: true,
                  onChanged: (val) {},
                  activeColor: kPrimaryColor,
                )
              ],
            ),
          ),
          Container(
            width: (SizeConfig.screenWidth - 60) / 2,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                boxShadow: boxShadow(0.1, 8),
                color: kBgLightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  text: 'Rush Hour',
                  fontSize: 12,
                ),
                Switch.adaptive(
                  value: true,
                  onChanged: (val) {},
                  activeColor: kPrimaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget availRouteBottomDetails() {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: boxShadow(),
        color: kBgLightColor,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: (SizeConfig.screenWidth - 60) / 2,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                boxShadow: boxShadow(0.1, 8),
                color: kBgLightColor,
                borderRadius: BorderRadius.circular(10)),
            child: const AppText(
              text: 'Total Price: Kr 2000',
              fontSize: 12,
            ),
          ),
          Container(
            width: (SizeConfig.screenWidth - 60) / 2,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                boxShadow: boxShadow(0.1, 8),
                color: kBgLightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: const [
                CustomSurffixIcon(svgIcon: 'assets/icons/share-icon.svg'),
                AppText(
                  text: '  Share Route Tolls Cost',
                  fontSize: 12,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
