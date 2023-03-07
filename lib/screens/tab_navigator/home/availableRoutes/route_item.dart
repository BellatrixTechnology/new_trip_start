import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/controllers/places.controller.dart';
import 'package:new_trip_start/services/index.dart';

class RouteItem extends StatelessWidget {
  const RouteItem({super.key, required this.onPress, required this.index});
  final VoidCallback onPress;
  final int index;
  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.find();

    var item = mapController.features[index]['attributes'];
    var direction = mapController.directions[index];

    return GetBuilder<MapController>(
      builder: (controller) => GestureDetector(
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 8),
          decoration: BoxDecoration(
              boxShadow: boxShadow(),
              color: kBgLightColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: direction['routeName'],
                        fontWeight: FontWeight.w600,
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Total ',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor)),
                            ),
                            TextSpan(
                              text:
                                  '  ${(controller.autopass.isTrue ? item['Total_Toll small'] : item['Total_Toll_Without_Discount small']) + double.parse(item['summary']['gasolinePrice'])} NOK',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: kTextColor)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CustomSpacer(spaceValue: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottomChild('assets/icons/clock.svg',
                            srvRouting.formatTime(item['Total_Minutes'] * 60)),
                        bottomChild(
                            'assets/icons/choose-route.svg',
                            srvRouting
                                .formatLength(item['Total_Meters'] * 0.001)),
                        bottomChild('assets/icons/price-bundle.svg',
                            'Kr ${controller.autopass.isTrue ? item['Total_Toll small'] : item['Total_Toll_Without_Discount small']}'),
                        bottomChild('assets/icons/pump.svg',
                            '${item['summary']['gasolinePrice']} Kr'),
                      ])
                ],
              )),
              const CustomSpacer(spaceValue: 5),
              const CustomSurffixIcon(svgIcon: 'assets/icons/arrow-right.svg')
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomChild(String iconPath, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSurffixIcon(
          svgIcon: iconPath, //'assets/icons/clock.svg',
          size: 13,
        ),
        const CustomSpacer(spaceValue: 1),
        AppText(
          text: text,
          fontSize: 12,
        )
      ],
    );
  }
}
