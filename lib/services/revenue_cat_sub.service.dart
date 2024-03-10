import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/subscription.controller.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;

class RevenueCatSubscriptionService {
  List<Package> products = [];
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.debug);

    late PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_xWnMHLurRswibDxunfFUkafpoDj");
      // if (buildingForAmazon) {
      //   // use your preferred way to determine if this build is for Amazon store
      //   // checkout our MagicWeather sample for a suggestion
      //   configuration = AmazonConfiguration(<public_amazon_api_key>);
      // }
    } else if (Platform.isIOS) {
      configuration =
          PurchasesConfiguration("appl_hUPXcbRjXVrdFEJxvmtgbfcPQwL");
    }
    await Purchases.configure(configuration);
    getOffers();
    checkSubStatus();
  }

  getOffers() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        products = offerings.current!.availablePackages;

        // Display packages for sale
      }
    } on PlatformException catch (e) {
      // optional error handling

      // ignore: avoid_print
      print(e);
    }
  }

  buy(Package pkg) async {
    try {
      subscriptionController.toggleLoader(true);
      Purchases.purchasePackage(pkg).then((purchaserInfo) {
        EntitlementInfo? data = purchaserInfo.entitlements.all['Pro'];
        if (data == null) return;
        if (data.isActive) {
          srvUser.user.isSubscribed = true;
          srvFirebase.updateUser({
            "isSubscribed": true,
            "productId": data.productIdentifier,
            "originalPurchaseDate": data.originalPurchaseDate,
            "latestPurchaseDate": data.latestPurchaseDate,
          }).then((value) {
            subscriptionController.toggleLoader(false, true);
            srvToastAlert
                .toast("You are pro user now. enjoy the access of full app.");
            Get.close(0);
          });
          // Unlock that great "pro" content
        }
      }).catchError((e) {
        subscriptionController.toggleLoader(false, true);
        srvToastAlert.toast(e.message!);
      });
    } on PlatformException catch (e) {
      subscriptionController.toggleLoader(false, true);
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      srvToastAlert.toast(e.message!);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        // showError(e);
      }
    }
  }

  checkSubStatus() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      onPurchaseDone(customerInfo);
      // access latest customerInfo
    } on PlatformException catch (e) {
      // Error fetching customer info
      // ignore: avoid_print
      print("customerInfo err --> $e");
    }
  }

  Package getYearly() => products.firstWhere((element) =>
      element.storeProduct.identifier ==
      (isAndroid
          ? "bompengeappen_sub_id_2:yearly-base-id-2"
          : "bompengeappen_sub_id_2"));

  Package getMonthly() => products.firstWhere((element) =>
      element.storeProduct.identifier ==
      (isAndroid
          ? "bompengeappen_sub_id_1:monthly-base-id-1"
          : "bompengeappen_sub_id_1"));

  restorePurchase() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      Map<String, EntitlementInfo> data = customerInfo.entitlements.all;
      srvUser.user.isSubscribed = true;
      srvFirebase.updateUser({
        "isSubscribed": true,
        "productId": data['productIdentifier'],
        "originalPurchaseDate": data['originalPurchaseDate'],
        "latestPurchaseDate": data['latestPurchaseDate'],
      }).then((value) {
        subscriptionController.toggleLoader(false, true);
        srvToastAlert.toast("Your purcahase has been restored successfully.");
        Get.close(0);
      });
    } catch (e) {
      // ignore: avoid_print
      print("restore error == > $e");
    }
  }

  onPurchaseDone(CustomerInfo customerInfo, [bool shouldGoBack = false]) {
    EntitlementInfo? data =
        customerInfo.entitlements.all["my_entitlement_identifier"];
    if (data == null) return;
    srvUser.user.isSubscribed = true;
    srvFirebase.updateUser({
      "isSubscribed": true,
      "productId": data.productIdentifier,
      "originalPurchaseDate": data.originalPurchaseDate,
      "latestPurchaseDate": data.latestPurchaseDate,
    }).then((value) {
      if (shouldGoBack == true) {
        subscriptionController.toggleLoader(false, true);
        srvToastAlert
            .toast("You are pro user now. enjoy the access of full app.");
        Get.close(0);
      }
    });
  }
}
