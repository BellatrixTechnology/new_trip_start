import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_trip_start/size_config.dart';
import 'package:new_trip_start/config/env_config.dart';

const kPrimaryColor = Color(0xFF0046AC);
const kPrimaryColorLight = Color(0xFF2273B7);
const kPrimaryYellowColor = Color(0xFFFBA808);
const kPrimaryLightColor = Color(0xFFFFFFFF);
const kBgLightColor = Color(0xFFFFFFFF);
const kPrimaryButtonTextColor = Color(0xFF1AAD8F);
const kUnSelectedTbbarColor = Color(0xFFC7CFDC);
const kScaffoldBgColor = Color(0xFFF0F0F0);
const kGreenColor = Color(0xFF35C600);
// const kDarkGreenColor = Color(0xFF3C7E40);
const kBoxColor = Color(0xFFEAEAEA);
const kPlaceholderColor = Color(0xFFc1c9d6);

const kPurpleColor = Color(0xFF463D8F);
const kDarkGreenColor = Color(0xFF008970);
const kMaroonColor = Color(0xFF933D63);
const kBlueColor = Color(0xFF3D84F8);
const kfrozyColor = Color(0xFF33599f);
const k51Color = Color(0xFF515050);

late BuildContext globalContext;

const kRedColor = Color(0xFFF71515);

bool isDev = false;

List riderTotalBadges = [];

// API keys are now loaded from environment variables
String get hereApiKey => EnvConfig.hereApiKey;
String get mapApiKey => EnvConfig.googleMapsApiKey;

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  tileMode: TileMode.decal,
  colors: [
    // Color.fromARGB(50, 0, 69, 172),
    Color.fromARGB(50, 142, 183, 244),
    Color(0xFFF5F5F5),
    Color(0xFFF5F5F5),
    Color(0xFFF5F5F5),
    Color.fromARGB(50, 142, 183, 244),
    // Color(0xFF0046ac),
  ],
);

const kPrimaryBottomGradientColor = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  tileMode: TileMode.decal,
  colors: [
    // Color.fromARGB(50, 0, 69, 172),
    // Color.fromARGB(150, 142, 183, 244),
    Color(0xFFF5F5F5),
    Color(0xFFF5F5F5),
    Color(0xFFF5F5F5),
    Color.fromARGB(0, 142, 183, 244),
    // Color(0xFF0046ac),
  ],
);

const kButtonGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.decal,
  colors: [
    Color(0xFF149BD7),
    Color(0xFF2F4D99),
    // Color(0xFF0046ac),
  ],
);
const kDisableGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.decal,
  colors: [
    Color(0xFFD9D9D9),
    Color(0xFFD9D9D9),
    // Color(0xFF0046ac),
  ],
);

const gPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  tileMode: TileMode.clamp,
  colors: [Color(0xFFd9d9d9), Color(0xFFd9d9d9)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF59636B);
const kBlackColor = Colors.black;
const kInputBg = Color(0xFFF9F9F9);

const kAnimationDuration = Duration(milliseconds: 200);

var contactUsLink = '';

double commissionValue = 20;

const headingStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: kPrimaryLightColor,
  height: 1.5,
);

List<BoxShadow> boxShadow([double? opacity, double? spreadRadius]) {
  return [
    BoxShadow(
      color: Colors.grey.withOpacity(opacity ?? 0.6),
      spreadRadius: spreadRadius ?? 0,
      blurRadius: 8,
      offset: const Offset(0, 3),
    )
  ];
}

const defaultDuration = Duration(milliseconds: 250);
final isAndroid = Platform.isAndroid ? true : false;
// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

// final otpInputDecoration = InputDecoration(
//     contentPadding:
//         EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//     border: underlineInputBorder(),
//     focusedBorder: underlineInputBorder(),
//     enabledBorder: underlineInputBorder(),

//     hintStyle: const TextStyle(
//         fontSize: 12, color: kSecondaryColor, fontFamily: 'Avenir'));

