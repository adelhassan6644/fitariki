import '../../../maps/models/address_model.dart';

class FollowerModel {
  int? id;
  String? fullName;
  String? age;
  int? gender;
  LocationModel? pickLocation;
  LocationModel? endLocation;

  FollowerModel({
    this.id,
    this.fullName,
    this.age,
    this.gender,
    this.pickLocation,
    this.endLocation,
  });

  FollowerModel copyWith({
    int? id,
    String? fullName,
    String? age,
    int? gender,
    LocationModel? pickLocation,
    LocationModel? endLocation,
  }) =>
      FollowerModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        pickLocation: pickLocation ?? this.pickLocation,
        endLocation: endLocation ?? this.endLocation,
      );

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        id: json["id"],
        fullName: json["full_name"],
        age: json["age"],
        gender: json["gender"],
        pickLocation: json["pick_location"] == null
            ? null : LocationModel.fromJson(json["pick_location"]),
        endLocation: json["end_location"] == null
            ? null : LocationModel.fromJson(json["end_location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "age": age,
        "gender": gender,
        "pick_location": pickLocation?.toJson(),
        "end_location": endLocation?.toJson(),
      };
}
