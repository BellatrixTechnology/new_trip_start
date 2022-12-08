import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/constants.dart';

class AppBars extends AppBar {
  AppBars({Key? key, title, context, hideBackbtn, elevation})
      : super(
          key: key,
          elevation: elevation ?? 0.5,
          backgroundColor: kPrimaryLightColor,
          leading: hideBackbtn != null
              ? const SizedBox()
              : IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(CupertinoIcons.back)),
          title: AppText(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kBlackColor,
              text: title),
        );
}
