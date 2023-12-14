import '../../../maps/models/location_model.dart';

class FollowerModel {
  int? id;
  String? name;
  String? age;
  int? gender;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  bool? sameHomeLocation;
  bool? sameDestination;

  FollowerModel({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.pickupLocation,
    this.dropOffLocation,
    this.sameHomeLocation,
    this.sameDestination,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        id: json["id"],
        name: json["name"],
        age: json["age"].toString(),
        gender: json["gender"] != null
            ? int.tryParse(json["gender"].toString())
            : 0,
        sameHomeLocation: json["is_same_pickup_location"] == 1 ? true : false,
        sameDestination: json["is_same_drop_off_location"] == 1 ? true : false,
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
