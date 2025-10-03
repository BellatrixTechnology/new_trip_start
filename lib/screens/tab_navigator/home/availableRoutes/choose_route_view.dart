import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
// import 'package:new_trip_start/controllers/tab_ctrl.dart';
// import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/screens/tab_navigator/my-vehicles/vehicle_item.dart';

class ChooseRouteView extends StatelessWidget {
  const ChooseRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.find();

    return Column(
      children: [
        VechicleItem(
          vehicle: mapController.carData.value,
          index: 0,
          isFromAvailRoute: true,
        ),
        const CustomSpacer(spaceValue: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText(
              text: 'Choose a Route',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            AppText(
                text:
                    '${mapController.carData.value.regNum!.toUpperCase()} - ${mapController.carData.value.vehBrand!.toUpperCase()}')
          ],
        ),
      ],
    );
  }
}
