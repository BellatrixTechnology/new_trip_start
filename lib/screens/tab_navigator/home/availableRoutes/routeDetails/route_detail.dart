import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_sdk/mapview.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/places.controller.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';

class RouteDetails extends StatelessWidget {
  const RouteDetails({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlaceController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: Obx(
              () => AppText(
                text: controller.availRoutetitle.value,
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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: getProportionateScreenHeight(420),
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    boxShadow: boxShadow(),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: HereMap(
                        onMapCreated: onMapCreated,
                      ),
                    ),
                  ),
                ),

                ListView.builder(
                  itemCount: controller.availRoutes[index]['sections'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
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
                    );
                  },
                )

                // Container(
                //   margin: const EdgeInsets.only(top: 20),
                //   decoration: BoxDecoration(
                //     boxShadow: boxShadow(),
                //     borderRadius: BorderRadius.circular(10),
                //     color: kBgLightColor,
                //   ),
                //   padding: const EdgeInsets.all(20),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const AppText(
                //               text:
                //                   'Hovinmoen - DalNOK 18.40\nZero emission discount: 76%\nAutopass discount: 20%'),
                //           Row(
                //             children: const [
                //               AppText(text: 'Kr. 18,00 '),
                //               CustomSurffixIcon(
                //                 svgIcon: 'assets/icons/arrow-down.svg',
                //                 size: 10,
                //               ),
                //             ],
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: const EdgeInsets.only(top: 20),
                //   decoration: BoxDecoration(
                //     boxShadow: boxShadow(),
                //     borderRadius: BorderRadius.circular(10),
                //     color: kBgLightColor,
                //   ),
                //   padding: const EdgeInsets.all(20),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const AppText(text: 'Boksrud - Minnesund'),
                //           Row(
                //             children: const [
                //               AppText(text: 'Kr. 18,00 '),
                //               CustomSurffixIcon(
                //                 svgIcon: 'assets/icons/arrow-up.svg',
                //                 size: 10,
                //               ),
                //             ],
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
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
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      boxShadow: boxShadow(0.1, 8),
                      color: kBgLightColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: AppText(
                    text:
                        'Total Price: Kr ${controller.availRoutes[index]['sections'][0]['travelSummary']['totalSpent']}',
                    fontSize: 12,
                  ),
                ),
                // Container(
                //   width: (SizeConfig.screenWidth - 60) / 2,
                //   margin: const EdgeInsets.only(left: 10),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                //   decoration: BoxDecoration(
                //       boxShadow: boxShadow(0.1, 8),
                //       color: kBgLightColor,
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Row(
                //     children: const [
                //       CustomSurffixIcon(svgIcon: 'assets/icons/share-icon.svg'),
                //       AppText(
                //         text: '  Share Route Tolls Cost',
                //         fontSize: 12,
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ));
    });
  }

  void onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }
      srvRouting.routeDetailMap(hereMapController, index);
      // _routingExample = RoutingExample(_showDialog, hereMapController);
      // const double distanceToEarthInMeters = 8000;
      // MapMeasure mapMeasureZoom =
      //     MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      // hereMapController.camera.lookAtPointWithMeasure(
      //     GeoCoordinates(52.530932, 13.384915), mapMeasureZoom);
    });
  }
}
