import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/screens/profile/profile_body.dart';
// import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/size_config.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // Stack(
          //   alignment: Alignment.center,
          //   children: <Widget>[
          Column(
        children: <Widget>[
          Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              gradient: kButtonGradientColor,
              boxShadow: boxShadow(0.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                  child: AppText(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kBgLightColor,
                      text: 'My Profile'.tr)),
            ),
          ),
          const Expanded(child: ProfileBody())
        ],
      ),
      // Profile image
      //   Positioned(
      //     top: (getProportionateScreenHeight(170)) -
      //         (getProportionateScreenHeight(120) /
      //             2), // (background container size) - (circle height / 2)
      //     child: Container(
      //       height: 120,
      //       width: 120,
      //       alignment: Alignment.center,
      //       decoration: BoxDecoration(
      //           color: kBgLightColor,
      //           borderRadius: BorderRadius.circular(20),
      //           boxShadow: boxShadow(0.6)),
      //       // child: srvUser.user. != null
      //       //     ? ClipRRect(
      //       //         borderRadius: BorderRadius.circular(12),
      //       //         child: FadeInImage(
      //       //             height: 80,
      //       //             placeholder:
      //       //                 const AssetImage('assets/images/new_logo.png'),
      //       //             image: NetworkImage(
      //       //               srvFirebase.auth.currentUser!.photoURL!,
      //       //             )),
      //       //       )
      //       child: const LogoWithText(logoWidthHeight: 80, hideText: true),
      //     ),
      //   )
      // ],
      // ),
    );
  }
}
