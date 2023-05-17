import '../../../main_models/weak_model.dart';
import '../../maps/models/address_model.dart';

class ClientModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
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
  List<WeekModel>? clientDays;

  ClientModel({
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
    this.dropOffLocation,
    this.pickupLocation,
    this.clientDays,
  });

  ClientModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? image,
    String? nickname,
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
    List<WeekModel>? clientDays,
  }) =>
      ClientModel(
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
        dropOffLocation: dropOffLocation ?? this.dropOffLocation,
        pickupLocation: pickupLocation ?? this.pickupLocation,
        clientDays: clientDays ?? this.clientDays,
      );

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        image: json["image"],
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
        dropOffLocation: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        pickupLocation: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
        clientDays: json["client_days"] == null
            ? null
            : List<WeekModel>.from(
                json["client_days"]!.map((x) => WeekModel.fromJson(x))),
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
        "drop_off_location": dropOffLocation?.toJson(),
        "pickup_location": pickupLocation?.toJson(),
        "client_days": clientDays == null
            ? []
            : List<dynamic>.from(clientDays!.map((x) => x)),
      };
}
