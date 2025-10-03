// // lib/widgets/banner_ad_widget.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:new_trip_start/controllers/ad_controller.dart';
// import 'package:new_trip_start/controllers/map_ctrl.dart';

// class BannerAdWidget extends StatelessWidget {
//   const BannerAdWidget({
//     super.key,
//     this.showOnError = false,
//     this.backgroundColor,
//     this.padding,
//   });

//   final bool showOnError;
//   final Color? backgroundColor;
//   final EdgeInsetsGeometry? padding;

//   @override
//   Widget build(BuildContext context) {
//     final MapController mapController = Get.find<MapController>();
//     return GetBuilder<AdController>(
//       builder: (controller) {
//         if (mapController.user.value.isSubscribe) {
//           return SizedBox();
//         }
//         if (!controller.isBannerLoaded.value || controller.bannerAd == null) {
//           return showOnError
//               ? SizedBox(
//                   height: AdSize.banner.height.toDouble(),
//                   child: const Center(
//                     child: Text('Ad not loaded'),
//                   ),
//                 )
//               : const SizedBox();
//         }

//         return Container(
//           color: backgroundColor,
//           padding: padding,
//           width: controller.bannerAd!.size.width.toDouble(),
//           height: controller.bannerAd!.size.height.toDouble(),
//           child: AdWidget(ad: controller.bannerAd!),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobBannerService {
  // Singleton pattern
  static final AdMobBannerService _instance = AdMobBannerService._internal();
  factory AdMobBannerService() => _instance;
  AdMobBannerService._internal();

  // Map to track created banners by their unique keys
  final Map<String, BannerAd> _bannerAds = {};

  // Create or retrieve a banner ad
  BannerAd getBannerAd({
    required String adUnitId,
    required String key,
    required AdSize size,
  }) {
    // If we already have a banner for this key, return it
    if (_bannerAds.containsKey(key)) {
      return _bannerAds[key]!;
    }

    // Otherwise create a new one
    final BannerAd bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          debugPrint('Ad loaded successfully: $key');
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Ad failed to load: $error');
          ad.dispose();
          _bannerAds.remove(key);
        },
        onAdClosed: (ad) {
          debugPrint('Ad closed');
          ad.dispose();
          _bannerAds.remove(key);
        },
      ),
    );

    // Load the ad
    bannerAd.load();

    // Cache the ad
    _bannerAds[key] = bannerAd;

    return bannerAd;
  }

  void disposeBanner(String key) {
    if (_bannerAds.containsKey(key)) {
      _bannerAds[key]!.dispose();
      _bannerAds.remove(key);
    }
  }

  void disposeAll() {
    for (var ad in _bannerAds.values) {
      ad.dispose();
    }
    _bannerAds.clear();
  }
}

class AdMobBannerWidget extends StatefulWidget {
  final String adUnitId;
  final String uniqueKey;
  final AdSize size;

  const AdMobBannerWidget({
    super.key,
    required this.adUnitId,
    required this.uniqueKey,
    this.size = AdSize.banner,
  });

  @override
  State<AdMobBannerWidget> createState() => _AdMobBannerWidgetState();
}

class _AdMobBannerWidgetState extends State<AdMobBannerWidget> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = AdMobBannerService().getBannerAd(
      adUnitId: widget.adUnitId,
      key: widget.uniqueKey,
      size: widget.size,
    );

    setState(() {
      _isAdLoaded = true;
    });
  }

  @override
  void dispose() {
    // We don't dispose the ad here, as it's managed by the service
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded) {
      return SizedBox(
        height: widget.size.height.toDouble(),
        width: widget.size.width.toDouble(),
      );
    }

    return SizedBox(
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd),
    );
  }
}
