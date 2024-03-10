import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

// import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:utm/utm.dart';

class OsGridConverter {
  // LatLongConverter converter = LatLongConverter();

  // void yourFunction(double lat, double long) {
  //   OSRef result = converter.getOSGBfromDec(lat, long, Datums.ED50);
  //   print("${result.easting} ${result.northing}");
  // }

  // LatLong osToLatLng(int easting, int northing) {
  //   var result =
  //       converter.getLatLongFromOSGB(easting, northing, Datums.WGS84);
  //   print("${result.lat} ${result.long}");
  //   return result;
  // }

  // void yourFunctionOne(String letterRef) {
  //   LatLong result = converter.getLatLongFromOSGBLetterRef(letterRef);
  //   print("${result.lat} ${result.long}");
  // }

  // //you can also define your own OSRef object
  // void yourOtherFunction(OSRef os) {
  //   LatLong result = converter.getLatLongFromOSGB(os.easting, os.northing);
  //   print("${result.lat} ${result.long}");
  // }

  // void yourOtherFunctionOne(OSRef os) {
  //   LatLong result = converter.getLatLongFromOSGBLetterRef(os.letterRef);
  //   print("${result.lat} ${result.long}");
  // }

  // void usingObjects() {
  //   LatLong latL = LatLong(59.945167, 10.758978, 0, Datums.ETRS89);
  //   OSRef osReference = latL.toOsGrid();
  //   print(osReference
  //       .numericalRef); //will output the easting and northing as above
  //   print(
  //       osReference.letterRef); //will output the letter pair reference as above
  // }

  // void usingConverter() {
  //   OSRef result = converter.getOSGBfromDec(59.892365, 10.790427, Datums.WGS84);
  //   print(result.northing.toString());
  //   print(result.easting.toString());
  //   // print(
  //   //     "${result.numericalRef}"); //will output the easting and northing (460334 452192)
  //   // print(
  //   //     "${result.letterRef}"); //will output the letter pair reference (SE 60334 52192)
  // }

  UtmCoordinate utmToLatlong(int easting, int northing) {
    // input UTM coordinates (example)
    // double easting = 600181.9909578746;
    // double northing = 6640778.495358432;
    int zoneNumber = 33;
    String zoneLetter = 'N';

// convert UTM to WGS84 lat/long
    UtmCoordinate latLng = UTM.fromUtm(
        easting: easting.toDouble(),
        northing: northing.toDouble(),
        zoneLetter: zoneLetter,
        zoneNumber: zoneNumber,
        type: GeodeticSystemType.wgs84);
    return latLng;

// print result
  }

  utmConverter(double lat, double long) {
    double a = 6378137; // Semi-major axis of the ellipsoid (m)
    double f = 1 / 298.257223563; // Flattening of the ellipsoid
    double k0 = 0.9996; // Scale factor

    double latitude = 59.945167; // WGS84 latitude (decimal degrees)
    double longitude = 10.758978; // WGS84 longitude (decimal degrees)

    double lonRad = longitude * pi / 180; // Convert longitude to radians
    double latRad = latitude * pi / 180; // Convert latitude to radians

    // Calculate UTM zone
    int zone = (longitude + 180) ~/ 6 + 1; // Round down to the nearest integer

    // Define constants for the UTM projection
    double aPrime = a / sqrt(1 - pow(f, 2) * pow(sin(latRad), 2));
    double eSquared = (pow(a, 2) - pow(aPrime, 2)) / pow(a, 2);
    double ePrimeSquared = eSquared / (1 - eSquared);
    double N = a / sqrt(1 - pow(f, 2) * pow(sin(latRad), 2));
    num T = pow(tan(latRad), 2);
    double C = ePrimeSquared * pow(cos(latRad), 2);
    double A = (lonRad - ((zone - 1) * 6 - 180) * pi / 180) * cos(latRad);

    // Calculate UTM coordinates
    double easting = k0 *
            aPrime *
            (A +
                (1 - T + C) * pow(A, 3) / 6 +
                (5 - 18 * T + pow(T, 2) + 72 * C - 58 * ePrimeSquared) *
                    pow(A, 5) /
                    120) +
        500000;
    double northing = k0 *
        (N * (latRad - latRad % (pi / 180) + pi / 180 * (4 - (zone % 2) * 2)) +
            N /
                6 *
                pow(cos(latRad), 3) *
                (A -
                    pow(A, 3) / 6 * (1 - T + C + 5 * C * pow(cos(latRad), 2))) *
                pow(cos(latRad), 3) *
                (A -
                    pow(A, 5) /
                        120 *
                        (5 -
                            18 * T +
                            pow(T, 2) +
                            72 * C -
                            58 * ePrimeSquared)));

    // Print UTM coordinates
    print('UTM Easting: $easting');
    print('UTM Northing: $northing');
  }

