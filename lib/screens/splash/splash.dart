import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/logo_text.dart';
import 'package:new_trip_start/models/users.model.dart';
import 'package:new_trip_start/screens/auth/auth.dart';
import 'package:new_trip_start/screens/tab_navigator/tabs.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initStorage();
  }

  initStorage() async {
    await srvLocalStorage.init();
    navigateUser();
  }

  navigateUser() async {
    NewUserModel? user = await srvLocalStorage.getUser();
    if (user == null) {
      srvPageRoute.goNextWithGetxAndRemovedAll(const AuthScreen());
    } else {
      try {
        srvUser.initUser(user);
        var resp = await srvApi.apiUrlget(concaturl: "me");
        debugPrint("user-> $resp");
        srvUser.initUser(
            NewUserModel.fromMap(resp.data['data'] as Map<String, dynamic>));
        srvRevenueCatSub.initPlatformState();
        srvPageRoute.goNextWithGetxAndRemovedAll(const Tabs());
      } catch (e) {
        debugPrint("err is -> $e");
        srvPageRoute.goNextWithGetxAndRemovedAll(const AuthScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // srvPaymentService.initPlatformState();

    // Future.delayed(const Duration(seconds: 3), () async {
    //   User? user = FirebaseAuth.instance.currentUser;
    //   if (user == null) {
    //     srvPageRoute.goToNextAndRemoved(context, const AuthScreen());
    //   } else {
    //     await srvFirebase.getUserFromFirestore(user);
    //     // ignore: use_build_context_synchronously
    //     srvPageRoute.goToNextAndRemoved(context, const Tabs());
    //   }
    // });

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
            const Column(
              children: [
                LogoWithText(logoWidthHeight: 120),
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
