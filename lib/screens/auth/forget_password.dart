import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/back_button.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/auth_ctrl.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key, this.isFromInnerApp});
  final bool? isFromInnerApp;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authCtrl) {
      return Scaffold(
        body: AppGradientBg(
          padding: 0,
          child: SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                      height: SizeConfig.heightExcludedSafeArea,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomBackButton(),
                          const CustomSpacer(spaceValue: 10),
                          AppText(
                            textAlign: TextAlign.left,
                            text: isFromInnerApp == true
                                ? "Change Password".tr
                                : 'Reset Your Password'.tr,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          const CustomSpacer(spaceValue: 4),
                          AppText(
                            text:
                                'We’ll send an rest password link to your email.'
                                    .tr,
                            color: kTextColor,
                          ),
                          const CustomSpacer(spaceValue: 20),
                          Center(
                            child: CustomSurffixIcon(
                              svgIcon:
                                  authCtrl.forgetPasswordViewCount.value == 1
                                      ? 'assets/icons/Frame.svg'
                                      : "assets/icons/forgetPassword.svg",
                              size: SizeConfig.screenWidth * 0.75,
                            ),
                          ),
                          const CustomSpacer(spaceValue: 10),
                          if (authCtrl.forgetPasswordViewCount.value == 1)
                            emailInputView(),
                          if (authCtrl.forgetPasswordViewCount.value == 2)
                            codeInputView(),
                          if (authCtrl.forgetPasswordViewCount.value == 3)
                            newPasswordInputView(),
                          const CustomSpacer(spaceValue: 20),
                          AppButton(
                            text: 'Reset Password',
                            press: () async {
                              authCtrl.handleRequest(context);
                              // authCtrl.changeFPView(count: 3);
                              // if (ctrl.text.isEmail) {
                              //   srvFirebase
                              //       .sendResetPasswordLink(ctrl.text)
                              //       .then((value) {
                              //     AppBottomModal().bottomSheet(context);
                              //   });
                              // }
                            },
                            showLoader: authCtrl.isfPLoading.value,
                            width: SizeConfig.screenWidth,
                          ),
                          const Spacer(),
                          if (isFromInnerApp == null)
                            Align(
                              alignment: Alignment.center,
                              child: AppText(
                                text: 'If you don’t have and account.'.tr,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          if (isFromInnerApp == null)
                            Align(
                              alignment: Alignment.center,
                              child: AppText(
                                onTap: () {
                                  authCtrl.onViewChange(newView: "SIGN_UP");
                                  srvPageRoute.goBack(context);
                                },
                                text: 'Register Now'.tr,
                                textAlign: TextAlign.center,
                                color: kPrimaryColor,
                                textDecoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          const Spacer(),
                        ],
                      )))),
        ),
      );
    });
  }

  Widget emailInputView() {
    AuthController authCtrl = Get.find<AuthController>();
    return AppInput(
      hintText: 'Email'.tr,
      controller: authCtrl.fPemailCtrl,
      icon: const Center(
        child: CustomSurffixIcon(
          svgIcon: 'assets/icons/email.svg',
          size: 12,
        ),
      ),
    );
  }

  Widget codeInputView() {
    AuthController authCtrl = Get.find<AuthController>();
    return AppInput(
      hintText: 'enter_code_here'.tr,
      controller: authCtrl.fPcodeCtrl,
      textAlign: TextAlign.center,
      // icon: const Center(
      //   child: CustomSurffixIcon(
      //     svgIcon: 'assets/icons/email.svg',
      //     // color: kPrimaryColor,
      //     size: 12,
      //   ),
      // ),
    );
  }

  Widget newPasswordInputView() {
    AuthController authCtrl = Get.find<AuthController>();
    return AppInput(
      hintText: 'enter_new_password'.tr,
      controller: authCtrl.fPpasswordCtrl,
      icon: const Center(
        child: CustomSurffixIcon(
          svgIcon: 'assets/icons/email.svg',
          // color: kPrimaryColor,
          size: 12,
        ),
      ),
    );
  }
}
