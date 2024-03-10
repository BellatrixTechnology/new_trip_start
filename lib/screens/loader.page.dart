import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/shared.controller.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    SharedController sharedController = Get.put(SharedController());
    sharedController.getText();
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      body: Center(
        child: Container(
          // padding: const EdgeInsets.all(20),
          height: 350,
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: Column(
            children: [
              const CustomSpacer(spaceValue: 10),
              AppText(
                  color: kBlackColor,
                  fontWeight: FontWeight.bold,
                  text: "WE ARE SEARHING...".tr,
                  textAlign: TextAlign.center),
              SizedBox(height: 180, child: Lottie.asset(travelIsFun)),
              const CustomSpacer(spaceValue: 10),
              AppText(
                  text: "DID YOU KNOW!!!".tr,
                  textAlign: TextAlign.center,
                  color: kBlackColor,
                  fontWeight: FontWeight.bold),
              Obx(() => AppText(
                  padding: const EdgeInsets.all(20),
                  textAlign: TextAlign.center,
                  text: sharedController.randomPoint.value.toString()))
            ],
          ),
        ),
      ),
    );
  }
}
