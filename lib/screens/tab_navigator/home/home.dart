import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/constants.dart';
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
    return Scaffold(
      body: AppGradientBg(
        padding: 0,
        child: Column(
          children: [
            const HomeUpperView(),
            Expanded(
                child: HereMap(
              onMapCreated: _onMapCreated,
            ) //HomeMapView(),
                ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                  text: 'See Available Route',
                  press: () {
                    // srvPageRoute.goToNext(context, const AvailableRoutes());
                    srvRouting.clearMap();
                    srvRouting.addRoute();
                  },
                  showLoader: false),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }
      srvRouting.init(hereMapController);
      // _routingExample = RoutingExample(_showDialog, hereMapController);
      // const double distanceToEarthInMeters = 8000;
      // MapMeasure mapMeasureZoom =
      //     MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      // hereMapController.camera.lookAtPointWithMeasure(
      //     GeoCoordinates(52.530932, 13.384915), mapMeasureZoom);
    });
  }

}
