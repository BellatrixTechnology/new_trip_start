import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon(
      {super.key, required this.svgIcon, this.color, this.size});

  final String svgIcon;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgIcon,
      height: getProportionateScreenWidth(size ?? 20),
      // ignore: deprecated_member_use
      color: color,
    );
    // return Padding(
    //   padding: EdgeInsets.fromLTRB(
    //     0,
    //     getProportionateScreenWidth(2),
    //     getProportionateScreenWidth(2),
    //     getProportionateScreenWidth(2),
    //   ),
    //   child: SvgPicture.asset(
    //     svgIcon,
    //     height: getProportionateScreenWidth(18),
    //     color: color,
    //   ),
    // );
  }
}
