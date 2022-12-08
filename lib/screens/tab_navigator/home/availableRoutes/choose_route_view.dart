import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/size_config.dart';

class ChooseRouteView extends StatelessWidget {
  const ChooseRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppText(
          text: 'Choose a Route',
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        Container(
          // width: getProportionateScreenWidth(120),
          height: getProportionateScreenHeight(40),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomSurffixIcon(svgIcon: 'assets/icons/avoid.svg'),
              CustomSpacer(spaceValue: 5),
              AppText(text: 'Avoid'),
              CustomSpacer(spaceValue: 10),
              CustomSurffixIcon(
                svgIcon: 'assets/icons/arrow_down.svg',
                size: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
