// To parse this JSON data, do
//
//     final myOOffers = myOOffersFromJson(jsonString);



import 'package:fitariki/features/maps/models/location_model.dart';

import '../../../main_models/weak_model.dart';
import '../../followers/follower_details/model/follower_model.dart';
import '../../profile/model/client_model.dart';

// class MyOOffers {
//   List<Offer>? offers;
//
//   MyOOffers({
//     this.offers,
//   });
//
//   factory MyOOffers.fromJson(Map<String, dynamic> json) => MyOOffers(
//     offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
//   };
// }

class MyOfferModle {
  int? id;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  int? duration;
  int? minPrice;
  int? maxPrice;
  int? offerType;
  dynamic driverId;
  int? clientId;
  DateTime? createdAt;
  DateTime? updatedAt;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  List<WeekModel>? offerDays;
  dynamic driver;
  ClientModel? client;
  List<dynamic>? offerRequests;
  List<OfferFollower>? offerFollowers;

  MyOfferModle({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.duration,
    this.minPrice,
    this.maxPrice,
    this.offerType,
    this.driverId,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.dropOffLocation,
    this.pickupLocation,
    this.offerDays,
    this.driver,
    this.client,
    this.offerRequests,
    this.offerFollowers,
  });

  factory MyOfferModle.fromJson(Map<String, dynamic> json) => MyOfferModle(
    id: json["id"],
    name: json["name"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    duration: json["duration"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    offerType: json["offer_type"],
    driverId: json["driver_id"],
    clientId: json["client_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    dropOffLocation: json["drop_off_location"] == null ? null : LocationModel.fromJson(json["drop_off_location"]),
    pickupLocation: json["pickup_location"] == null ? null : LocationModel.fromJson(json["pickup_location"]),
    offerDays: json["offer_days"] == null ? [] : List<WeekModel>.from(json["offer_days"]!.map((x) => WeekModel.fromJson(x))),
    driver: json["driver"],
    client: json["client"] == null ? null : ClientModel.fromJson(json["client"]),
    offerRequests: json["offer_requests"] == null ? [] : List<dynamic>.from(json["offer_requests"]!.map((x) => x)),
    offerFollowers: json["offer_followers"] == null ? [] : List<OfferFollower>.from(json["offer_followers"]!.map((x) => OfferFollower.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "duration": duration,
    "min_price": minPrice,
    "max_price": maxPrice,
    "offer_type": offerType,
    "driver_id": driverId,
    "client_id": clientId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "drop_off_location": dropOffLocation?.toJson(),
    "pickup_location": pickupLocation?.toJson(),
    "offer_days": offerDays == null ? [] : List<dynamic>.from(offerDays!.map((x) => x.toJson())),
    "driver": driver,
    "client": client?.toJson(),
    "offer_requests": offerRequests == null ? [] : List<dynamic>.from(offerRequests!.map((x) => x)),
    "offer_followers": offerFollowers == null ? [] : List<dynamic>.from(offerFollowers!.map((x) => x.toJson())),
  };
}









class OfferFollower {
  int? id;
  int? offerId;
  int? followerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  FollowerModel? follower;

  OfferFollower({
    this.id,
    this.offerId,
    this.followerId,
    this.createdAt,
    this.updatedAt,
    this.follower,
  });

  factory OfferFollower.fromJson(Map<String, dynamic> json) => OfferFollower(
    id: json["id"],
    offerId: json["offer_id"],
    followerId: json["follower_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    follower: json["follower"] == null ? null : FollowerModel.fromJson(json["follower"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer_id": offerId,
    "follower_id": followerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "follower": follower?.toJson(),
  };
}




