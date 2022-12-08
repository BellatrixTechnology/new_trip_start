// Copyright (c) 2019-2022 HERE Global B.V. and its affiliate(s).
// All rights reserved.
// This software and other materials contain proprietary information
// controlled by HERE and are protected by applicable copyright legislation.
// Any use and utilization of this software and other materials and
// disclosure to any third parties is conditional upon having a separate
// agreement with HERE for the access, use, utilization or disclosure of this
// software. In the absence of such agreement, the use of the software is not
// allowed.
//

import 'dart:ffi';
import 'dart:ui' as ui;
import 'package:here_sdk/src/_library_context.dart' as __lib;
import 'package:here_sdk/src/_native_base.dart' as __lib;
import 'package:here_sdk/src/_token_cache.dart' as __lib;
import 'package:here_sdk/src/sdk/animation/animation_listener.dart';
import 'package:here_sdk/src/sdk/animation/map_polyline_animation.dart';
import 'package:here_sdk/src/sdk/core/color.dart';
import 'package:here_sdk/src/sdk/core/geo_polyline.dart';
import 'package:here_sdk/src/sdk/core/metadata.dart';
import 'package:here_sdk/src/sdk/mapview/dash_pattern.dart';
import 'package:here_sdk/src/sdk/mapview/line_cap.dart';
import 'package:meta/meta.dart';

/// A visual representation of a line on the map.
///
/// The geometry to be visualized is represented
/// by an instance of [GeoPolyline].
abstract class MapPolyline {
  /// Creates a new MapPolyline instance.
  ///
  /// [geometry] The list of vertices representing the polyline.
  ///
  /// [widthInPixels] The width of the polyline (in pixels). The chosen value should be greater than or equal
  /// to 0. Negative values are clamped to 0.
  ///
  /// [color] The color of the polyline.
  ///
  factory MapPolyline(GeoPolyline geometry, double widthInPixels, ui.Color color) => $prototype.$init(geometry, widthInPixels, color);
  /// Creates a new [MapPolyline] instance with an outline.
  ///
  /// The width of the outline comes on top of the polyline width, meaning that a line of width 10
  /// and outline width of 2 will have a total width of 14 pixels.
  ///
  /// [geometry] The list of vertices representing the polyline.
  ///
  /// [widthInPixels] The width of the polyline (in pixels). The chosen value should be greater than or equal
  /// to 0. Negative values are clamped to 0.
  ///
  /// [color] The color of the polyline.
  ///
  /// [outlineWidthInPixels] The width of the outline (in pixels) on one side of the polyline. The total width of the
  /// polyline will thus be widthInPixels + 2 * outlineWidthInPixels. The chosen value should
  /// be greater than or equal to 0. Negative values are clamped to 0.
  ///
  /// [outlineColor] The outline color of the polyline.
  ///
  factory MapPolyline.withOutlineWidthInPixelsAndOutlineColor(GeoPolyline geometry, double widthInPixels, ui.Color color, double outlineWidthInPixels, ui.Color outlineColor) => $prototype.withOutlineWidthInPixelsAndOutlineColor(geometry, widthInPixels, color, outlineWidthInPixels, outlineColor);

  /// Starts an animation of this map polyline.
  ///
  /// Any ongoing animation of this map polyline will get cancelled.
  ///
  /// [animation] The animation to start. This object may be shared between multiple instances of map polyline.
  /// Starting animation on one polyline does not influence any ongoing animations on other polylines.
  ///
  /// [listener] The listener to receive notifications
  /// about animation start, completion or cancellation.
  ///
  void startAnimation(MapPolylineAnimation animation, AnimationListener listener);
  /// Cancels single ongoing animation of this map polyline.
  ///
  /// Does nothing if the specified animation is not currently in progress for this polyline.
  /// Does not affect other polylines that might be running this animation.
  ///
  /// [animation] The animation to cancel
  ///
  void cancelAnimation(MapPolylineAnimation animation);
  /// Gets the geometry of the polyline.
  GeoPolyline get geometry;
  /// Sets the geometry of the polyline.
  set geometry(GeoPolyline value);

  /// Gets the Metadata instance attached to this polyline.
  /// This will be  if nothing has been
  /// attached before.
  Metadata? get metadata;
  /// Sets the Metadata instance attached to this polyline.
  set metadata(Metadata? value);

