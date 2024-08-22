import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/services/index.dart';

class RouteItem extends StatelessWidget {
  const RouteItem({super.key, required this.onPress, required this.index});
  final VoidCallback onPress;
  final int index;
  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.find();

    return GetBuilder<MapController>(builder: (controller) {
      var info = mapController.routeData[index];
      // print("info --> ${info['distance']}");

      return GestureDetector(
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
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
                      Flexible(
                          child: AppText(
                        text: info['summary'] ?? info['title'],
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                      )),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Total ',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor)),
                            ),
                            TextSpan(
                              text:
                                  "${mapController.routeData[index]['price'] == null ? "Calculating..." : '${info['price']['withFuel'].toStringAsFixed(2)} NOK'} ",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 12,
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
                        bottomChild(
                            'assets/icons/clock.svg',
                            srvShared.convertMinutesToHoursAndMinutes(
                                info['duration'].runtimeType == int
                                    ? info['duration'].toString()
                                    : info['duration']['value'].toString())),
                        bottomChild(
                            'assets/icons/choose-route.svg',
                            info['distance'].runtimeType == int
                                ? info['distance'].toString()
                                : info['distance']['text']
                            // info['distance']['text'],
                            ),
                        bottomChild(
                            'assets/icons/price-bundle.svg',
                            mapController.routeData[index]['price'] == null
                                ? "Calculating..."
                                : 'Kr ${info['price']['withoutFuel'].toStringAsFixed(2)}'),
                        bottomChild(
                          'assets/icons/pump.svg',
                          (info['totalPriceFuel'] ?? 0).toStringAsFixed(2),
                        ),
                      ])
                ],
              )),
              const CustomSpacer(spaceValue: 10),
              const CustomSurffixIcon(
                svgIcon: 'assets/icons/arrow-right.svg',
                size: 13,
              )
            ],
          ),
        ),
      );
    });
  }

  Widget bottomChild(String iconPath, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSurffixIcon(
          svgIcon: iconPath, //'assets/icons/clock.svg',
          size: 15,
        ),
        const CustomSpacer(spaceValue: 3),
        AppText(
          padding: const EdgeInsets.only(top: 1.5),
          text: text,
          fontSize: 10,
        )
      ],
    );
  }
}
