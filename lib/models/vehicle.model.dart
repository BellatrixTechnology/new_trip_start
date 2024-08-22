// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:new_trip_start/services/index.dart';

class Vehicle {
  final String? regNum;
  final String? vehBrand;
  final String? vehFuelCmp;
  final String? vehLength;
  final String? vehWeight;
  final String? vehClass;
  final String? vehFuelType;
  final String? color;
  final String? createdAt;
  final String? updatedAt;
  final String? userId;
  final String? docId;
  final String? fuelTypeid;
  final String? vehicleGroup;
  bool? isSelected;
  int? id;

  Vehicle({
    this.regNum,
    this.vehBrand,
    this.vehFuelCmp,
    this.vehLength,
    this.vehWeight,
    this.vehClass,
    this.vehFuelType,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.docId,
    this.fuelTypeid,
    this.vehicleGroup,
    this.isSelected,
    this.id,
  });

  // factory Vehicle.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();

  //   return Vehicle(
  //       regNum: data?['regNum'],
  //       vehBrand: data?['vehBrand'],
  //       vehFuelCmp: data?['vehFuelCmp'],
  //       vehLength: data?['vehLength'],
  //       vehWeight: data?['vehWeight'],
  //       vehClass: data?['vehClass'],
  //       vehFuelType: data?['vehFuelType'],
  //       color: data?['color'],
  //       createdAt: data?['createdAt'],
  //       updatedAt: data?['updatedAt'],
  //       userId: data?['userId'],
  //       fuelTypeid: data?['fuelTypeid'],
  //       docId: snapshot.id,
  //       vehicleGroup: data?['vehicleGroup'],
  //       isSelected: data?['isSelected']);
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'regNum': regNum,
      'vehBrand': vehBrand,
      'vehFuelCmp': vehFuelCmp,
      'vehLength': vehLength,
      'vehWeight': vehWeight,
      'vehClass': vehClass,
      'vehFuelType': vehFuelType,
      'color': color,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userId': userId,
      'docId': docId,
      'fuelTypeid': fuelTypeid,
      'vehicleGroup': vehicleGroup,
      'isSelected': isSelected,
      'id': id,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (regNum != null) "regNum": regNum,
      if (vehBrand != null) "vehBrand": vehBrand,
      if (vehFuelCmp != null) "vehFuelCmp": vehFuelCmp,
      if (vehLength != null) "vehLength": vehLength,
      if (vehWeight != null) "vehWeight": vehWeight,
      if (vehClass != null) "vehClass": vehClass,
      if (vehFuelType != null) "vehFuelType": vehFuelType,
      if (color != null) "color": color,
      if (createdAt != null) "createdAt": createdAt,
      if (updatedAt != null) "updatedAt": updatedAt,
      if (userId != null) "userId": userId,
      if (fuelTypeid != null) "fuelTypeid": fuelTypeid,
      if (vehicleGroup != null) "vehicleGroup": vehicleGroup,
      if (isSelected != null) "isSelected": isSelected
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        id: json['id'],
        regNum: json['regNum'],
        vehBrand: json['vehBrand'],
        vehFuelCmp: json['vehFuelCmp'],
        vehLength: json['vehLength'],
        vehWeight: json['vehWeight'],
        vehClass: json['vehClass'],
        vehFuelType: json['vehFuelType'],
        color: json['color'],
        createdAt: srvShared.createDate(json['createdAt']),
        updatedAt: srvShared.createDate(json['updatedAt']),
        // userId: json['userId'],
        fuelTypeid: json['fuelTypeid'] ?? json['fuelTypeId'].toString(),
        vehicleGroup: json['vehicleGroup'] ?? json['vehGroup'],
        isSelected: json['isSelected']);
  }
}
