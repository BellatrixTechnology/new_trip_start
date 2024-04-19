import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
// import 'package:new_trip_start/models/users.model.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/screens/splash/splash.dart';
import 'package:new_trip_start/services/index.dart';

class FirebaseService {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  //auth module
  Future<UserCredential?> signInWithEmailPass(
      String email, String password, Function callback) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      callback(credential);
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        // callback('No user found for that email.');
        srvToastAlert.toast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        // callback('Wrong password provided for that user');
        srvToastAlert.toast(e.message!);
      }
      // return null;
    }
    callback(null);
    return null;
  }

  Future<UserCredential?> signUpWithEmailPass(
      String email, String password, Function callback) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      callback(credential);
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e);
      // if (e.code == 'weak-password') {
      //   // print('The password provided is too weak.');
      //   // callback('The password provided is too weak.');
      //   srvToastAlert.toast('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   // print('The account already exists for that email.');
      //   // callback('The account already exists for that email.');
      //   srvToastAlert.toast('The account already exists for that email.');
      // }
      srvToastAlert.toast(e.message!);
    } catch (e) {
      print(e);
    }
    callback(null);
    return null;
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    final credential =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);

    return credential;
  }

  Future<UserCredential> signInWithFacebook() async {
    print(1);
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    print(2);
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    print(3);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// manage vehicle data
  /// add, delete, edit

  Future addVehicle(data) async {
    return db.collection('cars').add(data).then((value) {
      print("value.id ${value.id}");
      return true;
    }).catchError((e) => srvToastAlert.alert(
        "Error while adding your vehicle, Please check your information or try again later\nThanks"));
  }

  getVehicles() async {
    var ref = db
        .collection('cars')
        .where("userId", isEqualTo: srvFirebase.auth.currentUser!.uid)
        .withConverter(
          fromFirestore: Vehicle.fromFirestore,
          toFirestore: (Vehicle city, _) => city.toFirestore(),
        );

    final docSnap = await ref.get();

    return docSnap;
  }

  Future deleteVehicle(String id) async {
    return await db.collection("cars").doc(id).delete();
  }

  Future updateVehicle(String id, data) async {
    return await db.collection("cars").doc(id).update(data);
  }

  toDouble(dynamic val) {
    if (val == null) return 0.0;
    return val.runtimeType == double ? val : double.parse(val.toString());
  }

  signout(BuildContext context) async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
    srvPageRoute.goToNextAndRemoved(context, const SplashScreen());
  }

  deleteAccount(BuildContext context) async {
    try {
      final providerData = auth.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await auth.currentUser!.reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await auth.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await auth.currentUser?.delete();

      // ignore: use_build_context_synchronously
      srvPageRoute.goToNextAndRemoved(context, const SplashScreen());
    } catch (e) {
      // Handle exceptions
      srvToastAlert.toast("Something went wrong while deleting your account");
    }
    // ignore: use_build_context_synchronously
  }

  saveUserInFirestore(User user) {
    Map<String, dynamic> u = {
      "email": user.email ?? user.providerData[0].uid,
      "isSubscribed": false,
      "isFreeTrial": false,
      "subsDueDate": "",
      "subStartDate": "",
    };
    db
        .collection("users")
        .doc(user.email ?? user.providerData[0].uid)
        .set(u)
        .then((value) {
      srvUser.initUser(user, u);
    });
  }

  Future getUserFromFirestore(User user) {
    print("user.providerData[0].uid ${user.providerData[0].uid}");
    return db
        .collection("users")
        .doc(user.email ?? user.providerData[0].uid)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> u = value.data() as Map<String, dynamic>;
        srvUser.initUser(user, u);
      } else {
        saveUserInFirestore(user);
      }
    });
  }

  Future updateUser(data) {
    return db.collection("users").doc(srvUser.user.email).update(data);
  }

  Future sendResetPasswordLink(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  User get getUser => FirebaseAuth.instance.currentUser!;

  addFeedBack({String feedback = "", double rating = 5, int index = 0}) {
    MapController mapController = Get.find<MapController>();
    db.collection("users_route_feedback").add({
      "feedback": feedback,
      "rating": rating,
      "startPosDesp": mapController.startPlace.name,
      "endPosDesp": mapController.endPlace.name,
      "startLatLng":
          "${mapController.startPlace.position!.lat}, ${mapController.startPlace.position!.lng}",
      "endLatLng":
          "${mapController.endPlace.position!.lat}, ${mapController.endPlace.position!.lng}",
      "routeName": mapController.routeData[index]['summary'],
      "userId": getUser.uid,
      "userName": srvUser.user.email,
    });
  }
}
