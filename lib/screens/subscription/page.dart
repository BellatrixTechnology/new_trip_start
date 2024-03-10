import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/subscription.controller.dart';
import 'package:new_trip_start/screens/subscription/allPlans/page.dart';
// import 'package:new_trip_start/screens/subscription/components/cancel.view.dart';
import 'package:new_trip_start/screens/subscription/components/how_it_works.view.dart';
import 'package:new_trip_start/screens/subscription/components/unlimited_text.view.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class SubscriptionPage extends GetView<SubscriptionController> {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBg(
          padding: 0,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            // Get.back();
                            srvPageRoute.goBack(context);
                          },
                          icon: const Icon(Icons.close, size: 30))),
                  AppText(
                    text: "How your free trial works".tr,
                    color: kPrimaryColor,
                    fontSize: 28,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                  const HowItWorksView(),
                  const CustomSpacerWidthHeight(height: 23),
                  const UnlimitedTextView(),
                  const CustomSpacerWidthHeight(height: 10),
                  AppText(
                    onTap: () {
                      srvPageRoute.goNextWithGetx(const ViewAllPlansPage());
                    },
                    text: "View All Plans".tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColorLight,
                    textDecoration: TextDecoration.underline,
                  ),
                  const CustomSpacerWidthHeight(height: 23),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      var monthly = srvRevenueCatSub.getMonthly();
                      srvRevenueCatSub.buy(monthly);
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            tileMode: TileMode.decal,
                            colors: [
                              Color(0xFF149BD7),
                              Color(0xFF2F4D99),
                            ],
                          )),
                      child:
                          Obx(() => controller.isLoadingForSubscription.isTrue
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: kBgLightColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kBgLightColor),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: "Start Free Trial Now".tr,
                                      fontSize: 18,
                                      color: kBgLightColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    AppText(
                                      text:
                                          "2 taps to start, super easy to cancel"
                                              .tr,
                                      fontSize: 12,
                                      color: kBgLightColor,
                                    ),
                                  ],
                                )),
                    ),
                  ),
                  AppText(
                    text: "restore_purchase".tr,
                    padding: const EdgeInsets.only(top: 30),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    onTap: () {
                      srvRevenueCatSub.restorePurchase();
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
