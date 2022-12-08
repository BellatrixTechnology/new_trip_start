import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/available_routes.dart';
import 'package:new_trip_start/screens/tab_navigator/home/map_view.dart';
import 'package:new_trip_start/screens/tab_navigator/home/upper_view.dart';
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
            const Expanded(
              child: HomeMapView(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                  text: 'See Available Route',
                  press: () {
                    srvPageRoute.goToNext(context, const AvailableRoutes());
                  },
                  showLoader: false),
            ),
          ],
        ),
      ),
    );
  }
}
