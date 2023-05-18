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
  String? age;
  String? national;
  String? city;
  String? countryId;
  String? phone;
  String? status;
  double? rate;
  double? wallet;
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
      this.age,
      this.national,
      this.city,
      this.countryId,
      this.phone,
      this.status,
      this.rate,
      this.wallet,
      this.dropOffLocation,
      this.pickupLocation,
      this.driverDays,
      this.carInfo,
      this.bankInfo,
      this.createdAt,
      this.updatedAt});

  DriverModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? image,
    String? nickname,
    String? identityNumber,
    String? identityImage,
    int? gender,
    String? age,
    String? national,
    String? city,
    String? countryId,
    String? phone,
    String? status,
    double? rate,
    double? wallet,
    LocationModel? dropOffLocation,
    LocationModel? pickupLocation,
    List<WeekModel>? driverDays,
    CarInfo? carInfo,
    BankInfo? bankInfo,
  }) =>
      DriverModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        image: image ?? this.image,
        nickname: nickname ?? this.nickname,
        identityNumber: identityNumber ?? this.identityNumber,
        identityImage: identityImage ?? this.identityImage,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        national: national ?? this.national,
        city: city ?? this.city,
        countryId: countryId ?? this.countryId,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        rate: rate ?? this.rate,
        wallet: wallet ?? this.wallet,
        dropOffLocation: dropOffLocation ?? this.dropOffLocation,
        pickupLocation: pickupLocation ?? this.pickupLocation,
        driverDays: driverDays ?? this.driverDays,
        carInfo: carInfo ?? this.carInfo,
        bankInfo: bankInfo ?? this.bankInfo,
      );

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        image: json["image"],
        nickname: json["nickname"],
        gender: int.parse(json["gender"] ?? "0"),
        age: json["age"],
        national: json["national"],
        city: json["city"],
        countryId: json["country_id"],
        identityNumber: json["identity_number"],
        identityImage: json["identity_image"],
        phone: json["phone"],
        status: json["status"],
        rate: json["rate"],
        wallet: double.tryParse(json["wallet"].toString()),
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
        "national": national,
        "city": city,
        "country_id": countryId,
        "phone": phone,
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
  String? seatsCount;
  String? carImage;
  String? licenceImage;
  String? insuranceImage;
  String? formImage;

  CarInfo({
    this.name,
    this.model,
    this.palletNumber,
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
        seatsCount: json["seats_count"],
        carImage: json["car_image"],
        licenceImage: json["licence_image"],
        insuranceImage: json["insurance_image"],
        formImage: json["form_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "model": model,
        "pallet_number": palletNumber,
        "seats_count": seatsCount,
        "car_image": carImage,
        "licence_image": licenceImage,
        "insurance_image": insuranceImage,
        "form_image": formImage,
      };
}

class BankInfo {
  String? fullName;
  String? bank;
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

  BankInfo copyWith({
    String? fullName,
    String? bank,
    String? iban,
    String? swift,
    String? accountNumber,
    String? accountImage,
  }) =>
      BankInfo(
        fullName: fullName ?? this.fullName,
        bank: bank ?? this.bank,
        iban: iban ?? this.iban,
        swift: swift ?? this.swift,
        accountNumber: accountNumber ?? this.accountNumber,
        accountImage: accountImage ?? this.accountImage,
      );

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        fullName: json["name"],
        bank: json["bank"],
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
