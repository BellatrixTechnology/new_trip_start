import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/screens/subscription/page.dart';
import 'package:new_trip_start/size_config.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        srvPageRoute.goNextWithGetx(const SubscriptionPage());
      },
      child: GetBuilder<MapController>(
        init: MapController(),
        builder: (controller) => Container(
          padding: const EdgeInsets.all(16),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: controller.user.value.isSubscribe == true
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFDAA520), Color(0xFFFFD700)])
                : kButtonGradientColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: controller.user.value.isSubscribe == true
                    ? "pro_user".tr
                    : "become_pro_user".tr,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFAFAD2),
                fontSize: 18,
              ),
              const CustomSpacer(spaceValue: 8),
              Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: controller.user.value.isSubscribe == true
                        ? const Color(0xFFDAA520)
                        : kSecondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1)),
                child: AppText(
                  text: controller.user.value.name.split("")[0],
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFAFAD2),
                  fontSize: 28,
                ),
              ),
              const CustomSpacer(spaceValue: 8),
              AppText(
                text: controller.user.value.isSubscribe == true
                    ? "all_features_are_unlocked".tr
                    : "become_pro_user_descp".tr,
                color: const Color(0xFFFAFAD2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
