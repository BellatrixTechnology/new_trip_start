/// AppLovin MAX Configuration
///
/// This file contains all AppLovin MAX SDK keys and Ad Unit IDs.
/// DO NOT implement the actual ad loading code yet - this is just for configuration.
///
/// Setup completed: AndroidManifest.xml ✓, Info.plist ✓, pubspec.yaml ✓

class AppLovinConfig {
  /// AppLovin SDK Key (Used for initialization)
  /// Added to:
  /// - Android: AndroidManifest.xml (applovin.sdk.key)
  /// - iOS: Info.plist (AppLovinSdkKey)
  static const String sdkKey =
      'HxG0kwNPZLu9fZGFTsyH3adwu6MhD5nxd56xOeBUveZcyo7qWT4TbyUE3uwWhzekaE4EFEVlJGvqJNDwtyrB_o';

  // ==================== AD UNIT IDs ====================

  /// Banner Ad Units
  static const String androidBannerId = '377609a017143797';
  static const String iosBannerId = 'f6e396a963d97745';

  /// Interstitial Ad Units ✓
  /// Created in AppLovin Dashboard
  static const String androidInterstitialId = 'd2afb8ae471f12ab';
  static const String iosInterstitialId = '9447cf03c84a0e29';

  /// Rewarded Ad Units ✓
  /// Created in AppLovin Dashboard
  static const String androidRewardedId = 'd65dd81556d43c03';
  static const String iosRewardedId = 'd009a6e1d669cddf';

  /// Native Ad Units (Optional - only if using native ads)
  static const String androidNativeId = 'TODO_CREATE_IF_NEEDED';
  static const String iosNativeId = 'TODO_CREATE_IF_NEEDED';

  // ==================== EXISTING ADMOB IDs (For Mediation Setup) ====================

  /// Current AdMob App ID (Keep this - needed for mediation)
  static const String admobAppId = 'ca-app-pub-3165620212348966~4400278118';

  /// Current AdMob Banner IDs (Map these in AppLovin mediation)
  static const String admobBannerId = 'ca-app-pub-3165620212348966/5052984428';

  /// Current AdMob Interstitial IDs (Map these in AppLovin mediation)
  /// Note: Android uses test ID in production (Line 23 - needs update!)
  static const String admobInterstitialAndroid =
      'ca-app-pub-3940256099942544/1033173712'; // TEST ID!
  static const String admobInterstitialIos =
      'ca-app-pub-3165620212348966/4807472225';

  /// Current AdMob Rewarded IDs (Map these in AppLovin mediation)
  static const String admobRewardedAndroid =
      'ca-app-pub-3165620212348966/9045073972';
  static const String admobRewardedIos = 'ca-app-pub-3165620212348966/5240624551';

  /// Current AdMob Native IDs (If using)
  static const String admobNativeAndroid =
      'ca-app-pub-3165620212348966/9475383030';
  static const String admobNativeIos = 'ca-app-pub-3165620212348966/6849219693';

  // ==================== CONFIGURATION FLAGS ====================

  /// Enable AppLovin ads (Set to false to keep using AdMob only)
  /// This will be used with feature flags for gradual rollout
  static const bool enableAppLovin = false; // ❌ DISABLED - Using AdMob only for now

  /// Test mode (Show test ads instead of real ads)
  static const bool testMode = true; // Test mode

  // ==================== NEXT STEPS ====================

  /// TODO - Dashboard Setup:
  /// 1. Create Interstitial ad units (Android + iOS)
  /// 2. Create Rewarded ad units (Android + iOS)
  /// 3. Setup AdMob mediation for all ad units
  /// 4. Configure waterfall/bidding settings
  /// 5. Enable test mode initially
  ///
  /// TODO - Code Implementation (NOT NOW):
  /// 1. Create AppLovinMaxService class
  /// 2. Add initialization in main.dart
  /// 3. Implement feature flags
  /// 4. Add gradual rollout logic
  /// 5. Setup analytics tracking
}
