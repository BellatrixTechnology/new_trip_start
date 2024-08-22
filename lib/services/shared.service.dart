import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_trip_start/models/places.model.dart';
import 'package:new_trip_start/models/vehicle.model.dart';
import 'package:new_trip_start/services/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class SharedService {
  anyTypeToDouble(val, [bool? forceNull = false]) {
    if (val == null) return forceNull == true ? null : 0.0;
    return val.runtimeType == double ? val : double.tryParse(val.toString());
  }

  lauchUrl(String url) async {
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDateAndManipulateHere(GooglePlacesModel startPlace,
      GooglePlacesModel endPlace, Vehicle carData) async {
    debugPrint("api called");
    var response = await srvApi.getRouteData(
        startPlace.position!, endPlace.position!, carData);
    debugPrint("api called");
    if (response.statusCode == 200) {
      var data = response.data['data'];
      if (data.length > 0) {
        for (var point in data['coordinates']) {
          data['coordinates']
              .add(LatLng(point['latitude'], point['longitude']));
        }
        return data;
      } else {
        srvToastAlert.toast("No Route Found");
      }
    }
  }

  String convertMinutesToHoursAndMinutes(String input) {
    // print("inpute $input");
    // Extract the numeric part from the input string
    int totalMinutes = int.tryParse(input.split('.')[0]) ?? 0;

    // Calculate hours and remaining minutes
    int hours = totalMinutes ~/ 60;
    int remainingMinutes = totalMinutes % 60;

    // Build the result string
    String result = '';
    if (hours > 0) {
      result += '${hours}h';
      if (remainingMinutes > 0) {
        result += ' & ';
      }
    }
    if (remainingMinutes > 0) {
      result += '${remainingMinutes}m';
    }

    // print("result $result");

    return result.isNotEmpty
        ? result
        : '0 mins'; // Default to '0 mins' if input is invalid or zero
  }

  createDate(String _createdAt, [String? format]) {
    var createdAt = DateTime.parse(_createdAt);
    return DateFormat(format ?? 'MMMM dd, yyyy hh:mm a').format(createdAt);
  }

  void printWrapped(dynamic text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text.toString())
        // ignore: avoid_print
        .forEach((match) => print(match.group(0)));
  }
}
