import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_trip_start/constants.dart';

class LoaderService {
  showLoader() {
    return Get.dialog(const CustomAlertDialog(),
        barrierDismissible: false, barrierColor: Colors.black12);
  }

  hideLoader() {
    print(Get.isDialogOpen);
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kBgLightColor,
          ),
          // You can customize the box color
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
