import 'package:flutter/material.dart';
import 'package:new_trip_start/constants.dart';

class SizeConfig {
  // ignore: avoid_init_to_null
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static late bool isAndroid;
  static late double heightExcludedSafeArea;
  static late double kAppBarWithStatusBarHeight;
  static late double statusBarHeight;
  static late double appBarHeight;
  static late double kBottomBarWithNavigationBarHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    globalContext = context;
    isAndroid = Theme.of(context).platform == TargetPlatform.iOS ? false : true;
    final padding = MediaQuery.of(context).padding;
    heightExcludedSafeArea =
        SizeConfig.screenHeight - (padding.top + padding.bottom + 10);
    statusBarHeight = _mediaQueryData.padding.top;
    appBarHeight = kToolbarHeight;
    kAppBarWithStatusBarHeight = statusBarHeight + appBarHeight;
    double bottomBarHeight = _mediaQueryData.padding.bottom;
    double appNavigationBarHeight = kBottomNavigationBarHeight;
    kBottomBarWithNavigationBarHeight =
        bottomBarHeight + appNavigationBarHeight;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;

  // 375 is the layout width that designer use
  return (inputWidth / 428.0) * screenWidth;
}
