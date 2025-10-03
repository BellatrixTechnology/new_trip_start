import 'package:tiktok_events_sdk/tiktok_events_sdk.dart';

class TikTokService {
  init() async {
    await TikTokEventsSdk.initSdk(
      androidAppId:
          '7546831357519970305', // Ads Manager → Android App card ka numeric ID
      tikTokAndroidId:
          'com.kadodata.journeycost', // Tumhara Android package name
      iosAppId: '1572605386', // iOS App ID (Events Manager → iOS card)
      tiktokIosId:
          '7546831357519921153', // iOS App ID (Events Manager → iOS card)
      isDebugMode: true,
      logLevel: TikTokLogLevel.info,
    );

    startTrack();
  }

  static startTrack() async {
    await TikTokEventsSdk.startTrack();
  }

  static identify() async {
    final identier = TikTokIdentifier(
      externalId: 'externalId',
      externalUserName: "externalUserName",
      phoneNumber: "phoneNumber",
      email: "email",
    );
    await TikTokEventsSdk.identify(
      identifier: identier,
    );
  }

  static logout() async {
    await TikTokEventsSdk.logout();
  }

  static logEvent() async {
    await TikTokEventsSdk.logEvent(
      event: TikTokEvent(
        eventName: 'eventName',
      ),
    );
  }
}
