import 'package:flutter/material.dart';

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
}
