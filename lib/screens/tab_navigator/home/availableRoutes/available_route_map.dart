import 'package:flutter/material.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/screens/tab_navigator/home/map_view.dart';
import 'package:new_trip_start/size_config.dart';

class AvailRouteMaps extends StatelessWidget {
  const AvailRouteMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(320),
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: boxShadow(),
      ),
      child: const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Align(
          alignment: Alignment.bottomRight,
          heightFactor: 0.3,
          widthFactor: 2.5,
          child: HomeMapView(),
        ),
      ),
    );
  }
}
