// /*
//  * Copyright (C) 2019-2022 HERE Europe B.V.
//  *
//  * Licensed under the Apache License, Version 2.0 (the "License")
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  *     http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  *
//  * SPDX-License-Identifier: Apache-2.0
//  * License-Filename: LICENSE
//  */

// import 'dart:developer';
// import 'dart:ui';
// // import 'dart:math';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// // import 'package:here_sdk/core.dart';
// // import 'package:here_sdk/core.errors.dart';
// // import 'package:here_sdk/mapview.dart';
// // import 'package:here_sdk/routing.dart';
// // import 'package:here_sdk/routing.dart' as here;
// import 'package:new_trip_start/constants.dart';
// import 'package:new_trip_start/controllers/places.controller.dart';
// import 'package:new_trip_start/models/places.model.dart';
// import 'package:new_trip_start/services/index.dart';
// import 'package:new_trip_start/utils/flexible-polylines/flexible_polyline.dart';

// // A callback to notify the hosting widget.
// typedef ShowDialogFunction = void Function(String title, String message);

// class RoutingService {
//   late HereMapController _hereMapController;
//   List<MapPolyline> mapPolylines = [];
//   List<MapMarker> mapMarkers = [];
//   late RoutingEngine _routingEngine;
//   PlaceController placeController = Get.put(PlaceController());
//   MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(
//       'assets/images/my-marker.png', 40, 40);
//   MapImage otherImage = MapImage.withFilePathAndWidthAndHeight(
//       'assets/images/dest-icon.png', 52, 70);

//   MapImage tollImage = MapImage.withFilePathAndWidthAndHeight(
//       'assets/images/tollImage.png', 42, 42);

//   // double distanceToEarthInMeters = 10000;/
//   MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, 10000);

//   init(HereMapController hereMapController) {
//     _hereMapController = hereMapController;

//     try {
//       _hereMapController.camera.lookAtPointWithMeasure(
//           GeoCoordinates(59.91234, 10.75), mapMeasureZoom);
//       placeController.drawAllPaths();
//       // addRoute();
//     } catch (e) {
//       print(e);
//     }
//     try {
//       _routingEngine = RoutingEngine();
//     } on InstantiationException {
//       throw ("Initialization of RoutingEngine failed.");
//     }
//   }

//   Future<void> addRoute() async {
//     srvRouting.clearMap();

//     Position position1 = placeController.startPlace.position!;
//     Position position2 = placeController.endPlace.position!;

//     // inspect(position1);
//     // inspect(position2);

//     var startGeoCoordinates = GeoCoordinates(position1.lat,
//         position1.lng); //_createRandomGeoCoordinatesInViewport();
//     var destinationGeoCoordinates = GeoCoordinates(position2.lat,
//         position2.lng); //_createRandomGeoCoordinatesInViewport();
//     var startWaypoint = Waypoint.withDefaults(startGeoCoordinates);
//     var destinationWaypoint = Waypoint.withDefaults(destinationGeoCoordinates);
//     srvRouting.addMyMarker(position1);
//     srvRouting.addDestMarker(position2);
//     List<Waypoint> waypoints = [startWaypoint, destinationWaypoint];

//     _routingEngine.calculateCarRoute(waypoints, CarOptions.withDefaults(),
//         (RoutingError? routingError, List<here.Route>? routeList) async {
//       if (routingError == null) {
//         // When error is null, then the list guaranteed to be not null.

//         var geoBox = GeoBox(startGeoCoordinates, destinationGeoCoordinates);
//         var bearing = 45.0; // Set null, to keep bearing unchanged.
//         var tilt = 0.0;
//         var orientation = GeoOrientationUpdate(bearing, tilt);
//         _hereMapController.camera
//             .lookAtAreaWithGeoOrientation(geoBox, orientation);

//         here.Route route = routeList!.first;

