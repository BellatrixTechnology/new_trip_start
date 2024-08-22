import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/shared.controller.dart';
// import 'package:new_trip_start/services/index.dart';
// import 'package:lottie/lottie.dart';

class ToastAlertService {
  toast(String message,
      [SnackPosition? position, String? title, int? seconds]) {
    Get.snackbar(title ?? "Trip Start", message,
        backgroundColor: kBlackColor,
        colorText: kBgLightColor,

        // icon: CustomSurffixIcon(svgIcon: 'assets/'),
        duration: Duration(seconds: seconds ?? 3),
        snackPosition: position ?? SnackPosition.TOP);
  }

  alert(String message, [String? textConfirm, void Function()? onClick]) {
    Get.defaultDialog(
      title: "Trip Start",
      middleText: message,
      confirm: InkWell(
        onTap: () {
          Get.close(0);
        },
        child: Ink(
          child: AppText(
            padding: const EdgeInsets.all(20),
            text: textConfirm ?? "OKAY",
            fontWeight: FontWeight.w700,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  nativeAlert(BuildContext context, String message, [bool showTitle = true]) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: showTitle
                ? const AppText(
                    text: 'Trip Start',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    color: kBlackColor,
                  )
                : null,
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

  confirmNativeAlert(BuildContext context, String message,
      [String? textConfirm, void Function()? onClick]) {
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
                  text: 'CANCEL',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: kRedColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: AppText(
                  text: textConfirm ?? 'OKAY',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClick!();
                },
              ),
            ],
          );
        });
  }

  closePopup() {
    Get.back();
    // Navigator.pop(Get.overlayContext ?? Get.context!);
  }

  void loaderPopup(BuildContext context) {
    SharedController sharedController = Get.put(SharedController());
    sharedController.getText();
    // Get.dialog(
    //   AlertDialog(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     content: Center(
    //       child: Container(
    //         padding: const EdgeInsets.all(20),
    //         height: 350,
    //         margin: const EdgeInsets.symmetric(horizontal: 20),
    //         decoration: BoxDecoration(
    //             color: Colors.white, borderRadius: BorderRadius.circular(40)),
    //         child: Column(
    //           children: [
    //             const CustomSpacer(spaceValue: 10),
    //             AppText(
    //                 color: kBlackColor,
    //                 fontWeight: FontWeight.bold,
    //                 text: "WE ARE SEARHING...".tr,
    //                 textAlign: TextAlign.center),
    //             SizedBox(height: 180, child: Lottie.asset(travelIsFun)),
    //             const CustomSpacer(spaceValue: 10),
    //             AppText(
    //                 text: "DID YOU KNOW!!!".tr,
    //                 textAlign: TextAlign.center,
    //                 color: kBlackColor,
    //                 fontWeight: FontWeight.bold),
    //             Obx(() => AppText(
    //                 textAlign: TextAlign.center,
    //                 text: sharedController.randomPoint.value.toString()))
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   // barrierDismissible: false,
    //   // barrierColor: Colors.black12,
    //   // navigatorKey: GlobalKey(debugLabel: "loaderPopup"),
    // );

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 350,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: Column(
              children: [
                const CustomSpacer(spaceValue: 10),
                AppText(
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                    text: "WE ARE SEARHING...".tr,
                    textAlign: TextAlign.center),
                SizedBox(height: 180, child: Lottie.asset(travelIsFun)),
                const CustomSpacer(spaceValue: 10),
                AppText(
                    text: "DID YOU KNOW!!!".tr,
                    textAlign: TextAlign.center,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold),
                Obx(() => AppText(
                    textAlign: TextAlign.center,
                    text: sharedController.randomPoint.value.toString()))
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
