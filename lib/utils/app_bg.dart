import 'package:flutter/material.dart';
import 'package:new_trip_start/constants.dart';

class AppGradientBg extends StatelessWidget {
  const AppGradientBg(
      {super.key, required this.child, this.padding, this.gradient});
  final Widget child;
  final double? padding;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: gradient ?? kPrimaryGradientColor),
      child: child,
    );
  }
}
