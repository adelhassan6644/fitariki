import '../../../app/core/utils/methods.dart';
import '../../../main_models/offer_model.dart';
import '../../followers/follower_details/model/follower_model.dart';
import '../../profile/model/client_model.dart';
import '../../profile/model/driver_model.dart';

class OfferRequestDetailsModel {
  int? id;
  DateTime? startAt;
  DateTime? endAt;
  int? duration;
  double? price;
  double? offerPrice;
  int? offerType;
  String? message;
  DateTime? approvedAt;
  bool? isSpecialOffer;
  bool? approvedByClient;
  bool? approvedByDriver;
  DateTime? rejectedAt;
  bool? rejectedByClient;
  bool? rejectedByDriver;
  bool? updatedByDriver;
  bool? updatedByClient;
  int? clientId;
  int? driverId;
  int? offerId;
  int? requestId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? paidAt;
  double? matching;
  DriverModel? driverModel;
  ClientModel? clientModel;
  List<FollowerModel>? followers;
  OfferModel? offer;

  OfferRequestDetailsModel({
    this.id,
    this.startAt,
    this.endAt,
    this.duration,
    this.price,
    this.isSpecialOffer,
    this.offerType,
    this.offerPrice,
    this.message,
    this.approvedAt,
    this.approvedByClient,
    this.approvedByDriver,
    this.matching,
    this.rejectedAt,
    this.rejectedByClient,
    this.rejectedByDriver,
    this.updatedByDriver,
    this.updatedByClient,
    this.clientId,
    this.driverId,
    this.offerId,
    this.requestId,
    this.createdAt,
    this.updatedAt,
    this.paidAt,
    this.driverModel,
    this.clientModel,
    this.followers,
    this.offer,
  });

  factory OfferRequestDetailsModel.fromJson(Map<String, dynamic> json) =>
      OfferRequestDetailsModel(
        id: json["id"],
        startAt: json["start_at"] == null
            ? DateTime.now()
            : Methods.convertStringToDataTime(json["start_at"]),
        endAt: json["end_at"] == null
            ? DateTime.now()
            : Methods.convertStringToDataTime(json["end_at"]),
        duration: json["duration"],
        price: json["offer_price"] == null
            ? 0.0
            : double.parse(json["offer_price"].toString()) == 0.0
                ? double.parse(json["price"].toString())
                : double.parse(json["offer_price"].toString()),
        offerPrice: double.parse(json["offer_price"].toString()),
        offerType: json["offer_type"] ?? 1,
        isSpecialOffer: json["is_special"] == 1 ? true : false,
        message: json["message"],
        matching: json["matching"] == null
            ? 0.0
            : double.parse(json["matching"].toString()) < 0
                ? 0
                : double.parse(json["matching"].toString()),
        approvedAt: json["approved_at"] != null
            ? DateTime.parse(json["approved_at"])
            : null,
        approvedByClient: json["approved_by_client"] == 1 ? true : false,
        approvedByDriver: json["approved_by_driver"] == 1 ? true : false,
        rejectedAt: json["rejected_at"] != null
            ? DateTime.parse(json["rejected_at"])
            : null,
        rejectedByClient: json["rejected_by_client"] == 1 ? true : false,
        rejectedByDriver: json["rejected_by_driver"] == 1 ? true : false,
        updatedByClient: json["updated_by_client"] == 1 ? true : false,
        updatedByDriver: json["updated_by_driver"] == 1 ? true : false,
        clientId: json["client_id"],
        driverId: json["driver_id"],
        offerId: json["offer_id"],
        requestId: json["request_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        offer:
            json["offer"] == null ? null : OfferModel.fromJson(json["offer"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        paidAt:
            json["paid_at"] == null ? null : DateTime.parse(json["paid_at"]),
        clientModel: json["client"] == null
            ? null
            : ClientModel.fromJson(json["client"]),
        driverModel: json["driver"] == null
            ? null
            : DriverModel.fromJson(json["driver"]),
        followers: json["request_followers"] == null
            ? []
            : List<FollowerModel>.from(json["request_followers"]!
                .map((x) => FollowerModel.fromJson(x["follower"]))),
      );
}
