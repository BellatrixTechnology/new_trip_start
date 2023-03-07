import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/places.controller.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/available_routes.dart';
import 'package:new_trip_start/screens/tab_navigator/home/map_view.dart';
import 'package:new_trip_start/screens/tab_navigator/home/upper_view.dart';
import 'package:new_trip_start/services/Routing.service.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    PlaceController placeController = Get.put(PlaceController());
    // srvApi.getData();
    // srvOsGridConverter.yourFunction(59.892365, 10.790427);
    // srvOsGridConverter.utmConverter(59.892365, 10.790427);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppGradientBg(
        padding: 0,
        child: Column(
          children: [
            const HomeUpperView(),
            const Expanded(
              child: HomeMapView(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => AppButton(
                    text: 'See Available Route',
                    press: () {
                      // inspect(placeController.startPlace.position);
                      // inspect(placeController.endPlace.position);
                      srvPageRoute.goToNext(context, const AvailableRoutes());
                      // srvRouting.clearMap();
                      // srvRouting.addRoute();
                      // srvRouting.showAllRouteOnMap(
                      //     "BGw22w3Do0iqOge0jB8L0FsJTgKzFwH3IkhQj_fkkWj0sBgFjX8BnVoB_2B");
                    },
                    showLoader: placeController.isFindigRoutes.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
