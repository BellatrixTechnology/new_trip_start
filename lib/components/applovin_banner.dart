import 'package:new_trip_start/config/applovin_config.dart';
import 'package:new_trip_start/services/index.dart';

/// AppLovin MAX Banner Controller
///
/// NOTE: AppLovin banners are shown programmatically, not as widgets.
/// The banner is already showing at bottom of screen when AppLovin is enabled.
///
/// Usage:
/// ```dart
/// // Show banner
/// srvAppLovin.showBanner();
///
/// // Hide banner
/// srvAppLovin.hideBanner();
/// ```
///
/// This class is kept for potential future use with different ad formats
class AppLovinBannerHelper {
  /// Check if AppLovin is enabled
  static bool get isEnabled => AppLovinConfig.enableAppLovin;

  /// Check if banner is loaded
  static bool get isLoaded => srvAppLovin.isBannerLoaded;

  /// Show banner (if AppLovin enabled)
  static void show() {
    if (isEnabled) {
      srvAppLovin.showBanner();
    }
  }

  /// Hide banner
  static void hide() {
    if (isEnabled) {
      srvAppLovin.hideBanner();
    }
  }
}
