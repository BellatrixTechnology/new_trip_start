import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/size_config.dart';

import '../constants.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {Key? key,
      required this.press,
      required this.showLoader,
      required this.icon})
      : super(key: key);
  final VoidCallback press;
  final bool showLoader;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showLoader ? null : press,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.decal,
            colors: [
              Color(0xFF149BD7),
              Color(0xFF2F4D99),
              // Color(0xFF0046ac),
            ],
          ),
        ),
        child: showLoader ? const CircularProgressIndicator.adaptive() : icon,
      ),
    );
  }
}
