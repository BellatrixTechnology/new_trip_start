import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class OnBoardingController extends GetxController {
  List onboadings = [
    {
      "icon": 'assets/icons/onboarding1.svg',
      "text":
          "Don't get unexpectedly charged,\nplan your trip ahead and enjoy\nyour trip"
    },
    {
      "icon": 'assets/icons/onboarding2.svg',
      "text": "See alternative routes and save\non tolls and fuel",
      "size": 0.9
    },
    {
      "icon": 'assets/icons/onboarding3.svg',
      "text": "Keep up to date with the up-adjusted\ntoll rates and much more"
    },
  ];

  RxInt currentIndex = 0.obs;

  updateIndex(idx) {
    currentIndex.value = idx;
    update();
  }
}
