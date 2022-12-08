import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/screens/tab_navigator/home/availableRoutes/available_route_map.dart';

class AvailRouteDetails extends StatelessWidget {
  const AvailRouteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            boxShadow: boxShadow(),
            borderRadius: BorderRadius.circular(10),
            color: kBgLightColor,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                      child: AppText(
                          text:
                              'E6 Alna Bridge\nTime rule( Oslo Ring )\nZero emission discount: 20%\nAutopass discount: 20%\nRush hour: 0630-0900 and 1500-1700')),
                  Row(
                    children: const [
                      AppText(text: 'Kr. 18,00 '),
                      CustomSurffixIcon(
                        svgIcon: 'assets/icons/arrow-up.svg',
                        size: 10,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            boxShadow: boxShadow(),
            borderRadius: BorderRadius.circular(10),
            color: kBgLightColor,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                      text:
                          'Hovinmoen - DalNOK 18.40\nZero emission discount: 76%\nAutopass discount: 20%'),
                  Row(
                    children: const [
                      AppText(text: 'Kr. 18,00 '),
                      CustomSurffixIcon(
                        svgIcon: 'assets/icons/arrow-down.svg',
                        size: 10,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            boxShadow: boxShadow(),
            borderRadius: BorderRadius.circular(10),
            color: kBgLightColor,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(text: 'Boksrud - Minnesund'),
                  Row(
                    children: const [
                      AppText(text: 'Kr. 18,00 '),
                      CustomSurffixIcon(
                        svgIcon: 'assets/icons/arrow-up.svg',
                        size: 10,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
