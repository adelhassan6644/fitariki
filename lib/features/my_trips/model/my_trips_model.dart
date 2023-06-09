import '../../request_details/model/offer_request_details_model.dart';

class MyTripModel {
  OfferRequestDetailsModel? myTripRequest;
  DateTime? createAt;
  bool? paid;
  int? status;
  int? id;
  int? offerId;
  int? requestId;

  MyTripModel(
      {this.id,
      this.offerId,
      this.requestId,
      this.myTripRequest,
      this.paid,
      this.status,
      this.createAt});
  factory MyTripModel.fromJson(Map<String, dynamic> json) => MyTripModel(
      id: json["id"],
      offerId: json["offer_id"],
      requestId: json["offer_request_id"],
      paid: json["paid"],
      status: json["status"],
      createAt: DateTime.tryParse(json["created_at"]),
      myTripRequest: json['offer_request'] != null
          ? OfferRequestDetailsModel.fromJson(json["offer_request"])
          : null);
}
