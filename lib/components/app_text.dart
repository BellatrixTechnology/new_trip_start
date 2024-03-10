import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/size_config.dart';

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
      this.fontSize,
      this.fontWeight,
      this.color,
      required this.text,
      this.fontStyle,
      this.textAlign,
      this.textDecoration,
      this.maxLines,
      this.onTap,
      this.padding});
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? text;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final int? maxLines;
  final void Function()? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Text(
          text ?? "",
          // textAlign: TextAlign.start,
          textAlign: textAlign ?? TextAlign.start,
          // overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  decoration: textDecoration ?? TextDecoration.none,
                  fontSize: getProportionateScreenWidth(fontSize ?? 14),
                  fontWeight: fontWeight ?? FontWeight.w400,
                  color: color ?? kBlackColor,
                  height: 1.2,
                  fontStyle: fontStyle,
                  fontFamily: 'Avenir')),
        ),
      ),
    );
  }
}
