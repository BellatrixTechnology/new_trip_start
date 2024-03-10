import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageRoute {
  goToNextAndRemoved(BuildContext context, pageName) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => pageName), (route) => false);
  }

  goToNext(BuildContext context, pageName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
  }

  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  goNextWithGetx(page, [Map? argument]) {
    try {
      Get.to(page, arguments: argument);
    } catch (e) {
      Get.to(() => page, arguments: argument);
    }
  }
}
