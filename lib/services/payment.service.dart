// import 'package:flutter/foundation.dart';
// // import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
// import 'package:get/get.dart';
// import 'package:new_trip_start/controllers/subscription.controller.dart';
// import 'dart:async';

// import 'package:new_trip_start/services/index.dart';

class PaymentService {
  // SubscriptionController subscriptionController =
  //     Get.put(SubscriptionController());

  // /// We want singelton object of ``PaymentService`` so create private constructor
  // ///
  // /// Use PaymentService as ``PaymentService.instance``
  // // PaymentService._internal();

  // static final PaymentService instance = PaymentService.instance;

  // /// To listen the status of connection between app and the billing server
  // StreamSubscription<ConnectionResult?>? connectionSubscription;

  // ///
  // StreamSubscription<PurchasedItem?>? purchaseUpdatedSubscription;

  // /// To listen the errors of the purchase
  // StreamSubscription<PurchaseResult?>? purchaseErrorSubscription;

  // final List<String> productIds = [
  //   'bompengeappen_sub_id_1',
  //   'bompengeappen_sub_id_2'
  // ];

  // List<IAPItem> products = [];

  // /// All past purchases will be store in this list
  // List<PurchasedItem>? pastPurchases;

  // ObserverList<Function> proStatusChangedListeners = ObserverList<Function>();

  // /// view of the app will subscribe to this to get errors of the purchase
  // ObserverList<Function(String)> errorListeners =
  //     ObserverList<Function(String)>();

  // /// logged in user's premium status
  // bool isProUser = false;

  // bool get getisProUser => isProUser;

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   // String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.

  //   // prepare
  //   var result = await FlutterInappPurchase.instance.initialize();
  //   print('result: $result');

  //   // refresh items for android
  //   try {
  //     String msg = await FlutterInappPurchase.instance.consumeAll();
  //     print('consumeAllItems: $msg');
  //   } catch (err) {
  //     print('consumeAllItems error: $err');
  //   }

  //   connectionSubscription =
  //       FlutterInappPurchase.connectionUpdated.listen((connected) {
  //     print('connected: $connected');
  //   });

  //   purchaseUpdatedSubscription =
  //       FlutterInappPurchase.purchaseUpdated.listen((productItem) {
  //     // print('purchase-updated: $productItem');
  //     print('email: ${srvUser.user.email}');
  //     srvUser.user.isSubscribed = true;
  //     srvFirebase.updateUser({
  //       "isSubscribed": true,
  //       "productId": productItem!.productId,
  //       "transactionId": productItem.transactionId,
  //       "transactionDate": productItem.transactionDate,
  //     }).then((value) {
  //       subscriptionController.toggleLoader();
  //       srvToastAlert
  //           .toast("You are pro user now. enjoy the access of full app.");
  //       Get.close(0);
  //     });
  //   });

  //   purchaseErrorSubscription =
  //       FlutterInappPurchase.purchaseError.listen((purchaseError) {
  //     print('purchase-error: $purchaseError');
  //     srvToastAlert.alert(purchaseError!.message!);
  //     subscriptionController.toggleLoader();
  //   });

  //   getProduct();
  // }

  // void requestPurchase(IAPItem item) {
  //   subscriptionController.toggleLoader();
  //   FlutterInappPurchase.instance
  //       .requestPurchase(item.productId.toString())
  //       .then((value) {
  //     subscriptionController.toggleLoader();
  //     print("request purchase $value");
  //   }).catchError((e) {
  //     subscriptionController.toggleLoader();
  //     print("request purchase err $e");
  //   });
  // }

  // Future getProduct() async {
  //   List<IAPItem> items =
  //       await FlutterInappPurchase.instance.getProducts(productIds);
  //   // print('getProduct=> ${items.toString()}');
  //   for (var item in items) {
  //     products.add(item);
  //     // this. items.add(item);
  //   }
  //   // srvToastAlert.alert(products.toString());
  // }

  // Future getPurchases() async {
  //   List<PurchasedItem>? items =
  //       await FlutterInappPurchase.instance.getAvailablePurchases();
  //   for (var item in items!) {
  //     print('getPurchases=> ${item.toString()}');
  //   }
  // }

  // Future getPurchaseHistory() async {
  //   List<PurchasedItem>? items =
  //       await FlutterInappPurchase.instance.getPurchaseHistory();
  //   for (var item in items!) {
  //     print('getPurchaseHistory=> ${item.toString()}');
  //   }
  // }
}