  String _getZoneLetter(double lat) {
    if (84 >= lat && lat >= 72) {
      return 'X';
    } else if (72 > lat && lat >= 64) {
      return 'W';
    } else if (64 > lat && lat >= 56) {
      return 'V';
    } else if (56 > lat && lat >= 48) {
      return 'U';
    } else if (48 > lat && lat >= 40) {
      return 'T';
    } else if (40 > lat && lat >= 32) {
      return 'S';
    } else if (32 > lat && lat >= 24) {
      return 'R';
    } else if (24 > lat && lat >= 16) {
      return 'Q';
    } else if (16 > lat && lat >= 8) {
      return 'P';
    } else if (8 > lat && lat >= 0) {
      return 'N';
    } else if (0 > lat && lat >= -8) {
      return 'M';
    } else if (-8 > lat && lat >= -16) {
      return 'L';
    } else if (-16 > lat && lat >= -24) {
      return 'K';
    } else if (-24 > lat && lat >= -32) {
      return 'J';
    } else if (-32 > lat && lat >= -40) {
      return 'H';
    } else if (-40 > lat && lat >= -48) {
      return 'G';
    } else if (-48 > lat && lat >= -56) {
      return 'F';
    } else if (-56 > lat && lat >= -64) {
      return 'E';
    } else if (-64 > lat && lat >= -72) {
      return 'D';
    } else if (-72 > lat && lat >= -80) {
      return 'C';
    } else {
      return "";
    }
  }

  final K0 = 0.9996;

  final E = 0.00669438;
  late final E2 = pow(E, 2);
  late final E3 = pow(E, 3);
  late final E_P2 = E / (1 - E);

  late var SQRT_E = sqrt(1 - E);
  late final _E = (1 - SQRT_E) / (1 + SQRT_E);
  late final _E2 = pow(_E, 2);
  late final _E3 = pow(_E, 3);
  late final _E4 = pow(_E, 4);
  late final _E5 = pow(_E, 5);

  late final M1 = 1 - E / 4 - 3 * E2 / 64 - 5 * E3 / 256;
  late final M2 = 3 * E / 8 + 3 * E2 / 32 + 45 * E3 / 1024;
  late final M3 = 15 * E2 / 256 + 45 * E3 / 1024;
  late final M4 = 35 * E3 / 3072;

  late final P2 = 3 / 2 * _E - 27 / 32 * _E3 + 269 / 512 * _E5;
  late final P3 = 21 / 16 * _E2 - 55 / 32 * _E4;
  late final P4 = 151 / 96 * _E3 - 417 / 128 * _E5;
  late final P5 = 1097 / 512 * _E4;

  final R = 6378137;

  final ZONE_LETTERS = 'CDEFGHJKLMNPQRSTUVWXX';

  fromLatLon(latitude, longitude, forceZoneNum) {
    if (latitude > 84 || latitude < -80) {
      throw RangeError(
          'latitude out of range (must be between 80 deg S and 84 deg N)');
    }
    if (longitude > 180 || longitude < -180) {
      throw RangeError(
          'longitude out of range (must be between 180 deg W and 180 deg E)');
    }

    var latRad = toRadians(latitude);
    var latSin = sin(latRad);
    var latCos = cos(latRad);

    var latTan = tan(latRad);
    var latTan2 = pow(latTan, 2);
    var latTan4 = pow(latTan, 4);

    var zoneNum;

    if (forceZoneNum == null) {
      zoneNum = latLonToZoneNumber(latitude, longitude);
    } else {
      zoneNum = forceZoneNum;
    }

    var zoneLetter = "N"; //latitudeToZoneLetter(latitude);

    var lonRad = toRadians(longitude);
    var centralLon = zoneNumberToCentralLongitude(zoneNum);
    var centralLonRad = toRadians(centralLon);

    var n = R / sqrt(1 - E * latSin * latSin);
    var c = E_P2 * latCos * latCos;

    var a = latCos * (lonRad - centralLonRad);
    var a2 = pow(a, 2);
    var a3 = pow(a, 3);
    var a4 = pow(a, 4);
    var a5 = pow(a, 5);
    var a6 = pow(a, 6);

    var m = R *
        (M1 * latRad -
            M2 * sin(2 * latRad) +
            M3 * sin(4 * latRad) -
            M4 * sin(6 * latRad));
    var easting = K0 *
            n *
            (a +
                a3 / 6 * (1 - latTan2 + c) +
                a5 / 120 * (5 - 18 * latTan2 + latTan4 + 72 * c - 58 * E_P2)) +
        500000;
    var northing = K0 *
        (m +
            n *
                latTan *
                (a2 / 2 +
                    a4 / 24 * (5 - latTan2 + 9 * c + 4 * c * c) +
                    a6 /
                        720 *
                        (61 - 58 * latTan2 + latTan4 + 600 * c - 330 * E_P2)));
    if (latitude < 0) northing += 1e7;

    return {
      "easting": easting,
      "northing": northing,
      "zoneNum": zoneNum,
      "zoneLetter": zoneLetter
    };
  }

