// import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';

import 'package:new_trip_start/controllers/route_detail.controller.dart';
import 'package:new_trip_start/modals/feedback.dart';
import 'package:new_trip_start/services/index.dart';

import 'package:new_trip_start/size_config.dart';
import 'package:shimmer/shimmer.dart';

class RouteDetails extends StatelessWidget {
  const RouteDetails({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RouteDetailCtrl>(
        init: RouteDetailCtrl(),
        builder: (controller) {
          Map data = controller.mapController.routeData[index];
          return Scaffold(
              appBar: AppBar(
                title: AppText(
                  text: data['summary'],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kBgLightColor,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    if (data['isFeedbackAsked'] == null) {
                      data['isFeedbackAsked'] = true;
                      controller.mapController.update();
                      FeedbackModal().showModal(() {
                        srvPageRoute.goBack(context);
                      });
                    } else {
                      srvPageRoute.goBack(context);
                    }
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
              body: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    height: getProportionateScreenHeight(320),
                    decoration: BoxDecoration(
                      boxShadow: boxShadow(),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GoogleMap(
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(59.892365, 10.790427),
                            zoom: 5,
                          ),
                          // ignore: prefer_collection_literals
                          gestureRecognizers: Set()
                            ..add(Factory<EagerGestureRecognizer>(
                                () => EagerGestureRecognizer())),
                          onMapCreated: (GoogleMapController ctrl) {
                            controller.googlemapController = ctrl;
                            controller.addMarkerstoMap(index);
                            controller.getPolyLines(index);
                          },
                          markers: Set.from(controller.markersList),
                          polylines: Set.from(controller.polylines),
                          myLocationButtonEnabled: false,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: AppText(
                      text: "Tolls",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const CustomSpacer(spaceValue: 5),
                  if (controller.isLoading.isTrue)
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: ((context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: kScaffoldBgColor,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: 30,
                                    width: SizeConfig.screenWidth - 40,
                                    decoration: BoxDecoration(
                                        color: kScaffoldBgColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only(bottom: 10),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: kScaffoldBgColor,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: 1,
                                    width: SizeConfig.screenWidth / 2,
                                    decoration: BoxDecoration(
                                        color: kScaffoldBgColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only(bottom: 20),
                                  ),
                                ),
                              ],
                            ))),
                  if (controller.isLoading.isFalse)
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        controller.tolls[index]['isExpanded'] = isExpanded;
                        controller.tolls.refresh();
                        controller.update();
                      },
                      children: controller.tolls.map<ExpansionPanel>((item) {
                        return ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            // print(item['NAME TOLL STATION']);
                            return ListTile(
                              title: Text(item['NAME TOLL STATION']),
                            );
                          },
                          body: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(text: '${item['NAME TOLL STATION']}'),
                                  AppText(
                                      text:
                                          '${"Time rule".tr}(${item['TIME RULE']})'),
                                  // AppText(text: '${item['NAME TOLL STATION']}'),
                                  AppText(
                                      text:
                                          '${"Zero emission discount".tr}: 20%'),
                                  AppText(
                                      text: '${"Autopass discount".tr}: 20%'),
                                  if (item['RUSH TIME TOMORROW, FROM'] != null)
                                    AppText(
                                        text:
                                            '${"Rush hour".tr}: ${item['RUSH TIME TOMORROW, FROM']}-${item['RUSH TIME TOMORROW, TIL']} and ${item['AFTERNOON RUSH TIME, FROM']}-${item['AFTERNOON RUSH TIME, TO']}'),
                                  const CustomSpacer(spaceValue: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppText(
                                          text: "Price",
                                          fontWeight: FontWeight.bold),
                                      // const AppText(text: item),
                                      AppText(
                                          fontWeight: FontWeight.bold,
                                          text: item['waive_off'] == true
                                              ? "Kr 0.0(Hour Rule)"
                                              : "kr ${controller.calcTollPrice(item).toStringAsFixed(2)}"),
                                    ],
                                  ),
                                  const CustomSpacer(spaceValue: 5),
                                ],
                              ),
                              onTap: () {
                                controller.animateCameraOnPosition(
                                    srvShared.anyTypeToDouble(item['latitude']),
                                    srvShared
                                        .anyTypeToDouble(item['longitude']));
                              }),
                          isExpanded: item['isExpanded'] ?? false,
                        );
                      }).toList(),
                    ),
                  Visibility(
                      visible: controller.tolls.isEmpty,
                      child: Center(
                        child: AppText(text: "No Tolls Found.".tr),
                      )),
                  Visibility(
                    visible: controller.ferries.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: AppText(
                        text: "Ferries".tr,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.ferries.length,
                    itemBuilder: (context, index) {
                      var info = data['ferry'][index]
                          ['Informasjon om sambandet']['strekningers'];
                      if (index == 0) print(info);
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          print(info.toString());
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: AppText(
                                          text:
                                              info[0]['Strekning'].toString()),
                                    ),
                                    AppText(
                                      text: controller.calcFerryPrice(
                                          info[0]['fullpris']['Fullpris']),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                height: 120,
                width: (SizeConfig.screenWidth - 60),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: 'Tolls Price: ',
                        ),
                        controller.isLoading.isTrue
                            ? Shimmer.fromColors(
                                baseColor: kScaffoldBgColor,
                                highlightColor: Colors.grey.shade300,
                                child: Container(
                                  height: 10,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: kScaffoldBgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(bottom: 10),
                                ),
                              )
                            : AppText(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                text:
                                    'Kr ${(data['price']['withoutFuel']).toStringAsFixed(2)}',
                              ),
                      ],
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: 'Fuel Price: ',
                        ),
                        controller.isLoading.isTrue
                            ? Shimmer.fromColors(
                                baseColor: kScaffoldBgColor,
                                highlightColor: Colors.grey.shade300,
                                child: Container(
                                  height: 10,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: kScaffoldBgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(bottom: 10),
                                ),
                              )
                            : AppText(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                text:
                                    'Kr ${(data['totalPriceFuel']).toStringAsFixed(2)}',
                              ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: 'Total Price: ',
                        ),
                        controller.isLoading.isTrue
                            ? Shimmer.fromColors(
                                baseColor: kScaffoldBgColor,
                                highlightColor: Colors.grey.shade300,
                                child: Container(
                                  height: 10,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: kScaffoldBgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(bottom: 10),
                                ),
                              )
                            : AppText(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                text:
                                    'Kr ${(data['price']['withFuel']).toStringAsFixed(2)}',
                              ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
