class LocationModel {
  int? id;
  String? latitude;
  String? longitude;
  String? address;
  String? cityName;

  LocationModel(
      {this.id, this.address, this.latitude, this.longitude, this.cityName});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;

    return data;
  }
}
