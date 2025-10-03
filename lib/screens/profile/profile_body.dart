import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
// import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';

import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/screens/auth/forget_password.dart';
import 'package:new_trip_start/screens/profile/profile_item.dart';

import 'package:new_trip_start/screens/profile/subscription_view.dart';
import 'package:new_trip_start/screens/splash/splash.dart';
import 'package:new_trip_start/screens/subscription/page.dart';
import 'package:new_trip_start/services/index.dart';

import 'package:new_trip_start/utils/app_bg.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBg(
      child: SingleChildScrollView(
        // padding: EdgeInsets.only(
        //     // top: (getProportionateScreenHeight(170)) -
        //     //     (getProportionateScreenHeight(200) / 2),
        //     ),
        child: GetBuilder<MapController>(
          init: MapController(),
          builder: (controller) => Column(
            children: [
              // const SubscriptionCard(),
              // AppText(text: controller.user.value.apiCount.toString()),
              SubscriptionStatus(
                type: srvUser.user.loginType.toString(),
                isPremium: controller.user.value.isSubscribe == true,
                searchesLeft: controller.user.value.apiCount ?? 0,
                totalVehicles: controller.tabController.myVehicles.length,
              ),
              const CustomSpacer(spaceValue: 10),
              AppText(
                text: srvUser.user.name,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              if (controller.user.value.loginType != "guest")
                ProfileItem(
                  prefixIcon: const CustomSurffixIcon(
                    svgIcon: 'assets/icons/email.svg',
                    size: 28,
                  ),
                  text: srvUser.user.email,
                  onPress: () {
                    srvPageRoute.goNextWithGetx(const SubscriptionPage());
                  },
                ),
              if (controller.user.value.loginType != "guest")
                ProfileItem(
                  prefixIcon: const CustomSurffixIcon(
                    svgIcon: 'assets/icons/password.svg',
                    size: 28,
                  ),
                  showsuffixIcon: true,
                  text: 'Change Password'.tr,
                  onPress: () async {
                    srvPageRoute.goToNext(
                        context, const ForgetPassword(isFromInnerApp: true));
                  },
                ),
              ProfileItem(
                prefixIcon: const CustomSurffixIcon(
                  svgIcon: 'assets/icons/language.svg',
                  size: 28,
                ),
                showsuffixIcon: true,
                text: 'Language Settings'.tr,
                onPress: () {
                  AppBottomModal().changeLangModal(context);
                },
              ),
              // ProfileItem(
              //   prefixIcon: const CustomSurffixIcon(
              //     svgIcon: 'assets/icons/rating.svg',
              //   ),
              //   showsuffixIcon: true,
              //   text: 'Feedback'.tr,
              //   onPress: () {
              //     srvShared.lauchUrl(
              //         "mailto:hello@tripstart.no?subject=Feedback To BompengeAppen");
              //     // srvPageRoute.goToNext(context, const SubscriptionPage());
              //   },
              // ),
              ProfileItem(
                prefixIcon: const CustomSurffixIcon(
                  svgIcon: 'assets/icons/privacy_policy.svg',
                  size: 28,
                ),
                showsuffixIcon: true,
                text: 'privacy_policy'.tr,
                onPress: () {
                  srvShared.lauchUrl(
                      "https://www.privacypolicygenerator.info/live.php?token=5JA0iHT81FqJ8Wtz4nsV3UqTmZrxoiKs");
                  // srvPageRoute.goToNext(context, const SubscriptionPage());
                },
              ),
              if (controller.user.value.loginType != "guest")
                ProfileItem(
                  prefixIcon: const CustomSurffixIcon(
                    svgIcon: 'assets/icons/logout.svg',
                    size: 28,
                  ),
                  showsuffixIcon: true,
                  text: 'Logout'.tr,
                  onPress: () {
                    AppBottomModal().confirmBottomSheet(context, () {
                      srvFirebase.signout(context);
                    },
                        Image.asset(
                          'assets/illustrations/logout.png',
                          width: 120,
                          height: 120,
                        ),
                        'You are about to Logout!'.tr,
                        'Do you want to proceed or cancel?'.tr,
                        'Logout'.tr);
                  },
                ),
              if (controller.user.value.loginType != "guest")
                ProfileItem(
                  prefixIcon: CustomSurffixIcon(
                    svgIcon: 'assets/icons/profileDelete.svg',
                    size: 30,
                  ),
                  showsuffixIcon: true,
                  text: 'Delete Account'.tr,
                  onPress: () {
                    AppBottomModal().confirmBottomSheet(context, () async {
                      srvFirebase.signout(context);
                      try {
                        var resp = await srvApi.apiUrlDelete(concaturl: "me");
                        srvShared.printWrapped(resp.toString());
                        srvPageRoute.goToNextAndRemoved(
                            // ignore: use_build_context_synchronously
                            context,
                            const SplashScreen());
                      } on DioException catch (e) {
                        srvToastAlert.toast(e.message ??
                            "Something went wrong while deleting your account"
                                .tr);
                      }
                    },
                        Image.asset(
                          'assets/illustrations/logout.png',
                          width: 120,
                          height: 120,
                        ),
                        'You are about to Delete your account!'.tr,
                        'Do you want to proceed or cancel?'.tr,
                        'Delete Account'.tr);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
