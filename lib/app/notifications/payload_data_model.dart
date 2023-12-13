part of notification_helper;

class PayloadData {
  int? id;
  String? url;
  int? status;
  bool? isMyOffer;
  MyRideModel? myRideModel;

  PayloadData({
    this.id,
    this.url,
    this.status,
    this.isMyOffer,
    this.myRideModel,
  });

  factory PayloadData.fromJson(Map<String, dynamic> json) => PayloadData(
      id: json["id"],
      url: json["url"],
      isMyOffer: json["is_my_offer"] ?? false,
      status: json["status"],
      myRideModel: json["ride_data"] != null
          ? MyRideModel.fromJson(json["ride_data"])
          : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "status": status,
        "is_my_offer": isMyOffer,
        "ride_data": myRideModel?.toJson(),
      };
}
