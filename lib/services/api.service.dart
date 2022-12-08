import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
}
