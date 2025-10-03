// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:new_trip_start/components/app_text.dart';
// import 'package:new_trip_start/controllers/google_ads.controller.dart';
// import 'package:new_trip_start/controllers/map_ctrl.dart';
// import 'package:new_trip_start/services/index.dart';

// class NativeAdComponent extends StatefulWidget {
//   const NativeAdComponent({super.key});

//   @override
//   State<NativeAdComponent> createState() => _NativeAdComponentState();
// }

// class _NativeAdComponentState extends State<NativeAdComponent> {
//   final googleAdsController = Get.find<GoogleAdsController>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(covariant NativeAdComponent oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     srvAdmob.loadNativeAd();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MapController>(builder: (mapCtrl) {
//       if (mapCtrl.user.value.isSubscribe) return SizedBox();

//       return Obx(() => googleAdsController.isNativeShown.isTrue
//           ? googleAdsController.nativeAd == null
//               ? AppText(text: googleAdsController.nativeAd.toString())
//               : Container(
//                   margin: EdgeInsets.only(top: 20),
//                   constraints: const BoxConstraints(
//                     minWidth: 320, // minimum recommended width
//                     minHeight: 90, // minimum recommended height
//                     maxWidth: 400,
//                     maxHeight: 200,
//                   ),
//                   child: AdWidget(
//                       key: UniqueKey(), ad: googleAdsController.nativeAd!),
//                 )
//           : SizedBox());
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdService {
  // Singleton pattern
  static final NativeAdService _instance = NativeAdService._internal();
  factory NativeAdService() => _instance;
  NativeAdService._internal();

  // Map to track created native ads by their unique keys
  final Map<String, NativeAd> _nativeAds = {};

  // Create or retrieve a native ad
  NativeAd getNativeAd({
    required String adUnitId,
    required String key,
    required String factoryId,
    NativeAdOptions? nativeAdOptions,
    required Function(NativeAd ad) onAdLoaded,
    Function(Ad ad, LoadAdError error)? onAdFailedToLoad,
  }) {
    // If we already have a native ad for this key, return it
    if (_nativeAds.containsKey(key)) {
      return _nativeAds[key]!;
    }

    // Otherwise create a new one
    final NativeAd nativeAd = NativeAd(
      adUnitId: adUnitId,
      factoryId: factoryId, // This is the crucial missing parameter
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('Native ad loaded successfully: $key');
          _nativeAds[key] = ad as NativeAd;
          onAdLoaded(ad as NativeAd);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Native ad failed to load: $error');
          ad.dispose();
          _nativeAds.remove(key);
          if (onAdFailedToLoad != null) {
            onAdFailedToLoad(ad, error);
          }
        },
        onAdClosed: (ad) {
          debugPrint('Native ad closed');
          ad.dispose();
          _nativeAds.remove(key);
        },
      ),
      request: const AdRequest(),
      nativeAdOptions: nativeAdOptions,
    );

    // Load the ad
    nativeAd.load();

    return nativeAd;
  }

  void disposeNativeAd(String key) {
    if (_nativeAds.containsKey(key)) {
      _nativeAds[key]!.dispose();
      _nativeAds.remove(key);
    }
  }

  void disposeAll() {
    for (var ad in _nativeAds.values) {
      ad.dispose();
    }
    _nativeAds.clear();
  }
}

class NativeAdWidget extends StatefulWidget {
  final String adUnitId;
  final String uniqueKey;
  final String factoryId; // Added required factoryId parameter
  final NativeAdOptions? nativeAdOptions;
  final Widget Function(NativeAd ad) adBuilder;
  final Widget loadingWidget;
  final Widget errorWidget;

  const NativeAdWidget({
    Key? key,
    required this.adUnitId,
    required this.uniqueKey,
    required this.factoryId, // Required parameter
    required this.adBuilder,
    this.nativeAdOptions,
    this.loadingWidget = const SizedBox(height: 250),
    this.errorWidget = const SizedBox(height: 250),
  }) : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;
  bool _isAdLoadFailed = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    final options = widget.nativeAdOptions ??
        NativeAdOptions(
          adChoicesPlacement: AdChoicesPlacement.topRightCorner,
          mediaAspectRatio: MediaAspectRatio.landscape,
        );

    _nativeAd = NativeAdService().getNativeAd(
      adUnitId: widget.adUnitId,
      key: widget.uniqueKey,
      factoryId: widget.factoryId, // Pass the factoryId
      nativeAdOptions: options,
      onAdLoaded: (ad) {
        if (mounted) {
          setState(() {
            _nativeAd = ad;
            _isAdLoaded = true;
          });
        }
      },
      onAdFailedToLoad: (ad, error) {
        if (mounted) {
          setState(() {
            _isAdLoadFailed = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    // We don't dispose the ad here, as it's managed by the service
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoadFailed) {
      return widget.errorWidget;
    }

    if (!_isAdLoaded || _nativeAd == null) {
      return widget.loadingWidget;
    }

    return widget.adBuilder(_nativeAd!);
  }
}
