// Copyright (c) 2018-2022 HERE Global B.V. and its affiliate(s).
// All rights reserved.
//
// This software and other materials contain proprietary information
// controlled by HERE and are protected by applicable copyright legislation.
// Any use and utilization of this software and other materials and
// disclosure to any third parties is conditional upon having a separate
// agreement with HERE for the access, use, utilization or disclosure of this
// software. In the absence of such agreement, the use of the software is not
// allowed.
//

import 'dart:ffi';
import 'package:here_sdk/src/_library_context.dart' as __lib;
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/sdk/search/ev_charging_point_experimental.dart';
import 'package:here_sdk/src/sdk/search/ev_name_id_experimental.dart';

/// @nodoc

class EvConnectorExperimental {
  /// The EV charge point operator
  String? supplierName;

  /// Id and name element pair representing the connector type in the EV pool group.
  /// For more information on the current connector types, see
  /// https://developer.here.com/documentation/charging-stations/dev_guide/topics/resource-type-connector-types.html
  /// values in the HERE EV Charge Points API.
  EvNameIdExperimental? connectorType;

  /// Details on type of power feed with respect to SAE J1772
  /// https://en.wikipedia.org/wiki/SAE_J1772#Charging standard.
  EvNameIdExperimental? powerFeedType;

  /// INTERNAL: Charge capacity of the connector.
  String? chargeCapacity;

  /// INTERNAL: Boolean indicating whether a cable is provided for the connector.
  /// If true, then there is a cable for the connector at the station.
  bool? fixedCable;

  /// Maximum charge power (in kilowatt) of connectors in connectors group.
  double? maxPowerLevel;

  /// Connectors group additional charging information
  EvChargingPointExperimental? chargingPoint;

  /// INTERNAL: Information about when the facility information was last updated, in ISO 8601 format.
  /// If the time is UTC, a Z is added. If the time is not UTC, then the offset is added as a ±hh:mm value
  /// (for example, 2014-01-14T10:00:00.000+0100).'
  /// example: 2013-12-31T12:00:00.000Z
  String? lastUpdateTimestamp;

  EvConnectorExperimental(this.supplierName, this.connectorType, this.powerFeedType, this.chargeCapacity, this.fixedCable, this.maxPowerLevel, this.chargingPoint, this.lastUpdateTimestamp);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EvConnectorExperimental) return false;
    EvConnectorExperimental _other = other;
    return supplierName == _other.supplierName &&
        connectorType == _other.connectorType &&
        powerFeedType == _other.powerFeedType &&
        chargeCapacity == _other.chargeCapacity &&
        fixedCable == _other.fixedCable &&
        maxPowerLevel == _other.maxPowerLevel &&
        chargingPoint == _other.chargingPoint &&
        lastUpdateTimestamp == _other.lastUpdateTimestamp;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + supplierName.hashCode;
    result = 31 * result + connectorType.hashCode;
    result = 31 * result + powerFeedType.hashCode;
    result = 31 * result + chargeCapacity.hashCode;
    result = 31 * result + fixedCable.hashCode;
    result = 31 * result + maxPowerLevel.hashCode;
    result = 31 * result + chargingPoint.hashCode;
    result = 31 * result + lastUpdateTimestamp.hashCode;
    return result;
  }
}


// EvConnectorExperimental "private" section, not exported.

final _sdkSearchEvconnectorexperimentalCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_create_handle'));
final _sdkSearchEvconnectorexperimentalReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_release_handle'));
final _sdkSearchEvconnectorexperimentalGetFieldsupplierName = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_supplierName'));
final _sdkSearchEvconnectorexperimentalGetFieldconnectorType = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_connectorType'));
final _sdkSearchEvconnectorexperimentalGetFieldpowerFeedType = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_powerFeedType'));
final _sdkSearchEvconnectorexperimentalGetFieldchargeCapacity = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_chargeCapacity'));
final _sdkSearchEvconnectorexperimentalGetFieldfixedCable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_fixedCable'));
final _sdkSearchEvconnectorexperimentalGetFieldmaxPowerLevel = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_maxPowerLevel'));
final _sdkSearchEvconnectorexperimentalGetFieldchargingPoint = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_chargingPoint'));
final _sdkSearchEvconnectorexperimentalGetFieldlastUpdateTimestamp = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_field_lastUpdateTimestamp'));



