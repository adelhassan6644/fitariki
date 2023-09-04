import 'package:fitariki/features/maps/models/location_model.dart';
import 'package:fitariki/features/profile/model/driver_model.dart';

import '../../profile/model/client_model.dart';

class MyRideModel {
  int? id;
  int? number;
  DriverModel? driver;
  ClientModel? client;
  String? time;
  String? day;
  DateTime? startedAt;
  DateTime? arrivedAt;
  int? cancelByDriver;
  int? cancelByClient;
  int? type;
  int? reservationId;
  int? status;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  List<FollowerRideLocations>? followersLocations;

  MyRideModel({
    this.id,
    this.number,
    this.time,
    this.day,
    this.startedAt,
    this.arrivedAt,
    this.cancelByDriver,
    this.cancelByClient,
    this.type,
    this.reservationId,
    this.status,
    this.client,
    this.driver,
    this.dropOffLocation,
    this.pickupLocation,
    this.followersLocations,
  });

  factory MyRideModel.fromJson(Map<String, dynamic> json) => MyRideModel(
        id: json["id"],
        number: json["number"],
        time: json["time"],
        day: json["day"],
        startedAt: json["started_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["started_at"]),
        arrivedAt: json["arrived_at"] == null
            ? null
            : DateTime.parse(json["arrived_at"]),
        cancelByDriver: json["cancel_by_driver"],
        cancelByClient: json["cancel_by_client"],
        type: json["type"],
        reservationId: json["reservation_id"],
        status: json["status"],
        client: json["client"] != null
            ? ClientModel.fromJson(json["client"])
            : null,
        driver: json["driver"] != null
            ? DriverModel.fromJson(json["driver"])
            : null,
        dropOffLocation: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        pickupLocation: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
        followersLocations: json["followers"] == null
            ? []
            : List<FollowerRideLocations>.from(json["followers"]!
                .map((x) => FollowerRideLocations.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "started_at": startedAt?.toIso8601String(),
        "arrived_at": arrivedAt?.toIso8601String(),
        "cancel_by_driver": cancelByDriver,
        "cancel_by_client": cancelByClient,
        "type": type,
        "reservation_id": reservationId,
        "status": status,
        "drop_off_location": dropOffLocation?.toJson(),
        "pickup_location": pickupLocation?.toJson(),
        "followers": followersLocations == null
            ? []
            : List<dynamic>.from(followersLocations!.map((x) => x.toJson())),
      };
}

class FollowerRideLocations {
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;

  FollowerRideLocations({
    this.dropOffLocation,
    this.pickupLocation,
  });

  factory FollowerRideLocations.fromJson(Map<String, dynamic> json) =>
      FollowerRideLocations(
        dropOffLocation: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        pickupLocation: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
      );

  Map<String, dynamic> toJson() => {
        "drop_off_location": dropOffLocation?.toJson(),
        "pickup_location": pickupLocation?.toJson(),
      };
}
