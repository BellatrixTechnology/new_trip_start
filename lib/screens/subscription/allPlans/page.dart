import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/subscription.controller.dart';
// import 'package:new_trip_start/screens/subscription/allPlans/components/offers.dart';
import 'package:new_trip_start/screens/subscription/allPlans/components/subscription.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class ViewAllPlansPage extends StatelessWidget {
  const ViewAllPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionController());
    return Scaffold(
      body: AppGradientBg(
          padding: 0,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              // top: false,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            srvPageRoute.goBack(context);
                          },
                          icon: const Icon(Icons.close, size: 30))),
                  const CustomSpacerWidthHeight(height: 23),
                  AppText(
                    text: "Get access to unlimited powerful ideas".tr,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                  const CustomSpacerWidthHeight(height: 23),
                  Image.asset(subsIllustrations),
                  const CustomSpacerWidthHeight(height: 23),
                  // const SubscriptionOffer(),
                  // const CustomSpacerWidthHeight(height: 23),
                  const SubscriptionTypes(),
                ],
              ),
            ),
          )),
    );
  }
}
