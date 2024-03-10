import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/controllers/places.controller.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/choose_route_view.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/routeDetails/route_detail.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/route_item.dart';
import 'package:new_trip_start/screens/tab_navigator/home/map_view.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class AvailableRoutes extends StatelessWidget {
  const AvailableRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlaceController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Obx(
              () => AppText(
                text: controller.availRoutetitle.value.tr,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kBgLightColor,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                if (controller.switchToNext.isTrue) {
                  controller.switchToNext.toggle();
                  controller.availRoutetitle.value = 'Available Route';
                  controller.update();
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
              // physics: const ScrollPhysics(),
              // physics: const NeverScrollableScrollPhysics(),

              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                // physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    // const AvailRouteMaps(),
                    const CustomSpacer(spaceValue: 10),
                    Container(
                      height: 300,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        boxShadow: boxShadow(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const HomeMapView(),
                      ),
                    ),

                    availRoutesList(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: availRouteBottom(),
        );
      },
    );
  }

  Widget availRoutesList() {
    MapController controller = Get.find();
    return Column(
      children: [
        const CustomSpacer(spaceValue: 10),
        ChooseRouteView(
          controller: controller,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.routeData.length,
          itemBuilder: (context, index) {
            controller.calcFuelPrice(index);
            return RouteItem(
              index: index,
              onPress: () {
                srvPageRoute.goNextWithGetx(
                    RouteDetails(index: index), {"index": index});
              },
            );
          },
        ),
      ],
    );
    // );
  }

  Widget availRouteBottom() {
    return GetBuilder<MapController>(
      builder: (controller) => Container(
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
                  AppText(
                    text: 'Auto Pass'.tr,
                    fontSize: 12,
                  ),
                  Switch.adaptive(
                    value: controller.autopass.value,
                    onChanged: (val) {
                      controller.autopass.toggle();
                      controller.update();
                      controller.calcAfterToggle();
                    },
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
                  AppText(
                    text: 'Rush Hour'.tr,
                    fontSize: 12,
                  ),
                  Switch.adaptive(
                    value: controller.rushHour.value,
                    onChanged: (val) {
                      controller.rushHour.toggle();
                      controller.update();
                      controller.calcAfterToggle();
                    },
                    activeColor: kPrimaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
