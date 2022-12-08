import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:new_trip_start/size_config.dart';

const kPrimaryColor = Color(0xFF0046AC);
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

late BuildContext globalContext;

const kRedColor = Color(0xFFF71515);

bool isDev = false;

List riderTotalBadges = [];

const mapApiKey = 'AIzaSyBH1ciOuOLVHKjgfaxLempr30PfblTdVEg';

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
