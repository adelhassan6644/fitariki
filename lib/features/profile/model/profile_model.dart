import '../../../main_models/weak_model.dart';

class ProfileModel {
  Driver? driver;

  ProfileModel({
    this.driver,
  });

  ProfileModel copyWith({
    Driver? driver,
  }) =>
      ProfileModel(
        driver: driver ?? this.driver,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "driver": driver?.toJson(),
      };
}

class Driver {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? nickname;
  int? gender;
  String? age;
  String? national;
  String? city;
  dynamic countryId;
  String? phone;
  dynamic status;
  dynamic rate;
  double? wallet;
  dynamic lat;
  dynamic long;
  dynamic pickLocation;
  dynamic endLocation;
  List<WeekModel>? driverDays;

  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.nickname,
    this.gender,
    this.age,
    this.national,
    this.city,
    this.countryId,
    this.phone,
    this.status,
    this.rate,
    this.wallet,
    this.lat,
    this.long,
    this.pickLocation,
    this.endLocation,
    this.driverDays,
  });

  Driver copyWith({
    String? id,
    String? firstName,
    dynamic lastName,
    dynamic email,
    dynamic emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    dynamic image,
    dynamic password,
    dynamic nickname,
    dynamic gender,
    dynamic age,
    dynamic national,
    dynamic city,
    dynamic countryId,
    String? phone,
    dynamic status,
    dynamic rate,
    double? wallet,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic lat,
    dynamic long,
    dynamic pickLocation,
    dynamic endLocation,
    List<WeekModel>? driverDays,
  }) =>
      Driver(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        image: image ?? this.image,
        nickname: nickname ?? this.nickname,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        national: national ?? this.national,
        city: city ?? this.city,
        countryId: countryId ?? this.countryId,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        rate: rate ?? this.rate,
        wallet: wallet ?? this.wallet,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        pickLocation: pickLocation ?? this.pickLocation,
        endLocation: endLocation ?? this.endLocation,
        driverDays: driverDays ?? this.driverDays,
      );

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"].toString(),
        firstName: json["first_name"].toString(),
        lastName: json["last_name"].toString(),
        email: json["email"].toString(),
        image: json["image"],
        nickname: json["nickname"],
        gender: int.parse(json["gender"] ?? "0"),
        age: json["age"].toString(),
        national: json["national"],
        city: json["city"],
        countryId: json["country_id"],
        phone: json["phone"],
        status: json["status"],
        rate: json["rate"],
        wallet: double.parse(json["wallet"].toString() ),
        lat: json["lat"],
        long: json["long"],
        pickLocation: json["pick_location"],
        endLocation: json["end_location"],
        driverDays: json["driver_days"] == null
            ? []
            : List<WeekModel>.from(
                json["driver_days"]!.map((x) => WeekModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "image": image,
        "nickname": nickname,
        "gender": gender,
        "age": age,
        "national": national,
        "city": city,
        "country_id": countryId,
        "phone": phone,
        "status": status,
        "rate": rate,
        "wallet": wallet,
        "lat": lat,
        "long": long,
        "pick_location": pickLocation,
        "end_location": endLocation,
        "driver_days": driverDays == null
            ? []
            : List<dynamic>.from(driverDays!.map((x) => x.toJson())),
      };
}
