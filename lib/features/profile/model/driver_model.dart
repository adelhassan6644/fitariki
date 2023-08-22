import 'package:fitariki/features/profile/model/bank_model.dart';
import 'package:fitariki/features/profile/model/country_model.dart';

import '../../../main_models/weak_model.dart';
import '../../maps/models/location_model.dart';

class DriverModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? identityNumber;
  String? identityImage;
  String? nickname;
  int? gender;
  int? requestsCount;
  int? reservationsCount;
  String? age;
  Country? national;
  String? city;
  String? phone;
  String? countryId;
  String? countryFlag;
  String? countryCode;
  String? status;
  double? rate;
  double? wallet;
  double? pendingWallet;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  List<WeekModel>? driverDays;
  CarInfo? carInfo;
  BankInfo? bankInfo;
  DateTime? createdAt;
  DateTime? updatedAt;

  DriverModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.image,
      this.nickname,
      this.identityNumber,
      this.identityImage,
      this.gender,
      this.countryId,
      this.countryFlag,
      this.countryCode,
      this.age,
      this.national,
      this.city,
      this.phone,
      this.status,
      this.rate,
      this.wallet,
      this.pendingWallet,
      this.reservationsCount,
      this.requestsCount,
      this.dropOffLocation,
      this.pickupLocation,
      this.driverDays,
      this.carInfo,
      this.bankInfo,
      this.createdAt,
      this.updatedAt});

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"].toString(),
        countryId: json["country_id"].toString(),
        countryFlag: json["country_flag"].toString(),
        countryCode: json["country_code"].toString(),
        image: json["image"],
        nickname: json["nickname"],
        requestsCount: json["requests_count"] ?? 0,
        reservationsCount: json["reservations_count"] ?? 0,
        gender: json["gender"] == null
            ? null
            : int.parse(json["gender"].toString()),
        age: json["age"] != null ? json["age"].toString() : null,
        national: json["country"] != null
            ? Country.fromJson(
                json["country"],
              )
            : null,
        city: json["city"],
        identityNumber: json["id_number"],
        identityImage: json["id_image"],
        status: json["status"] != null ? json["status"].toString() : null,
        rate: double.tryParse(json["rate"].toString()),
        wallet: json["wallet"] == null
            ? null
            : double.tryParse(json["wallet"].toString()),
        pendingWallet: json["pending_wallet"] == null
            ? null
            : double.tryParse(json["pending_wallet"].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        dropOffLocation: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        pickupLocation: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
        driverDays: json["driver_days"] == null || json["driver_days"] == []
            ? null
            : List<WeekModel>.from(
                json["driver_days"]!.map((x) => WeekModel.fromJson(x))),
        carInfo: json["car_info"] == null
            ? null
            : CarInfo.fromJson(json["car_info"]),
        bankInfo: json["bank_info"] == null
            ? null
            : BankInfo.fromJson(json["bank_info"]),
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
        "country": national?.toJson(),
        "city": city,
        "phone": phone,
        "country_flag": countryFlag,
        "country_code": countryCode,
        "country_id": countryId,
        "status": status,
        "rate": rate,
        "wallet": wallet,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "drop_off_location": dropOffLocation?.toJson(),
        "pickup_location": pickupLocation?.toJson(),
        "driver_days": driverDays == null
            ? []
            : List<dynamic>.from(driverDays!.map((x) => x)),
        "car_info": carInfo?.toJson(),
        "bank_info": bankInfo?.toJson(),
      };
}

class CarInfo {
  String? name;
  String? model;
  String? palletNumber;
  String? color;
  String? seatsCount;
  String? carImage;
  String? licenceImage;
  String? insuranceImage;
  String? formImage;

  CarInfo({
    this.name,
    this.model,
    this.palletNumber,
    this.color,
    this.seatsCount,
    this.carImage,
    this.licenceImage,
    this.insuranceImage,
    this.formImage,
  });

  CarInfo copyWith({
    String? name,
    String? model,
    String? palletNumber,
    String? color,
    String? seatsCount,
    String? carImage,
    String? licenceImage,
    String? insuranceImage,
    String? formImage,
  }) =>
      CarInfo(
        name: name ?? this.name,
        model: model ?? this.model,
        palletNumber: palletNumber ?? this.palletNumber,
        color: color ?? this.color,
        seatsCount: seatsCount ?? this.seatsCount,
        carImage: carImage ?? this.carImage,
        licenceImage: licenceImage ?? this.licenceImage,
        insuranceImage: insuranceImage ?? this.insuranceImage,
        formImage: formImage ?? this.formImage,
      );

  factory CarInfo.fromJson(Map<String, dynamic> json) => CarInfo(
        name: json["name"],
        model: json["model"].toString(),
        palletNumber: json["pallet_number"],
        color: json["color"],
        seatsCount: json["seats_count"].toString(),
        carImage: json["car_image"],
        licenceImage: json["licence_image"],
        insuranceImage: json["insurance_image"],
        formImage: json["form_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "model": model,
        "pallet_number": palletNumber,
        "color": color,
        "seats_count": seatsCount,
        "car_image": carImage,
        "licence_image": licenceImage,
        "insurance_image": insuranceImage,
        "form_image": formImage,
      };
}

class BankInfo {
  String? fullName;
  Bank? bank;
  String? iban;
  String? swift;
  String? accountNumber;
  String? accountImage;

  BankInfo({
    this.fullName,
    this.bank,
    this.iban,
    this.swift,
    this.accountNumber,
    this.accountImage,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        fullName: json["name"],
        bank: json["bank"] != null ? Bank.fromJson(json["bank"]) : null,
        iban: json["iban"],
        swift: json["swift"],
        accountNumber: json["account_number"],
        accountImage: json["account_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": fullName,
        "bank": bank,
        "iban": iban,
        "swift": swift,
        "account_number": accountNumber,
        "account_image": accountImage,
      };
}
