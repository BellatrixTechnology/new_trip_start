// import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_trip_start/constants.dart';

import 'package:new_trip_start/models/places.model.dart';
// import 'package:new_trip_start/models/toll.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/services/index.dart';

// import 'package:xml/xml.dart';
// import 'package:xml2json/xml2json.dart';

class ApiService {
  var dio = Dio(BaseOptions(
    // headers: {'Content-Type': 'application/json'},
    contentType: 'application/json',
  ));

  var baseURL =
      "https://us-central1-car-app-5b455.cloudfunctions.net/app"; //"http://localhost:5000/car-app-5b455/us-central1/app";

  var url = "https://api.bompengeappen.no/v1";
  var urlApi = "https://api.bompengeappen.no/api";

  Future<Response> getVehicleDataWithRegistrationNum(String regNum) async {
    Response response;
    var headerData = {
      'SVV-Authorization': '4df86f6c-0ebc-40e8-adf4-45f23d6e5252',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var url =
        // 'https://www.vegvesen.no/ws/no/vegvesen/kjoretoy/kjoretoyoppslag/v1/kjennemerkeoppslag/kjoretoy/AA12345&lang=en';
        kIsWeb
            ? 'https://polar-mountain-09929.herokuapp.com/https://www.vegvesen.no/ws/no/vegvesen/kjoretoy/felles/datautlevering/enkeltoppslag/kjoretoydata?kjennemerke=$regNum'
            : 'https://www.vegvesen.no/ws/no/vegvesen/kjoretoy/felles/datautlevering/enkeltoppslag/kjoretoydata?kjennemerke=$regNum&lang=en';

    response = await dio.get(url,
        options: Options(
          headers: headerData,
        ));
    return response;
  }

  Future<Response> getData() async {
    Response response;
    var headerData = {
      'SVV-Authorization': '4df86f6c-0ebc-40e8-adf4-45f23d6e5252',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var url =
        'https://www.vegvesen.no/ws/no/vegvesen/routeplan/routingService_v1_0/routingService?stops=277648.71063131,6760327.2812364;292465.40693137,6695768.8187861&returnDirections=true&returnGeometry=true&format=xml';
    response = await dio.get(url, options: Options(headers: headerData));
    // log(response.data.toString());
    return response;
  }

  Future<Response> getPlaceByKeyWords(String keywords) async {
    Response response = await dio.get(
        'https://geocode.search.hereapi.com/v1/geocode?q=$keywords&in=countryCode%3ANOR&limit=6&apiKey=$hereApiKey'
        // 'https://autocomplete.search.hereapi.com/v1/autocomplete?q=$keywords&in=countryCode%3ANOR&limit=2&apiKey=8ZI4V33ffRb_xelYDekkMJL4pAVM47fCa2eb82sog6s'
        );
    return response;
  }

  Future<Response?> searchPlaces(String text) async {
    Response response;
    try {
      String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&key=$mapApiKey&components=country:NO";

      response = await dio.get(url);
      return response;
    } on DioException catch (e) {
      // print(e);
      if (e.response != null) {
        return e.response;
      } else {
        return null;
      }
    }
  }

  Future<Response> getResultForSearchedPlaces(String text) async {
    // http://13.49.48.45:3000/v1/cities?keyword=oslo
    return await dio.get("$url/cities?keyword=$text");
  }

  Future<Response> getPlaceDetailsFromPlaceId(String placeId) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$mapApiKey";
    print(url);
    return await dio.get(url);
  }

  // get toll cost
  // https://fleet.ls.hereapi.com/2/calculateroute.json?apiKey=8ZI4V33ffRb_xelYDekkMJL4pAVM47fCa2eb82sog6s&mode=fastest;car;traffic:disabled&driver_cost=0&waypoint0=59.9138688,10.7522454&waypoint1=63.4305149,10.3950528&tollVehicleType=car&vehicle_cost=0&currency=NOK

  //get fuel cost
  // https://www.globalpetrolprices.com/api_gpp.php?cnt=NO&ind=gp,dp&prd=latest&uid=2554&uidc=fa4f1abfaf33b809fc521ca81061053a

  //get routes and tolls
  // https://router.hereapi.com/v8/routes?origin=60.0078531,11.0154395&destination=59.8267105,10.3816563&return=tolls&transportMode=car&departureTime=2021-01-01T21:00:00&currency=USD&alternatives=6&apikey=8ZI4V33ffRb_xelYDekkMJL4pAVM47fCa2eb82sog6s&tollPass=AutoPass

// get tolls, polylines, summary,
  // https://router.hereapi.com/v8/routes?origin=60.0078531,11.0154395&destination=59.8267105,10.3816563&return=polyline,travelSummary,tolls&currency=NOK&spans=tollSystems&transportMode=car&tolls[summaries]=total&tolls[vignettes]=all&alternatives=6&apikey=8ZI4V33ffRb_xelYDekkMJL4pAVM47fCa2eb82sog6s

  Future<Response> getAllData(Position origin, Position destination) async {
    Response response = await dio.get(
        'https://router.hereapi.com/v8/routes?origin=${origin.lat},${origin.lng}&destination=${destination.lat},${destination.lng}&return=polyline,travelSummary,tolls&currency=NOK&spans=tollSystems&transportMode=car&tolls[summaries]=total&tolls[vignettes]=all&alternatives=3&apikey=$hereApiKey');
    return response;
  }

  Future<Response> getFuelData() async {
    String url =
        'https://www.globalpetrolprices.com/api_gpp.php?cnt=NO&ind=gp,dp&prd=latest'
        '&uid=2554&uidc=fa4f1abfaf33b809fc521ca81061053a';
    print(url);
    Response response = await dio.get(url);
    return response;
  }

  Future<Response> getRouteData(
      Position start, Position end, Vehicle veh) async {
    String apiUrl =
        // "https://us-central1-car-app-5b455.cloudfunctions.net/direction/v2?origin=${start.lat},${start.lng}&destination=${end.lat},${end.lng}&vehicleGroup=${veh.vehicleGroup}&vehLength=${veh.vehLength}&vehFuelCmp=${double.parse(veh.vehFuelCmp!) / 10}&vehFuelType=${veh.vehFuelType}";
        "https://api.bompengeappen.no"; //"$baseURL/directions";
// https://api.bompengeappen.no/?origin=59.9138688,10.7522454&destination=61.83780729999999,8.5685637&vehicleGroup=1&vehLength=14.6&vehFuelCmp=5.390000000000001&vehFuelType=Bensin&awaisjaved458@gmail.com
    print("apiUrl $apiUrl");
    // print("veh.toMap() ${veh.toMap()}");
    print(srvUser.user.token);
    print({
      "origin": "${start.lat},${start.lng}",
      "destination": "${end.lat},${end.lng}",
      "vehicleGroup": veh.vehicleGroup,
      "vehFuelType": veh.vehFuelType,
      "vehFuelCmp": double.parse(veh.vehFuelCmp ?? "0"),
      "cache": true,
      "geometry": true,
      "coordinates": true,
      "vehLength": veh.vehLength,
      "type": "gas",
      "travelMode": "driving"
    });

    return dio.post(
      apiUrl,
      data: {
        "origin": "${start.lat},${start.lng}",
        "destination": "${end.lat},${end.lng}",
        "vehicleGroup": veh.vehicleGroup ?? "M1",
        "vehFuelType": veh.vehFuelType ?? "petrol",
        "vehFuelCmp": double.parse(veh.vehFuelCmp ?? "10"),
        "cache": true,
        "geometry": true,
        "coordinates": true,
        "vehLength": veh.vehLength,
        "type": "gas",
        "travelMode": "driving"
      },
      options: Options(
          receiveTimeout: const Duration(minutes: 2),
          sendTimeout: const Duration(minutes: 2),
          headers: {
            "x-token": srvUser.user.token,
          }),
    );
    // return await dio.post(apiUrl, data: data);
  }

  Future<Response> getTolls(String summary, Vehicle veh, int distance) async {
    String url =
        "https://us-central1-car-app-5b455.cloudfunctions.net/direction/v2/tolls?summary=$summary&vehicleGroup=${veh.vehicleGroup}&vehLength=${veh.vehLength}&vehFuelCmp=${double.parse(veh.vehFuelCmp!) / 10}&vehFuelType=${veh.vehFuelType}&distance=$distance";
    print(url);
    return await dio.get(url);
  }

  Map<String, double> parsePoint(String input) {
    Map<String, double> point = {};
    RegExp regex = RegExp(r"([-+]?\d*\.\d+|\d+)");

    List<double> values = regex
        .allMatches(input)
        .map((match) => double.parse(match.group(0)!))
        .toList();
    if (input.contains("POINT Z")) {
      point['easting'] = values[0];
      point['northing'] = values[1];
      point['altitude'] = values[2];
    } else {
      point['easting'] = values[0];
      point['northing'] = values[1];
    }

    return point;
  }

//  distance between two points
  Map<String, dynamic> findNearestPoint(
      Map<String, double> inputPoint, List<Map<String, dynamic>> tollList) {
    // initialize the nearest point id and the minimum distance
    Map<String, dynamic> nearestPointId = {};
    double minDistance = double.infinity;
    for (var e in tollList) {
      // create a local point from the wkt string
      Map<String, double> localPoint;
      if (e['vegobjekt']['geometri']['wkt'] != null) {
        localPoint = parsePoint(e['vegobjekt']['geometri']['wkt'] ?? "");
      } else {
        continue;
      }
      // calculate  the distance between the two points
      double distance = sqrt(
          pow((inputPoint['easting']! - localPoint['easting']!), 2) +
              pow(inputPoint['northing']! - localPoint['northing']!, 2));
      if (distance < minDistance) {
        minDistance = distance;
        nearestPointId = e['vegobjekt'];
      }
    }

    return nearestPointId;
  }

  //
  Future<Response> refetchRoutesOnServer(
      String origin, String destination) async {
    return await dio.get(
        "https://us-central1-car-app-5b455.cloudfunctions.net/direction/route?origin=$origin&destination=$destination");
  }

  //post get put delete methods

  Future<Response> post(
      {Map<String, dynamic>? data,
      required String concaturl,
      Map<String, dynamic>? headers,
      bool? addHeaders}) async {
    print(" post url -> ${'$url/$concaturl'}");
    print(" post data -> $data");
    // print(addHeaders == true
    //     ? Options(headers: headers ?? getHeader())
    //     : Options());
    return await dio.post(
      '$url/$concaturl',
      data: data,
      options: addHeaders == true
          ? Options(headers: headers ?? getHeader())
          : Options(headers: {}),
    );
  }

  Future<Response> apiUrlpost(
      {Map<String, dynamic>? data,
      required String concaturl,
      Map<String, dynamic>? headers,
      bool? addHeaders}) async {
    print(" post url -> ${'$urlApi/$concaturl'}");
    print(" post data -> $data");
    print(getHeader());
    return await dio.post(
      '$urlApi/$concaturl',
      data: data,
      options: Options(headers: headers ?? getHeader()),
    );
  }

  Future<Response> apiUrlput(
      {Map<String, dynamic>? data,
      required String concaturl,
      Map<String, dynamic>? headers,
      bool? addHeaders}) async {
    print(" put url -> ${'$urlApi/$concaturl'}");
    print(" put data -> $data");
    print(" put header -> ${getHeader()}");
    return await dio.put(
      '$urlApi/$concaturl',
      data: data,
      options: Options(headers: headers ?? getHeader()),
    );
  }

  Future<Response> put({
    Map<String, dynamic>? data,
    String? concaturl,
    String? url,
  }) async {
    print(" get url -> ${'$url/$concaturl'}");
    print(" get data -> $data");
    print(" put header -> ${getHeader()}");
    return await dio.put(
      '$url/$concaturl',
      data: data,
      options: Options(headers: getHeader()),
    );
  }

  Future<Response> apiUrlget({
    Map<String, dynamic>? data,
    String? concaturl,
  }) async {
    srvShared.printWrapped(" get url -> ${'$urlApi/$concaturl'}");
    srvShared.printWrapped(" get data -> $data");
    srvShared.printWrapped(" get headers -> ${getHeader()}");
    return await dio.get(
      '$urlApi/$concaturl',
      data: data,
      options: Options(headers: getHeader()),
    );
  }

  Future<Response> get({
    Map<String, dynamic>? data,
    String? concaturl,
  }) async {
    srvShared.printWrapped(" get url -> ${'$url/$concaturl'}");
    srvShared.printWrapped(" get data -> $data");
    srvShared.printWrapped(" get headers -> ${getHeader()}");
    return await dio.get(
      '$url/$concaturl',
      data: data,
      options: Options(headers: getHeader()),
    );
  }

  Future<Response> getWithoutHeader(
      {Map<String, dynamic>? data, String url = ""}) async {
    print(" getWithoutHeader url -> $url");
    print(" getWithoutHeader data -> $data");
    return await dio.get(url, data: data);
  }

  Future<Response> delete(
      {Map<String, dynamic>? data, String? concaturl, String? url}) async {
    print(" delete url -> $url");
    print(" delete data -> $data");
    return await dio.delete(
      url ?? '$url/$concaturl',
      data: data,
      // options: Options(headers: getHeader()),
    );
  }

  Future<Response> apiUrlDelete(
      {Map<String, dynamic>? data, String? concaturl, String? url}) async {
    print(" delete url -> $concaturl");
    print(" delete data -> $data");
    return await dio.delete(
      '$urlApi/$concaturl',
      data: data,
      options: Options(headers: getHeader()),
    );
  }

  getHeader() {
    return {"x-token": srvUser.user.token};
  }

  // end post get put delete methods
}
