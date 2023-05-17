import 'client_model.dart';
import 'driver_model.dart';

class ProfileModel {
  DriverModel? driver;
  ClientModel? client;

  ProfileModel({
    this.driver,
    this.client,
  });

  ProfileModel copyWith({
    DriverModel? driver,
    ClientModel? client,
  }) =>
      ProfileModel(
        driver: driver ?? this.driver,
        client: client ?? this.client,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        driver: json["driver"] == null
            ? null
            : DriverModel.fromJson(json["driver"]),
        client: json["client"] == null
            ? null
            : ClientModel.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "driver": driver?.toJson(),
        "client": client?.toJson(),
      };
}
