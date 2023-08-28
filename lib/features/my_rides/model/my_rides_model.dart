import 'package:fitariki/features/maps/models/location_model.dart';

class MyRideModel {
  int? id;
  int? number;
  String? name;
  DateTime? startedAt;
  DateTime? arrivedAt;
  bool? cancelByDriver;
  bool? cancelByClient;
  int? rideType;
  List<LocationModel>? locations;

  MyRideModel({
    this.id,
    this.number,
    this.name,
    this.startedAt,
    this.arrivedAt,
    this.cancelByDriver,
    this.cancelByClient,
    this.locations,
    this.rideType,
  });

  factory MyRideModel.fromJson(Map<String, dynamic> json) => MyRideModel(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        startedAt: json["started_at"] == null
            ? null
            : DateTime.parse(json["started_at"]),
        arrivedAt: json["arrived_at"] == null
            ? null
            : DateTime.parse(json["arrived_at"]),
        cancelByDriver: json["cancel_by_driver"] == 1 ? true : false,
        cancelByClient: json["cancel_by_client"] == 1 ? true : false,
        locations: json["locations"] == null || json["locations"] == []
            ? []
            : List<LocationModel>.from(
                json["locations"]!.map((x) => LocationModel.fromJson(x))),
        rideType: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "name": name,
        "started_at": startedAt?.toIso8601String(),
        "arrived_at": arrivedAt?.toIso8601String(),
        "cancel_by_driver": cancelByDriver,
        "cancel_by_client": cancelByClient,
        "locations": locations?.map((e) => e.toJson()).toList(),
        "type": rideType,
      };
}
