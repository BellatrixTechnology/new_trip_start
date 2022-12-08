import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';

class HomeUpperView extends StatelessWidget {
  const HomeUpperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: kButtonGradientColor,
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
          child: Row(
        children: [
          leftView(),
          const CustomSpacer(spaceValue: 5),
          middleView(),
          const CustomSpacer(spaceValue: 10),
          rightView()
        ],
      )),
    );
  }

  Widget leftView() {
    return Expanded(
        child: Column(
      children: const [
        CustomSurffixIcon(svgIcon: 'assets/icons/current-loc.svg'),
        CustomSpacer(spaceValue: 3),
        CustomSurffixIcon(
          svgIcon: 'assets/icons/dot.svg',
          size: 10,
        ),
        CustomSpacer(spaceValue: 2),
        CustomSurffixIcon(
          svgIcon: 'assets/icons/dot.svg',
          size: 10,
        ),
        CustomSpacer(spaceValue: 2),
        CustomSurffixIcon(
          svgIcon: 'assets/icons/dot.svg',
          size: 10,
        ),
        CustomSpacer(spaceValue: 3),
        CustomSurffixIcon(svgIcon: 'assets/icons/locations-white.svg'),
      ],
    ));
  }

  Widget middleView() {
    return Expanded(
        flex: 10,
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: AppInput(
                hintText: 'OSLO',
                borderRaidus: 10,
                textColor: kBgLightColor,
                color: kBgLightColor.withOpacity(0.24),
              ),
            ),
            const CustomSpacer(spaceValue: 10),
            SizedBox(
              height: 45,
              child: AppInput(
                hintText: 'TORP',
                borderRaidus: 10,
                textColor: kBgLightColor,
                color: kBgLightColor.withOpacity(0.24),
              ),
            ),
          ],
        ));
  }

  Widget rightView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: kBgLightColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomSurffixIcon(
                svgIcon: 'assets/icons/fill-add-white.svg',
                size: 8,
              ),
              AppText(
                text: 'Via',
                fontSize: 10,
                color: kBgLightColor,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        const CustomSurffixIcon(svgIcon: 'assets/icons/resync-white.svg'),
      ],
    );
  }
}