//         _showRouteDetails(route);
//         _showRouteOnMap(route);
//         _logRouteSectionDetails(route);
//         _logRouteViolations(route);
//       } else {
//         var error = routingError.toString();
//         // _showDialog('Error', 'Error while calculating a route: $error');
//         srvToastAlert.toast('Error while calculating a route: $error');
//       }
//     });
//   }

//   void setBoundries() {}

//   // A route may contain several warnings, for example, when a certain route option could not be fulfilled.
//   // An implementation may decide to reject a route if one or more violations are detected.
//   void _logRouteViolations(here.Route route) {
//     for (var section in route.sections) {
//       for (var notice in section.sectionNotices) {
//         print("This route contains the following warning: ${notice.code}");
//       }
//     }
//   }

//   void clearMap() {
//     for (var mapPolyline in mapPolylines) {
//       _hereMapController.mapScene.removeMapPolyline(mapPolyline);
//     }
//     clearWaypointMapMarker();
//     mapPolylines.clear();
//   }

//   void clearWaypointMapMarker() {
//     for (MapMarker mapMarker in mapMarkers) {
//       _hereMapController.mapScene.removeMapMarker(mapMarker);
//     }
//     mapMarkers.clear();
//   }

//   void _logRouteSectionDetails(here.Route route) {
//     DateFormat dateFormat = DateFormat().add_Hm();

//     print(route.sections.length);
//     for (int i = 0; i < route.sections.length; i++) {
//       Section section = route.sections.elementAt(i);

//       // ignore: avoid_print
//       print("Route Section : ${i + 1}");
//       // ignore: avoid_print
//       print(
//           "Route Section Departure Time : ${dateFormat.format(section.departureLocationTime!.localTime)}");
//       // ignore: avoid_print
//       print(
//           "Route Section Arrival Time : ${dateFormat.format(section.arrivalLocationTime!.localTime)}");
//       // ignore: avoid_print
//       print("Route Section length : ${section.lengthInMeters} m");
//       // ignore: avoid_print
//       print("Route Section duration : ${section.duration.inSeconds} s");
//     }
//   }

//   void _showRouteDetails(here.Route route) {
//     int estimatedTravelTimeInSeconds = route.duration.inSeconds;
//     int lengthInMeters = route.lengthInMeters;

//     String routeDetails =
//         'Travel Time: ${formatTime(estimatedTravelTimeInSeconds.toDouble())}, Length: ${formatLength(lengthInMeters.toDouble())}';

//     srvToastAlert.toast(routeDetails);
//   }

//   String formatTime(double sec) {
//     int hours = sec ~/ 3600;
//     int minutes = (sec % 3600) ~/ 60;

//     return '$hours h : $minutes mins';
//   }

//   String formatLength(
//     double meters,
//   ) {
//     // int kilometers = meters ~/ 1000;
//     // int remainingMeters = meters % 1000;

//     // return '$kilometers.$remainingMeters km';

//     double distanceInKiloMeters = meters / 1000;
//     // double roundDistanceInKM =
//     //     double.parse((distanceInKiloMeters).toStringAsFixed(2));
//     return '${distanceInKiloMeters.toStringAsFixed(2)} kms';
//   }

