import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_round_button.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/onboarding_ctrl.dart';
import 'package:new_trip_start/screens/auth/auth.dart';
import 'package:new_trip_start/screens/onboarding/indicator.dart';
import 'package:new_trip_start/screens/onboarding/onboarding_info.dart';
// import 'package:new_trip_start/screens/subscription/page.dart';
// import 'package:new_trip_start/screens/tab_navigator/tabs.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/services/local_storage.service.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    srvLocalStorage.set(onBoardingScreenShown, true);
    OnBoardingController onBoardingCtrl = Get.put(OnBoardingController());
    final PageController controller = PageController();
    return Scaffold(
      body: AppGradientBg(
          padding: 0,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/images/upper_curves.png',
                  fit: BoxFit.cover,
                  width: SizeConfig.screenWidth,
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: PageView.builder(
                    controller: controller,
                    itemCount: onBoardingCtrl.onboadings.length,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (idx) {
                      onBoardingCtrl.updateIndex(idx);
                    },
                    itemBuilder: (context, index) {
                      return OnboardingInfo(
                        icon: onBoardingCtrl.onboadings[index]['icon'],
                        text: onBoardingCtrl.onboadings[index]['text'],
                        size: onBoardingCtrl.onboadings[index]['size'],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const CustomSpacer(spaceValue: 20),
                    ListView.builder(
                      padding: const EdgeInsets.only(left: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: onBoardingCtrl.onboadings.length,
                      itemBuilder: ((context, index) {
                        return Obx(
                          () => Indicator(
                              isActive:
                                  onBoardingCtrl.currentIndex.value == index),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: RoundButton(
                        press: () {
                          if (onBoardingCtrl.currentIndex.value > 1) {
                            srvPageRoute.goToNextAndRemoved(
                                context,
                                // srvUser.user.isSubscribed == true
                                //     ?
                                const AuthScreen()
                                // : const SubscriptionPage());
                                // : const SubscriptionPage()
                                );
                          }
                          controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linear);
                        },
                        showLoader: false,
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: kBgLightColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
