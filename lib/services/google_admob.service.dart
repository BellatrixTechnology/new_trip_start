import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/google_ads.controller.dart';
import 'package:new_trip_start/services/index.dart';

class GoogleAdMobService extends GetxService {
  GoogleAdsController googleAdsController = Get.put(GoogleAdsController());

  final bannerAdId = isAndroid
      ? !kReleaseMode
          ? "ca-app-pub-3940256099942544/9214589741"
          : 'ca-app-pub-3165620212348966/5052984428'
      : !kReleaseMode
          ? "ca-app-pub-3940256099942544/2435281174"
          : 'ca-app-pub-3165620212348966/9674755713';

  final interstitialAdId = isAndroid
      ? !kReleaseMode
          ? "ca-app-pub-3940256099942544/1033173712"
          : 'ca-app-pub-3940256099942544/1033173712'
      : !kReleaseMode
          ? "ca-app-pub-3940256099942544/4411468910"
          : 'ca-app-pub-3165620212348966/4807472225';

  final rewardedAdId = isAndroid
      ? !kReleaseMode
          ? "ca-app-pub-3940256099942544/5224354917"
          : 'ca-app-pub-3165620212348966/9045073972'
      : !kReleaseMode
          ? "ca-app-pub-3940256099942544/1712485313"
          : 'ca-app-pub-3165620212348966/5240624551';

  final nativeAdId = isAndroid
      ? !kReleaseMode
          ? "ca-app-pub-3940256099942544/2247696110"
          : 'ca-app-pub-3165620212348966/9475383030'
      : !kReleaseMode
          ? "ca-app-pub-3940256099942544/3986624511"
          : 'ca-app-pub-3165620212348966/6849219693';

  @override
  void onInit() {
    super.onInit();
    loadBannerAd();
    // loadIntertisialAd();
    loadNativeAd();
    // rewardAd();
  }

  // void loadBannerAd() {
  //   BannerAd(
  //     adUnitId: bannerAdId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         // bannerAd = ad as BannerAd;
  //         // print(bannerAd!.size.width);
  //         googleAdsController.updateIsBannerShown(true, ad as BannerAd);
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, err) {
  //         debugPrint('BannerAd failed to load: $err');
  //         // Dispose the ad here to free resources.
  //         ad.dispose();
  //       },
  //     ),
  //   ).load();
  // }

  Future<void> loadBannerAd() async {
    print("googleAdsController.bannerAd ${googleAdsController.bannerAd}");
    if (googleAdsController.bannerAd != null) return;
    // if (googleAdsController.isLoading.value) return;

    // isLoading.value = true;

    googleAdsController.bannerAd = BannerAd(
      // Add your ad unit ID here
      adUnitId: 'your_ad_unit_id',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          googleAdsController.isBannerShown.value = true;
          // isLoading.value = false;
          googleAdsController.update();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          googleAdsController.bannerAd = null;
          googleAdsController.isBannerShown.value = false;
          // isLoading.value = false;
          googleAdsController.update();
        },
      ),
    );

    try {
      await googleAdsController.bannerAd?.load();
    } catch (e) {
      googleAdsController.bannerAd = null;
      googleAdsController.isBannerShown.value = false;
      // isLoading.value = false;
      googleAdsController.update();
    }
  }

  void loadIntertisialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            // googleAdsController.interstitialAd = ad;
            googleAdsController.showInterstitialAd(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  loadRewardAd({bool isFromInnerApp = false}) {
    if (isFromInnerApp) srvLoader.showLoader();
    RewardedAd.load(
        adUnitId: rewardedAdId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');

            // Keep a reference to the ad so you can show it later.
            srvLoader.hideLoader();
            googleAdsController.rewardedAd = ad;
            if (isFromInnerApp) {
              googleAdsController.showRewardedAd();
            }
          },
// Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            srvLoader.hideLoader();
            debugPrint('RewardedAd failed to load: $error');
            srvToastAlert.toast('RewardedAd failed to load: $error');
          },
        ));
  }

  /// Loads a native ad.
  void loadNativeAd() {
    NativeAd(
            adUnitId: nativeAdId,
            listener: NativeAdListener(
              onAdLoaded: (ad) {
                print('$NativeAd loaded.');
                googleAdsController.updateIsNativeShown(true, ad as NativeAd);
              },
              onAdFailedToLoad: (ad, error) {
                // Dispose the ad here to free resources.
                print('$NativeAd failedToLoad: $error');
                googleAdsController.updateIsNativeShown(false, ad as NativeAd);
                ad.dispose();
              },
              // Called when a click is recorded for a NativeAd.
              onAdClicked: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when an ad removes an overlay that covers the screen.
              onAdClosed: (ad) {},
              // Called when an ad opens an overlay that covers the screen.
              onAdOpened: (ad) {},
              // For iOS only. Called before dismissing a full screen view
              onAdWillDismissScreen: (ad) {},
              // Called when an ad receives revenue value.
              onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
            ),
            request: const AdRequest(),
            // Styling
            nativeTemplateStyle: NativeTemplateStyle(
                // Required: Choose a template.
                templateType: TemplateType.small,
                // Optional: Customize the ad's style.
                mainBackgroundColor: Colors.white,
                cornerRadius: 10.0,
                callToActionTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.cyan,
                    backgroundColor: Colors.red,
                    style: NativeTemplateFontStyle.monospace,
                    size: 16.0),
                primaryTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.red,
                    backgroundColor: Colors.cyan,
                    style: NativeTemplateFontStyle.italic,
                    size: 16.0),
                secondaryTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.green,
                    backgroundColor: Colors.black,
                    style: NativeTemplateFontStyle.bold,
                    size: 16.0),
                tertiaryTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.brown,
                    backgroundColor: Colors.amber,
                    style: NativeTemplateFontStyle.normal,
                    size: 16.0)))
        .load();
  }
}
