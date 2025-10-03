import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_trip_start/utils/ad_helper.dart';

class AdController extends GetxController {
  static AdController get instance => Get.find();

  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;

  final RxBool isBannerLoaded = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    loadBannerAd();
    super.onInit();
  }

  @override
  void onClose() {
    _bannerAd?.dispose();
    super.onClose();
  }

  Future<void> loadBannerAd() async {
    if (_bannerAd != null || isLoading.value) return;

    isLoading.value = true;

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          print('Banner ad loaded');
          isBannerLoaded.value = true;
          isLoading.value = false;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner ad failed to load: $error');
          ad.dispose();
          _bannerAd = null;
          isBannerLoaded.value = false;
          isLoading.value = false;
          update();
        },
        onAdOpened: (ad) => print('Banner ad opened'),
        onAdClosed: (ad) => print('Banner ad closed'),
      ),
    );

    try {
      await _bannerAd?.load();
    } catch (e) {
      print('Error loading banner ad: $e');
      _bannerAd = null;
      isBannerLoaded.value = false;
      isLoading.value = false;
      update();
    }
  }
}
