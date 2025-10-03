// lib/utils/ad_helper.dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:new_trip_start/constants.dart';

class AdHelper {
  static String get bannerAdUnitId {
    // Replace these test ad units with your real ad units for production
    if (isAndroid) {
      // return 'ca-app-pub-3940256099942544/6300978111'; // Android test ad unit
      return !kReleaseMode
          ? "ca-app-pub-3940256099942544/9214589741"
          : 'ca-app-pub-3165620212348966/5052984428';
    } else if (Platform.isIOS) {
      // return 'ca-app-pub-3940256099942544/2934735716'; // iOS test ad unit
      return !kReleaseMode
          ? "ca-app-pub-3940256099942544/2435281174"
          : 'ca-app-pub-3165620212348966/9674755713';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
