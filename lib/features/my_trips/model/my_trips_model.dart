import '../../../main_models/offer_model.dart';
import '../../followers/follower_details/model/follower_model.dart';
import '../../profile/model/client_model.dart';
import '../../profile/model/driver_model.dart';
import '../../request_details/model/offer_request_details_model.dart';

class MyTripModel {
  OfferRequestDetailsModel? myTripRequest;
  OfferModel? offerModel;
  DateTime? createAt;
  DateTime? endAt;
  bool? paid;
  int? status;
  int? id;
  int? offerId;
  int? clientId;
  int? driverId;
  int? requestId;
  int? offerPassengers;
  int? offerType;
  DriverModel? driverModel;
  ClientModel? clientModel;
  OfferModel? offer;
  List<FollowerModel>? offerFollowers;

  MyTripModel(
      {this.id,
      this.offerId,
      this.requestId,
      this.myTripRequest,
      this.paid,
      this.status,
      this.offerType,
      this.clientId,
      this.driverId,
      this.offerPassengers,
      this.driverModel,
      this.clientModel,
      this.offer,
      this.createAt,
      this.endAt});
  factory MyTripModel.fromJson(Map<String, dynamic> json) => MyTripModel(
      id: json["id"],
      offerId: json["offer_id"],
      driverId: json["driver_id"],
      clientId: json["client_id"],
      offerType: json["offer_type"],
      requestId: json["offer_request_id"],
      paid: json["paid"] == 1 ? true : false,
      status: json["status"],
      offerPassengers: json["offer_passengers"],
      offer: OfferModel.fromJson(json["offer"]),
      createAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,
      endAt: json["end_at"] != null ? DateTime.tryParse(json["end_at"]) : null,
      clientModel:
          json["client"] == null ? null : ClientModel.fromJson(json["client"]),
      driverModel:
          json["driver"] == null ? null : DriverModel.fromJson(json["driver"]),
      myTripRequest: json['offer_request'] != null
          ? OfferRequestDetailsModel.fromJson(json["offer_request"])
          : null);
}
