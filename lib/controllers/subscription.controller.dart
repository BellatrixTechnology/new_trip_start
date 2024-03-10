import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  // RxList<ProductDetails> products = RxList([]);
  var isLoadingForSubscription = false.obs;

  toggleLoader([bool keepTrue = false, bool keepFalse = false]) {
    if (keepTrue) {
      isLoadingForSubscription.value = true;
      update();
      return;
    }

    if (keepFalse == true) {
      isLoadingForSubscription.value = false;
      update();
      return;
    }
    isLoadingForSubscription.toggle();
    update();
  }
}
