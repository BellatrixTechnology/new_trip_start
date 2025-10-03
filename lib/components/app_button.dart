import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/size_config.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.text,
      required this.press,
      this.width,
      this.color,
      this.appText,
      this.isDisable,
      required this.showLoader,
      this.height});
  final String text;
  final VoidCallback press;
  final double? width;
  final double? height;
  final bool showLoader;
  final Color? color;
  final AppText? appText;
  final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? SizeConfig.screenWidth,
        height: height ?? 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: isDisable == true
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.decal,
                    colors: [
                      Color(0xFF149BD7).withValues(alpha: 0.45),
                      Color(0xFF2F4D99).withValues(alpha: 0.45),
                      // Color(0xFF0046ac),
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.decal,
                    colors: [
                      Color(0xFF149BD7),
                      Color(0xFF2F4D99),
                      // Color(0xFF0046ac),
                    ],
                  )),
        child: ElevatedButton(
          onPressed: (showLoader || isDisable == true) ? null : press,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: showLoader
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : appText ??
                  AppText(
                    text: text,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
        ));
  }
}
