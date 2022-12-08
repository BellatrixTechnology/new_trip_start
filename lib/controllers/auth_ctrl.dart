import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/screens/onboarding/onboarding.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:new_trip_start/utils/email_validator.dart';

class AuthController extends GetxController {
  RxString view = 'LOGIN'.obs; //SIGN_UP

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  var obscureText = true.obs;

  var isLoading = false.obs;

  onViewChange() {
    view = RxString(view.value == 'LOGIN' ? 'SIGN_UP' : 'LOGIN');
    update();
  }

  updateobscureText() {
    obscureText.toggle();
    update();
  }

  onSignUp(BuildContext context) {
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
      srvFirebase.signUpWithEmailPass(emailCtrl.text, password.text, (resp) {
        if (resp != null) {
          UserCredential user = resp;
          user.user?.updateDisplayName(nameCtrl.text);
          srvPageRoute.goToNextAndRemoved(context, const OnBoarding());
        }
      });
    }
  }

  onSignIn(BuildContext context) {
    if (!EmailValidator()
        .isValidEmail(emailCtrl.text.isEmpty ? '' : emailCtrl.text)) {
      srvToastAlert.toast('Please enter valid Email Address');
    } else if (password.text.length < 6) {
      srvToastAlert.toast('Password must be larger than 6 characters');
    } else {
      srvFirebase.signInWithEmailPass(emailCtrl.text, password.text, (resp) {
        if (resp != null) {
          srvPageRoute.goToNextAndRemoved(context, const OnBoarding());
          // UserCredential user = resp;
          // user.user?.updateDisplayName(nameCtrl.text);

        } else {}
      });
    }
  }

  facebookLogin() {
    srvFirebase.signInWithFacebook();
  }

  googleLogin() {
    srvFirebase.signInWithGoogle();
  }

  appleLogin() {
    srvFirebase.signInWithApple().then((value) {
      print(value);
    });
  }

  updateLoader() {
    isLoading.toggle();
    update();
  }
}
