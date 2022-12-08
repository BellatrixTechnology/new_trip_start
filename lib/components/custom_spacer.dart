import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({Key? key, required this.spaceValue}) : super(key: key);
  final double spaceValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(spaceValue),
    );
  }
}
