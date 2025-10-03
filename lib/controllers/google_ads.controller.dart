import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/services/index.dart';

class GoogleAdsController extends GetxController {
  var isBannerShown = false.obs;
  var isNativeShown = false.obs;

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  NativeAd? nativeAd;

  MapController mapCtrl = Get.put(MapController());

  updateIsBannerShown(bool value, BannerAd ad) {
    isBannerShown.value = value;
    bannerAd = ad;
    update();
  }

  updateIsNativeShown(bool value, NativeAd ad) {
    isNativeShown.value = value;
    nativeAd = ad;
    update();
  }

  showInterstitialAd(InterstitialAd ad) {
    interstitialAd = ad;
    Future.delayed(kAnimationDuration, () {
      interstitialAd!.show();
    });
  }

  void loadRewardedAd() {
    if (rewardedAd != null) return; // Don't load if we already have an ad

    srvAdmob.loadRewardAd(isFromInnerApp: false);
  }

  showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
        print(ad.onPaidEvent);
        print(ad.adUnitId);
        print(rewardItem.amount);
        print(rewardItem.type);
        rewardedAd = null;
        srvUser.user.apiCount = (srvUser.user.apiCount ?? 0) + 1;
        mapCtrl.updateApiCount(srvUser.user.apiCount!);
        print("api_count_updated_succesffuly -> ${srvUser.user.apiCount}");
        var resp = await srvApi.get(
            concaturl:
                "api-count?user=${srvUser.user.id}&count=${srvUser.user.apiCount}");
        print("api-count resp -> $resp");
        if (resp.statusCode == 200) {
          if (resp.data['status'] == true) {
            srvToastAlert.toast("api_count_updated_succesffuly".tr);
          }
        }
      });
    } else {
      srvAdmob.loadRewardAd(isFromInnerApp: true);
    }
  }
}
