import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
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
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        // callback('No user found for that email.');
        srvToastAlert.toast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        // callback('Wrong password provided for that user');
        srvToastAlert.toast('Wrong password provided for that user');
      }
    }
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
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        // callback('The password provided is too weak.');
        srvToastAlert.toast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        // callback('The account already exists for that email.');
        srvToastAlert.toast('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    final credential =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);
    return credential;
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

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
      return true;
    }).catchError((e) {
      srvToastAlert.alert(
          "Error while adding your vehicle, Please check your information or try again later\nThanks");
    });
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
}
