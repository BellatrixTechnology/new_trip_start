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
import 'package:meta/meta.dart';

/// This is an interface for capturing user's intent for the
/// desired catalog version to use in [DesiredCatalog] class.
///
/// You can request a specific or latest version of a catalog by calling the
/// static functions [CatalogVersionHint.specific] and
/// [CatalogVersionHint.latest] respectively. The HERE platform will make the
/// best effort to provide an appropriate version for the catalog based on this
/// version hint.
///
/// Internally, the derived classes override the method
/// [CatalogVersionHint.getVersion] and return an appropriate
/// CatalogVersionHint based objects for specific or latest version numbers.
abstract class CatalogVersionHint {

  /// This static method is used when you are interested in a
  /// specific version of a catalog, that you want to specify manually.
  ///
  /// [version] An integer value indicating the version of catalog desired.
  /// If the desired version does not exist, the HERE platform will make the
  /// best effort to provide an appropriate version or result in error logs
  /// about invalid version.
  ///
  static CatalogVersionHint specific(int version) => $prototype.specific(version);
  /// This static method is used when you are interested in the most latest
  /// version of a catalog.
  ///
  static CatalogVersionHint latest() => $prototype.latest();

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = CatalogVersionHint$Impl(Pointer<Void>.fromAddress(0));
}


// CatalogVersionHint "private" section, not exported.

final _sdkCoreEngineCatalogversionhintRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_core_engine_CatalogVersionHint_register_finalizer'));
final _sdkCoreEngineCatalogversionhintCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_CatalogVersionHint_copy_handle'));
final _sdkCoreEngineCatalogversionhintReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_CatalogVersionHint_release_handle'));




/// @nodoc
@visibleForTesting
class CatalogVersionHint$Impl extends __lib.NativeBase implements CatalogVersionHint {

  CatalogVersionHint$Impl(Pointer<Void> handle) : super(handle);

  CatalogVersionHint specific(int version) {
    final _specificFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Int64), Pointer<Void> Function(int, int)>('here_sdk_sdk_core_engine_CatalogVersionHint_specific__Long'));
    final _versionHandle = (version);
    final __resultHandle = _specificFfi(__lib.LibraryContext.isolateId, _versionHandle);

    try {
      return sdkCoreEngineCatalogversionhintFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineCatalogversionhintReleaseFfiHandle(__resultHandle);

    }

  }

  CatalogVersionHint latest() {
    final _latestFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32), Pointer<Void> Function(int)>('here_sdk_sdk_core_engine_CatalogVersionHint_latest'));
    final __resultHandle = _latestFfi(__lib.LibraryContext.isolateId);
    try {
      return sdkCoreEngineCatalogversionhintFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineCatalogversionhintReleaseFfiHandle(__resultHandle);

    }

  }


}

Pointer<Void> sdkCoreEngineCatalogversionhintToFfi(CatalogVersionHint value) =>
  _sdkCoreEngineCatalogversionhintCopyHandle((value as __lib.NativeBase).handle);

CatalogVersionHint sdkCoreEngineCatalogversionhintFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is CatalogVersionHint) return instance;

  final _copiedHandle = _sdkCoreEngineCatalogversionhintCopyHandle(handle);
  final result = CatalogVersionHint$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkCoreEngineCatalogversionhintRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkCoreEngineCatalogversionhintReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkCoreEngineCatalogversionhintReleaseHandle(handle);

Pointer<Void> sdkCoreEngineCatalogversionhintToFfiNullable(CatalogVersionHint? value) =>
  value != null ? sdkCoreEngineCatalogversionhintToFfi(value) : Pointer<Void>.fromAddress(0);

CatalogVersionHint? sdkCoreEngineCatalogversionhintFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkCoreEngineCatalogversionhintFromFfi(handle) : null;

void sdkCoreEngineCatalogversionhintReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreEngineCatalogversionhintReleaseHandle(handle);

// End of CatalogVersionHint "private" section.


