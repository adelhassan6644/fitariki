import '../../../maps/models/location_model.dart';

class FollowerModel {
  int? id;
  String? name;
  String? age;
  int? gender;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;

  FollowerModel({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.pickupLocation,
    this.dropOffLocation,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        id: json["id"],
        name: json["name"],
        age: json["age"].toString(),
        gender: int.tryParse(json["gender"].toString()),
        dropOffLocation: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        pickupLocation: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "gender": gender,
        "drop_off_location": dropOffLocation?.toJson(),
        "pickup_location": pickupLocation?.toJson(),
      };

  Map<String, dynamic> toPostJson() => {
        "follower_id": id,
      };
}
