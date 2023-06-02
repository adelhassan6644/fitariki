import '../../../main_models/offer_model.dart';
import '../../followers/follower_details/model/follower_model.dart';
import '../../profile/model/client_model.dart';
import '../../profile/model/driver_model.dart';

class OfferRequestDetailsModel {
  int? id;
  DateTime? startAt;
  DateTime? endAt;
  int? duration;
  int? price;
  int? offerPrice;
  String? message;
  DateTime? approvedAt;
  int? approvedByClient;
  int? approvedByDriver;
  DateTime? rejectedAt;
  int? rejectedByClient;
  int? rejectedByDriver;
  int? clientId;
  int? driverId;
  int? offerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DriverModel? driver;
  ClientModel? client;
  List<FollowerModel>? followers;
  OfferModel? offer;

  OfferRequestDetailsModel({
    this.id,
    this.startAt,
    this.endAt,
    this.duration,
    this.price,
    this.offerPrice,
    this.message,
    this.approvedAt,
    this.approvedByClient,
    this.approvedByDriver,
    this.rejectedAt,
    this.rejectedByClient,
    this.rejectedByDriver,
    this.clientId,
    this.driverId,
    this.offerId,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.client,
    this.followers,
    this.offer,
  });

  factory OfferRequestDetailsModel.fromJson(Map<String, dynamic> json) =>
      OfferRequestDetailsModel(
        id: json["id"],
        startAt: json["start_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["start_at"]),
        endAt: json["end_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["end_at"]),
        duration: json["duration"],
        price: json["price"],
        offerPrice: json["offer_price"],
        message: json["message"],
        approvedAt: json["approved_at"] != null
            ? DateTime.parse(json["approved_at"])
            : null,
        approvedByClient: json["approved_by_client"],
        approvedByDriver: json["approved_by_driver"],
        rejectedAt: json["rejected_at"] != null
            ? DateTime.parse(json["rejected_at"])
            : null,
        rejectedByClient: json["rejected_by_client"],
        rejectedByDriver: json["rejected_by_driver"],
        clientId: json["client_id"],
        driverId: json["driver_id"],
        offerId: json["offer_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        offer: json["offer"] == null ? null : OfferModel.fromJson(json["offer"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        client: json["client"] == null
            ? null
            : ClientModel.fromJson(json["client"]),
        driver: json["driver"] == null
            ? null
            : DriverModel.fromJson(json["driver"]),
        followers: json["offer_followers"] == null
            ? null
            : List<FollowerModel>.from(json["offer_followers"]!
                .map((x) => FollowerModel.fromJson(x["follower"]))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_at":
            "${startAt!.year.toString().padLeft(4, '0')}-${startAt!.month.toString().padLeft(2, '0')}-${startAt!.day.toString().padLeft(2, '0')}",
        "end_at":
            "${endAt!.year.toString().padLeft(4, '0')}-${endAt!.month.toString().padLeft(2, '0')}-${endAt!.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "price": price,
        "offer_price": offerPrice,
        "message": message,
        "approved_at": approvedAt,
        "approved_by_client": approvedByClient,
        "approved_by_driver": approvedByDriver,
        "rejected_at": rejectedAt,
        "rejected_by_client": rejectedByClient,
        "rejected_by_driver": rejectedByDriver,
        "client_id": clientId,
        "driver_id": driverId,
        "offer_id": offerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "driver": driver,
        "client": client?.toJson(),
      };
}
