import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/components/app_text.dart';
// import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';

class UnderlineText extends StatelessWidget {
  const UnderlineText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    return Container(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      // height: 4,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kPrimaryColor,
            width: 4.0,
          ),
        ),
      ),
      child: AppText(
        text: text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: kBlackColor,
      ),
      // ),
      // Image.asset(
      //   'assets/images/new_logo.png',
      //   width: 40,
      //   height: 40,
      // ),
      // LogoWithText(
      //   fontSize: 10,
      //   logoWidthHeight: 40,
      //   // ),
      // ],
    );
  }
}