InputDecoration underlineInputBorder(String hintText) {
  return InputDecoration(
      contentPadding:
          EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
      border: const UnderlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor)),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kSecondaryColor),
      ),
      // focusedBorder: const UnderlineInputBorder(
      //   borderSide: BorderSide(color: kPrimaryColor),
      // ),
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: 12, color: kSecondaryColor, fontFamily: 'Avenir'));
}

InputDecoration opacityInputBorder(String hintText,
    [Color? fillColor, double? borderRadius]) {
  return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: fillColor ?? Colors.white24,
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: 12, color: kSecondaryColor, fontFamily: 'Avenir'));
}

String countryCurrency = "RM ";

// markers

const kstartMarker =
    '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="16" cy="16" r="16" fill="#0046AC" fill-opacity="0.3"/><circle cx="16" cy="16" r="10" fill="#0046AC"/></svg>';
const kendMarker =
    '<svg fill="#0046AC" height="800px" width="800px" version="1.1" id="Filled_Icons" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve"><g id="Location-Pin-Filled"><path d="M12,1c-4.97,0-9,4.03-9,9c0,6.75,9,13,9,13s9-6.25,9-13C21,5.03,16.97,1,12,1z M12,13c-1.66,0-3-1.34-3-3s1.34-3,3-3 s3,1.34,3,3S13.66,13,12,13z"/></g></svg>';
const ktollMarker =
    '<svg width="50" height="50" viewBox="0 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg"><linearGradient id="paint0_linear_302_20" x1="25" y1="0" x2="25" y2="50" gradientUnits="userSpaceOnUse"><stop stop-color="#149BD7"/><stop offset="1" stop-color="#2F4D99"/></linearGradient><path d="M0 9.09091C0 4.07014 4.07014 0 9.09091 0H40.9091C45.9299 0 50 4.07014 50 9.09091V40.9091C50 45.9299 45.9299 50 40.9091 50H9.09091C4.07014 50 0 45.9299 0 40.9091V9.09091Z" fill="url(#paint0_linear_302_20)"/><path d="M43.1818 25C43.1818 35.0415 35.0415 43.1818 25 43.1818C14.9585 43.1818 6.81818 35.0415 6.81818 25C6.81818 14.9585 14.9585 6.81818 25 6.81818C35.0415 6.81818 43.1818 14.9585 43.1818 25Z" fill="white"/><path d="M24.8545 31.8182L21.0182 25.6727L19.2727 27.8V31.8182H17.2909V19.0909H19.2727V25.1636L24.1455 19.0909H26.4545L22.3273 24.1091L27.0364 31.8182H24.8545Z" fill="#0146AB"/><path d="M28.3649 24.9455C28.3649 23.9152 28.3467 23.1758 28.3104 22.7273H30.0013C30.0498 23.2121 30.074 23.7455 30.074 24.3273V24.5091H30.1285C30.371 23.8909 30.7528 23.4121 31.274 23.0727C31.8073 22.7212 32.4316 22.5455 33.1467 22.5455C33.3407 22.5455 33.5164 22.5636 33.674 22.6V24.0545C33.5892 24.0303 33.4013 24.0182 33.1104 24.0182C32.577 24.0182 32.0801 24.1758 31.6195 24.4909C31.171 24.7939 30.8134 25.2121 30.5467 25.7455C30.2922 26.2667 30.1649 26.8424 30.1649 27.4727V31.8182H28.3649V24.9455Z" fill="#0146AB"/><defs></defs></svg>';

const url =
    "https://nvdbapiles-v3.atlas.vegvesen.no/vegobjekter/45?inkluder=alle";

const privacyPolicy =
    "https://bellatrixtechnology.github.io/new_trip_start/privacy-policy/";

//lottiee json path
const travelIsFun = "assets/lottie-jsons/42070-travel-is-fun.json";

const subsIllustrations = "assets/illustrations/subs-illustration.png";

const subLockIcon = "assets/icons/subsScreenIcons/lock.png";
const subBellIcon = "assets/icons/subsScreenIcons/bell.png";
const subStarIcon = "assets/icons/subsScreenIcons/star.png";
const subIconCheckIcon = "assets/icons/subsScreenIcons/check.png";
const subValuedOfferIcon = "assets/icons/subsScreenIcons/valued_offer.png";
