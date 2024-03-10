import 'package:flutter/material.dart';
import 'package:new_trip_start/constants.dart';


class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: kTextColor,
      height: 0,
    );
  }
}