//   _showRouteOnMap(here.Route route) {
//     // Show route as polyline.
//     // var pol =
//     //     "BGu6yuyD44qgVlO3C7BzZnBjNnB_JnBjI7BrJ7BjI3DjNrEnQnLjmB7BzF7BzF7B_E7B_E7BrE7BrEvCzFnGnLvMvW7GvM_O_dvCzFjDjIvC7G7BnG7BnGrEvRrJnpBjD3N7BrJ7B_J7BnLvCrT7BnLvCjNnBzFnB_EnBrE7BzF7B_EjDjIrE_J3D3IvCnGvC7G7BzF7BnGnB_EnB7GnBjInB_JrE_sBvCnV7BvMjDvRvHzoBrEnV_ErY7BrJ3DrT7BrOnBjNT7LUjNoBnL8BzKwCnLkD7LgF_OkIzUoLvbsJ7VsYnzB0PvgBkSzjBkI_O8G_J8G3I8G7GoGzF8GrEoL_EwRrJ0FrEkDvCwCvC4DrEwHjI8G7G4DjDkDvCkD7B4D7BwgBvM8GjDoGjDoG3DgF3DwHnG0jB7kB0FzF8G7GgUnVgK_J8azesJ7LoG3IsO_T4IvM8LvRoQ_Y0KrTsE3I4D3I4DrJkD3IwC3I8BvHgF_TgF_TsEvWsEvbsO7gDkIz3BkDnaoB7LUjNAvMTnQnBnVnBrT3DrnBvCnkBT3NArJAnLU7QUzKoB3NgFnzB0F_7BgKj7DwCzoBU3NAzPArTT_OTnL7B_T_E31BzFv5BnGr7BrEzyBvM7jE7BrYnBzeU_JoB_J8B7LsEjX0K_xB8G7fwCzP8BvMUrJUnLA3NAnLTzKnB7LnBjInBvHzFjc7B3IjDjNzF3XrErO_E3NrJvWzKrYnG3NrE_JvHrOvH3N7G_JvH_JjI_J3I_J3IzKvHzKvHvMvH3N_JzUzF3N3DzKjD_J3D7LnLvqBzF3SrE7L3DrJrE_JrEjI_EjIvbriB_EvHnG_J_E_J3D3IrEjNjDvMvC7L7BvMnB_OA3NU3NwC3hB8BjcU_OUjXAvbTzUTjSTrOT_JnB_J7BvM7BrJvC3IvC7GvCnGjDnGrE7GvHzKvH3IrJ_J3XjX3SjSrYjXnVnVvMvM3IrJvH3I_J3NnGnLzFzK_EnLzF3NrEvMrE_OjDvMvCnL7B_J7BjNT7LUrJoBvHoBzFoB3D8BrE8BjDwCjDkDvC4D3DwCjDkD_E8B3D8B3D8BrEwCnG8LriB8GjSkIzUsOriBoGnQsE3N0FnQsJvWkNjcwCnGkDjIkDrJgK_iBwCvH8BzFwCnG0Kvb8BnGoBzFU_EU7GA7GT7GTzFnB7G_EzZnBjInBrJTrJAjIAzKAjNUvMUzK8BzPoGv5BoBzK8BnLsEnVgF_ToG3XoB7GoBvHoB_JUjIAnGTjITvHnBjInBnGvCrJvCvH3D_JjN7fjDjIjDrJvCrJjDrO_Evb3D3XvCrTnB3NT_OArYoBvboB_OoBzK8BvM8B_JwCrJwCvHsEvMkN_dsE_JsEzKwCnG8BzFsE_OkDvMoBzFoB7GoBnGoG7pBgFnfwCvMwC7LkI3hB8B3I8BnLoBnLUrOUvRArYU_JoBnL8BrJwC_JwCvH8G7Q4DrO8BzKoBjNAzKTrJnBnLnBjI7B3InGnVvCzK7BzKnBnLAnLUnL8B7LwCzKkDrJoGvRkDrJ8BnGoBrE4DrOwH3c0Pn4BkDnLkDrJ4D3IkDzFgFvH0FnGoG_E8GrE0FvCgF7B4DTgFA4I8B4DU4DUgFnB4DvC4DrE8B3D8B_EoB7GUvHA_J0KvCkIjD8BnBsEvCoGzF0FvHsE7GgF_JsJ3SjDvHjDvH3DvH3DvHrEvHjD_ErEzF_E_EnG_EzFvC7G7B7GTvH8BzF8BzF8B7GwCvH8BjIUjIAnGTjI7B_EAzFoB7azUzZjXnavWnkB3cnxC7iC_djX_YnQzZ3NvWnL7azK7f_J_djIze3DzevCvgBA_YwCzjB8G_iB0K_sBkSnkBkSrYgP7akSzU0Pvb4XjcoazZwbjXwbrY4c7VsdrTkc7akrBvHwM3I0P7QgezUgoBvbg8BvMkc7Vs2BvbgwC_TsgC3XkuCzK8kB7L4mB3N8pB3N4hBrOge3SkhBzKwRvHkN7Q0ZzPsT3IkIzKwH3N8G7L8BnGnB_EnBrEnBjDnBjD7BvC7B7B7BjD3D7BjDvCnBnBA7BUzPjD_J7BnLoBnLjDrOzFnLzFzPrJjmBvWzjBvW_sBjc7uB7a7VnLzKrEjIjDjSnGrOjDjNnBnLUnfwC_dwHjSoG7VsJrJsE_JsE7QsJ_OkI3hBsTzKgF7LwCrOoBvRTrOUzK4DnLkI3NoLnQsO7Q4NvMwHvHoB3IA3IvCjIrErOnL7G7GvHvH7GrJvHzKrO3XvM7ajDjIrEjNjInavH7fnGvgB7G3mBrEjhBzFjhBnGnajIzZ_J3c_J3c_Tn4BvgBv8C7Lnf_EnL3DvHnBjD7QrdnQzZvWvgB_d3mBzjB3rBzKrOzKnQnLzU_JzZ7GrTzKjc_ErOzFrOjDvHvC7G7L3XzF_J7G7LnL7Q7GrJnnCvhDj1BjpCnQnarT3hBjhBv-BjXzoBrEvH3NnarJ3XvHrYzF_TjIze_T3pCvH7avHnVvHnQ3I3NzKjNzZ3hBzF3NjN3X7QrdvHjNzKzPnL7QzFjIrJrOnGzFvMvWvH3N3D7GriBrgC3D7G3D7G7V7pBzPzejXrsBvCrEvCzFnG7LnL7V3I_TvHnVzFvW7BvM7BrJ7BrTU_YUze0Fz3B8BzUU3SUrJUvMAzjBArsBTzjBUnLArdnB3hB_E_-C_EjzC3DnnC3D79BjDz3B7BnfnBzPvC_drE_iB7GrxB_J79BzK_2BnG7avCvM3I_iBnB_ErJriBzP7zBzKvgB7L7fnG7QrE_JrEnL3D3I_E7LnL3X_E_JnQ7f_JvR3SzenajmB_E7G7fztB3SzZrOrTjIzKrEzFrO3S_O7QrO3NnL_JjDvC_EjDnVvM_YjN7QjIjNvHrO_JrOjN7LrOrJ3N3IvR3DrJjD3IvHvbzFna3DzZ3DnkB_E7iCjDnpB7B3cjDzoB_En4B3D3crErd_EvbzFrYrJriB3I3cjNriBvMjcrO_Y3SzZrJ7L7anf_JjN7QnanLjX_EvM3I_TjIzUzrC7pGrOrnBvMrnBzKnpB_Y70D_E3XjN79BzevuEvWzpDjNzhCnG7kBzFjrBjDzoB7BvqB7B_nB7B3c3DzwCjDnuBzFjwB3I_xBrO_qCzFrdvC3N3D_Y_ErxB7B_dTvHTjrB8BnuBoBjNwC_Y0F7fkIjhBwMzjBgPzoB0KzesJ7f8GvbsEjXwCrTwC_Y8BjXoBnVUrnB7BrnBjDjhBjDnV7BvMnGvgBrJ_sBjD_OnuBz3GjI_nBvHjmBnL7iCnG3rBjDjcjDjXnBrJ_TvsFrEriB7BzP7GzyB3D3XnG7kBr2B_wJna_1ErnB_gHnLv-BzKz3BnGnfrEnVrJ7pBnGnarEvR7G7azF7VvHvlBjInanL_dvM3hBjDvH3SrsB3DzKvCjI7GnVArE0FnLkD7GgF_JgFvHsEnGoGzKoG_J0KzP4IvM4InL0KvM8LjNwCvCkI_JoBTkNrJ0KvHgK7GwHrEgFvC8G3DoLnGsJrEgFvCgjB7QgP7GoavM4N7GoQjI0PjIsO3IwRzKk1B7fgoB_TkcjNkNzFgKrEokBnQsTnGgyBjNwbrJ8L_EokB7Q0UnLssBrYwWvMkX3N0KjIsJ3I0KvMsJ3N8BvCwMnVkI7QgK3X0FnQsE_O4InfsEzPgKzoBgKnkB4I_dgFnQ4D3NkhBzuDwWrvCoG3XgFrYgF3c8BvR8B7Q8BjhBoB_nBAnLA7fTnQnB7pBT_OnBrdAzFTnQAzFT3ITrOArOnBrnBT3hBTriBTnaTzZnBjhBT_nBAvRU3SU_OwCjhBwC3X4DnkBkDnkB8BnVoB3XU3cA7avC74BrEjrBnBrJvCvRjD7V7GnkB_JnpBzPzyBriB7vDvWzmC_O_2B_ErTrE_TzFzjB_EzjBjDriB7BzeT7LnBrsB7BjqEArTArETvgBTnVnB3rBnBjNnBnQjDze3DnfzF7kB_EnanBjI7BrJvHzjBrJ3rB7B3IzP79BzPv5BjI7f7G_Y7L_sBjDzKzFrT3NvvB_T_lCjNvvB7fr8D3DrO_O_7BnQv-B3N_xBvHzZjDzKnGnV7L7kBvC7G7GrTjI3X_T_2B7G_TnGzUzF3X_EjX_EvgBrE7fT3D7BzZnBzjBUrdAjNoB3SwC7VoB_O8BnQwC7Q4Iv0BoQr5CoB7GgFnf8BnLsEjcwCzZ8BjhBUnVA_Y7BzZvC_Y3DrYrE7VzFnV7GrTzKrYzK_TrO_YrsB3pCnL3S7GjNzF_JrJ7QrJzUzKrd7GjczF7fjIzhCzFjrB3DjXnGjc7GzZ_Jvb7Q7kBvHrOz8B3xDzP7fzKnVrT3rBvR_sB7ajuCrTz8BnGrTnGrTvbn7Crdj9C7LzjB7LvlB_sB30E_OjwB3DnLjD3InB3D_E3S_EnQvHvW3N_nB7Q7uBjD3Inf7xCjmB_-C3I7VrEzK_EvM3SrsBrEzK7L7azP7kB3SjrBjwBnvDn7CnzG7uB3sD3X_2BnQ7kBvWv0BvCzFnLjc_J3cjI3cvCrJvHnfnG3czF_djIvvBnGnpB3DvW7B7LjDvRrEvW3DvRrJvlB7LjrBzF3SnLriB3DzKrJ3c7B_EnG3SzKzevH3X7G_T7VzmCvCjI7GnV7GvWnG_TzFrT7kBr3D7GrYzFnVzF_YjDzP3DrY7BzKzFjwB7BnQ_Ev0BrEnpB7B3ST7GnB_JnBvRvH_vCnGz3BrEzjBvCrT3D7V3InzBjD7Q3DvR3I7pB3InkB3I7fvM3rBnG_TnG3SzFzPjNriBnLnajNvbvHjN7LnVzKnQrJ3N3N7QvM3N7LzK3NrJnV_JnQnGnLjD3IvCrJ3DzF7B_JjDjSvHjNvH3SrOjN3N3InLjDzFrJnQ_E_J_EzK_EjNrO7pBjIvW3DzKzKrTnLvRnLrOzPzPzKvHnLzF_JjD3I7BnLAvMwC_JsEnLgFvMkIrdkSjN8G7LsErJ8BvHAvM7B3N_ErJ_Enf3SvMvHzjB_TriBjS7LnGvCnB7a3N7f7QrEvC3NjI7LjIjX_OzP_JvH_EnG_EnGnGnG3IzF_JrErJ_EjN_E_O3cngD_EzP_E3NvH3S7G7arOr7Bn9Br-Hz8Bn2H3rBjyFnVj4CnL3wBnG3hB3InzBvH79BnGzhCvCzenB_OnBzK7Gj_B_EjmBnLvoCjI_sBjIjmBvR7xC7L31BvC_J3Sr0C7G3hB7Q_qCvHjhBvM74B_J3rBnQvjCnkBnyEnL3wBnQvjCzF3XzKvvBvCjN7B7LnBvHjD7Q7G3wBzFjrBnGv5BrO37D_J72C3D3czFrnBzF7fvH3mB7LvvBzFjXnGrYnG3XrErO3DvMvMjmBnLzoBzK_nB_J_sB_Eze7GzoBnBzKnBnLzF_sBvCrTrJrqCzF7kBjD3SrEvWzFvbrJ7pBzKjwBvHzjBjIjmB_ErY7BzK3NvoCnf7wFrJ7zB7LrlCnG3hBvHrsB_Jz3B_TzuDvHnpB7G3rBvCjX3D3c3DnzBjDn7CnBrsBT3N3DzyBzFztB3D3XvC7QjIvlBjI3hBjIvbjN7uBzKnkB7LjrBjSnnC_Tv8C7VjxDrT7vDnQz6CvCrOzK36B7VzpDzK3wB3D7Q_EnVnQn9BrTzhC7arvC7GjSjDjIrOvlB7QvqBzFvMjSzoBjIzPrdn4BnLvWjDzFnQ7a7LrT_ErJ3N7VjNzU_nBv-BvbnpB7G_JjNrTrJ3NnQzZzP7V7kBj1B_JrOriBnzB_OvWjmBr2B3IvMjwBrqCjrBvoCzjBzhCrYnzBnLnarJnVvMrd_OnpBvH_TzU79B_Tn9BnLjcnargCjNjczFzK3I7QrE7GzFrJjNjSnG3I7G3IzFnG7V3Xna7a3wB7uB_Yvb7G3IrEnGvHrJrJvMrO3S_TjhB3IrO7GnLjInQvH_OjD7GjS3rBrY79Bnfz1CzjB_jDvWj6BnV_xBnQ7fvRzevR7a7QvWnLrOzP_OnLzK3SzPrYrTnfzU7ajSjN3I3hBvWnV_Or2BvlBjiDrgCjsDvoC_dzUrd_T36B3mB77Cz8BjIzF3DvCvW7QvRjN7GnG3XzUnQrOrJjIrJ_JrJzKvHrJ7GjI3IzKjIzK_OrT3S_YzK3N3D_E_J7LrJzKvHvH7L7LrErEzZ7V7fzUvWnLjSzFnLjDrY3D72CnG7ajD3XzFnQ7GvRvH_TvMvb7V3XrY_Y7f3N_TzPvbjS_iBnVjwBvlBv8CnkBz6CnQjrBnVr2B_Yj_BnfvtCrY79BzZ79B_2BvpE3Xj6BvH_TrEzKvbnnCnQ_sBvb7xCvH_YnGrT3Sv-BvRn9B3N3wB7G7V7L_iB_Jna7QrnB_Onf3N_Yrd_xBriB74B3X3rB7GjN3DvHjDzFnG3N3DjIvMnanVv0BjNvgBzFrOzUv0B7G7Q_TnuB_TjrBnav0BzjB_gC_YvvBrE3I7QnfrO_d_Yv5BjNjhBvMjmBnBrEnVzhC_OzyB_JjrB3IvqBjN7nCjD_TrE3cjD3czFz3BnBvWvCjrBTnuBU_nBoBnfAnG8B_dgF_7BsEzjBsOv1D4DvHwCvHwCvMwCnLkDrOoLrsBgFnVwCvMwC_OwCvWwCvgBwC7a8BrJ8B7GkDvHkD_EkDrEkDrEoBUoBA8BnB8BvCUjDA3DT3DT7BnB7BnBjInBnG7BvHvCjIvCrJ3D7L3DzKrE_J_E3InGrJzF7G3IvM_E7G_OnV7QjXjSvW7GjI3IzKzKjNrJ3NzF3IzFrJnGnLzFzKrErJ3DjIzFjN7BvM7BjI7BzKTnGTzKoBvCUjDArET3DTvCT7BnB7BnB7BnBnB3D_J7B7GjDnL7GjmB3DzUjDnQ_E_Y3DrTvC3N3IrxBTnQUrJUnGoBrJoBjDUjDA_ET3DnBjDnBnB7BT7BA7BUjDrEjDzF7B3D3D3InL79BnL3_B7G3mBzFvgB_EzejD3SkDjDgF7GwHvMgF_J4InQsE3NwCnL8GnzBoB7LsEvWgFrO4crlCgFzP4D3NwCvWAjSjDjc7B7LnV7tE7L7xCnBjST3hBnB3qEsE7wFkDj0EoBj1BUzeArJTjN3DjS3DjNvWj6B_J3X7BrEzF_JjXnf3Xv0BnQ3hB3DnG7GrJvbvgBrOzP7UtlB";

