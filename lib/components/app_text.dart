import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/size_config.dart';

class AppText extends StatelessWidget {
  const AppText(
      {Key? key,
      this.fontSize,
      this.fontWeight,
      this.color,
      required this.text,
      this.fontStyle,
      this.textAlign,
      this.textDecoration})
      : super(key: key);
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? text;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      // textAlign: TextAlign.start,
      textAlign: textAlign ?? TextAlign.start,
  // overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              decoration: textDecoration ?? TextDecoration.none,
              fontSize: getProportionateScreenWidth(fontSize ?? 14),
              fontWeight: fontWeight ?? FontWeight.w400,
              color: color ?? kBlackColor,
              height: 1.2,
              fontStyle: fontStyle,
              fontFamily: 'Avenir')),
    );
  }
}