Pointer<Void> sdkSearchEvconnectorexperimentalToFfi(EvConnectorExperimental value) {
  final _supplierNameHandle = stringToFfiNullable(value.supplierName);
  final _connectorTypeHandle = sdkSearchEvnameidexperimentalToFfiNullable(value.connectorType);
  final _powerFeedTypeHandle = sdkSearchEvnameidexperimentalToFfiNullable(value.powerFeedType);
  final _chargeCapacityHandle = stringToFfiNullable(value.chargeCapacity);
  final _fixedCableHandle = booleanToFfiNullable(value.fixedCable);
  final _maxPowerLevelHandle = doubleToFfiNullable(value.maxPowerLevel);
  final _chargingPointHandle = sdkSearchEvchargingpointexperimentalToFfiNullable(value.chargingPoint);
  final _lastUpdateTimestampHandle = stringToFfiNullable(value.lastUpdateTimestamp);
  final _result = _sdkSearchEvconnectorexperimentalCreateHandle(_supplierNameHandle, _connectorTypeHandle, _powerFeedTypeHandle, _chargeCapacityHandle, _fixedCableHandle, _maxPowerLevelHandle, _chargingPointHandle, _lastUpdateTimestampHandle);
  stringReleaseFfiHandleNullable(_supplierNameHandle);
  sdkSearchEvnameidexperimentalReleaseFfiHandleNullable(_connectorTypeHandle);
  sdkSearchEvnameidexperimentalReleaseFfiHandleNullable(_powerFeedTypeHandle);
  stringReleaseFfiHandleNullable(_chargeCapacityHandle);
  booleanReleaseFfiHandleNullable(_fixedCableHandle);
  doubleReleaseFfiHandleNullable(_maxPowerLevelHandle);
  sdkSearchEvchargingpointexperimentalReleaseFfiHandleNullable(_chargingPointHandle);
  stringReleaseFfiHandleNullable(_lastUpdateTimestampHandle);
  return _result;
}

EvConnectorExperimental sdkSearchEvconnectorexperimentalFromFfi(Pointer<Void> handle) {
  final _supplierNameHandle = _sdkSearchEvconnectorexperimentalGetFieldsupplierName(handle);
  final _connectorTypeHandle = _sdkSearchEvconnectorexperimentalGetFieldconnectorType(handle);
  final _powerFeedTypeHandle = _sdkSearchEvconnectorexperimentalGetFieldpowerFeedType(handle);
  final _chargeCapacityHandle = _sdkSearchEvconnectorexperimentalGetFieldchargeCapacity(handle);
  final _fixedCableHandle = _sdkSearchEvconnectorexperimentalGetFieldfixedCable(handle);
  final _maxPowerLevelHandle = _sdkSearchEvconnectorexperimentalGetFieldmaxPowerLevel(handle);
  final _chargingPointHandle = _sdkSearchEvconnectorexperimentalGetFieldchargingPoint(handle);
  final _lastUpdateTimestampHandle = _sdkSearchEvconnectorexperimentalGetFieldlastUpdateTimestamp(handle);
  try {
    return EvConnectorExperimental(
      stringFromFfiNullable(_supplierNameHandle), 
      sdkSearchEvnameidexperimentalFromFfiNullable(_connectorTypeHandle), 
      sdkSearchEvnameidexperimentalFromFfiNullable(_powerFeedTypeHandle), 
      stringFromFfiNullable(_chargeCapacityHandle), 
      booleanFromFfiNullable(_fixedCableHandle), 
      doubleFromFfiNullable(_maxPowerLevelHandle), 
      sdkSearchEvchargingpointexperimentalFromFfiNullable(_chargingPointHandle), 
      stringFromFfiNullable(_lastUpdateTimestampHandle)
    );
  } finally {
    stringReleaseFfiHandleNullable(_supplierNameHandle);
    sdkSearchEvnameidexperimentalReleaseFfiHandleNullable(_connectorTypeHandle);
    sdkSearchEvnameidexperimentalReleaseFfiHandleNullable(_powerFeedTypeHandle);
    stringReleaseFfiHandleNullable(_chargeCapacityHandle);
    booleanReleaseFfiHandleNullable(_fixedCableHandle);
    doubleReleaseFfiHandleNullable(_maxPowerLevelHandle);
    sdkSearchEvchargingpointexperimentalReleaseFfiHandleNullable(_chargingPointHandle);
    stringReleaseFfiHandleNullable(_lastUpdateTimestampHandle);
  }
}

void sdkSearchEvconnectorexperimentalReleaseFfiHandle(Pointer<Void> handle) => _sdkSearchEvconnectorexperimentalReleaseHandle(handle);

// Nullable EvConnectorExperimental

final _sdkSearchEvconnectorexperimentalCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_create_handle_nullable'));
final _sdkSearchEvconnectorexperimentalReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_release_handle_nullable'));
final _sdkSearchEvconnectorexperimentalGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EvConnectorExperimental_get_value_nullable'));

Pointer<Void> sdkSearchEvconnectorexperimentalToFfiNullable(EvConnectorExperimental? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkSearchEvconnectorexperimentalToFfi(value);
  final result = _sdkSearchEvconnectorexperimentalCreateHandleNullable(_handle);
  sdkSearchEvconnectorexperimentalReleaseFfiHandle(_handle);
  return result;
}

EvConnectorExperimental? sdkSearchEvconnectorexperimentalFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkSearchEvconnectorexperimentalGetValueNullable(handle);
  final result = sdkSearchEvconnectorexperimentalFromFfi(_handle);
  sdkSearchEvconnectorexperimentalReleaseFfiHandle(_handle);
  return result;
}

void sdkSearchEvconnectorexperimentalReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkSearchEvconnectorexperimentalReleaseHandleNullable(handle);

// End of EvConnectorExperimental "private" section.


