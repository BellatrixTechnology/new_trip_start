import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_rich_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/auth_ctrl.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authCtrl) => Column(
        children: [
          const CustomSpacer(spaceValue: 10),
          const AppText(text: 'or sign in with'),
          const CustomSpacer(spaceValue: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  authCtrl.facebookLogin();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: kBgLightColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: boxShadow(0.1)),
                  child: Image.asset(
                    'assets/images/facebook.png',
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  authCtrl.googleLogin();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: kBgLightColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: boxShadow(0.1)),
                  child: Image.asset(
                    'assets/images/google.png',
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  authCtrl.appleLogin();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: kBgLightColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: boxShadow(0.1)),
                  child: Image.asset(
                    'assets/images/apple.png',
                  ),
                ),
              ),
            ],
          ),
          // const CustomSpacer(spaceValue: 20),
          // const AppText(text: 'or sign in with'),
          InkWell(
            onTap: () {
              authCtrl.onViewChange();
            },
            child: CustomRichText(
                text1: authCtrl.view.value == 'LOGIN'
                    ? 'If you don’t have and account. '
                    : 'If you have an account. ',
                text2: authCtrl.view.value == 'LOGIN'
                    ? 'Register Now'
                    : 'Login Now'),
          )
        ],
      ),
    );
  }
}
