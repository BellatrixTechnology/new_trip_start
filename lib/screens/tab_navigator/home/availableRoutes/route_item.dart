import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';

class RouteItem extends StatelessWidget {
  const RouteItem({super.key, required this.onPress});
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            boxShadow: boxShadow(),
            color: kBgLightColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'Fv120',
                      fontWeight: FontWeight.w600,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Total ',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kBlackColor)),
                          ),
                          TextSpan(
                            text: '  700 NOK',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: kTextColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const CustomSpacer(spaceValue: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bottomChild('assets/icons/clock.svg', '2 h 40 min'),
                      bottomChild('assets/icons/choose-route.svg', '111 km'),
                      bottomChild('assets/icons/price-bundle.svg', 'Kr 500'),
                      bottomChild('assets/icons/pump.svg', '200 Kr'),
                    ])
              ],
            )),
            const CustomSpacer(spaceValue: 10),
            const CustomSurffixIcon(svgIcon: 'assets/icons/arrow-right.svg')
          ],
        ),
      ),
    );
  }

  Widget bottomChild(String iconPath, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSurffixIcon(
          svgIcon: iconPath, //'assets/icons/clock.svg',
          size: 15,
        ),
        const CustomSpacer(spaceValue: 3),
        AppText(
          text: text,
          fontSize: 14,
        )
      ],
    );
  }
}
