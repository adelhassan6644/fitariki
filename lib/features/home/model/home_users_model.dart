import '../../profile/model/client_model.dart';
import '../../profile/model/driver_model.dart';

class HomeUsersModel {
  List<ClientModel>? clients;
  List<DriverModel>? drivers;

  HomeUsersModel({
    this.clients,
    this.drivers,
  });

  factory HomeUsersModel.fromJson(Map<String, dynamic> json) => HomeUsersModel(
        clients: json["clients"] == null ? []
            : List<ClientModel>.from(json["clients"]!.map((x) => ClientModel.fromJson(x))),
        drivers: json["drivers"] == null ? []
            : List<DriverModel>.from(json["drivers"]!.map((x) => DriverModel.fromJson(x))),
      );
}
