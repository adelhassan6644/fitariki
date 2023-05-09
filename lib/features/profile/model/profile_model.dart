// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import '../../../main_models/weak_model.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

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
  int? id;
  String? firstName;
  dynamic lastName;
  dynamic email;
  dynamic emailVerifiedAt;
  DateTime? phoneVerifiedAt;
  dynamic image;
  dynamic password;
  dynamic nickname;
  dynamic gender;
  dynamic age;
  dynamic national;
  dynamic city;
  dynamic countryId;
  String? phone;
  dynamic status;
  dynamic rate;
  int? wallet;
  DateTime? createdAt;
  DateTime? updatedAt;
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
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.image,
    this.password,
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
    this.createdAt,
    this.updatedAt,
    this.lat,
    this.long,
    this.pickLocation,
    this.endLocation,
    this.driverDays,
  });

  Driver copyWith({
    int? id,
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
    int? wallet,
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
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
        image: image ?? this.image,
        password: password ?? this.password,
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
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        pickLocation: pickLocation ?? this.pickLocation,
        endLocation: endLocation ?? this.endLocation,
        driverDays: driverDays ?? this.driverDays,
      );

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
    image: json["image"],
    password: json["password"],
    nickname: json["nickname"],
    gender: json["gender"],
    age: json["age"],
    national: json["national"],
    city: json["city"],
    countryId: json["country_id"],
    phone: json["phone"],
    status: json["status"],
    rate: json["rate"],
    wallet: json["wallet"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    lat: json["lat"],
    long: json["long"],
    pickLocation: json["pick_location"],
    endLocation: json["end_location"],
    driverDays: json["driver_days"] == null ? [] : List<WeekModel>.from(json["driver_days"]!.map((x) => WeekModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
    "image": image,
    "password": password,
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "lat": lat,
    "long": long,
    "pick_location": pickLocation,
    "end_location": endLocation,
    "driver_days": driverDays == null ? [] : List<dynamic>.from(driverDays!.map((x) => x.toJson())),
  };
}