  /// Returns the cap shape of the polyline and its outline.
  LineCap get lineCap;
  /// Sets the cap shape of the polyline and its outline. The default shape is
  /// {LineCap.ROUND}.
  set lineCap(LineCap value);

  /// Gets the color of the polyline.
  ui.Color get lineColor;
  /// Sets the color of the polyline.
  set lineColor(ui.Color value);

  /// Gets the width of the polyline in pixels.
  double get lineWidth;
  /// Sets the width of the polyline in pixels. The value should be positive. Values
  /// less than or equal to 0 are ignored and the existing width is maintained.
  set lineWidth(double value);

  /// Gets the outline color of the polyline.
  ui.Color get outlineColor;
  /// Sets the outline color of the polyline. The default outline color is opaque white.
  set outlineColor(ui.Color value);

  /// Gets the outline width of the polyline in pixels.
  double get outlineWidth;
  /// Sets the outline width of the polyline in pixels. The value should be greater than or
  /// equal to 0. Negative values are ignored and the existing outline width is maintained.
  /// The default outline width is 0.
  set outlineWidth(double value);

  /// Gets the dash pattern of the polyline. Returns `null` if no pattern is used.
  DashPattern? get dashPattern;
  /// Sets the dash pattern of the polyline or `null` if no pattern is to be used. The pattern
  /// has two parts; the dash and the gap between successive dashes. The dashes use the line
  /// color, whereas the gaps separating them use the dash fill color. The pattern does not
  /// appear on the progress part of the polyline. By default, no dash pattern is used.
  set dashPattern(DashPattern? value);

  /// Gets the fill color for the gaps of the polyline's dash pattern. Returns `null` if no
  /// color is used.
  ui.Color? get dashFillColor;
  /// Sets the fill color for the gaps of the polyline's dash pattern or 'null' if no color is
  /// to be used. By default, no dash fill color is used.
  set dashFillColor(ui.Color? value);

  /// Gets the draw order of the polyline.
  int get drawOrder;
  /// Sets the draw order of the polyline. Polylines with a higher draw order are drawn on top
  /// of polylines with a lower draw order. In case multiple polylines have the same draw
  /// order, they are drawn in the order of submission. Chosen values are clamped in the range
  /// \[0; 1023\]. The default draw order is 0.
  set drawOrder(int value);

  /// Gets the progress of the polyline.
  double get progress;
  /// Sets the progress of the polyline from its starting point as a ratio of its total length
  /// clamped in the range \[0; 1\]. As the progress varies, the equivalent part of the
  /// polyline gets covered by the progress color and progress outline color. The rest of the
  /// polyline until its end point retains the line color and outline color along with an
  /// optional dash pattern. The default progress is 0.
  set progress(double value);

  /// Gets the progress color of the polyline.
  ui.Color get progressColor;
  /// Sets the progress color of the polyline. The default progress color is opaque white.
  /// Note that this does not affect [DashPattern] styles.
  set progressColor(ui.Color value);

  /// Gets the progress outline color of the polyline.
  ui.Color get progressOutlineColor;
  /// Sets the progress outline color of the polyline. The default progress outline color is
  /// opaque white.
  set progressOutlineColor(ui.Color value);


  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = MapPolyline$Impl(Pointer<Void>.fromAddress(0));
}


// MapPolyline "private" section, not exported.

final _sdkMapviewMappolylineRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_MapPolyline_register_finalizer'));
final _sdkMapviewMappolylineCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapPolyline_copy_handle'));
final _sdkMapviewMappolylineReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapPolyline_release_handle'));






/// @nodoc
@visibleForTesting
class MapPolyline$Impl extends __lib.NativeBase implements MapPolyline {

  MapPolyline$Impl(Pointer<Void> handle) : super(handle);


