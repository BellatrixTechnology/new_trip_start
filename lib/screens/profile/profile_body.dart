import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/screens/profile/chnage_password.dart';
import 'package:new_trip_start/screens/profile/profile_item.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/utils/app_bg.dart';

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
              text: srvFirebase.auth.currentUser!.email.toString(),
            ),
            // const ProfileItem(
            //   prefixIcon: CustomSurffixIcon(
            //     svgIcon: 'assets/icons/telephone.svg',
            //   ),
            //   text: '+92 300 1234567',
            // ),
            ProfileItem(
              prefixIcon: const CustomSurffixIcon(
                svgIcon: 'assets/icons/password.svg',
              ),
              showsuffixIcon: true,
              text: 'Change Password',
              onPress: () {
                srvPageRoute.goToNext(context, const ChangePasswordScreen());
              },
            ),
            ProfileItem(
              prefixIcon: const CustomSurffixIcon(
                svgIcon: 'assets/icons/telephone.svg',
              ),
              showsuffixIcon: true,
              text: 'Language Settings',
              onPress: () {
                AppBottomModal().changeLangModal(context);
              },
            ),
            const ProfileItem(
              prefixIcon: CustomSurffixIcon(
                svgIcon: 'assets/icons/rating.svg',
              ),
              showsuffixIcon: true,
              text: 'Feedback',
            ),
            const ProfileItem(
              prefixIcon: CustomSurffixIcon(
                svgIcon: 'assets/icons/search.svg',
              ),
              showsuffixIcon: true,
              text: 'Search History',
            ),
            const ProfileItem(
              prefixIcon: CustomSurffixIcon(
                svgIcon: 'assets/icons/more-info.svg',
              ),
              showsuffixIcon: true,
              text: 'More Information',
            ),
            ProfileItem(
              prefixIcon: const CustomSurffixIcon(
                svgIcon: 'assets/icons/logout.svg',
              ),
              showsuffixIcon: true,
              text: 'Logout',
              onPress: () {
                AppBottomModal().confirmBottomSheet(
                    context,
                    () {},
                    Image.asset(
                      'assets/illustrations/logout.png',
                      width: 120,
                      height: 120,
                    ),
                    'You are about to Logout!',
                    'Do you want to proceed or cancel?',
                    'Logout');
              },
            ),
          ],
        ),
      ),
    );
  }
}
