import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ToastAlertService {
  toast(String message,
      [SnackPosition? position, String? title, int? seconds]) {
    Get.snackbar(title ?? "Trip Start", message,
        // backgroundColor: kPrimaryColor,
        // colorText: kBgLightColor,
        // icon: CustomSurffixIcon(svgIcon: 'assets/'),
        duration: Duration(seconds: seconds ?? 3),
        snackPosition: position ?? SnackPosition.TOP);
  }

  alert(String message, [String? textConfirm, void Function()? onClick]) {
    Get.defaultDialog(
      title: "Trip Start",
      middleText: message,
      confirm: InkWell(
        onTap: onClick,
        child: AppText(
          text: textConfirm ?? "OKAY",
          fontWeight: FontWeight.w700,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  nativeAlert(BuildContext context, String message) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const AppText(
              text: 'Trip Start',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: kBlackColor,
            ),
            content: Column(
              children: [
                const CustomSpacer(spaceValue: 5),
                AppText(
                  text: message,
                  textAlign: TextAlign.center,
                  color: kBlackColor,
                )
              ],
            ),
            actions: [
              TextButton(
                child: const AppText(
                  text: 'OKAY',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
