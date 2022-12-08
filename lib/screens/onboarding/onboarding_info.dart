import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/size_config.dart';

class OnboardingInfo extends StatelessWidget {
  const OnboardingInfo(
      {super.key, required this.icon, required this.text, this.size});
  final String icon;
  final String text;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomSurffixIcon(
          svgIcon: icon,
          size: SizeConfig.screenWidth * (size ?? 0.7),
        ),
        AppText(fontSize: 18, textAlign: TextAlign.center, text: text),
      ],
    );
  }
}
