import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_input.dart';
import 'package:new_trip_start/components/app_underline_text.dart';
import 'package:new_trip_start/components/back_button.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/components/logo_text.dart';
import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
                  const LogoWithText(
                    logoWidthHeight: 70,
                  ),
                  const CustomSpacer(spaceValue: 30),
                  const UnderlineText(text: 'Chnage Password'),
                  const CustomSpacer(spaceValue: 30),
                  const AppInput(
                      hintText: 'Old Password',
                      icon: Center(
                        child: CustomSurffixIcon(
                          svgIcon: 'assets/icons/password.svg',
                          size: 15,
                        ),
                      ),
                      suffixicon: Icon(CupertinoIcons.eye)
                      // CustomSurffixIcon(svgIcon: 'assets/icons/eye-off.svg'),
                      ),
                  const CustomSpacer(spaceValue: 10),
                  const AppInput(
                      hintText: 'New Password',
                      icon: Center(
                        child: CustomSurffixIcon(
                          svgIcon: 'assets/icons/password.svg',
                          size: 15,
                        ),
                      ),
                      suffixicon: Icon(CupertinoIcons.eye)),
                  const CustomSpacer(spaceValue: 10),
                  const AppInput(
                      hintText: 'Confirm New Password',
                      icon: Center(
                        child: CustomSurffixIcon(
                          svgIcon: 'assets/icons/password.svg',
                          size: 15,
                        ),
                      ),
                      suffixicon: Icon(CupertinoIcons.eye)),
                  const CustomSpacer(spaceValue: 20),
                  AppButton(
                    text: 'Change Password',
                    press: () {
                      AppBottomModal().bottomSheet(
                        context,
                        null,
                        'Password Chnaged',
                        'Your password has been changed successfully. Please login into your account again.',
                        'Ok',
                      );
                    },
                    showLoader: false,
                    width: SizeConfig.screenWidth,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
