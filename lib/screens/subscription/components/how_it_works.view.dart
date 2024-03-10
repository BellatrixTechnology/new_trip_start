import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/size_config.dart';

class HowItWorksView extends StatelessWidget {
  const HowItWorksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 23),
      decoration: BoxDecoration(
          color: kBgLightColor,
          boxShadow: boxShadow(),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item(
              subLockIcon,
              "Today".tr,
              "Optimize Your Commute: Know Your Daily Cost and Find Cheaper Routes!"
                  .tr),
          divider([const Color(0xFF2F4D99), const Color(0xFF4380BC)]),
          item(subBellIcon, "Day 5".tr,
              "Seamless Road Trips: Plan Ahead and Travel Stress-Free!".tr),
          divider([const Color(0xFF2F4D99), const Color(0xFF5BB9E2)]),
          item(
              subStarIcon,
              "Day 7".tr,
              "Norway Unleashed: Enjoy Unlimited Navigation Across the Country!"
                  .tr),
          divider([
            const Color(0xFF2F4D99),
            const Color(0xFF6EE25B),
            const Color(0xFFFDFDFD)
          ]),
        ],
      ),
    );
  }

  Widget divider(List<Color> colors) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      height: 48,
      width: 4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors)),
    );
  }

  Widget item(
    String img,
    String text1,
    String text2,
  ) {
    return Row(
      children: [
        Image.asset(img, width: 52, height: 52),
        const CustomSpacerWidthHeight(width: 5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text: text1,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColorLight),
              AppText(
                text: text2,
                fontSize: 13,
                color: k51Color,
              ),
            ],
          ),
        )
      ],
    );
  }
}
