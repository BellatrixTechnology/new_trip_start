import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/places.controller.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';

class SearchDestPage extends StatelessWidget {
  const SearchDestPage(
      {super.key, required this.isDestination, required this.heading});
  final bool isDestination;
  final String heading;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlaceController>(
      builder: (placeCtrl) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: kPrimaryColor, elevation: 0),
        body: SafeArea(
          child: AnimatedContainer(
              height: SizeConfig.screenHeight - (kToolbarHeight),
              duration: const Duration(milliseconds: 3),
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  AppText(text: heading),
                  const CustomSpacer(spaceValue: 10),
                  AppInput(
                    hintText: "Search Place Here...".tr,
                    onChanged: (e) async {
                      if (e.length > 1) {
                        placeCtrl.getSearchResult(e);
                      }
                      if (e.isEmpty) {
                        placeCtrl.googlePlaces = RxList([]);
                        placeCtrl.googlePlaces.refresh();
                      }
                    },
                    controller: placeCtrl.placeSearch,
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.search,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  const CustomSpacer(spaceValue: 10),
                  Expanded(
                    child: placeCtrl.googlePlaces.isEmpty
                        ? Center(
                            child: AppText(text: "No search Found...".tr),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: placeCtrl.googlePlaces.length,
                            itemBuilder: (context, index) {
                              CityModel place = placeCtrl.googlePlaces[index];
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  // isDestination
                                  //     ? controller.endPlace = place
                                  //     : controller.startPlace = place;
                                  srvPageRoute.goBack(context);
                                  placeCtrl.onPlaceSelect(place, isDestination);

                                  if (isDestination) {
                                    // placeCtrl.findRoutesAndData();
                                    // srvPageRoute.goToNext(
                                    //     context, const AvailableRoutes());
                                  }
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/destination-marker.png',
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.contain,
                                        ),
                                        const CustomSpacer(spaceValue: 5),
                                        Flexible(
                                            child: AppText(
                                                text: place.name, maxLines: 2))
                                      ],
                                    ),
                                    const Divider(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
