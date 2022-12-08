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
import 'package:here_sdk/src/_native_base.dart' as __lib;
import 'package:here_sdk/src/_token_cache.dart' as __lib;
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/traffic/traffic_incident_type.dart';
import 'package:meta/meta.dart';

/// Provides settings regarding map data which are applied globally to all map views.
///
/// The settings
/// can already be changed before a map view instance is created.
abstract class MapContentSettings {

  /// Filters the displayed traffic incidents so that only the ones applicable to the specified
  /// criteria are shown when general display of traffic incidents is enabled.
  ///
  /// The display of traffic incidents can be enabled using [MapScene.enableFeatures] with
  /// [MapFeatures.trafficIncidents].
  ///
  /// [trafficIncidents] The traffic incidents to filter for, so that only applicable incidents are displayed.
  /// When the list is empty, then all traffic incidents will be displayed.
  /// If the [MapContentSettings.filterTrafficIncidents.trafficIncidents] contains [TrafficIncidentType.unknown], then the
  /// traffic filter will be applied ignoring this element.
  ///
  static void filterTrafficIncidents(List<TrafficIncidentType> trafficIncidents) => $prototype.filterTrafficIncidents(trafficIncidents);
  /// Removes all filters regarding Traffic Incidents so that all incidents will be displayed,
  /// when the display of Traffic Incidents is enabled using [MapScene.enableFeatures] with
  /// [MapFeatures.trafficIncidents].
  ///
  static void resetTrafficIncidentFilter() => $prototype.resetTrafficIncidentFilter();

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = MapContentSettings$Impl(Pointer<Void>.fromAddress(0));
}


// MapContentSettings "private" section, not exported.

final _sdkMapviewMapcontentsettingsRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_MapContentSettings_register_finalizer'));
final _sdkMapviewMapcontentsettingsCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapContentSettings_copy_handle'));
final _sdkMapviewMapcontentsettingsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapContentSettings_release_handle'));




/// @nodoc
@visibleForTesting
class MapContentSettings$Impl extends __lib.NativeBase implements MapContentSettings {

  MapContentSettings$Impl(Pointer<Void> handle) : super(handle);

  void filterTrafficIncidents(List<TrafficIncidentType> trafficIncidents) {
    final _filterTrafficIncidentsFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Pointer<Void>), void Function(int, Pointer<Void>)>('here_sdk_sdk_mapview_MapContentSettings_filterTrafficIncidents__ListOf_sdk_traffic_TrafficIncidentType'));
    final _trafficIncidentsHandle = heresdkMapviewHarpBindingslistofSdkTrafficTrafficincidenttypeToFfi(trafficIncidents);
    _filterTrafficIncidentsFfi(__lib.LibraryContext.isolateId, _trafficIncidentsHandle);
    heresdkMapviewHarpBindingslistofSdkTrafficTrafficincidenttypeReleaseFfiHandle(_trafficIncidentsHandle);

  }

  void resetTrafficIncidentFilter() {
    final _resetTrafficIncidentFilterFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32), void Function(int)>('here_sdk_sdk_mapview_MapContentSettings_resetTrafficIncidentFilter'));
    _resetTrafficIncidentFilterFfi(__lib.LibraryContext.isolateId);

  }


}

Pointer<Void> sdkMapviewMapcontentsettingsToFfi(MapContentSettings value) =>
  _sdkMapviewMapcontentsettingsCopyHandle((value as __lib.NativeBase).handle);

MapContentSettings sdkMapviewMapcontentsettingsFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is MapContentSettings) return instance;

  final _copiedHandle = _sdkMapviewMapcontentsettingsCopyHandle(handle);
  final result = MapContentSettings$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewMapcontentsettingsRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMapcontentsettingsReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewMapcontentsettingsReleaseHandle(handle);

Pointer<Void> sdkMapviewMapcontentsettingsToFfiNullable(MapContentSettings? value) =>
  value != null ? sdkMapviewMapcontentsettingsToFfi(value) : Pointer<Void>.fromAddress(0);

MapContentSettings? sdkMapviewMapcontentsettingsFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewMapcontentsettingsFromFfi(handle) : null;

void sdkMapviewMapcontentsettingsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMapcontentsettingsReleaseHandle(handle);

// End of MapContentSettings "private" section.


