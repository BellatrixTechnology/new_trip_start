import 'package:flutter/material.dart';
import 'package:new_trip_start/constants.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(right: 4.0),
          height: isActive ? 10 : 10,
          width: isActive ? 30 : 10,
          decoration: BoxDecoration(
              gradient: isActive ? kButtonGradientColor : kDisableGradientColor,
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
