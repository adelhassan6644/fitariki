import '../../../main_models/offer_model.dart';
import '../../profile/model/client_model.dart';
import '../../profile/model/driver_model.dart';

class FavouriteModel {
  List<OfferModel>? offers;
  List<ClientModel>? clients;
  List<DriverModel>? drivers;

  FavouriteModel({
    this.offers,
    this.clients,
    this.drivers,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        offers: json["offers"] == null
            ? []
            : List<OfferModel>.from(
                json["offers"]!.map((x) => OfferModel.fromJson((x["offer"]!=null)?x["offer"]:{}))),
        clients: json["clients"] == null
            ? []
            : List<ClientModel>.from(
                json["clients"]!.map((x) => ClientModel.fromJson(x["client"]))),
        drivers: json["drivers"] == null
            ? []
            : List<DriverModel>.from(
                json["drivers"]!.map((x) => DriverModel.fromJson(x["driver"]))),
      );
}
