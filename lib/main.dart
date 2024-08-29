import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/constants.dart';
// import 'package:here_sdk/core.dart';
// import 'package:here_sdk/core.engine.dart';
// import 'package:here_sdk/core.errors.dart';
import 'package:new_trip_start/controllers/add_vehicle.controller.dart';
import 'package:new_trip_start/controllers/auth_ctrl.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/controllers/onboarding_ctrl.dart';
import 'package:new_trip_start/controllers/places.controller.dart';
import 'package:new_trip_start/controllers/route_detail.controller.dart';
import 'package:new_trip_start/controllers/subscription.controller.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/firebase_options.dart';
import 'package:new_trip_start/screens/splash/splash.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/utils/translations/translations.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';

// import 'package:device_preview/device_preview.dart';

// import 'package:purchases_flutter/purchases_flutter.dart';

// final configuration =
//     PurchasesConfiguration("appl_hUPXcbRjXVrdFEJxvmtgbfcPQwL");

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => MapController());
  Get.lazyPut(() => AddVehicleCtrl());
  Get.lazyPut(() => OnBoardingController());
  Get.lazyPut(() => PlaceController());
  Get.lazyPut(() => RouteDetailCtrl());
  Get.lazyPut(() => BottomTabController());
  Get.lazyPut(() => SubscriptionController());
  WidgetsFlutterBinding.ensureInitialized();

  // final config = QonversionConfigBuilder('UXhA__7E9XnhUW7nf6YwjGAUZae260Zc',
  //         QLaunchMode.subscriptionManagement)
  //     .build();
  // Qonversion.initialize(config);

  // await Purchases.configure(configuration);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(), // Wrap your app
  // );
}

// void initializeHERESDK() async {
//   // Needs to be called before accessing SDKOptions to load necessary libraries.
//   SdkContext.init(IsolateOrigin.main);

//   // Set your credentials for the HERE SDK.
//   String accessKeyId = "wtwzmWpiLelM_6syxvMqFQ";
//   String accessKeySecret =
//       "b7WrYeLusbcUzJNJcmp_aGvBlZmmmR7vB18otH5J9Sn0ybOT_IZpMNKQeND9QUpeHAHH2F8CipHCPMblacg6dw";
//   SDKOptions sdkOptions =
//       SDKOptions.withAccessKeySecret(accessKeyId, accessKeySecret);

//   try {
//     await SDKNativeEngine.makeSharedInstance(sdkOptions);
//   } on InstantiationException {
//     throw Exception("Failed to initialize the HERE SDK.");
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterUxcam
        .optIntoSchematicRecordings(); // Confirm that you have user permission for screen recording
    FlutterUxConfig config = FlutterUxConfig(
        userAppKey: "jfjftjbnbna61dz", enableAutomaticScreenNameTagging: false);
    FlutterUxcam.startWithConfiguration(config);
    return GetMaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        navigatorObservers: [srvAnalytics.getAnalyticsObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Trip Start',
        translations: AppTranslations(),
        locale: Get.deviceLocale, //const Locale("en", "US"),
        fallbackLocale: const Locale("en", "US"),
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: kPrimaryColor,
              selectionColor: kPrimaryColor,
              selectionHandleColor: kPrimaryColor,
            ),
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: kBgLightColor)),
            colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
            fontFamily: 'Sarabun'),
        home:
            const SplashScreen() //const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
