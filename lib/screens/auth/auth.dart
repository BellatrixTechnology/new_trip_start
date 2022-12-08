import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/logo_text.dart';
import 'package:new_trip_start/controllers/auth_ctrl.dart';
import 'package:new_trip_start/screens/auth/login.dart';
import 'package:new_trip_start/screens/auth/signup.dart';
import 'package:new_trip_start/screens/auth/social_buttons.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authCtrl = Get.put(AuthController());
    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        body: AppGradientBg(
          child: SafeArea(
            // bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSpacer(spaceValue: 5),
                  const LogoWithText(
                    logoWidthHeight: 70,
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
    );
  }
}