  MapPolyline $init(GeoPolyline geometry, double widthInPixels, ui.Color color) {
    final _result_handle = _$init(geometry, widthInPixels, color);
    final _result = MapPolyline$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewMappolylineRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);
    return _result;
  }


  MapPolyline withOutlineWidthInPixelsAndOutlineColor(GeoPolyline geometry, double widthInPixels, ui.Color color, double outlineWidthInPixels, ui.Color outlineColor) {
    final _result_handle = _withOutlineWidthInPixelsAndOutlineColor(geometry, widthInPixels, color, outlineWidthInPixels, outlineColor);
    final _result = MapPolyline$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewMappolylineRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);
    return _result;
  }

  static Pointer<Void> _$init(GeoPolyline geometry, double widthInPixels, ui.Color color) {
    final _$initFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Double, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>, double, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_make__GeoPolyline_Double_Color'));
    final _geometryHandle = sdkCoreGeopolylineToFfi(geometry);
    final _widthInPixelsHandle = (widthInPixels);
    final _colorHandle = sdkCoreColorToFfi(color);
    final __resultHandle = _$initFfi(__lib.LibraryContext.isolateId, _geometryHandle, _widthInPixelsHandle, _colorHandle);
    sdkCoreGeopolylineReleaseFfiHandle(_geometryHandle);

    sdkCoreColorReleaseFfiHandle(_colorHandle);
    return __resultHandle;
  }

  static Pointer<Void> _withOutlineWidthInPixelsAndOutlineColor(GeoPolyline geometry, double widthInPixels, ui.Color color, double outlineWidthInPixels, ui.Color outlineColor) {
    final _withOutlineWidthInPixelsAndOutlineColorFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Double, Pointer<Void>, Double, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>, double, Pointer<Void>, double, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_make__GeoPolyline_Double_Color_Double_Color'));
    final _geometryHandle = sdkCoreGeopolylineToFfi(geometry);
    final _widthInPixelsHandle = (widthInPixels);
    final _colorHandle = sdkCoreColorToFfi(color);
    final _outlineWidthInPixelsHandle = (outlineWidthInPixels);
    final _outlineColorHandle = sdkCoreColorToFfi(outlineColor);
    final __resultHandle = _withOutlineWidthInPixelsAndOutlineColorFfi(__lib.LibraryContext.isolateId, _geometryHandle, _widthInPixelsHandle, _colorHandle, _outlineWidthInPixelsHandle, _outlineColorHandle);
    sdkCoreGeopolylineReleaseFfiHandle(_geometryHandle);

    sdkCoreColorReleaseFfiHandle(_colorHandle);

    sdkCoreColorReleaseFfiHandle(_outlineColorHandle);
    return __resultHandle;
  }

  @override
  void startAnimation(MapPolylineAnimation animation, AnimationListener listener) {
    final _startAnimationFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_startAnimation__MapPolylineAnimation_AnimationListener'));
    final _animationHandle = sdkAnimationMappolylineanimationToFfi(animation);
    final _listenerHandle = sdkAnimationAnimationlistenerToFfi(listener);
    final _handle = this.handle;
    _startAnimationFfi(_handle, __lib.LibraryContext.isolateId, _animationHandle, _listenerHandle);
    sdkAnimationMappolylineanimationReleaseFfiHandle(_animationHandle);
    sdkAnimationAnimationlistenerReleaseFfiHandle(_listenerHandle);

  }

  @override
  void cancelAnimation(MapPolylineAnimation animation) {
    final _cancelAnimationFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_cancelAnimation__MapPolylineAnimation'));
    final _animationHandle = sdkAnimationMappolylineanimationToFfi(animation);
    final _handle = this.handle;
    _cancelAnimationFfi(_handle, __lib.LibraryContext.isolateId, _animationHandle);
    sdkAnimationMappolylineanimationReleaseFfiHandle(_animationHandle);

  }

  @override
  GeoPolyline get geometry {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_geometry_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreGeopolylineFromFfi(__resultHandle);
    } finally {
      sdkCoreGeopolylineReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set geometry(GeoPolyline value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_geometry_set__GeoPolyline'));
    final _valueHandle = sdkCoreGeopolylineToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreGeopolylineReleaseFfiHandle(_valueHandle);

  }


  @override
  Metadata? get metadata {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_metadata_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreMetadataFromFfiNullable(__resultHandle);
    } finally {
      sdkCoreMetadataReleaseFfiHandleNullable(__resultHandle);

    }

  }

  @override
  set metadata(Metadata? value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_metadata_set__Metadata_'));
    final _valueHandle = sdkCoreMetadataToFfiNullable(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreMetadataReleaseFfiHandleNullable(_valueHandle);

  }


  @override
  LineCap get lineCap {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Uint32 Function(Pointer<Void>, Int32), int Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_lineCap_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkMapviewLinecapFromFfi(__resultHandle);
    } finally {
      sdkMapviewLinecapReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set lineCap(LineCap value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Uint32), void Function(Pointer<Void>, int, int)>('here_sdk_sdk_mapview_MapPolyline_lineCap_set__LineCap'));
    final _valueHandle = sdkMapviewLinecapToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkMapviewLinecapReleaseFfiHandle(_valueHandle);

  }


  @override
  ui.Color get lineColor {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_lineColor_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreColorFromFfi(__resultHandle);
    } finally {
      sdkCoreColorReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set lineColor(ui.Color value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_lineColor_set__Color'));
    final _valueHandle = sdkCoreColorToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreColorReleaseFfiHandle(_valueHandle);

  }


  @override
  double get lineWidth {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_lineWidth_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set lineWidth(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapPolyline_lineWidth_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  ui.Color get outlineColor {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_outlineColor_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreColorFromFfi(__resultHandle);
    } finally {
      sdkCoreColorReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set outlineColor(ui.Color value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_outlineColor_set__Color'));
    final _valueHandle = sdkCoreColorToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreColorReleaseFfiHandle(_valueHandle);

  }


  @override
  double get outlineWidth {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_outlineWidth_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set outlineWidth(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapPolyline_outlineWidth_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  DashPattern? get dashPattern {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_dashPattern_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkMapviewDashpatternFromFfiNullable(__resultHandle);
    } finally {
      sdkMapviewDashpatternReleaseFfiHandleNullable(__resultHandle);

    }

  }

  @override
  set dashPattern(DashPattern? value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_dashPattern_set__DashPattern_'));
    final _valueHandle = sdkMapviewDashpatternToFfiNullable(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkMapviewDashpatternReleaseFfiHandleNullable(_valueHandle);

  }


  @override
  ui.Color? get dashFillColor {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_dashFillColor_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreColorFromFfiNullable(__resultHandle);
    } finally {
      sdkCoreColorReleaseFfiHandleNullable(__resultHandle);

    }

  }

  @override
  set dashFillColor(ui.Color? value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_dashFillColor_set__Color_'));
    final _valueHandle = sdkCoreColorToFfiNullable(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreColorReleaseFfiHandleNullable(_valueHandle);

  }


  @override
  int get drawOrder {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Int32 Function(Pointer<Void>, Int32), int Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_drawOrder_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set drawOrder(int value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Int32), void Function(Pointer<Void>, int, int)>('here_sdk_sdk_mapview_MapPolyline_drawOrder_set__Int'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  double get progress {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_progress_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set progress(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapPolyline_progress_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  ui.Color get progressColor {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_progressColor_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreColorFromFfi(__resultHandle);
    } finally {
      sdkCoreColorReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set progressColor(ui.Color value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_progressColor_set__Color'));
    final _valueHandle = sdkCoreColorToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreColorReleaseFfiHandle(_valueHandle);

  }


  @override
  ui.Color get progressOutlineColor {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapPolyline_progressOutlineColor_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreColorFromFfi(__resultHandle);
    } finally {
      sdkCoreColorReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set progressOutlineColor(ui.Color value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapPolyline_progressOutlineColor_set__Color'));
    final _valueHandle = sdkCoreColorToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreColorReleaseFfiHandle(_valueHandle);

  }



}

Pointer<Void> sdkMapviewMappolylineToFfi(MapPolyline value) =>
  _sdkMapviewMappolylineCopyHandle((value as __lib.NativeBase).handle);

MapPolyline sdkMapviewMappolylineFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is MapPolyline) return instance;

  final _copiedHandle = _sdkMapviewMappolylineCopyHandle(handle);
  final result = MapPolyline$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewMappolylineRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMappolylineReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewMappolylineReleaseHandle(handle);

Pointer<Void> sdkMapviewMappolylineToFfiNullable(MapPolyline? value) =>
  value != null ? sdkMapviewMappolylineToFfi(value) : Pointer<Void>.fromAddress(0);

MapPolyline? sdkMapviewMappolylineFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewMappolylineFromFfi(handle) : null;

void sdkMapviewMappolylineReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMappolylineReleaseHandle(handle);

// End of MapPolyline "private" section.


