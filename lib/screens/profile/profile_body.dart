import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';

import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/screens/auth/forget_password.dart';
import 'package:new_trip_start/screens/profile/profile_item.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBg(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: (getProportionateScreenHeight(170)) -
              (getProportionateScreenHeight(200) / 2),
        ),
        child: Column(
          children: [
            AppText(
              text: srvFirebase.auth.currentUser!.displayName,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            ProfileItem(
              prefixIcon: const CustomSurffixIcon(
                svgIcon: 'assets/icons/email.svg',
                size: 15,
              ),
              text: srvFirebase.auth.currentUser!.email != null
                  ? srvFirebase.auth.currentUser!.email.toString()
                  : srvFirebase.auth.currentUser!.providerData[0].uid
                      .toString(),
            ),
            ProfileItem(
              prefixIcon: const CustomSurffixIcon(
                svgIcon: 'assets/icons/password.svg',
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
                size: 100,
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
                svgIcon: 'assets/icons/rating.svg',
              ),
              showsuffixIcon: true,
              text: 'privacy_policy'.tr,
              onPress: () {
                srvShared.lauchUrl(
                    "https://www.privacypolicygenerator.info/live.php?token=5JA0iHT81FqJ8Wtz4nsV3UqTmZrxoiKs");
                // srvPageRoute.goToNext(context, const SubscriptionPage());
              },
            ),
            ProfileItem(
              prefixIcon: const CustomSurffixIcon(
                svgIcon: 'assets/icons/logout.svg',
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
            ProfileItem(
              prefixIcon: const CustomSurffixIcon(
                svgIcon: 'assets/icons/logout.svg',
              ),
              showsuffixIcon: true,
              text: 'Delete Account'.tr,
              onPress: () {
                AppBottomModal().confirmBottomSheet(context, () {
                  srvFirebase.signout(context);
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
    );
  }
}
