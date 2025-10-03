import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/components/ripple_animation.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/services/google_admob.service.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(GoogleAdMobService());
  }

  @override
  Widget build(BuildContext context) {
    BottomTabController btmTabCtrl = Get.put(BottomTabController());
    MapController mapCtrl = Get.put(MapController());
    double iconSize = 28;
    // btmTabCtrl.checkIfUserNotSubscribed(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0), // <- lock scaling
      ),
      child: Scaffold(
        body: Obx(() =>
            Center(child: btmTabCtrl.page[btmTabCtrl.selectedTabIndex.value])),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: boxShadow(),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Obx(
              () => BottomNavigationBar(
                  selectedLabelStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                    ),
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                    ),
                  ),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: CustomSurffixIcon(
                          size: iconSize,
                          svgIcon: btmTabCtrl.selectedTabIndex.value == 0
                              ? 'assets/icons/map-new.svg'
                              : 'assets/icons/map-new-unselected.svg'),
                      label: 'Route'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: CustomSurffixIcon(
                          size: 25,
                          svgIcon: btmTabCtrl.selectedTabIndex.value == 1
                              ? 'assets/icons/car-selected.svg'
                              : 'assets/icons/car-unselected.svg'),
                      label: 'My Vehicles'.tr,
                    ),
                    BottomNavigationBarItem(
                      // icon:
                      //  CustomSurffixIcon(
                      //     svgIcon: btmTabCtrl.selectedTabIndex.value == 2
                      //         ? 'assets/icons/tab-selected-profile.svg'
                      //         : 'assets/icons/tab-profile.svg'),
                      icon: Obx(() => Stack(
                            children: [
                              if (mapCtrl.user.value.isSubscribe == false &&
                                  mapCtrl.user.value.apiCount == 0 &&
                                  kReleaseMode)
                                RippleAnimation(
                                    size: 10,
                                    color: kRedColor.withValues(alpha: 0.8),
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    maxRadius: 5,
                                    numberOfRipples: 3,
                                    child: CustomSurffixIcon(
                                        size: iconSize,
                                        svgIcon: btmTabCtrl
                                                    .selectedTabIndex.value ==
                                                2
                                            ? 'assets/icons/new_profile.svg'
                                            : 'assets/icons/profile-unselected.svg'))
                              else
                                CustomSurffixIcon(
                                    size: iconSize,
                                    svgIcon: btmTabCtrl
                                                .selectedTabIndex.value ==
                                            2
                                        ? 'assets/icons/new_profile.svg'
                                        : 'assets/icons/profile-unselected.svg'),
                            ],
                          )),
                      label: 'Profile'.tr,
                    ),
                  ],
                  currentIndex: btmTabCtrl.selectedTabIndex.value,
                  selectedItemColor: kPrimaryColor,
                  onTap: (value) => btmTabCtrl.onTabChange(value, context)),
            ),
          ),
        ),
      ),
    );
  }
}