  toLatLon(easting, northing, zoneNum, zoneLetter, northern, strict) {
    strict = strict ?? true;

    // if (!zoneLetter && northern == null) {
    //   // throw new Error('either zoneLetter or northern needs to be set');
    // } else if (zoneLetter && northern == null) {
    //   // throw new Error('set either zoneLetter or northern, but not both');
    // }

    if (strict) {
      if (easting < 100000 || 1000000 <= easting) {
        throw RangeError(
            'easting out of range (must be between 100 000 m and 999 999 m)');
      }
      if (northing < 0 || northing > 10000000) {
        throw RangeError(
            'northing out of range (must be between 0 m and 10 000 000 m)');
      }
    }
    if (zoneNum < 1 || zoneNum > 60) {
      throw RangeError('zone number out of range (must be between 1 and 60)');
    }
    if (zoneLetter != null) {
      zoneLetter = zoneLetter.toUpperCase();
      if (zoneLetter.length != 1 || !ZONE_LETTERS.contains(zoneLetter)) {
        throw RangeError('zone letter out of range (must be between C and X)');
      }
      northern = zoneLetter == 'N';
    }

    var x = easting - 500000;
    var y = northing;

    if (!northern) y -= 1e7;

    var m = y / K0;
    var mu = m / (R * M1);

    var pRad = mu +
        P2 * sin(2 * mu) +
        P3 * sin(4 * mu) +
        P4 * sin(6 * mu) +
        P5 * sin(8 * mu);

    var pSin = sin(pRad);
    var pSin2 = pow(pSin, 2);

    var pCos = cos(pRad);

    var pTan = tan(pRad);
    var pTan2 = pow(pTan, 2);
    var pTan4 = pow(pTan, 4);

    var epSin = 1 - E * pSin2;
    var epSinSqrt = sqrt(epSin);

    var n = R / epSinSqrt;
    var r = (1 - E) / epSin;

    var c = _E * pCos * pCos;
    var c2 = c * c;

    var d = x / (n * K0);
    var d2 = pow(d, 2);
    var d3 = pow(d, 3);
    var d4 = pow(d, 4);
    var d5 = pow(d, 5);
    var d6 = pow(d, 6);

    var latitude = pRad -
        (pTan / r) *
            (d2 / 2 - d4 / 24 * (5 + 3 * pTan2 + 10 * c - 4 * c2 - 9 * E_P2)) +
        d6 /
            720 *
            (61 + 90 * pTan2 + 298 * c + 45 * pTan4 - 252 * E_P2 - 3 * c2);
    var longitude = (d -
            d3 / 6 * (1 + 2 * pTan2 + c) +
            d5 /
                120 *
                (5 - 2 * c + 28 * pTan2 - 3 * c2 + 8 * E_P2 + 24 * pTan4)) /
        pCos;

    return {
      latitude: toDegrees(latitude),
      longitude: toDegrees(longitude) + zoneNumberToCentralLongitude(zoneNum)
    };
  }

  toDegrees(rad) {
    return rad / pi * 180;
  }

  toRadians(deg) {
    return deg * pi / 180;
  }

  zoneNumberToCentralLongitude(zoneNum) {
    return (zoneNum - 1) * 6 - 180 + 3;
  }

  latLonToZoneNumber(latitude, longitude) {
    if (56 <= latitude && latitude < 64 && 3 <= longitude && longitude < 12) {
      return 32;
    }

    if (72 <= latitude && latitude <= 84 && longitude >= 0) {
      if (longitude < 9) return 31;
      if (longitude < 21) return 33;
      if (longitude < 33) return 35;
      if (longitude < 42) return 37;
    }

    return (((longitude + 180) / 6) + 1).floor();
  }

  latitudeToZoneLetter(latitude) {
    if (-80 <= latitude && latitude <= 84) {
      return ZONE_LETTERS[((latitude + 80) / 8).floor()];
    } else {
      return null;
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> toMarkerIcon(
      String svgString, double width, double height) async {
    final PictureInfo pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), null);
    final img =
        await pictureInfo.picture.toImage(width.toInt(), height.toInt());
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}
