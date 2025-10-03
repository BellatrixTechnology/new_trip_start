import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/subscription.controller.dart';

import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionTypes extends StatelessWidget {
  const SubscriptionTypes({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionController());
    var monthly = srvRevenueCatSub.getMonthly();
    var yearly = srvRevenueCatSub.getYearly();

    return Column(
      children: [
        positionedItem(yearly),
        const CustomSpacerWidthHeight(height: 23),
        item(
            "Monthly".tr,
            {"price": monthly.storeProduct.priceString, "type": "/month".tr},
            "Recurring billing. Cancel anytime.".tr, () {
          srvRevenueCatSub.buy(monthly);
        }, 0)
      ],
    );
  }

  Widget positionedItem(Package yearly) {
    return Stack(
      children: [
        item(
            "Yearly + 7-day free trial".tr,
            {"price": yearly.storeProduct.priceString, "type": "/year".tr},
            "Cancel up to 24 hours before trial ends.".tr, () {
          srvRevenueCatSub.buy(yearly);
        }, 25),
        Positioned(
          top: -15,
          child: Image.asset(
            subValuedOfferIcon,
            width: 67,
          ),
        ),
      ],
    );
  }

  Widget item(String heading, Map price, String descp, void Function()? onTap,
      double topMargin) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: kBgLightColor,
          borderRadius: BorderRadius.circular(12),
          // boxShadow: boxShadow(),
        ),
        margin: EdgeInsets.only(top: topMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: heading, fontWeight: FontWeight.w500, fontSize: 15),
            const CustomSpacerWidthHeight(height: 3),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${price['price']}/'.tr,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: kPrimaryColorLight,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                children: <TextSpan>[
                  TextSpan(
                      text: price['type'],
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: kPrimaryColorLight, fontSize: 16))),
                ],
              ),
            ),
            const CustomSpacerWidthHeight(height: 3),
            AppText(text: descp, fontWeight: FontWeight.w300)
          ],
        ),
      ),
    );
  }
}
