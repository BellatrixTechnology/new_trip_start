import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/models/users.model.dart';
import 'package:new_trip_start/screens/tab_navigator/tabs.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/utils/email_validator.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthController extends GetxController {
  RxString view = 'LOGIN'.obs; //SIGN_UP

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  ///start forget password
  TextEditingController fPemailCtrl = TextEditingController();
  TextEditingController fPcodeCtrl = TextEditingController();
  TextEditingController fPpasswordCtrl = TextEditingController();
  var forgetPasswordViewCount = 1.obs;
  var isfPLoading = false.obs;
  var secretKey = "";

  ///end forget password

  var obscureText = true.obs;

  var isLoading = false.obs;
  var isSkipping = false.obs;

  onViewChange({String? newView}) {
    view = newView != null
        ? RxString(newView)
        : RxString(view.value == 'LOGIN' ? 'SIGN_UP' : 'LOGIN');
    update();
  }

  updateobscureText() {
    obscureText.toggle();
    update();
  }

  onSignUp(BuildContext context) async {
    if (isSkipping.isTrue || isLoading.isTrue) return;
    if (nameCtrl.text.isEmpty) {
      srvToastAlert.toast('Please enter your Full Name');

      // } else if (phoneNumber.text.isEmpty) {
      //   srvToastAlert.toast('Please enter your valid Phone Number');
    } else if (!EmailValidator()
        .isValidEmail(emailCtrl.text.isEmpty ? '' : emailCtrl.text)) {
      srvToastAlert.toast('Please enter valid Email Address');
    } else if (password.text.length < 6) {
      srvToastAlert.toast('Password must be larger than 6 characters');
    } else if (password.text != confirmPassword.text) {
      srvToastAlert.toast('Passwords are not matched');
    } else {
      try {
        updateLoader();
        var resp = await srvApi.post(concaturl: "register", data: {
          "email": emailCtrl.text.toLowerCase(),
          "password": password.text,
          "name": nameCtrl.text,
        });
        print("resp $resp");
        // updateLoader();
        if (resp.statusCode == 200) {
          if (resp.data['status'] == true) {
            goToOnBoarding(resp.data);
          } else {
            updateLoader();
            srvToastAlert
                .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
          }
        }
      } on DioException catch (e) {
        updateLoader();
        srvToastAlert.toast(e.message ?? "something_went_wrong_text".tr);

        print(e);
      }

      // srvFirebase.signUpWithEmailPass(emailCtrl.text, password.text, (resp) {
      //   if (resp != null) {
      //     UserCredential user = resp;
      //     srvFirebase.saveUserInFirestore(user.user!);
      //     user.user?.updateDisplayName(nameCtrl.text);
      //     srvPageRoute.goToNextAndRemoved(context, const OnBoarding());
      //   }
      // });
    }
  }

  onSignIn(BuildContext context) async {
    if (isSkipping.isTrue || isLoading.isTrue) return;
    if (!EmailValidator()
        .isValidEmail(emailCtrl.text.isEmpty ? '' : emailCtrl.text)) {
      srvToastAlert.toast('Please enter valid Email Address');
    } else if (password.text.length < 6) {
      srvToastAlert.toast('Password must be larger than 6 characters');
    } else {
      try {
        updateLoader();
        var resp = await srvApi.post(concaturl: "login", data: {
          "email": emailCtrl.text.toLowerCase(),
          "password": password.text,
        });
        print("resp -> $resp");
        // updateLoader();
        if (resp.statusCode == 200) {
          if (resp.data['status'] == true) {
            goToOnBoarding(resp.data);
          } else {
            updateLoader();
            srvToastAlert
                .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
          }
        } else {
          srvToastAlert
              .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
        }
      } on DioException catch (e) {
        var msg = e.message;
        if (e.response != null) {
          msg = e.response!.data['message'];
        }
        // print(e.error);
        // print(e.response);
        // print(e.me);
        updateLoader();
        srvToastAlert.toast(msg ?? "something_went_wrong_text".tr);
      }
    }
  }

  facebookLogin(BuildContext context) {
    if (isSkipping.isTrue || isLoading.isTrue) return;
    srvFirebase.signInWithFacebook().then((value) {
      print(value.user!);
      // srvFirebase.getUserFromFirestore(value.user!);
      // srvPageRoute.goToNextAndRemoved(context, const OnBoarding());
    }).catchError((e) {
      print(e);
    });
  }

  googleLogin(BuildContext context) {
    if (isSkipping.isTrue || isLoading.isTrue) return;
    try {
      srvFirebase.signInWithGoogle().then((value) async {
        if (value == null) {
          return;
          // srvToastAlert.toast("something_went_wrong_text".tr);
        }
        try {
          updateLoader();
          var resp = await srvApi.post(
              concaturl: "register",
              data: {"type": "google"},
              addHeaders: true,
              headers: {"x-token": value.idToken});
          srvShared.printWrapped("resp $resp");
          if (resp.data['status'] == true) {
            goToOnBoarding(resp.data);
            updateLoader();
          } else {
            updateLoader();
          }
        } on DioException catch (e) {
          srvShared.printWrapped(e.message ?? "something_went_wrong_text".tr);
        }
      });
    } on DioException catch (e) {
      updateLoader();
      var msg = e.message;
      if (e.response != null) {
        msg = e.response!.data['message'];
      }
      // print(e.error);
      // print(e.response);
      // print(e.me);
      updateLoader();
      srvToastAlert.toast(msg ?? "something_went_wrong_text".tr);
      print(e);
    }
  }

  appleLogin(BuildContext context) {
    if (isSkipping.isTrue || isLoading.isTrue) return;
    srvFirebase.signInWithApple().then((credential) async {
      log(credential.identityToken.toString());
      try {
        updateLoader();
        var resp = await srvApi.post(
            concaturl: "register",
            data: {"type": "apple"},
            addHeaders: true,
            headers: {"x-token": credential.identityToken});
        srvShared.printWrapped("resp $resp");
        if (resp.data['status'] == true) {
          goToOnBoarding(resp.data);
          updateLoader();
        } else {
          updateLoader();
        }
      } on DioException catch (e) {
        updateLoader();
        var msg = e.message;
        if (e.response != null) {
          msg = e.response!.data['message'];
        }
        // print(e.error);
        // print(e.response);
        // print(e.me);
        updateLoader();
        srvToastAlert.toast(msg ?? "something_went_wrong_text".tr);
      }
      // log(credential.authorizationCode);
      // log(credential.email.toString());
      // // log(credential.toString());
      // log(credential.userIdentifier.toString());
      // log(credential.identityToken.toString());

      // final signInWithAppleEndpoint = Uri(
      //   scheme: 'https',
      //   host: 'flutter-sign-in-with-apple-example.glitch.me',
      //   path: '/sign_in_with_apple',
      //   queryParameters: <String, String>{
      //     'code': credential.authorizationCode,
      //     if (credential.givenName != null) 'firstName': credential.givenName!,
      //     if (credential.familyName != null) 'lastName': credential.familyName!,
      //     'useBundleId': !kIsWeb && (Platform.isIOS || Platform.isMacOS)
      //         ? 'true'
      //         : 'false',
      //     if (credential.state != null) 'state': credential.state!,
      //   },
      // );
      // try {
      //   final session = await http.Client().post(
      //     signInWithAppleEndpoint,
      //   );

      //   // If we got this far, a session based on the Apple ID credential has been created in your system,
      //   // and you can now set this as the app's session
      //   // ignore: avoid_print
      //   print(session.body);
      // } catch (e) {
      //   print(e.toString());
      // }
      // print(value.user!);
      // srvFirebase.getUserFromFirestore(value.user!);
      // srvPageRoute.goToNextAndRemoved(context, const OnBoarding());
    });
  }

  goToOnBoarding(data) async {
    srvLocalStorage.setUser(data['data']);
    srvUser.initUser(NewUserModel.fromMap(data['data']));
    await srvRevenueCatSub.initPlatformState();
    srvToastAlert.toast(data['message']);
    Get.deleteAll();
    srvPageRoute.goNextWithGetxAndRemovedAll(const Tabs());
    updateLoader();
  }

  updateLoader() {
    isLoading.toggle();
    update();
  }

  updateSkipLoader(bool val) {
    isSkipping(val);
    update();
  }

  changeFPView({int count = 1}) {
    forgetPasswordViewCount.value = count;
    update();
  }

  handleRequest(BuildContext context) {
    if (forgetPasswordViewCount.value == 1) {
      forgetPasswordReq();
    }
    if (forgetPasswordViewCount.value == 2) {
      forgetPasswordVerifyCode();
    }
    if (forgetPasswordViewCount.value == 3) {
      forgetPasswordUpdatePassword(context);
    }
  }

  forgetPasswordReq() async {
    updatefPLoading(true);
    var resp = await srvApi
        .post(concaturl: "forgot-password", data: {"email": fPemailCtrl.text});
    log("resp of forgetPasswordReq $resp");
    updatefPLoading(false);
    if (resp.statusCode == 200) {
      if (resp.data['message'] != null) {
        srvToastAlert.toast(resp.data['message']);
        if (resp.data['message'].toString().toLowerCase() ==
            "Invalid Email".toLowerCase()) return;
        changeFPView(count: 2);
      } else {
        srvToastAlert
            .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
      }
    } else {
      srvToastAlert
          .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
    }
  }

  forgetPasswordVerifyCode() async {
    try {
      updatefPLoading(true);
      var resp = await srvApi.post(
        concaturl: "verify/forgot-password",
        data: {
          "email": fPemailCtrl.text,
          "code": fPcodeCtrl.text,
        },
      );
      updatefPLoading(false);
      if (resp.statusCode == 200) {
        if (resp.data['status'] == true) {
          secretKey = resp.data['data']['secret'];
          srvToastAlert.toast(resp.data['message']);
          changeFPView(count: 3);
        } else {
          srvToastAlert
              .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
        }
      } else {
        srvToastAlert
            .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
      }
    } on DioException catch (e) {
      updatefPLoading(false);
      srvToastAlert.toast(e.message ?? "something_went_wrong_text".tr);
    }
  }

  forgetPasswordUpdatePassword(BuildContext context) async {
    updatefPLoading(true);
    try {
      var resp = await srvApi.post(
        concaturl: "update-password",
        data: {"password": fPpasswordCtrl.text, "secret": secretKey},
      );
      srvShared.printWrapped(resp.toString());
      updatefPLoading(false);
      if (resp.statusCode == 200) {
        if (resp.data['status'] == true) {
          srvToastAlert.toast(resp.data['message']);
          // ignore: use_build_context_synchronously
          srvPageRoute.goBack(context);
        } else {
          srvToastAlert
              .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
        }
      } else {
        srvToastAlert
            .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
      }
    } on DioException catch (e) {
      srvToastAlert.toast(e.message ?? "something_went_wrong_text".tr);
    }
  }

  updatefPLoading(bool val) {
    isfPLoading.value = val;
    update();
  }

  onSkip() async {
    if (isSkipping.isTrue || isLoading.isTrue) return;
    String deviceId = await getDeviceInfo();
    try {
      updateSkipLoader(true);

      var resp = await srvApi.post(concaturl: "login/skip", data: {
        "uuid": deviceId,
      });
      print("resp of skip $resp");
      // updateLoader();
      if (resp.statusCode == 200) {
        if (resp.data['status'] == true) {
          goToOnBoarding(resp.data);
        } else {
          // updateLoader();
          srvToastAlert
              .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
        }
      } else {
        srvToastAlert
            .toast(resp.data['message'] ?? "something_went_wrong_text".tr);
      }
    } on DioException catch (e) {
      print("resp of skip $e");
      var msg = e.message;
      if (e.response != null) {
        msg = e.response!.data['message'];
      }
      // print(e.error);
      // print(e.response);
      // print(e.me);
      // updateLoader();
      srvToastAlert.toast(msg ?? "something_went_wrong_text".tr);
    } finally {
      updateSkipLoader(false);
    }
  }

  Future<String> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    return isAndroid ? allInfo['id'] : allInfo['identifierForVendor'];
  }

  resetFPViews() {
    changeFPView(count: 1);
    fPemailCtrl.clear();
    updatefPLoading(false);
  }
}
