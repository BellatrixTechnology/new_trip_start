import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/auth_ctrl.dart';
// import 'package:new_trip_start/modals/new_changes.info.dart';
import 'package:new_trip_start/screens/auth/forget_password.dart';
import 'package:new_trip_start/screens/auth/social_buttons.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();

    // Future.delayed(const Duration(milliseconds: 400), () {
    //   NewChangesInfoModal().showModal();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (controller) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const CustomSpacer(spaceValue: 10),
                  // UnderlineText(text: 'Login'.tr),
                  const CustomSpacer(spaceValue: 20),
                  AppInput(
                    hintText: 'Email',
                    controller: controller.emailCtrl,
                    textInputType: TextInputType.emailAddress,
                    icon: const Center(
                      child: CustomSurffixIcon(
                        svgIcon: 'assets/icons/email.svg',
                        // color: kPrimaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                  const CustomSpacer(spaceValue: 10),
                  AppInput(
                    hintText: 'Password'.tr,
                    controller: controller.password,
                    obscureText: controller.obscureText.value,
                    textInputType: TextInputType.visiblePassword,
                    icon: const Center(
                      child: CustomSurffixIcon(
                        svgIcon: 'assets/icons/password.svg',
                        // color: kPrimaryColor,
                        size: 15,
                      ),
                    ),
                    suffixicon: GestureDetector(
                      onTap: () {
                        controller.updateobscureText();
                      },
                      child: controller.obscureText.value == true
                          ? const Icon(
                              CupertinoIcons.eye_slash,
                              color: kTextColor,
                            )
                          : const Icon(
                              CupertinoIcons.eye,
                              color: kTextColor,
                            ),
                    ),
                  ),
                  const CustomSpacer(spaceValue: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Terms & conditions",
                        fontWeight: FontWeight.bold,
                        onTap: () {
                          srvShared.lauchUrl(
                              "https://www.privacypolicygenerator.info/live.php?token=5JA0iHT81FqJ8Wtz4nsV3UqTmZrxoiKs");
                        },
                        textDecoration: TextDecoration.underline,
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.onSignIn();
                          srvPageRoute.goToNext(
                              context, const ForgetPassword());
                        },
                        behavior: HitTestBehavior.opaque,
                        child: AppText(
                          text: 'Forget Password?'.tr,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const CustomSpacer(spaceValue: 30),
                  AppButton(
                    text: 'Login'.tr,
                    width: SizeConfig.screenWidth,
                    showLoader: controller.isLoading.value,
                    isDisable: controller.isSkipping.isTrue,
                    press: () {
                      controller.onSignIn(context);
                      // srvApi.getVehicleDataWithRegistrationNum('Vh60815');
                      // srvPageRoute.goToNext(context, const OnBoarding());
                    },
                  ),

                  const SocialButtons(),
                ],
              ),
            ));
  }
}
