// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/screens/subscription/page.dart';
// import 'package:new_trip_start/screens/subscription/page.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/available_routes.dart';
import 'package:new_trip_start/screens/tab_navigator/home/map_view.dart';
import 'package:new_trip_start/screens/tab_navigator/home/upper_view.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController());
    globalContext = context;
    // print(srvOsGridConverter.fromLatLon(59.824852, 10.804570, 33));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppGradientBg(
        padding: 0,
        child: Stack(
          children: [
            const HomeMapView(),
            const HomeUpperView(),
            Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => AppButton(
                    width: SizeConfig.screenWidth - 40,
                    text: 'See Available Route'.tr,
                    press: () {
                      // return;
                      if (srvUser.user.isSubscribe == false) {
                        srvPageRoute.goNextWithGetx(const SubscriptionPage());
                        return;
                      }
                      if (mapController.routeData.isEmpty) return;
                      srvPageRoute.goToNext(context, const AvailableRoutes());
                    },
                    showLoader: mapController.isFetching.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