//     var pol = "BGw22w3Do0iqOge0jB8L0FsJTgKzFwH3IkhQj_fkkWj0sBgFjX8BnVoB_2B";
//     // print("here");
//     // // print(FlexiblePolyline.decode(pol));
//     GeoPolyline polyline = GeoPolyline(FlexiblePolyline.decode(pol));

//     print(polyline);
//     // GeoPolyline routeGeoPolyline = route.geometry;

//     // // print(routeGeoPolyline.vertices);
//     // print(polyline.vertices[0].latitude);
//     // print(polyline.vertices[0].longitude);

//     double widthInPixels = 5;

//     inspect(polyline);

//     MapPolyline routeMapPolyline =
//         MapPolyline(polyline, widthInPixels, kPrimaryColor);
//     _hereMapController.mapScene.addMapPolyline(routeMapPolyline);

//     mapPolylines.add(routeMapPolyline);
//   }

//   showAllRouteOnMap(String embeddedPolyline) {
//     var pol = embeddedPolyline;
//     GeoPolyline polyline = GeoPolyline(FlexiblePolyline.decode(pol));
//     double widthInPixels = 5;

//     inspect(polyline);

//     MapPolyline routeMapPolyline =
//         MapPolyline(polyline, widthInPixels, kPrimaryColor);
//     _hereMapController.mapScene.addMapPolyline(routeMapPolyline);

