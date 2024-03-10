import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String email;
  bool isSubscribed;
  bool isFreeTrial;
  String subsDueDate;
  String subStartDate;
  User? user;

  UserModel({
    required this.email,
    required this.isSubscribed,
    required this.subsDueDate,
    required this.subStartDate,
    required this.isFreeTrial,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return UserModel(
        email: map['email'],
        isFreeTrial: map['isFreeTrial'],
        isSubscribed: map['isSubscribed'],
        subsDueDate: map['subsDueDate'],
        subStartDate: map['subStartDate'],
        user: map['user']);
  }
}
