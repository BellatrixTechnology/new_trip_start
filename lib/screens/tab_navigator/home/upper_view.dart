import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/places.controller.dart';
import 'package:new_trip_start/screens/tab_navigator/home/search.dest.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';

class HomeUpperView extends StatelessWidget {
  const HomeUpperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(237),
      decoration: const BoxDecoration(
        gradient: kButtonGradientColor,
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
          child: Row(
        children: [
          leftView(),
          const CustomSpacer(spaceValue: 5),
          middleView(context),
          // const CustomSpacer(spaceValue: 10),
          // rightView()
        ],
      )),
    );
  }

  Widget leftView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSpacer(spaceValue: 6),
        CustomSurffixIcon(svgIcon: 'assets/icons/current-loc.svg'),
        CustomSpacer(spaceValue: 3),
        CustomSurffixIcon(
          svgIcon: 'assets/icons/dot.svg',
          size: 10,
        ),
        CustomSpacer(spaceValue: 3),
        CustomSurffixIcon(
          svgIcon: 'assets/icons/dot.svg',
          size: 10,
        ),
        CustomSpacer(spaceValue: 3),
        CustomSurffixIcon(
          svgIcon: 'assets/icons/dot.svg',
          size: 10,
        ),
        CustomSpacer(spaceValue: 5),
        CustomSurffixIcon(svgIcon: 'assets/icons/locations-white.svg'),
        CustomSpacer(spaceValue: 15),
      ],
    );
  }

  Widget middleView(BuildContext context) {
    PlaceController placeController = Get.put(PlaceController());
    return Expanded(
      flex: 10,
      child: ListView(
        children: [
          SizedBox(
            // height: 45,
            child: AppInput(
              onPress: () {
                srvPageRoute.goToNext(
                    context,
                    SearchDestPage(
                        isDestination: false,
                        heading: "Enter from where you wanna start?".tr));
              },
              readOnly: true,
              controller: placeController.startPlaceCtrl,
              hintText: 'origin'.tr,
              borderRaidus: 10,
              textColor: kBgLightColor,
              color: kBgLightColor.withOpacity(0.24),
            ),
          ),
          const CustomSpacer(spaceValue: 10),
          SizedBox(
            // height: 45,
            child: AppInput(
              onPress: () {
                srvPageRoute.goToNext(
                    context,
                    SearchDestPage(
                        isDestination: true,
                        heading: "Enter your destination".tr));
                // AppBottomModal()
                //     .searchModal(context, "Enter your destination", true);
              },
              controller: placeController.endPlaceCtrl,
              readOnly: true,
              hintText: 'destination'.tr,
              borderRaidus: 10,
              textColor: kBgLightColor,
              color: kBgLightColor.withOpacity(0.24),
            ),
          ),
        ],
      ),
    );
  }

  Widget rightView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: kBgLightColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSurffixIcon(
                svgIcon: 'assets/icons/fill-add-white.svg',
                size: 8,
              ),
              AppText(
                text: 'Via',
                fontSize: 10,
                color: kBgLightColor,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        const CustomSurffixIcon(svgIcon: 'assets/icons/resync-white.svg'),
      ],
    );
  }
}
