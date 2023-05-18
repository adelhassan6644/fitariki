import '../../../maps/models/location_model.dart';

class FollowerModel {
  int? id;
  String? fullName;
  String? age;
  int? gender;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;

  FollowerModel({
    this.id,
    this.fullName,
    this.age,
    this.gender,
    this.pickupLocation,
    this.dropOffLocation,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        id: json["id"],
        fullName: json["full_name"],
        age: json["age"],
        gender: json["gender"],
        dropOffLocation: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        pickupLocation: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "age": age,
        "gender": gender,
        "drop_off_location": dropOffLocation?.toJson(),
        "pickup_location": pickupLocation?.toJson(),
      };
}
