import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    BottomTabController btmTabCtrl = Get.put(BottomTabController());
    // btmTabCtrl.checkIfUserNotSubscribed(context);
    return Scaffold(
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
                        svgIcon: btmTabCtrl.selectedTabIndex.value == 0
                            ? 'assets/icons/tab-selected-route.svg'
                            : 'assets/icons/tab-route.svg'),
                    label: 'Route'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: CustomSurffixIcon(
                        svgIcon: btmTabCtrl.selectedTabIndex.value == 1
                            ? 'assets/icons/tab-selected-vehicles.svg'
                            : 'assets/icons/tab-vehicles.svg'),
                    label: 'My Vehicles'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: CustomSurffixIcon(
                        svgIcon: btmTabCtrl.selectedTabIndex.value == 2
                            ? 'assets/icons/tab-selected-profile.svg'
                            : 'assets/icons/tab-profile.svg'),
                    label: 'Profile'.tr,
                  ),
                ],
                currentIndex: btmTabCtrl.selectedTabIndex.value,
                selectedItemColor: kPrimaryColor,
                onTap: (value) => btmTabCtrl.onTabChange(value, context)),
          ),
        ),
      ),
    );
  }
}
