import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/app_underline_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/keyboard_hider.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/auth_ctrl.dart';
import 'package:new_trip_start/screens/auth/login.dart';
import 'package:new_trip_start/screens/auth/signup.dart';

import 'package:new_trip_start/utils/app_bg.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, this.isFromInnerApp});
  final bool? isFromInnerApp;

  @override
  Widget build(BuildContext context) {
    // AuthController authCtrl = Get.put(AuthController());
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => KeyboardHider(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.transparent,
            title: UnderlineText(
                text: controller.view.value == 'LOGIN'
                    ? 'Login'.tr
                    : 'Sign Up'.tr),
            centerTitle: false,
            // title: const LogoWithText(
            //   logoWidthHeight: 10,
            //   fontSize: 10,
            // ),
            actions: [
              isFromInnerApp == true
                  ? const SizedBox()
                  : AppButton(
                      text: "",
                      appText: AppText(
                        text: "Skip".tr,
                        fontSize: 13,
                        color: kBgLightColor,
                        fontWeight: FontWeight.bold,
                      ),
                      press: () {
                        controller.onSkip();
                      },
                      isDisable: controller.isLoading.isTrue,
                      showLoader: controller.isSkipping.value,
                      width: 100,
                      height: 30),
              const CustomSpacer(spaceValue: 10),
            ],
          ),
          body: AppGradientBg(
            child: SafeArea(
              // bottom: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const CustomSpacer(spaceValue: 5),
                    // const LogoWithText(
                    //   logoWidthHeight: 70,
                    // ),
                    Image.asset(
                      'assets/images/new_logo.png',
                      width: 70,
                      height: 70,
                    ),
                    controller.view.value == 'LOGIN'
                        ? const LoginScreen()
                        : const Singup(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
