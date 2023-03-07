import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:utm/utm.dart';

class ApiService {
  var dio = Dio();
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
        options: Options(headers: headerData, receiveTimeout: 8000));
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
    response = await dio.get(url,
        options: Options(headers: headerData, receiveTimeout: 8000));
    log(response.data.toString());
    return response;
  }

  Future<Response> getPlaceByKeyWords(String keywords) async {
    Response response = await dio.get(
        'https://geocode.search.hereapi.com/v1/geocode?q=$keywords&in=countryCode%3ANOR&limit=6&apiKey=$hereApiKey'
        // 'https://autocomplete.search.hereapi.com/v1/autocomplete?q=$keywords&in=countryCode%3ANOR&limit=2&apiKey=8ZI4V33ffRb_xelYDekkMJL4pAVM47fCa2eb82sog6s'
        );
    return response;
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

  Future<Response> getFuelData(String totalDis, String tollCost) async {
    String url =
        'https://www.globalpetrolprices.com/api_gpp.php?cnt=NO&ind=gp,dp&prd=latest'
        '&uid=2554&uidc=fa4f1abfaf33b809fc521ca81061053a';
    // print(url);
    Response response = await dio.get(url);
    return response;
  }

  Future<Response> getRouteData(String stops) async {
    // Define the URL for the Routing Service
    // 277648.71063131,6760327.2812364;292465.40693137,6695768.8187861
    // const stops =
    //     "278533.80079608515,6658558.8728278065;93895.00050445361,6909396.81459309";
    // "261956.33112242934,6649777.651720167;249859.3503714263,6647664.398433175"; //oslo and sandvika (*.*)
    // "264542.8162633929,6646911.956227346;263162.1650432468,6652896.618364637;292465.40693137,6695768.8187861"; // multiple stops
    // '263162.1650432468,6652896.618364637;292465.40693137,6695768.8187861'; //oslo and req stops
    // '277648.71063131,6760327.2812364;292465.40693137,6695768.8187861'; //request stops

    String apiUrl =
        'https://www.vegvesen.no/ws/no/vegvesen/ruteplan/routingService_v2_0/routingService?stops=$stops&returnDirections=true&returnGeometry=true&lang=en-US&format=json'; //&route_type=alternative

    print(apiUrl);
    String username = 'TjeRuteplanJaved';
    String password = 'Yd2H7q0SNjF5dpwEKzQO';

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await dio.get(apiUrl,
        options: Options(headers: <String, String>{
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': basicAuth
        }));

    return response;

    // List<dynamic> latLngList = [];
    // for (var element in path) {
    //   latLngList.add(element['geometry']['paths'][0].map((point) {
    //     int easting = point[0];
    //     int northing = point[1];
    //     UtmCoordinate coordinate = srvOsGridConverter.utmToLatlong(
    //         easting.toDouble(), northing.toDouble());
    //     double latitude = coordinate.lat;
    //     double longitude =
    //         coordinate.lon; // convert UTM easting/northing to WGS84 longitude
    //     return [latitude, longitude];
    //   }).toList());
    // }

    // return latLngList;
  }
}
