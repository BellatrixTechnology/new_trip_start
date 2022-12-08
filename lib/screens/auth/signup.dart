import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_underline_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/auth_ctrl.dart';
import 'package:new_trip_start/screens/auth/social_buttons.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/email_validator.dart';

class Singup extends StatelessWidget {
  const Singup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (controller) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSpacer(spaceValue: 20),
                  const UnderlineText(text: 'Sign Up'),
                  const CustomSpacer(spaceValue: 20),
                  AppInput(
                    controller: controller.nameCtrl,
                    hintText: 'Name',
                    icon: const Center(
                      child: CustomSurffixIcon(
                        svgIcon: 'assets/icons/profile.svg',
                        // color: kPrimaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                  const CustomSpacer(spaceValue: 10),
                  // AppInput(
                  //   controller: controller.phoneNumber,
                  //   textInputType: TextInputType.phone,
                  //   hintText: 'Phone Number',
                  //   validator: (input) =>
                  //       EmailValidator().isValidEmail(input) == true
                  //           ? null
                  //           : 'Enter Valid email',
                  //   // input.isValidEmail() ? null : "Check your email",
                  //   icon: const Center(
                  //     child: CustomSurffixIcon(
                  //       svgIcon: 'assets/icons/telephone.svg',
                  //       // color: kPrimaryColor,
                  //       size: 15,
                  //     ),
                  //   ),
                  // ),
                  // const CustomSpacer(spaceValue: 10),
                  AppInput(
                    controller: controller.emailCtrl,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'Email',
                    icon: const Center(
                      child: CustomSurffixIcon(
                        svgIcon: 'assets/icons/email.svg',
                        // color: kPrimaryColor,
                        size: 12,
                      ),
                    ),
                  ),
                  const CustomSpacer(spaceValue: 10),
                  AppInput(
                    hintText: 'Password',
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
                      child: controller.obscureText.isTrue
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
                  AppInput(
                    hintText: 'Confirm Password',
                    controller: controller.confirmPassword,
                    obscureText: controller.obscureText.value,
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
                      child: controller.obscureText.isTrue
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
                  const CustomSpacer(spaceValue: 20),
                  AppButton(
                    text: 'Sign Up',
                    width: SizeConfig.screenWidth,
                    showLoader: controller.isLoading.value,
                    press: () {
                      controller.onSignUp(context);
                    },
                  ),
                  const SocialButtons(),
                ],
              ),
            ));
  }
}
