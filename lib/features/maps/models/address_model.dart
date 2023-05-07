class AddressModel {
  int? id;


  String? address;

  String? latitude;
  String ?longitude;
  String ?cityName;

  AddressModel(
      {this.id,

      this.address,
      this.latitude,
      this.longitude,
        this.cityName

      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    return data;
  }
}
