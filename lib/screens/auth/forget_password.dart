import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/back_button.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
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

                        const AppText(
                          text: 'Reset Your Password',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        const CustomSpacer(spaceValue: 4),
                        const AppText(
                          text:
                              'We’ll send an rest password link to your email.',
                          color: kTextColor,
                        ),
                        // Image.asset('assets/images/forget_illustration.png'),
                        CustomSurffixIcon(
                          svgIcon: 'assets/icons/Frame.svg',
                          size: SizeConfig.screenWidth * 0.9,
                        ),
                        const CustomSpacer(spaceValue: 10),
                        const AppInput(
                          hintText: 'Email',
                          icon: Center(
                            child: CustomSurffixIcon(
                              svgIcon: 'assets/icons/email.svg',
                              // color: kPrimaryColor,
                              size: 12,
                            ),
                          ),
                        ),
                        const CustomSpacer(spaceValue: 20),
                        AppButton(
                          text: 'Reset Password',
                          press: () {
                            AppBottomModal().bottomSheet(context);
                          },
                          showLoader: false,
                          width: SizeConfig.screenWidth,
                        ),
                        const Spacer(),

                        const Align(
                          alignment: Alignment.center,
                          child: AppText(
                            text: 'If you don’t have and account.',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: AppText(
                            text: 'Register Now',
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
  }
}