//     mapPolylines.add(routeMapPolyline);
//   }

//   boudMapWithLatLng(Position position1, Position position2) {
//     var geoBox = GeoBox(GeoCoordinates(position1.lat, position1.lng),
//         GeoCoordinates(position2.lat, position2.lng));
//     var bearing = 45.0; // Set null, to keep bearing unchanged.
//     var tilt = 0.0;
//     var orientation = GeoOrientationUpdate(bearing, tilt);
//     _hereMapController.camera.lookAtAreaWithGeoOrientation(geoBox, orientation);
//   }

//   addMultipleMarkers(Position position) {
//     GeoCoordinates latlng = GeoCoordinates(position.lat, position.lng);
//     MapMarker tollMarker = MapMarker(latlng, tollImage);
//     _hereMapController.mapScene.removeMapMarker(tollMarker);
//     _hereMapController.mapScene.addMapMarker(tollMarker);
//     mapMarkers.add(tollMarker);
//   }

//   addMyMarker(Position position) {
//     GeoCoordinates latlng = GeoCoordinates(position.lat, position.lng);
//     MapMarker myMarker = MapMarker(latlng, mapImage);
//     _hereMapController.mapScene.removeMapMarker(myMarker);
//     _hereMapController.mapScene.addMapMarker(myMarker);
//     mapMarkers.add(myMarker);
//   }

