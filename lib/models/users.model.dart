// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:new_trip_start/services/index.dart';

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

class NewUserModel {
  int id;
  String email;
  String token;
  String? expiry;
  String dt;
  // String udt;
  // int count;
  // int limit;
  // String status;
  String name;
  bool verified;
  // String? verificationToken;
  // String? loginType;
  String? subscriptionId;
  bool isSubscribe;
  String? subscribtionDate;
  String? subscriptionValidty;
  String? subscriptionType;
  int? apiCount;
  String? loginType;
  Map<String, dynamic>? config;

  NewUserModel(
      {
      // this.verificationToken,
      // this.loginType,
      required this.id,
      required this.email,
      required this.token,
      this.expiry,
      required this.dt,
      required this.name,
      required this.verified,
      this.subscriptionId,
      required this.isSubscribe,
      this.subscribtionDate,
      this.subscriptionValidty,
      this.subscriptionType,
      this.apiCount,
      this.loginType,
      this.config});

  NewUserModel copyWith(
      {int? id,
      String? email,
      String? token,
      String? expiry,
      String? dt,
      String? name,
      bool? verified,
      String? subscriptionId,
      bool? isSubscribe,
      String? subscribtionDate,
      String? subscriptionValidty,
      String? subscriptionType,
      int? apiCount,
      String? loginType,
      Map<String, dynamic>? config}) {
    return NewUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      expiry: expiry ?? this.expiry,
      dt: dt ?? this.dt,
      name: name ?? this.name,
      verified: verified ?? this.verified,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      isSubscribe: isSubscribe ?? this.isSubscribe,
      subscribtionDate: subscribtionDate ?? this.subscribtionDate,
      subscriptionValidty: subscriptionValidty ?? this.subscriptionValidty,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      apiCount: apiCount ?? this.apiCount,
      loginType: loginType ?? this.loginType,
      config: config ?? this.config,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'token': token,
      'expiry': expiry,
      'dt': dt,
      // 'udt': udt,
      // 'count': count,
      // 'limit': limit,
      // 'status': status,
      'name': name,
      'verified': verified,
      'apiCount': apiCount,
      // 'verification_token': verificationToken,
      'loginType': loginType,
    };
  }

  factory NewUserModel.fromMap(Map<String, dynamic> map) {
    print(map['is_subscribe']);
    return NewUserModel(
        id: map['id'] as int,
        email: map['email'] as String,
        token: map['token'] as String,
        expiry: map['expiry'] != null ? map['expiry'] as String : null,
        dt: srvShared.createDate(map['dt']),
        name: map['name'] as String,
        verified: map['verified'] as bool,
        isSubscribe: map['is_subscribe'] ?? false,
        subscribtionDate: map['subscribtion_date'] ?? "",
        subscriptionValidty: map['subscription_validty'] ?? "",
        subscriptionType: map['subscription_type'] ?? "",
        apiCount: map['api_count'] ?? 0,
        loginType: map['login_type'] ?? "",
        config: map['config'] ?? {});
  }

  String toJson() => json.encode(toMap());

  factory NewUserModel.fromJson(String source) =>
      NewUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewUserModel(id: $id, email: $email, token: $token, expiry: $expiry, dt: $dt, name: $name, verified: $verified,)';
  }

  @override
  bool operator ==(covariant NewUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.token == token &&
        other.expiry == expiry &&
        other.dt == dt &&
        // other.udt == udt &&
        // other.count == count &&
        // other.limit == limit &&
        // other.status == status &&
        other.name == name &&
        other.verified == verified;
    // &&
    // other.verificationToken == verificationToken &&
    // other.loginType == loginType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        token.hashCode ^
        expiry.hashCode ^
        dt.hashCode ^
        // udt.hashCode ^
        // count.hashCode ^
        // limit.hashCode ^
        // status.hashCode ^
        name.hashCode ^
        verified.hashCode;
    // verificationToken.hashCode ^
    // loginType.hashCode;
  }
}
