import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({super.key, required this.spaceValue});
  final double spaceValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(spaceValue),
    );
  }
}

class CustomSpacerWidthHeight extends StatelessWidget {
  const CustomSpacerWidthHeight({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
      // margin: EdgeInsets.all(spaceValue),
    );
  }
}
