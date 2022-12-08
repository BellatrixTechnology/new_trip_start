import 'package:flutter/material.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/size_config.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {Key? key, required this.text1, required this.text2, this.padding})
      : super(key: key);

  final String text1;
  final String text2;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenWidth(padding ?? 20)),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: text1,
              style: const TextStyle(
                  fontFamily: 'Avenir',
                  // fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor),
            ),
            TextSpan(
              text: text2,
              style: const TextStyle(
                color: kPrimaryColor,
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
