import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String? regNum;
  final String? vehBrand;
  final String? vehFuelCmp;
  final String? vehLength;
  final String? vehWeight;
  final String? vehClass;
  final String? vehFuelType;
  final String? color;
  final int? createdAt;
  final int? updatedAt;
  final String? userId;
  final String? docId;
  final String? fuelTypeid;
  final String? vehicleGroup;

  Vehicle(
      {this.regNum,
      this.vehBrand,
      this.vehFuelCmp,
      this.vehLength,
      this.vehWeight,
      this.vehClass,
      this.vehFuelType,
      this.color,
      this.createdAt,
      this.updatedAt,
      this.docId,
      this.fuelTypeid,
      this.userId,
      this.vehicleGroup});

  factory Vehicle.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Vehicle(
        regNum: data?['regNum'],
        vehBrand: data?['vehBrand'],
        vehFuelCmp: data?['vehFuelCmp'],
        vehLength: data?['vehLength'],
        vehWeight: data?['vehWeight'],
        vehClass: data?['vehClass'],
        vehFuelType: data?['vehFuelType'],
        color: data?['color'],
        createdAt: data?['createdAt'],
        updatedAt: data?['updatedAt'],
        userId: data?['userId'],
        fuelTypeid: data?['fuelTypeid'],
        docId: snapshot.id,
        vehicleGroup: data?['vehicleGroup']);
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
    };
  }
}