//   addDestMarker(Position position) {
//     GeoCoordinates latlng = GeoCoordinates(position.lat, position.lng);
//     MapMarker destMarker = MapMarker(latlng, otherImage);
//     _hereMapController.mapScene.removeMapMarker(destMarker);
//     _hereMapController.mapScene.addMapMarker(destMarker);
//     mapMarkers.add(destMarker);
//   }

//   GeoCoordinates _createRandomGeoCoordinatesInViewport() {
//     GeoBox? geoBox = _hereMapController.camera.boundingBox;
//     if (geoBox == null) {
//       // Happens only when map is not fully covering the viewport.
//       return GeoCoordinates(52.530932, 13.384915);
//     }

//     GeoCoordinates northEast = geoBox.northEastCorner;
//     GeoCoordinates southWest = geoBox.southWestCorner;

//     double minLat = southWest.latitude;
//     double maxLat = northEast.latitude;
//     double lat = _getRandom(minLat, maxLat);

//     double minLon = southWest.longitude;
//     double maxLon = northEast.longitude;
//     double lon = _getRandom(minLon, maxLon);

//     return GeoCoordinates(lat, lon);
//   }

//   double _getRandom(double min, double max) {
//     return min;
//     // return min + Random().nextDouble() * (max - min);
//   }

