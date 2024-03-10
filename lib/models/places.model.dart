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
  String placeId; //place_id
  Position? position;
  GooglePlacesModel({
    required this.description,
    required this.placeId,
    this.position,
  });

  factory GooglePlacesModel.fromJson(Map<String, dynamic> json) {
    return GooglePlacesModel(
        description: json['description'],
        placeId: json['place_id'],
        position: json['position']);
  }
}
