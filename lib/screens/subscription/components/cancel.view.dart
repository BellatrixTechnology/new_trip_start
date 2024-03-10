import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/size_config.dart';

class CancelView extends StatelessWidget {
  const CancelView({super.key});

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
          AppText(
            text: "How Can I Cancel?".tr,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
          const CustomSpacerWidthHeight(height: 2),
          const AppText(
              fontSize: 13,
              color: k51Color,
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore Lorem ipsum dolor sit amet, consectetur adipiscing elit, "),
        ],
      ),
    );
  }
}