//   ///route dettail maps starts from here
//   ///
//   ///
//   routeDetailMap(HereMapController hereMapController, int index) {
//     try {
//       var data = placeController.availRoutes[index]['sections'][0]['departure']
//           ['place']['location'];

//       hereMapController.camera.lookAtPointWithMeasure(
//           GeoCoordinates(data['lat'], data['lng']),
//           MapMeasure(MapMeasureKind.distance, 1000000));
//       routeDetailPath(hereMapController, index);
//     } catch (e) {
//       print(e);
//     }
//     // try {
//     //   _routingEngine = RoutingEngine();
//     // } on InstantiationException {
//     //   throw ("Initialization of RoutingEngine failed.");
//     // }
//   }

//   routeDetailPath(HereMapController hereMapController, int index) {
//     var sections = placeController.availRoutes[index]['sections'];
//     for (var section in sections) {
//       var pol = section['polyline'];
//       GeoPolyline polyline = GeoPolyline(FlexiblePolyline.decode(pol));
//       double widthInPixels = 5;

//       MapPolyline routeMapPolyline =
//           MapPolyline(polyline, widthInPixels, kPrimaryColor);
//       hereMapController.mapScene.addMapPolyline(routeMapPolyline);

//       if (section['tolls'] != null) {
//         for (var toll in section['tolls']) {
//           var loc = toll['tollCollectionLocations'][0]['location'];
//           Position position = Position(lat: loc['lat'], lng: loc['lng']);
//           hereMapController.mapScene.addMapMarker(
//               MapMarker(GeoCoordinates(position.lat, position.lng), tollImage));
//         }
//       }
//     }

//     var start = sections[0]['departure']['place']['location'];
//     var end = sections[sections.length - 1]['arrival']['place']['location'];

//     hereMapController.mapScene.addMapMarker(
//         MapMarker(GeoCoordinates(start['lat'], start['lng']), mapImage));
//     hereMapController.mapScene.addMapMarker(
//         MapMarker(GeoCoordinates(end['lat'], end['lng']), otherImage));
//   }

//   Future<Uint8List> toMarkerIcon(
//       String svgString, double width, double height) async {
//     final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");
//     final Picture picture =
//         svgDrawableRoot.toPicture(size: Size(width, height));
//     final img = await picture.toImage(width.toInt(), height.toInt());
//     final data = await img.toByteData(format: ImageByteFormat.png);
//     return data!.buffer.asUint8List();
//   }
// }
