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
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      // height: 4,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kPrimaryColor,
            width: 5.0,
          ),
        ),
      ),
      child: AppText(
        text: text,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: kBlackColor,
      ),
    );
  }
}
