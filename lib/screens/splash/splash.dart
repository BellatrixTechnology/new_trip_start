import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/logo_text.dart';
import 'package:new_trip_start/screens/auth/auth.dart';
import 'package:new_trip_start/screens/tab_navigator/tabs.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Future.delayed(const Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        srvPageRoute.goToNextAndRemoved(context, const AuthScreen());
      } else {
        srvPageRoute.goToNextAndRemoved(context, const Tabs());
      }
    });

    return Scaffold(
      body: AppGradientBg(
        padding: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/top_curves.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Column(
              children: const [
                LogoWithText(),
                CustomSpacer(spaceValue: 8),
                AppText(text: 'Bompenger og Drivstoff Kalkulator')
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/images/bottom_curves.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
