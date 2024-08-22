// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Place {
  String? title;
  String? id;
  String? resultType;
  Position? position;
  Object? access;
  Address? address;

  Place(
      {this.title,
      this.id,
      this.access,
      this.address,
      this.position,
      this.resultType});

  factory Place.fromjson(Map<String, dynamic> json) {
    return Place(
      access: json['access'],
      address: Address.fromjson(json['address']),
      position: Position.fromjson(json['position']),
      id: json['id'],
      resultType: json['resultType'],
      title: json['title'],
    );
  }
}

class Address {
  String? label;
  String? countryCode;
  String? countryName;
  String? state;
  String? county;
  String? city;
  String? street;
  String? postalCode;

  Address({
    this.label,
    this.countryCode,
    this.countryName,
    this.city,
    this.county,
    this.postalCode,
    this.state,
    this.street,
  });

  factory Address.fromjson(Map<String, dynamic> json) {
    return Address(
        city: json['city'],
        countryCode: json['countryCode'],
        countryName: json['countryName'],
        county: json['county'],
        label: json['label'],
        postalCode: json['postalCode'],
        state: json['state'],
        street: json['street']);
  }
}

class Position {
  double lat;
  double lng;
  Position({required this.lat, required this.lng});
  factory Position.fromjson(Map<String, dynamic> json) {
    return Position(lat: json['lat'], lng: json['lng']);
  }
}

class GooglePlacesModel {
  String description;
  String mainText;
  String placeId; //place_id
  Position? position;
  GooglePlacesModel({
    required this.description,
    required this.placeId,
    required this.mainText,
    this.position,
  });

  factory GooglePlacesModel.fromJson(Map<String, dynamic> json) {
    return GooglePlacesModel(
        description: json['description'],
        mainText: json['main_text'],
        placeId: json['place_id'],
        position: json['position']);
  }
}

class CityModel {
  int id;
  String name;
  String latitude;
  String longitude;
  Position? position;
  CityModel(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      this.position});

  CityModel copyWith({
    int? id,
    String? name,
    String? latitude,
    String? longitude,
    Position? position,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      "position": position
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as int,
      name: map['name'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      // position: map['position'] as Position,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CityModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ latitude.hashCode ^ longitude.hashCode;
  }
}
