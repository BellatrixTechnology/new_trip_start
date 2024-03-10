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
      required this.showLoader});
  final String text;
  final VoidCallback press;
  final double? width;
  final bool showLoader;
  final Color? color;
  final AppText? appText;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? SizeConfig.screenWidth,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: const LinearGradient(
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
          onPressed: showLoader ? null : press,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
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
