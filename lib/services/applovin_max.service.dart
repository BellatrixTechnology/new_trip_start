import 'dart:io';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/config/applovin_config.dart';

/// AppLovin MAX Service
/// Currently: BANNER ADS ONLY
/// Feature flag controlled - can be disabled anytime
class AppLovinMaxService extends GetxService {
  // Banner ad loaded status
  bool isBannerLoaded = false;

  /// Get platform-specific banner ad unit ID
  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return AppLovinConfig.androidBannerId;
    } else if (Platform.isIOS) {
      return AppLovinConfig.iosBannerId;
    }
    return '';
  }

  @override
  void onInit() {
    super.onInit();

    // Only load if AppLovin is enabled
    if (AppLovinConfig.enableAppLovin) {
      debugPrint('🎯 AppLovin MAX Service initialized');
      // loadBannerAd();
    } else {
      debugPrint('⚠️ AppLovin disabled - using AdMob only');
    }
  }

  /// Initialize Banner Ad (called automatically)
  Future<void> loadBannerAd() async {
    try {
      debugPrint('🎯 AppLovin: Initializing banner ad...');
      debugPrint('🎯 Ad Unit ID: $bannerAdUnitId');

      // Attach listener FIRST
      AppLovinMAX.setBannerListener(AdViewAdListener(
        onAdLoadedCallback: (ad) {
          debugPrint('✅✅✅ AppLovin Banner LOADED: ${ad.adUnitId}');
          isBannerLoaded = true;
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          debugPrint('❌❌❌ AppLovin Banner FAILED: $adUnitId');
          debugPrint('❌ Error Code: ${error.code}');
          debugPrint('❌ Error Message: ${error.message}');
          isBannerLoaded = false;
        },
        onAdClickedCallback: (ad) {
          debugPrint('👆 AppLovin Banner clicked');
        },
        onAdExpandedCallback: (ad) {
          debugPrint('📱 AppLovin Banner expanded');
        },
        onAdCollapsedCallback: (ad) {
          debugPrint('📱 AppLovin Banner collapsed');
        },
        onAdRevenuePaidCallback: (ad) {
          debugPrint('💰 AppLovin Banner revenue: ${ad.revenue}');
        },
      ));

      debugPrint('🎯 Creating banner...');

      // Create banner
      AppLovinMAX.createBanner(bannerAdUnitId, AdViewPosition.topCenter);

      // Small delay to let banner initialize
      await Future.delayed(const Duration(milliseconds: 500));

      debugPrint('🎯 Showing banner...');

      // Show banner
      AppLovinMAX.showBanner(bannerAdUnitId);

      debugPrint('✅ Banner ad initialized - waiting for callback...');
    } catch (e) {
      debugPrint('❌ AppLovin Banner error: $e');
      isBannerLoaded = false;
    }
  }

  /// Get banner ad unit ID
  String getBannerAdUnitId() {
    return bannerAdUnitId;
  }

  /// Hide banner
  void hideBanner() {
    try {
      AppLovinMAX.hideBanner(bannerAdUnitId);
      debugPrint('🙈 AppLovin Banner hidden');
    } catch (e) {
      debugPrint('❌ Error hiding banner: $e');
    }
  }

  /// Show banner
  void showBanner() {
    try {
      AppLovinMAX.showBanner(bannerAdUnitId);

      debugPrint('👁️ AppLovin Banner shown');
    } catch (e) {
      debugPrint('❌ Error showing banner: $e');
    }
  }

  /// Destroy banner ad
  void destroyBanner() {
    try {
      AppLovinMAX.destroyBanner(bannerAdUnitId);
      isBannerLoaded = false;
      debugPrint('🗑️ AppLovin Banner destroyed');
    } catch (e) {
      debugPrint('❌ Error destroying banner: $e');
    }
  }

  @override
  void onClose() {
    destroyBanner();
    super.onClose();
  }
}
