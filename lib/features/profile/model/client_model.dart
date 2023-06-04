import '../../../main_models/weak_model.dart';
import '../../maps/models/location_model.dart';
import 'country_model.dart';

class ClientModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? nickname;
  int? gender;
  String? age;
  Country? national;
  String? city;
  String? countryId;
  String? phone;
  String? status;
  double? rate;
  double? wallet;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  List<WeekModel>? clientDays;
  DateTime? createdAt;
  DateTime? updatedAt;

  ClientModel(
      {this.id,
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
      this.createdAt,
      this.updatedAt});

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        image: json["image"],
        nickname: json["nickname"],
        gender: int.parse(json["gender"] ?? "0"),
        age: json["age"].toString(),
        national: json["country"] != null
            ? Country.fromJson(
                json["country"],
              )
            : null,
        city: json["city"],
        countryId: json["country_id"].toString(),
        phone: json["phone"],
        status: json["status"].toString(),
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
        "national": national?.toJson(),
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
        "client_days": clientDays == null
            ? []
            : List<dynamic>.from(clientDays!.map((x) => x)),
      };
}
