import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';

class LogoWithText extends StatelessWidget {
  const LogoWithText({super.key, this.logoWidthHeight, this.hideText});
  final double? logoWidthHeight;
  final bool? hideText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/new_logo.png',
          width: logoWidthHeight,
          height: logoWidthHeight,
        ),
        if (hideText != true)
          const Column(
            children: [
              CustomSpacer(spaceValue: 8),
              AppText(
                text: "BompengeAppen",
                color: kPrimaryColor,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ],
          )
        // const CustomSpacer(spaceValue: 8),
        // const AppText(text: 'Bompenger og Drivstoff Kalkulator')
      ],
    );
  }
}
