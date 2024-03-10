import 'package:get/get.dart';
// import 'package:get/state_manager.dart';

class OnBoardingController extends GetxController {
  List onboadings = [
    {"icon": 'assets/icons/onboarding1.svg', "text": "onboarding text 1".tr},
    {
      "icon": 'assets/icons/onboarding2.svg',
      "text": "onboarding text 2".tr,
      "size": 0.9
    },
    {"icon": 'assets/icons/onboarding3.svg', "text": "onboarding text 3".tr},
  ];

  RxInt currentIndex = 0.obs;

  updateIndex(idx) {
    currentIndex.value = idx;
    update();
  }
}
